///////////////////////////////////////////////////////////
//  HelpManager.as
//  Macromedia ActionScript Implementation of the Class HelpManager
//  Generated by Enterprise Architect
//  Created on:      29-ago-2010 12.12.04
//  Original author: marco
///////////////////////////////////////////////////////////

package com.li.dc.sebc.turboFSE.util
{
	import com.li.dc.sebc.turboFSE.util.feedback.AbstractFeedback;
	import com.li.dc.sebc.turboFSE.util.feedback.FeedbackManager;
	
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.messages.MessageManager;
	
	import mx.core.DragSource;
	import mx.core.IFlexDisplayObject;
	import mx.core.IUIComponent;
	import mx.events.DragEvent;
	import mx.managers.DragManager;

	/**
	 * @author marco
	 * @version 1.0
	 * @created 29-ago-2010 12.12.04
	 */
	public class HelpManager
	{
		private static const INFO:String 		= "_info_help_manager_";
		private static const VALUEINFO:String 	= "_info_value_help_manager_";
		
		private static var instance:HelpManager;
		public static function getInstance():HelpManager
		{
			if(instance == null)
			{
				instance = new HelpManager(new HideClass());
			}
			return instance;
		}
		//==================================================
	    private var listTarget: Dictionary;
	    private var listFeedback: Dictionary;
	    private var dragInitiator: IDropDragClass;
	    private var oldTarget:IHelp;
	    private var exitShow:Boolean;

		public function HelpManager(hide:HideClass){
			listTarget 		= new Dictionary(true);
			listFeedback 	= new Dictionary(true);
			exitShow 		= true;
		}
		/**
	     * 
	     * @param btn
	     */
	    public function setButtonHelp(btn:IDropDragClass ): void
	    {
	    	removeOldDragInitiator( );
	    	addNewDragInitiator( btn );
	    }
	    private function addNewDragInitiator(btn:IDropDragClass):void
	    {
	    	if(btn != null)
	    	{
	    		dragInitiator = btn;
	    		dragInitiator.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag );
	    	}
	    }
	    private function removeOldDragInitiator():void
	    {
	    	if(dragInitiator != null)
	    	{
	    		dragInitiator.removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag );
	    		dragInitiator = null;
	    	}
	    }
		/**
		 * Al  click del mouse si inizia il dragAndDrop 
		 * @param event
		 * 
		 */		
	    private function beginDrag(event:MouseEvent):void
	    {
	   		// the drag source contains data about what's being dragged
		    var dragSource:DragSource = new DragSource();
		    // add some information to the drag source
     		dragSource.addData( HelpManager.VALUEINFO, HelpManager.INFO );
		    // ask the DragManger to begin the drag
		    var prxImg:IFlexDisplayObject 		= dragInitiator.getProxyImage();
		    DragManager.doDrag( dragInitiator, dragSource, event, prxImg);
	    }
	   
	    //==========================================================================
	    /**
	     * 
	     * @param target
	     * @param idTarget
	     */
	    private function addHelp(target:IHelp, idTarget:String): void
	    {
	    	listTarget[idTarget] = target;
	    	// 
	    	target.addEventListener(DragEvent.DRAG_ENTER, acceptDrop );
	    	// handling the drop...
     		target.addEventListener( DragEvent.DRAG_DROP, handleDrop );

     		//target.addEventListener( DragEvent.DRAG_COMPLETE, handleComplete );
			//
     		target.addEventListener( DragEvent.DRAG_EXIT, exitDrop );
     		 
	    }
		/**
		 * DragAndDrop accettato ho rilasciato il mouse
		 * @param dragEvent
		 * 
		 */		
		private function handleDrop( dragEvent:DragEvent ):void
		{
			var dropTarget:IUIComponent 	= dragEvent.currentTarget as IUIComponent;
			exitShow 		= true;
			hideFeedback(dropTarget as IHelp);
			// mostra messaggio
			showMessage(dropTarget as IHelp);
		}
		private function showMessage(dropTarget:IHelp):void
		{
			var msg:String 	= LabelStringManager.getInstance().findMessage( dropTarget.getIDHelp() );
			MessageManager.getInstance().addMessage(msg);
		}
		 
		/**
		 * se sto draggando ed entro dentro al component controllo se è da accettare 
		 * @param event
		 * 
		 */		
		private function acceptDrop(event:DragEvent):void
		{
			var dropTarget:IUIComponent = event.currentTarget as IUIComponent;
			var dragSource:DragSource 	= event.dragSource;
			if(dropTarget is IHelp)
			{
				var idMessage:String = IHelp(dropTarget).getIDHelp();
				// accept the drop if the drag source has a INFO format
		      	if( dragSource.hasFormat( HelpManager.INFO ) )
		      	{
		      		if(LabelStringManager.getInstance().existMessage( idMessage ))
		      		{
		      			//if(exitShow){ 
							DragManager.acceptDragDrop( dropTarget );
							showFeedback(dropTarget as IHelp);
		      			//}
						exitShow = false;
		        	}
		      	}
	      	}
		}
		private function exitDrop(event:DragEvent):void
		{
			var dropTarget:IUIComponent = event.currentTarget as IUIComponent;
			exitShow = true;
			hideFeedback(dropTarget as IHelp); 
		} 
		private function showFeedback(dropTarget:IHelp):void
		{
			if(dropTarget==null)return;
		 
			
			DragManager.showFeedback( DragManager.COPY );
			var importance:String 			=  LabelStringManager.getInstance().getImportance( dropTarget.getIDHelp() );
			var feedback:AbstractFeedback 	= FeedbackManager.getInstance().getFeedback(importance,dropTarget);
			listFeedback[dropTarget] 		= feedback;
			feedback.show();
		}
		private function hideFeedback(dropTarget:IHelp):void
		{
			// hide feedback
			DragManager.showFeedback( DragManager.NONE );
			var feedback:AbstractFeedback = listFeedback[dropTarget];
			if(feedback!=null)
				feedback.hide();
			delete listFeedback[dropTarget];
		}
	    /**
	     * 
	     * @param target
	     */
	    public function addHelpTarget(target:IHelp): void
	    {
	    	var id:String = target.getIDHelp();
	    	if( !exist(id) )
	    	{
	    		addHelp( target , id );
	    	}
	    }

	    /**
	     * 
	     * @param idTarget
	     */
	    public function exist(idTarget:String): Boolean
	    {
	    	return !(listTarget[idTarget] == null);
	    }

	    /**
	     * Rimuove dalla lista degli oggetti idHelp 
	     * @param idHelp
	     */
	    public function removeHelpTarget(idHelp:String): void
	    {
	    	if( exist(idHelp) )
	    	{
	    		var target:IHelp  = listTarget[idHelp];
	    		target.removeEventListener(DragEvent.DRAG_ENTER, acceptDrop );
	    		target.removeEventListener(DragEvent.DRAG_DROP, handleDrop );
				target.removeEventListener( DragEvent.DRAG_EXIT, exitDrop );
	    		delete listTarget[idHelp];
	    	}
	    }
	}//end HelpManager

}
class HideClass{}