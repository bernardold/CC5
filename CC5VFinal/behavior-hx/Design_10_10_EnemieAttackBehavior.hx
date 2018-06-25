package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_10_10_EnemieAttackBehavior extends ActorScript
{          	
	
public var _RelativeDistanceToCC5:Float;

public var _AttackCC5:Bool;

public var _AttackStation:Bool;

public var _Wandering:Bool;

public var _RelativeDistanceToClosestStation:Float;

public var _AuxiliarToCalculateDistance:Float;

public var _XofStationOnTheList:Float;

public var _YofStationOnTheList:Float;

public var _StationToFollow:Actor;

public var _InRangeToAttackCC5:Float;

public var _InRangeToAttackStation:Float;

public var _ShootingForce:Float;

public var _Shooting:Bool;

public var _ShootingWaitTime:Float;

public var _XScreenLimit:Float;

public var _WanderWaitTime:Float;

public var _DirectionOfWander:Float;

public var _EnemieSpeed:Float;

public var _ControlWander:Bool;

public var _activateControlWanderOnce:Bool;

public var _ShootingDirection:Float;
    
/* ========================= Custom Event ========================= */
public function _customEvent_DroppedNewStation():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            actor.shout("_customEvent_" + "GetStationToFollow");
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_Wander():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            _DirectionOfWander = asNumber(randomInt(Math.floor(1), Math.floor(4)));
propertyChanged("_DirectionOfWander", _DirectionOfWander);
            if((_DirectionOfWander == 1))
{
                actor.shout("_customEvent_" + "moveUp");
                actor.setYVelocity(-(_EnemieSpeed));
                actor.setXVelocity(0);
}

            else if((_DirectionOfWander == 2))
{
                actor.shout("_customEvent_" + "moveDown");
                actor.setYVelocity(_EnemieSpeed);
                actor.setXVelocity(0);
}

            else if((_DirectionOfWander == 3))
{
                actor.shout("_customEvent_" + "moveRight");
                actor.setXVelocity(_EnemieSpeed);
                actor.setYVelocity(0);
}

            else if((_DirectionOfWander == 4))
{
                actor.shout("_customEvent_" + "moveLeft");
                actor.setXVelocity(-(_EnemieSpeed));
                actor.setYVelocity(0);
}

}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_ShootStation():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            createRecycledActor(getActorType(17), actor.getX(), actor.getY(), Script.FRONT);
            getLastCreatedActor().applyImpulseInDirection(_ShootingDirection, _ShootingForce);
            getLastCreatedActor().setAngularVelocity(Utils.RAD * (600));
            _Shooting = false;
propertyChanged("_Shooting", _Shooting);
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_GetStationToFollow():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            for(item in cast(Engine.engine.getGameAttribute("PowerStations"), Array<Dynamic>))
{
                _XofStationOnTheList = asNumber(item.getXCenter());
propertyChanged("_XofStationOnTheList", _XofStationOnTheList);
                _YofStationOnTheList = asNumber(item.getYCenter());
propertyChanged("_YofStationOnTheList", _YofStationOnTheList);
                _AuxiliarToCalculateDistance = asNumber(Math.sqrt((Math.pow((actor.getXCenter() - _XofStationOnTheList), 2) + Math.pow((actor.getYCenter() - _YofStationOnTheList), 2))));
propertyChanged("_AuxiliarToCalculateDistance", _AuxiliarToCalculateDistance);
                if((_AuxiliarToCalculateDistance < _RelativeDistanceToClosestStation))
{
                    _RelativeDistanceToClosestStation = asNumber(_AuxiliarToCalculateDistance);
propertyChanged("_RelativeDistanceToClosestStation", _RelativeDistanceToClosestStation);
                    _StationToFollow = item;
propertyChanged("_StationToFollow", _StationToFollow);
}

}

}

}


 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
