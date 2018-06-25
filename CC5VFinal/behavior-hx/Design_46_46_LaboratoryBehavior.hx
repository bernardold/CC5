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



class Design_46_46_LaboratoryBehavior extends SceneScript
{
	
public var _RelativeDistanceBetweenCC5AndSicentist:Float;

public var _XofScientist:Float;

public var _YofScientist:Float;

public var _Scientist:Actor;

public var _TalkingToScientist:Bool;

public var _InTheDoor:Bool;

public var _SequenceOfText:Array<Dynamic>;

public var _TextCounter:Float;

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("RelativeDistanceBetweenCC5AndSicentist", "_RelativeDistanceBetweenCC5AndSicentist");
_RelativeDistanceBetweenCC5AndSicentist = 0.0;
nameMap.set("XofScientist", "_XofScientist");
_XofScientist = 0.0;
nameMap.set("YofScientist", "_YofScientist");
_YofScientist = 0.0;
nameMap.set("Scientist", "_Scientist");
nameMap.set("TalkingToScientist", "_TalkingToScientist");
_TalkingToScientist = false;
nameMap.set("InTheDoor", "_InTheDoor");
_InTheDoor = false;
nameMap.set("SequenceOfText", "_SequenceOfText");
_SequenceOfText = [];
nameMap.set("TextCounter", "_TextCounter");
_TextCounter = 0.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        stopAllSounds();
        loopSound(getSound(107));
        _SequenceOfText = new Array<Dynamic>();
propertyChanged("_SequenceOfText", _SequenceOfText);
        Engine.engine.setGameAttribute("CurrentLevel", "Laboratory");
        createRecycledActor(getActorType(98), 832, 224, Script.FRONT);
        _Scientist = getLastCreatedActor();
propertyChanged("_Scientist", _Scientist);
        _SequenceOfText.push("CC5: Hello Doctor!");
        _SequenceOfText.push("Scientist: Hi CC5. Good Work So Far, But I Still Need More Samples.");
        _SequenceOfText.push("Scientist:Do You Think You Can Go Get Me Some More ?");
        _SequenceOfText.push("CC5: Sure Doctor, See You Later");
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _RelativeDistanceBetweenCC5AndSicentist = asNumber(Math.sqrt((Math.pow((Engine.engine.getGameAttribute("XPositionCC5") - _Scientist.getX()), 2) + Math.pow((Engine.engine.getGameAttribute("YPositionCC5") - _Scientist.getY()), 2))));
propertyChanged("_RelativeDistanceBetweenCC5AndSicentist", _RelativeDistanceBetweenCC5AndSicentist);
        if((((Engine.engine.getGameAttribute("XPositionCC5") > 525) && (Engine.engine.getGameAttribute("XPositionCC5") < 850)) && ((Engine.engine.getGameAttribute("YPositionCC5") > 505) && (Engine.engine.getGameAttribute("YPositionCC5") < 590))))
{
            _InTheDoor = true;
propertyChanged("_InTheDoor", _InTheDoor);
}

        else
{
            _InTheDoor = false;
propertyChanged("_InTheDoor", _InTheDoor);
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
            if(_InTheDoor)
{
                switchScene(GameModel.get().scenes.get(8).getID(), null, createCrossfadeTransition(2));
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
            if(((_RelativeDistanceBetweenCC5AndSicentist <= 70) && !(_TalkingToScientist)))
{
                _TalkingToScientist = true;
propertyChanged("_TalkingToScientist", _TalkingToScientist);
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
            if(_TalkingToScientist)
{
                if((_TextCounter >= (_SequenceOfText.length - 1)))
{
                    _TalkingToScientist = false;
propertyChanged("_TalkingToScientist", _TalkingToScientist);
                    _TextCounter = asNumber(0);
propertyChanged("_TextCounter", _TextCounter);
}

                else
{
                    _TextCounter = asNumber((_TextCounter + 1));
propertyChanged("_TextCounter", _TextCounter);
}

}

}

}
});
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            g.setFont(getFont(34));
            if(((_RelativeDistanceBetweenCC5AndSicentist <= 70) && !(_TalkingToScientist)))
{
                g.drawString("" + "Press <SPACE> to talkto the scientist", (getScreenWidth() - 400), (getScreenHeight() - 55));
}

            else if(_InTheDoor)
{
                g.drawString("" + "Press <SPACE> To leave the room", (getScreenWidth() - 400), (getScreenHeight() - 55));
}

            else if(_TalkingToScientist)
{
                g.drawString("" + _SequenceOfText[Std.int(_TextCounter)], (getScreenWidth() - 800), (getScreenHeight() - 55));
                g.drawString("" + "Press <SPACE> To Continue", (getScreenWidth() - 800), (getScreenHeight() - 35));
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}