///////////////////////////////////////////////////////////
//  PushMementoCommand.as
//  Macromedia ActionScript Implementation of the Class PushMementoCommand
//  Generated by Enterprise Architect
//  Created on:      27-ago-2010 0.22.18
//  Original author: marco
///////////////////////////////////////////////////////////

package com.li.dc.sebc.turboFSE.controller.commands
{
	 
	import it.lispa.siss.sebc.flex.memento.IMemento;
	import it.lispa.siss.sebc.flex.memento.ManagerMemento;
	import it.lispa.siss.sebc.flex.mvc.controller.Command;
	 

	/**
	 * @author marco
	 * @version 1.0
	 * @created 27-ago-2010 0.22.18
	 */
	public class PushMementoCommand extends Command
	{
		public function PushMementoCommand(){

		}
	    /**
	     * 
	     * @param event
	     */
		override public function execute( data:Object = null): void
	    {
			ManagerMemento.getInstance().push( data as IMemento );
	    }

	}//end PushMementoCommand

}