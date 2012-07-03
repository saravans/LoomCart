package com.saravans.design.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class DesignModel extends EventDispatcher
	{
		public function DesignModel(target:IEventDispatcher=null)
		{
			super(target);
		}
	}
}