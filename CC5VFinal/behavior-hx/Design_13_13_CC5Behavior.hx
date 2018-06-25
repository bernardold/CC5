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



class Design_13_13_CC5Behavior extends ActorScript
{          	
	
public var _XScreenLimit:Float;

public var _isInARegion:Bool;

public var _loopOver:Bool;

public var _HasPermitionToDropStation:Bool;

public var _XPositionCC5:Float;

public var _YPositionCC5:Float;

public var _CurrentNumberOfStation:Float;

public var _StationLimit:Float;

public var _ShootingForce:Float;

public var _XofRegionToDropStation:Float;

public var _YofRegionToDropStation:Float;

public var _RelativeDistanceFromDropingPlace:Float;

public var _RagionRadius:Float;

public var _CurrentBullet:ActorType;

public var _BulletSound:Sound;
    
/* ========================= Custom Event ========================= */
public function _customEvent_ResetAttributes():Void
{
        actor.setFilter([createNegativeFilter()]);
        _CurrentBullet = getActorType(23);
propertyChanged("_CurrentBullet", _CurrentBullet);
        runLater(1000 * 2, function(timeTask:TimedTask):Void {
                    actor.clearFilters();
}, actor);
}


 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
nameMap.set("XScreenLimit", "_XScreenLimit");
_XScreenLimit = 198.0;
nameMap.set("isInARegion", "_isInARegion");
_isInARegion = false;
nameMap.set("loopOver", "_loopOver");
_loopOver = false;
nameMap.set("HasPermitionToDropStation", "_HasPermitionToDropStation");
_HasPermitionToDropStation = false;
nameMap.set("XPositionCC5", "_XPositionCC5");
_XPositionCC5 = 0.0;
nameMap.set("YPositionCC5", "_YPositionCC5");
_YPositionCC5 = 0.0;
nameMap.set("CurrentNumberOfStation", "_CurrentNumberOfStation");
_CurrentNumberOfStation = 0.0;
nameMap.set("StationLimit", "_StationLimit");
_StationLimit = 5.0;
nameMap.set("ShootingForce", "_ShootingForce");
_ShootingForce = 0.0;
nameMap.set("XofRegionToDropStation", "_XofRegionToDropStation");
_XofRegionToDropStation = 0.0;
nameMap.set("YofRegionToDropStation", "_YofRegionToDropStation");
_YofRegionToDropStation = 0.0;
nameMap.set("RelativeDistanceFromDropingPlace", "_RelativeDistanceFromDropingPlace");
_RelativeDistanceFromDropingPlace = 0.0;
nameMap.set("RagionRadius", "_RagionRadius");
_RagionRadius = 17.0;
nameMap.set("CurrentBullet", "_CurrentBullet");
nameMap.set("BulletSound", "_BulletSound");

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        actor.disableBehavior("CC5TheHubBehavior");
        actor.disableBehavior("CC5LabBehavior");
        actor.disableBehavior("CC5PawnShopBehavior");
        actor.enableBehavior("CC5HealthManagerBehavior");
        if((Engine.engine.getGameAttribute("CurrentLevel") == "IceDromeda"))
{
            _CurrentBullet = getActorType(23);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(102);
propertyChanged("_BulletSound", _BulletSound);
}

        else if((Engine.engine.getGameAttribute("CurrentLevel") == "Vulcomet"))
{
            _CurrentBullet = getActorType(44);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(101);
propertyChanged("_BulletSound", _BulletSound);
}

        else if((Engine.engine.getGameAttribute("CurrentLevel") == "Marsalis"))
{
            _CurrentBullet = getActorType(50);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(104);
propertyChanged("_BulletSound", _BulletSound);
}

        else if((Engine.engine.getGameAttribute("CurrentLevel") == "Rhinarous"))
{
            _CurrentBullet = getActorType(52);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(103);
propertyChanged("_BulletSound", _BulletSound);
}

        else if((Engine.engine.getGameAttribute("CurrentLevel") == "Deverest"))
{
            _CurrentBullet = getActorType(54);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(105);
propertyChanged("_BulletSound", _BulletSound);
}

