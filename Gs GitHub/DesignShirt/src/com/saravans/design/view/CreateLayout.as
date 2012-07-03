package com.saravans.design.view {
	import mx.core.UIComponent;

	public class CreateLayout {
		public var appStage:*;

		private static const _instance:CreateLayout = new CreateLayout(SingletonLock);

		public static function get instance():CreateLayout {
			return _instance;
		}

		public function CreateLayout(lock:Class) {
			if(lock != SingletonLock)
				throw new Error("Invalid Singleton access. Use CreateLayout.instance");
		}

		private var uiContainer:UIComponent;
		
		private var editor:Editor;

		public function drawLayout():void {
			if(!uiContainer) {
				uiContainer = new UIComponent();
				appStage.addElement(uiContainer);
			}
			
			if(!editor){
				editor = Editor.instance;
				uiContainer.addChild(editor);
				editor.width = appStage.width;
				editor.height = appStage.height;
				editor.init();
			}
		}
	}
}

class SingletonLock {
}