package com.saravans.design.view {
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import mx.core.UIComponent;
	import mx.utils.ColorUtil;
	
	import org.pixelami.fxg.renderer.FXGRenderer;
	
	import spark.components.Button;
	 

	public class Editor extends UIComponent {

		private static const _instance:Editor = new Editor(SingletonLock);

		public static function get instance():Editor {
			return _instance;
		}
		private var loader:URLLoader;
		
		private var urlRequest:URLRequest;
		
		private var xmlLoader:URLLoader;

		public function Editor(lock:Class) {
			super();

			if(lock != SingletonLock)
				throw new Error("Invalid Singleton access.  Use Editor.instance");
		}

		private var btnFillColor:Button;
		
		private var btnStrokeColor:Button;
		override protected function createChildren():void {
			super.createChildren();
			btnFillColor= new Button();
			 addChild(btnFillColor)
			 btnFillColor.width = 120;
			 btnFillColor.height = 50;
			 btnFillColor.label = "Change Color";
			 btnFillColor.addEventListener(MouseEvent.CLICK , btnColorClickHandler);
			 btnStrokeColor= new Button();
			 addChild(btnStrokeColor)
			 btnStrokeColor.width = 150;
			 btnStrokeColor.height = 50;
			 btnStrokeColor.x = 150;
			 btnStrokeColor.label = "Change Strich Color";
			 btnStrokeColor.addEventListener(MouseEvent.CLICK , btnStrichColorClickHandler);
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			super.updateDisplayList(unscaledWidth, unscaledHeight);
		 drawBG();
		}
		
		private var colorArray:Array = new Array("#FFFF33", "#FFFFFF", "#79DCF4", "#FF3333", "#FFCC33","#99CC33");
		
		private var colorStrokeArray:Array = new Array("#FF0000", "#00FF00", "#000000", "#0000FF", "#225A2","#99CC33");
	
		private var randomColorID:Number;
		
		
		private function btnColorClickHandler (event:MouseEvent):void {
			randomColorID = Math.floor(Math.random()*colorArray.length);
			var changeColorXml:* = fxgXml..*.*.(localName()=='SolidColor');
			var intLenght:int = changeColorXml.length();
			for(var i1:int = 0;i1<intLenght;i1++){
				changeColorXml[i1].@color = colorArray[randomColorID];
			}
			render.renderElement(fxgXml, spriteFxg);
		}
		
		private function  btnStrichColorClickHandler(event:MouseEvent):void {
			randomColorID = Math.floor(Math.random()*colorStrokeArray.length);
			var changeColorXml:* = fxgXml..*.*.(localName()=='SolidColorStroke');
			var intLenght:int = changeColorXml.length();
			for(var i1:int = 0;i1<intLenght;i1++){
				changeColorXml[i1].@color = colorStrokeArray[randomColorID];
			}
			render.renderElement(fxgXml, spriteFxg);
		}
		
		public function init():void{
			loadFxgtXml();
		}
		
		public function loadFxgtXml():void {
			xmlLoader = new URLLoader();
			xmlLoader.addEventListener(Event.COMPLETE, fxgXmlLoaded);
			xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, fxgXmlLoadError);
			var path:String;
			path = "../../../../assets/xml/xmlFxg.xml";
			xmlLoader.load(new URLRequest(path));
		}
		
		private var xmlFxgData:XML;
		
		private function fxgXmlLoaded(event:Event):void {
			XML.ignoreWhitespace = true;
			xmlFxgData = XML(event.target.data);
			xmlLoader.removeEventListener(Event.COMPLETE, fxgXmlLoaded);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, fxgXmlLoadError);
			xmlLoader = null;
			renderFXG();
		}
		
		private function fxgXmlLoadError(event:IOErrorEvent):void {
			xmlLoader.removeEventListener(Event.COMPLETE, fxgXmlLoaded);
			xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, fxgXmlLoadError);
			xmlLoader = null;
		}
		
		private var render:FXGRenderer;
		private var fxgXml:*;
		private var spriteFxg:MovieClip
		private function renderFXG():void{
			render = new FXGRenderer();
			spriteFxg = new MovieClip();
			addChild(spriteFxg);
			fxgXml = xmlFxgData..fxg.children()[0];
			render.renderElement(fxgXml, spriteFxg);
		}
		
		private function drawBG():void{
			var g:Graphics = graphics;
			g.clear();
			g.beginFill(0x989898);
			g.drawRect(0,0,unscaledWidth,unscaledHeight);
			g.endFill();
		}
	}
}
class SingletonLock {
}
