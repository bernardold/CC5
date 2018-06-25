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
import box2D.collision.shapes.B2Shape;

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



class Design_12_12_SpaningEnemies extends SceneScript
{
	
public var _EnemieToSpan:Actor;

public var _LevelName:String;

public var _RegionRadius:Float;

public var _GameOverMessege:String;

public var _ReloadTime:Float;

public var _EnemySpanTime:Float;

public var _MaxNumberOfEnemies:Float;

public var _top:Float;

public var _down:Float;

public var _left:Float;

public var _right:Float;

public var _placeAuxiliar:Float;

public var _CurrentTypeOfEnemy:ActorType;

public var _XScreenLimit:Float;

public var _CoreChargeRequired:Float;

public var _XStartOfInterface:Float;

public var _DrawingInterface:Bool;

public var _WinLevel:Bool;

public var _LastWave:Bool;
    
/* ========================= Custom Event ========================= */
public function _customEvent_LastWave():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            _LastWave = true;
propertyChanged("_LastWave", _LastWave);
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_FirstWaveOfEnemies():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            stopAllSounds();
            loopSound(getSound(108));
            while((Engine.engine.getGameAttribute("NumOfEnemiesAlive") < _MaxNumberOfEnemies))
{
                _placeAuxiliar = asNumber((randomInt(Math.floor(10), Math.floor(100)) % 4));
propertyChanged("_placeAuxiliar", _placeAuxiliar);
                if((_placeAuxiliar == _down))
{
                    createRecycledActor(_CurrentTypeOfEnemy, randomInt(Math.floor((_XScreenLimit + 2)), Math.floor((getSceneWidth()))), ((getSceneHeight()) - 3), Script.MIDDLE);
}

                else if((_placeAuxiliar == _top))
{
                    createRecycledActor(_CurrentTypeOfEnemy, randomInt(Math.floor((_XScreenLimit + 2)), Math.floor((getSceneWidth()))), 3, Script.MIDDLE);
}

                else if((_placeAuxiliar == _left))
{
                    createRecycledActor(_CurrentTypeOfEnemy, (_XScreenLimit + 2), randomInt(Math.floor(3), Math.floor((getSceneHeight()))), Script.MIDDLE);
}

                else if((_placeAuxiliar == _right))
{
                    createRecycledActor(_CurrentTypeOfEnemy, ((getSceneWidth()) + -3), randomInt(Math.floor(3), Math.floor((getSceneHeight()))), Script.MIDDLE);
}

                Engine.engine.setGameAttribute("NumOfEnemiesAlive", (Engine.engine.getGameAttribute("NumOfEnemiesAlive") + 1));
                getLastCreatedActor().moveToLayer(1, "" + "Enemies");
}

}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_ReloadTheGame():Void
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            Engine.engine.setGameAttribute("IsCC5Dead", false);
            Engine.engine.setGameAttribute("CC5LifePoints", 15);
            reloadCurrentScene(createFadeOut(3, Utils.getColorRGB(0,0,0)), createFadeIn(3, Utils.getColorRGB(0,0,0)));
}

}

    
/* ========================= Custom Event ========================= */
public function _customEvent_ResetAttributes():Void
{
        Engine.engine.setGameAttribute("IsCC5Dead", false);
        Engine.engine.setGameAttribute("GameIsOn", true);
        Engine.engine.setGameAttribute("SpanEnemies", false);
        Utils.clear(Engine.engine.getGameAttribute("PowerStations"));
        Utils.clear(Engine.engine.getGameAttribute("RegionList"));
        Utils.clear(Engine.engine.getGameAttribute("TargetList"));
        Engine.engine.setGameAttribute("NumOfEnemiesAlive", 0);
        Engine.engine.setGameAttribute("CC5LifePoints", 15);
        Engine.engine.setGameAttribute("XPositionCC5", 0);
        Engine.engine.setGameAttribute("YPositionCC5", 0);
        Engine.engine.setGameAttribute("CurrentLevel", "MainScreen");
}


 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("EnemieToSpan", "_EnemieToSpan");