nameMap.set("RelativeDistanceToCC5", "_RelativeDistanceToCC5");
_RelativeDistanceToCC5 = 0.0;
nameMap.set("AttackCC5", "_AttackCC5");
_AttackCC5 = false;
nameMap.set("AttackStation", "_AttackStation");
_AttackStation = false;
nameMap.set("Wandering", "_Wandering");
_Wandering = false;
nameMap.set("RelativeDistanceToClosestStation", "_RelativeDistanceToClosestStation");
_RelativeDistanceToClosestStation = 2000.0;
nameMap.set("AuxiliarToCalculateDistance", "_AuxiliarToCalculateDistance");
_AuxiliarToCalculateDistance = 0.0;
nameMap.set("XofStationOnTheList", "_XofStationOnTheList");
_XofStationOnTheList = 0.0;
nameMap.set("YofStationOnTheList", "_YofStationOnTheList");
_YofStationOnTheList = 0.0;
nameMap.set("StationToFollow", "_StationToFollow");
nameMap.set("InRangeToAttackCC5", "_InRangeToAttackCC5");
_InRangeToAttackCC5 = 215.0;
nameMap.set("InRangeToAttackStation", "_InRangeToAttackStation");
_InRangeToAttackStation = 170.0;
nameMap.set("ShootingForce", "_ShootingForce");
_ShootingForce = 0.0;
nameMap.set("Shooting", "_Shooting");
_Shooting = false;
nameMap.set("ShootingWaitTime", "_ShootingWaitTime");
_ShootingWaitTime = 2.0;
nameMap.set("XScreenLimit", "_XScreenLimit");
_XScreenLimit = 198.0;
nameMap.set("WanderWaitTime", "_WanderWaitTime");
_WanderWaitTime = 2.0;
nameMap.set("DirectionOfWander", "_DirectionOfWander");
_DirectionOfWander = 0.0;
nameMap.set("EnemieSpeed", "_EnemieSpeed");
_EnemieSpeed = 10.0;
nameMap.set("ControlWander", "_ControlWander");
_ControlWander = false;
nameMap.set("activateControlWanderOnce", "_activateControlWanderOnce");
_activateControlWanderOnce = true;
nameMap.set("ShootingDirection", "_ShootingDirection");
_ShootingDirection = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            actor.makeAlwaysSimulate();
            actor.shout("_customEvent_" + "GetStationToFollow");
            _AttackCC5 = false;
propertyChanged("_AttackCC5", _AttackCC5);
            _AttackStation = false;
propertyChanged("_AttackStation", _AttackStation);
            _Wandering = true;
propertyChanged("_Wandering", _Wandering);
            _Shooting = false;
propertyChanged("_Shooting", _Shooting);
}

    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            _RelativeDistanceToCC5 = asNumber(Math.sqrt((Math.pow((actor.getY() - Engine.engine.getGameAttribute("YPositionCC5")), 2) + Math.pow((actor.getX() - Engine.engine.getGameAttribute("XPositionCC5")), 2))));
