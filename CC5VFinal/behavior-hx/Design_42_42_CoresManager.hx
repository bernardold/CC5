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



class Design_42_42_CoresManager extends SceneScript
{
	
public var _BarOutlineSize:Float;

public var _BarXOffset:Float;

public var _BarYOffset:Float;

public var _BarWidth:Float;

public var _BarHeight:Float;

public var _PercentLeft:Float;

public var _CoresLeft:Float;

public var _TotalCores:Float;

 
 	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Bar Outline Size", "_BarOutlineSize");
_BarOutlineSize = 2.0;
nameMap.set("Bar X Offset", "_BarXOffset");
_BarXOffset = 20.0;
nameMap.set("Bar Y Offset", "_BarYOffset");
_BarYOffset = 150.0;
nameMap.set("Bar Width", "_BarWidth");
_BarWidth = 50.0;
nameMap.set("Bar Height", "_BarHeight");
_BarHeight = 200.0;
nameMap.set("Percent Left", "_PercentLeft");
_PercentLeft = 0.0;
nameMap.set("Cores Left", "_CoresLeft");
_CoresLeft = 0.0;
nameMap.set("Total Cores", "_TotalCores");
_TotalCores = 200.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        _CoresLeft = asNumber(_TotalCores);
propertyChanged("_CoresLeft", _CoresLeft);
    
/* ========================= When Drawing ========================= */
addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        g.translateToScreen();
        if((_BarOutlineSize > 0))
{
            g.fillColor = Utils.getColorRGB(102,102,102);
            g.fillRect((_BarXOffset - _BarOutlineSize), (_BarYOffset - _BarOutlineSize), (_BarWidth + (_BarOutlineSize * 2)), (_BarHeight + (_BarOutlineSize * 2)));
}

        g.fillColor = Utils.getColorRGB(0,0,0);
        g.fillRect(_BarXOffset, _BarYOffset, _BarWidth, _BarHeight);
        g.fillColor = Utils.getColorRGB(0,51,153);
        g.fillRect((_BarXOffset + 1), ((_BarYOffset + Math.round((_BarHeight * (1 - _PercentLeft)))) + 1), (_BarWidth - 2), (Math.round((_BarHeight * _PercentLeft)) - 2));
        g.setFont(getFont(82));
        g.drawString("" + "Cores:", 20, (_BarYOffset - 40));
        g.setFont(getFont(92));
        g.drawString("" + "0", ((_BarXOffset + _BarWidth) + 5), (_BarYOffset - (g.font.getHeight()/Engine.SCALE / 2)));
        g.drawString("" + _TotalCores, ((_BarXOffset + _BarWidth) + 5), ((_BarYOffset + _BarHeight) - (g.font.getHeight()/Engine.SCALE / 2)));
}
});
    
/* ======================= Every N seconds ======================== */
runPeriodically(1000 * 1, function(timeTask:TimedTask):Void
{
if(wrapper.enabled)
{
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if(Engine.engine.getGameAttribute("SpanEnemies"))
{
                if((_PercentLeft > 0.0))
{
                    _CoresLeft = asNumber((_CoresLeft - Engine.engine.getGameAttribute("PowerStations").length));
propertyChanged("_CoresLeft", _CoresLeft);
}

}

}

}
}, null);
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        _PercentLeft = asNumber((_CoresLeft / _TotalCores));
propertyChanged("_PercentLeft", _PercentLeft);
        if(Engine.engine.getGameAttribute("GameIsOn"))
{
            if((_CoresLeft <= 0))
{
                Engine.engine.setGameAttribute("SpanEnemies", false);
                shoutToScene("_customEvent_" + "LastWave");
}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}