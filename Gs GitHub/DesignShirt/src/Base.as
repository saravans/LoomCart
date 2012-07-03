package {
	import com.saravans.design.view.CreateLayout;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	
	import spark.components.Application;

	public class Base extends Application {
		public function Base() {
			super();
		}

		private var createLayout:CreateLayout= CreateLayout.instance;
		public function initApp(event:FlexEvent):void {
			createLayout.appStage = FlexGlobals.topLevelApplication;
			createLayout.drawLayout();
		}
	}
}
	