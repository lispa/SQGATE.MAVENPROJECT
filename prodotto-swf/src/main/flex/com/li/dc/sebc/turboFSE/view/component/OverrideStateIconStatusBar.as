package com.li.dc.sebc.turboFSE.view.component
{
	import mx.core.UIComponent;
	import mx.states.IOverride;
	import it.lispa.siss.sebc.sebwebsiss;
	
	use namespace sebwebsiss;
	internal class OverrideStateIconStatusBar implements IOverride
	{
		public function OverrideStateIconStatusBar()
		{
		}

		public function apply(parent:UIComponent):void
		{
			IconStatusBar( parent ).callChangeState();
		}
		public function initialize():void
	    {
	    }
		public function remove(parent:UIComponent):void
		{
		}
		
	}
}