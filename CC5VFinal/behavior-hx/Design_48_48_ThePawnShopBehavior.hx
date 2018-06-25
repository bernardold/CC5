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



class Design_48_48_ThePawnShopBehavior extends SceneScript
{
	
public var _PawnShopGuy:Actor;

public var _RelativeDistanceBetweenCC5AndPawnShopGuy:Float;

public var _SequenceOfText:Array<Dynamic>;

public var _InTheDoor:Bool;

public var _TalkingToPawnShop:Bool;

public var _TextCounter:Float;

public var _CurrentLine:String;

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("PawnShopGuy", "_PawnShopGuy");
nameMap.set("RelativeDistanceBetweenCC5AndPawnShopGuy", "_RelativeDistanceBetweenCC5AndPawnShopGuy");
_RelativeDistanceBetweenCC5AndPawnShopGuy = 0.0;
nameMap.set("SequenceOfText", "_SequenceOfText");
_SequenceOfText = [];
nameMap.set("InTheDoor", "_InTheDoor");
_InTheDoor = false;
nameMap.set("TalkingToPawnShop", "_TalkingToPawnShop");
_TalkingToPawnShop = false;
nameMap.set("TextCounter", "_TextCounter");
_TextCounter = 0.0;
nameMap.set("CurrentLine", "_CurrentLine");
_CurrentLine = "";

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        stopAllSounds();
        playSound(getSound(111));
        _SequenceOfText = new Array<Dynamic>();
propertyChanged("_SequenceOfText", _SequenceOfText);
        Engine.engine.setGameAttribute("CurrentLevel", "PawnShop");
        createRecycledActor(getActorType(96), 832, 224, Script.FRONT);
        _PawnShopGuy = getLastCreatedActor();
propertyChanged("_PawnShopGuy", _PawnShopGuy);
        _SequenceOfText.push("Jimbo: Welcome to my store, I~x2019ll be more than happy to take your money!");
        _SequenceOfText.push("Jimbo: What~x2019s good killa? What can I get for you today?");
        _SequenceOfText.push("Jimbo: Hey you~x2019re still alive! I like you; you~x2019re great for business.");
        _SequenceOfText.push("Jimbo: My guns are the best in the universe!!! My bullets are ok.");
        _SequenceOfText.push("Jimbo: Welcome! What can I do for you?");
        _SequenceOfText.push("Jimbo: I~x2019ve got the best prices in space! And by space I mean this space behind the counter~x2026");
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _RelativeDistanceBetweenCC5AndPawnShopGuy = asNumber(Math.sqrt((Math.pow((Engine.engine.getGameAttribute("XPositionCC5") - _PawnShopGuy.getX()), 2) + Math.pow((Engine.engine.getGameAttribute("YPositionCC5") - _PawnShopGuy.getY()), 2))));
propertyChanged("_RelativeDistanceBetweenCC5AndPawnShopGuy", _RelativeDistanceBetweenCC5AndPawnShopGuy);
        if((((Engine.engine.getGameAttribute("XPositionCC5") > 450) && (Engine.engine.getGameAttribute("XPositionCC5") < 815)) && ((Engine.engine.getGameAttribute("YPositionCC5") > 500) && (Engine.engine.getGameAttribute("YPositionCC5") < 590))))
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
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            g.setFont(getFont(34));
            if(((_RelativeDistanceBetweenCC5AndPawnShopGuy <= 70) && !(_TalkingToPawnShop)))
{
                g.drawString("" + "Press <SPACE> to speak with the scientist", (getScreenWidth() - 400), (getScreenHeight() - 55));
}

            else if(_InTheDoor)
{
                g.drawString("" + "Press <SPACE> To leave the room", (getScreenWidth() - 400), (getScreenHeight() - 55));
}

            else if(_TalkingToPawnShop)
{
                g.drawString("" + _CurrentLine, (getScreenWidth() - 900), (getScreenHeight() - 55));
                g.drawString("" + "Press <SPACE> To Continue", (getScreenWidth() - 900), (getScreenHeight() - 35));
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
            if(((_RelativeDistanceBetweenCC5AndPawnShopGuy <= 70) && !(_TalkingToPawnShop)))
{
                _TextCounter = asNumber(randomInt(Math.floor(0), Math.floor((_SequenceOfText.length - 1))));
propertyChanged("_TextCounter", _TextCounter);
                _CurrentLine = _SequenceOfText[Std.int(_TextCounter)];
propertyChanged("_CurrentLine", _CurrentLine);
                _TalkingToPawnShop = true;
propertyChanged("_TalkingToPawnShop", _TalkingToPawnShop);
}

            else if(((_RelativeDistanceBetweenCC5AndPawnShopGuy <= 70) && _TalkingToPawnShop))
{
                _TalkingToPawnShop = false;
propertyChanged("_TalkingToPawnShop", _TalkingToPawnShop);
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}