nameMap.set("LevelName", "_LevelName");
_LevelName = "";
nameMap.set("RegionRadius", "_RegionRadius");
_RegionRadius = 25.0;
nameMap.set("GameOverMessege", "_GameOverMessege");
_GameOverMessege = "Game Over !!";
nameMap.set("ReloadTime", "_ReloadTime");
_ReloadTime = 3.0;
nameMap.set("EnemySpanTime", "_EnemySpanTime");
_EnemySpanTime = 5.0;
nameMap.set("MaxNumberOfEnemies", "_MaxNumberOfEnemies");
_MaxNumberOfEnemies = 0.0;
nameMap.set("top", "_top");
_top = 1.0;
nameMap.set("down", "_down");
_down = 0.0;
nameMap.set("left", "_left");
_left = 2.0;
nameMap.set("right", "_right");
_right = 3.0;
nameMap.set("placeAuxiliar", "_placeAuxiliar");
_placeAuxiliar = 0.0;
nameMap.set("CurrentTypeOfEnemy", "_CurrentTypeOfEnemy");
nameMap.set("XScreenLimit", "_XScreenLimit");
_XScreenLimit = 0.0;
nameMap.set("CoreChargeRequired", "_CoreChargeRequired");
_CoreChargeRequired = 0.0;
nameMap.set("XStartOfInterface", "_XStartOfInterface");
_XStartOfInterface = 0.0;
nameMap.set("DrawingInterface?", "_DrawingInterface");
_DrawingInterface = true;
nameMap.set("WinLevel?", "_WinLevel");
_WinLevel = false;
nameMap.set("LastWave", "_LastWave");
_LastWave = false;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            stopAllSounds();
            playSound(getSound(109));
            Engine.engine.setGameAttribute("CurrentLevel", _LevelName);
}

    
/* ======================== When Creating ========================= */
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            Engine.engine.setGameAttribute("CurrentLevel", _LevelName);
            runLater(1000 * 1, function(timeTask:TimedTask):Void {
                        for(item in cast(Engine.engine.getGameAttribute("TargetList"), Array<Dynamic>))
{
                            createCircularRegion((item.getX() + 0), (item.getY() + 0), _RegionRadius);
                            Engine.engine.getGameAttribute("RegionList").push(getLastCreatedRegion());
}

}, null);
}

    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if(_LastWave)
{
                if((Engine.engine.getGameAttribute("NumOfEnemiesAlive") <= 0))
{
                    _WinLevel = true;
propertyChanged("_WinLevel", _WinLevel);
}

}

}

}
});
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * _EnemySpanTime, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if((Engine.engine.getGameAttribute("SpanEnemies") && (Engine.engine.getGameAttribute("NumOfEnemiesAlive") < _MaxNumberOfEnemies)))
{
                _placeAuxiliar = asNumber((randomInt(Math.floor(10), Math.floor(100)) % 4));
propertyChanged("_placeAuxiliar", _placeAuxiliar);
                if((_placeAuxiliar == _down))
{
                    createRecycledActor(_CurrentTypeOfEnemy, randomInt(Math.floor((_XScreenLimit + 2)), Math.floor((getSceneWidth()))), ((getSceneHeight()) - 3), Script.MIDDLE);
}

                else if((_placeAuxiliar == _top))
{
                    createRecycledActor(_CurrentTypeOfEnemy, randomInt(Math.floor((_XScreenLimit + 2)), Math.floor((getSceneWidth()))), 3, Script.MIDDLE);
}

                else if((_placeAuxiliar == _left))
{
                    createRecycledActor(_CurrentTypeOfEnemy, (_XScreenLimit + 2), randomInt(Math.floor(3), Math.floor((getSceneHeight()))), Script.MIDDLE);
}

                else if((_placeAuxiliar == _right))
{
                    createRecycledActor(_CurrentTypeOfEnemy, ((getSceneWidth()) + -3), randomInt(Math.floor(3), Math.floor((getSceneHeight()))), Script.MIDDLE);
}

                Engine.engine.setGameAttribute("NumOfEnemiesAlive", (Engine.engine.getGameAttribute("NumOfEnemiesAlive") + 1));
                getLastCreatedActor().moveToLayer(1, "" + "Enemies");
}

}

}
}, null);
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("IsCC5Dead"))
{
            g.setFont(getFont(22));
            g.drawString("" + _GameOverMessege, (getScreenWidth() / 2), (getScreenHeight() / 2));
            runLater(1000 * _ReloadTime, function(timeTask:TimedTask):Void {
                        shoutToScene("_customEvent_" + "ResetAttributes");
                        shoutToScene("_customEvent_" + "ReloadTheGame");
}, null);
}

        else if((!(Engine.engine.getGameAttribute("IsCC5Dead")) && _WinLevel))
{
            g.setFont(getFont(35));
            g.drawString("" + "You Finished This Planet", ((((getScreenWidth() - 198) / 2) - (getFont(30).font.getTextWidth("You Finished This Planet")/Engine.SCALE / 2)) + 198), ((getScreenHeight() / 2) - 80));
            runLater(1000 * 2, function(timeTask:TimedTask):Void {
                        shoutToScene("_customEvent_" + "ResetAttributes");
                        switchScene(GameModel.get().scenes.get(8).getID(), null, createCrossfadeTransition(1));
}, null);
}

}
});
    
/* =========================== Keyboard =========================== */
addKeyStateListener("Return(ESC)", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
{
if(wrapper.enabled && pressed)
{
        shoutToScene("_customEvent_" + "ResetAttributes");
        switchScene(GameModel.get().scenes.get(6).getID(), null, createCrossfadeTransition(1));
}
});
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            g.setFont(getFont(82));
            g.drawString("" + (("" + "Enemies: ") + ("" + ("" + Engine.engine.getGameAttribute("NumOfEnemiesAlive")).substring(Std.int(0), Std.int(4)))), _XStartOfInterface, 370);
}

        if((_LastWave && !(_WinLevel)))
{
            g.setFont(getFont(34));
            g.drawString("" + "Clear the planet to finish Level.", (((getScreenWidth() - 198) / 2) - (getFont(34).font.getTextWidth("Clear the planet to finish Level.")/Engine.SCALE / 2)), (getScreenHeight() - 40));
}

        if((!(Engine.engine.getGameAttribute("SpanEnemies")) && !(_LastWave)))
{
            g.setFont(getFont(34));
            g.drawString("" + "Press <Z> to place the Core Collector", (((getScreenWidth() - 198) / 2) - (getFont(34).font.getTextWidth("Clear the planet to finish Level.")/Engine.SCALE / 2)), (getScreenHeight() - 40));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}