propertyChanged("_RelativeDistanceToCC5", _RelativeDistanceToCC5);
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if((_RelativeDistanceToCC5 <= _InRangeToAttackCC5))
{
                _AttackCC5 = true;
propertyChanged("_AttackCC5", _AttackCC5);
                _AttackStation = false;
propertyChanged("_AttackStation", _AttackStation);
                _Wandering = false;
propertyChanged("_Wandering", _Wandering);
                _activateControlWanderOnce = true;
propertyChanged("_activateControlWanderOnce", _activateControlWanderOnce);
}

            else if(((_RelativeDistanceToCC5 > _InRangeToAttackCC5) && (_RelativeDistanceToClosestStation <= _InRangeToAttackStation)))
{
                _AttackCC5 = false;
propertyChanged("_AttackCC5", _AttackCC5);
                _AttackStation = true;
propertyChanged("_AttackStation", _AttackStation);
                _Wandering = false;
propertyChanged("_Wandering", _Wandering);
                _activateControlWanderOnce = true;
propertyChanged("_activateControlWanderOnce", _activateControlWanderOnce);
}

            else
{
                _AttackCC5 = false;
propertyChanged("_AttackCC5", _AttackCC5);
                _AttackStation = false;
propertyChanged("_AttackStation", _AttackStation);
                _Wandering = true;
propertyChanged("_Wandering", _Wandering);
}

}

}
});
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * _ShootingWaitTime, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if(_AttackCC5)
{
                actor.setYVelocity(0);
                actor.setXVelocity(0);
                _ShootingDirection = asNumber((Utils.DEG * (Math.atan2((actor.getYCenter() - Engine.engine.getGameAttribute("YPositionCC5")), (actor.getXCenter() - Engine.engine.getGameAttribute("XPositionCC5")))) + 180));
propertyChanged("_ShootingDirection", _ShootingDirection);
                createRecycledActor(getActorType(17), actor.getX(), actor.getY(), Script.FRONT);
                getLastCreatedActor().applyImpulseInDirection(_ShootingDirection, _ShootingForce);
                getLastCreatedActor().setAngularVelocity(Utils.RAD * (600));
}

}

}
}, actor);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if(_Wandering)
{
                if(_activateControlWanderOnce)
{
                    _ControlWander = true;
propertyChanged("_ControlWander", _ControlWander);
                    _activateControlWanderOnce = false;
propertyChanged("_activateControlWanderOnce", _activateControlWanderOnce);
}

                if(_ControlWander)
{
                    actor.shout("_customEvent_" + "Wander");
                    _ControlWander = false;
propertyChanged("_ControlWander", _ControlWander);
                    runLater(1000 * _WanderWaitTime, function(timeTask:TimedTask):Void {
                                _ControlWander = true;
propertyChanged("_ControlWander", _ControlWander);
}, actor);
}

}

}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if((actor.getY() <= 0))
{
                actor.setY(1);
}

            if((actor.getY() > ((getSceneHeight()) - (actor.getHeight()))))
{
                actor.setY(((getSceneHeight()) - ((actor.getHeight()) - 0)));
}

            if((actor.getX() <= _XScreenLimit))
{
                actor.setX((_XScreenLimit + 1));
}

            if((actor.getX() > ((getSceneWidth()) - (actor.getWidth()))))
{
                actor.setX(((getSceneWidth()) - ((actor.getWidth()) - 0)));
}

}

}
});
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * _ShootingWaitTime, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if(_AttackStation)
{
                if(!(Utils.contains(Engine.engine.getGameAttribute("PowerStations"), _StationToFollow)))
{
                    actor.shout("_customEvent_" + "GetStationToFollow");
}

                _ShootingDirection = asNumber((Utils.DEG * (Math.atan2((actor.getYCenter() - _StationToFollow.getYCenter()), (actor.getXCenter() - _StationToFollow.getXCenter()))) + 180));
propertyChanged("_ShootingDirection", _ShootingDirection);
                actor.setXVelocity(0);
                actor.setYVelocity(0);
                actor.shout("_customEvent_" + "ShootStation");
}

}

}
}, actor);
    
/* ======================== Specific Actor ======================== */
addWhenKilledListener(actor, function(list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            Engine.engine.setGameAttribute("NumOfEnemiesAlive", (Engine.engine.getGameAttribute("NumOfEnemiesAlive") - 1));
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            for(item in cast(Engine.engine.getGameAttribute("PowerStations"), Array<Dynamic>))
{
                _XofStationOnTheList = asNumber(item.getXCenter());
propertyChanged("_XofStationOnTheList", _XofStationOnTheList);
                _YofStationOnTheList = asNumber(item.getYCenter());
propertyChanged("_YofStationOnTheList", _YofStationOnTheList);
                _AuxiliarToCalculateDistance = asNumber(Math.sqrt((Math.pow((actor.getXCenter() - _XofStationOnTheList), 2) + Math.pow((actor.getYCenter() - _YofStationOnTheList), 2))));
propertyChanged("_AuxiliarToCalculateDistance", _AuxiliarToCalculateDistance);
                if((_AuxiliarToCalculateDistance < _RelativeDistanceToClosestStation))
{
                    _RelativeDistanceToClosestStation = asNumber(_AuxiliarToCalculateDistance);
propertyChanged("_RelativeDistanceToClosestStation", _RelativeDistanceToClosestStation);
                    _StationToFollow = item;
propertyChanged("_StationToFollow", _StationToFollow);
}

                else
{
                    _RelativeDistanceToClosestStation = asNumber(Math.sqrt((Math.pow((actor.getXCenter() - _StationToFollow.getXCenter()), 2) + Math.pow((actor.getYCenter() - _StationToFollow.getYCenter()), 2))));
propertyChanged("_RelativeDistanceToClosestStation", _RelativeDistanceToClosestStation);
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}