        else
{
            _CurrentBullet = getActorType(23);
propertyChanged("_CurrentBullet", _CurrentBullet);
            _BulletSound = getSound(102);
propertyChanged("_BulletSound", _BulletSound);
}

    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            engine.cameraFollow(actor);
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
    
/* =========================== Keyboard =========================== */
addKeyStateListener("TakeAShot(spaceBar)", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
{
if(wrapper.enabled && pressed)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            createRecycledActor(_CurrentBullet, actor.getX(), actor.getY(), Script.FRONT);
            playSoundOnChannel(_BulletSound, Std.int(1));
            setVolumeForChannel(40/100, Std.int(1));
            if(((actor.getAnimation() == "rightIdle") || (actor.getAnimation() == "WalkingRight")))
{
                getLastCreatedActor().applyImpulse(1, 0, _ShootingForce);
}

            else if(((actor.getAnimation() == "leftIdle") || (actor.getAnimation() == "WalkingLeft")))
{
                getLastCreatedActor().setAngle(Utils.RAD * (180));
                getLastCreatedActor().applyImpulse(-1, 0, _ShootingForce);
}

            else if(((actor.getAnimation() == "UpIdle") || (actor.getAnimation() == "WalkingUp")))
{
                getLastCreatedActor().setAngle(Utils.RAD * (270));
                getLastCreatedActor().applyImpulse(0, -1, _ShootingForce);
}

            else if(((actor.getAnimation() == "DownIdle") || (actor.getAnimation() == "WalkingDown")))
{
                getLastCreatedActor().setAngle(Utils.RAD * (90));
                getLastCreatedActor().applyImpulse(0, 1, _ShootingForce);
}

            else
{
                getLastCreatedActor().applyImpulseInDirection(45, _ShootingForce);
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
            for(item in cast(Engine.engine.getGameAttribute("TargetList"), Array<Dynamic>))
{
                _RelativeDistanceFromDropingPlace = asNumber(Math.sqrt((Math.pow((actor.getXCenter() - (item.getX() + (item.getWidth() / 2))), 2) + Math.pow((actor.getYCenter() - (item.getY() + (item.getHeight() / 2))), 2))));
propertyChanged("_RelativeDistanceFromDropingPlace", _RelativeDistanceFromDropingPlace);
                if((_RelativeDistanceFromDropingPlace <= _RagionRadius))
{
                    _XofRegionToDropStation = asNumber((item.getX() - 0));
propertyChanged("_XofRegionToDropStation", _XofRegionToDropStation);
                    _YofRegionToDropStation = asNumber((item.getY() - -2));
propertyChanged("_YofRegionToDropStation", _YofRegionToDropStation);
                    _isInARegion = true;
propertyChanged("_isInARegion", _isInARegion);
                    _loopOver = true;
propertyChanged("_loopOver", _loopOver);
}

                else
{
                    if(!(_loopOver))
{
                        _isInARegion = false;
propertyChanged("_isInARegion", _isInARegion);
}

}

}

            if(_isInARegion)
{
                _HasPermitionToDropStation = true;
propertyChanged("_HasPermitionToDropStation", _HasPermitionToDropStation);
}

            else
{
                _HasPermitionToDropStation = false;
propertyChanged("_HasPermitionToDropStation", _HasPermitionToDropStation);
}

            _loopOver = false;
propertyChanged("_loopOver", _loopOver);
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
            _XPositionCC5 = asNumber(actor.getXCenter());
propertyChanged("_XPositionCC5", _XPositionCC5);
            _YPositionCC5 = asNumber(actor.getYCenter());
propertyChanged("_YPositionCC5", _YPositionCC5);
            Engine.engine.setGameAttribute("XPositionCC5", _XPositionCC5);
            Engine.engine.setGameAttribute("YPositionCC5", _YPositionCC5);
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
            if((Engine.engine.getGameAttribute("CC5LifePoints") <= 0))
{
                Engine.engine.setGameAttribute("IsCC5Dead", true);
                recycleActor(actor);
}

}

}
});
    
/* =========================== Keyboard =========================== */
addKeyStateListener("PlaceStation(z)", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
{
if(wrapper.enabled && pressed)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if((_HasPermitionToDropStation && (_CurrentNumberOfStation < _StationLimit)))
{
                createRecycledActor(getActorType(7), _XofRegionToDropStation, _YofRegionToDropStation, Script.MIDDLE);
                _CurrentNumberOfStation = asNumber((_CurrentNumberOfStation + 1));
propertyChanged("_CurrentNumberOfStation", _CurrentNumberOfStation);
                shoutToScene("_customEvent_" + "DroppedNewStation");
                if((_CurrentNumberOfStation == _StationLimit))
{
                    shoutToScene("_customEvent_" + "FirstWaveOfEnemies");
                    Engine.engine.setGameAttribute("SpanEnemies", true);
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