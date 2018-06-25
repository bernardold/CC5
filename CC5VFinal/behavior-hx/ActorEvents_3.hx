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



class ActorEvents_3 extends ActorScript
{          	
	
public var _StationLimit:Float;

public var _CurrentNumberOfStation:Float;

public var _XPositionCC5:Float;

public var _YPositionCC5:Float;

public var _LifePoints:Float;

public var _XScreenLimit:Float;

public var _HasPermitionToDropStation:Bool;

public var _CurrentRegion:Region;

public var _isInARegion:Bool;

public var _loopOver:Bool;

 
 	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("StationLimit", "_StationLimit");
_StationLimit = 5.0;
nameMap.set("CurrentNumberOfStation", "_CurrentNumberOfStation");
_CurrentNumberOfStation = 0.0;
nameMap.set("XPositionCC5", "_XPositionCC5");
_XPositionCC5 = 0.0;
nameMap.set("YPositionCC5", "_YPositionCC5");
_YPositionCC5 = 0.0;
nameMap.set("LifePoints", "_LifePoints");
_LifePoints = 0.0;
nameMap.set("XScreenLimit", "_XScreenLimit");
_XScreenLimit = 198.0;
nameMap.set("HasPermitionToDropStation", "_HasPermitionToDropStation");
_HasPermitionToDropStation = false;
nameMap.set("CurrentRegion", "_CurrentRegion");
nameMap.set("isInARegion", "_isInARegion");
_isInARegion = false;
nameMap.set("loopOver", "_loopOver");
_loopOver = false;

	}
	
	override public function init()
	{
		
	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}