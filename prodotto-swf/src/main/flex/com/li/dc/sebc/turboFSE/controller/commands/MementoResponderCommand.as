///////////////////////////////////////////////////////////
//  MementoResponderCommand.as
//  Macromedia ActionScript Implementation of the Class MementoResponderCommand
//  Generated by Enterprise Architect
//  Created on:      30-ago-2010 23:53:10
//  Original author: marco
///////////////////////////////////////////////////////////

package com.li.dc.sebc.turboFSE.controller.commands
{
	import com.li.dc.sebc.turboFSE.memento.IMemento;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.memento.IOriginatorMemento;

	/**
	 * @author marco
	 * @version 1.0
	 * @created 30-ago-2010 23:53:10
	 */
	public class MementoResponderCommand extends ResponderCommand implements IOriginatorMemento
	{
		public function MementoResponderCommand(){

		}

	    public function createMemento(): IMemento
	    {
	    }

	}//end MementoResponderCommand

}