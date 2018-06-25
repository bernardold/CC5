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



class Design_19_19_WelcomeScreenBehavior extends SceneScript
{
	
public var _DelayMessegeTime:Float;

public var _CanDraw:Bool;

public var _fadeEffect:Float;

public var _canStart:Bool;

public var _tittleFadeEffect:Float;

public var _startFadeEffect:Float;

public var _fadeInc:Float;

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("DelayMessegeTime", "_DelayMessegeTime");
_DelayMessegeTime = 4.0;
nameMap.set("CanDraw", "_CanDraw");
_CanDraw = false;
nameMap.set("fadeEffect", "_fadeEffect");
_fadeEffect = 0.0;
nameMap.set("canStart", "_canStart");
_canStart = false;
nameMap.set("tittleFadeEffect", "_tittleFadeEffect");
_tittleFadeEffect = 0.0;
nameMap.set("startFadeEffect", "_startFadeEffect");
_startFadeEffect = 0.0;
nameMap.set("fadeInc", "_fadeInc");
_fadeInc = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        stopAllSounds();
        playSound(getSound(106));
        _fadeInc = asNumber(0.5);
propertyChanged("_fadeInc", _fadeInc);
        _startFadeEffect = asNumber(50);
propertyChanged("_startFadeEffect", _startFadeEffect);
        Engine.engine.getGameAttribute("LevelsList").push("Ice");
        Engine.engine.getGameAttribute("LevelsList").push("Lava");
        Engine.engine.getGameAttribute("LevelsList").push("Swamp");
        Engine.engine.getGameAttribute("LevelsList").push("Desert");
        Engine.engine.getGameAttribute("LevelsList").push("Rock");
    
/* ======================= After N seconds ======================== */
runLater(1000 * 4, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        _CanDraw = true;
propertyChanged("_CanDraw", _CanDraw);
}
}, null);
    
/* ======================= After N seconds ======================== */
runLater(1000 * 8, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        _canStart = true;
propertyChanged("_canStart", _canStart);
}
}, null);
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_CanDraw)
{
            g.setFont(getFont(30));
            g.alpha = (_tittleFadeEffect/100);
            g.drawString("" + "CC-5", 40, 80);
}

        g.setFont(getFont(34));
        g.alpha = (100/100);
        g.drawString("" + "Produced by 5Gs IN 2D", 40, (getScreenHeight() - 30));
        if(_canStart)
{
            g.setFont(getFont(35));
            g.alpha = (_startFadeEffect/100);
            g.drawString("" + "Press <space> to start a new game", ((getScreenWidth() / 2) - (getFont(35).font.getTextWidth("Press <space> to start a new game")/Engine.SCALE / 2)), (getScreenHeight() - 200));
}

}
});
    
/* =========================== Keyboard =========================== */
addKeyStateListener("TakeAShot(spaceBar)", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
{
if(wrapper.enabled && pressed)
{
        if(_canStart)
{
            switchScene(GameModel.get().scenes.get(8).getID(), null, createCrossfadeTransition(.5));
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(_CanDraw)
{
            if((_tittleFadeEffect < 100))
{
                _tittleFadeEffect = asNumber((_tittleFadeEffect + 0.1));
propertyChanged("_tittleFadeEffect", _tittleFadeEffect);
}

}

        if(_canStart)
{
            _startFadeEffect = asNumber((_startFadeEffect + _fadeInc));
propertyChanged("_startFadeEffect", _startFadeEffect);
            if(((_startFadeEffect <= 20) || (_startFadeEffect >= 100)))
{
                _fadeInc = asNumber((_fadeInc * -1));
propertyChanged("_fadeInc", _fadeInc);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}