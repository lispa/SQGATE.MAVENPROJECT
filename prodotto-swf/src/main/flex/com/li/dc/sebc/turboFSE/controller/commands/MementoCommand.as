///////////////////////////////////////////////////////////
//  MementoCommand.as
//  Macromedia ActionScript Implementation of the Class MementoCommand
//  Generated by Enterprise Architect
//  Created on:      30-ago-2010 23:53:37
//  Original author: marco
///////////////////////////////////////////////////////////

package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.memento.IMemento;
	import com.li.dc.sebc.turboFSE.controller.AbstractCommand;
	import com.li.dc.sebc.turboFSE.memento.IOriginatorMemento;

	/**
	 * @author marco
	 * @version 1.0
	 * @created 30-ago-2010 23:53:37
	 */
	public class MementoCommand extends AbstractCommand implements IOriginatorMemento
	{
		public function MementoCommand(){

		}

	    public function createMemento(): IMemento
	    {
	    }

	}//end MementoCommand

}