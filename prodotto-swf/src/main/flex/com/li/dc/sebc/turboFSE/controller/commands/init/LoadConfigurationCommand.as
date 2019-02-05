///////////////////////////////////////////////////////////
//  LoadConfigurationCommand.as
//  Macromedia ActionScript Implementation of the Class LoadConfigurationCommand
//  Generated by Enterprise Architect
//  Created on:      31-ago-2010 18:21:59
//  Original author: Marco Salonia
///////////////////////////////////////////////////////////

package com.li.dc.sebc.turboFSE.controller.commands.init
{
	import com.li.dc.sebc.turboFSE.business.FactoryService;
	import com.li.dc.sebc.turboFSE.controller.commands.ResponderCommand;
	import com.li.dc.sebc.turboFSE.model.ConstDataProxy;
	import com.li.dc.sebc.turboFSE.model.Costanti;
	import com.li.dc.sebc.turboFSE.model.FSEModel;
	import com.li.dc.sebc.turboFSE.model.QueryConst;
	import com.li.dc.sebc.turboFSE.model.vo.Configuration;
	import com.li.dc.sebc.turboFSE.model.vo.DebugConfig;
	import com.li.dc.sebc.turboFSE.model.vo.PopupConfig;
	import com.li.dc.sebc.turboFSE.util.UtilDate;
	
	import flash.utils.Dictionary;
	
	import it.lispa.siss.sebc.flex.debug.Debug;
	import it.lispa.siss.sebc.flex.mvc.controller.ISequenceReference;
	import it.lispa.siss.sebc.middleground.entity.DatoCodificato;
	import it.lispa.siss.sebc.middleground.entity.PercorsoDiagnosticoTerapeutico;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.events.ResultEvent;
	 

	/**
	 * Carica la configurazione da remoto
	 * @author Marco Salonia
	 * @version 1.0
	 * @created 31-ago-2010 18:21:59
	 */
	public class LoadConfigurationCommand extends ResponderCommand
	{
		private var reference:ISequenceReference;
		public function LoadConfigurationCommand()
		{
			super();
		}
	    /**
	     * 
	     * @param event
	     */
	    override public function execute( data:Object = null): void
	    {
			if( data is ISequenceReference)
			{
				reference 					=  data as ISequenceReference;
				
				var m:FSEModel 				= FSEModel.getInstance();
				var dictQuery:Dictionary	= m.queryParams;
				var urlXmlConfig:String		= dictQuery[QueryConst.XML_CONFIGURATION];
				if(urlXmlConfig==null || urlXmlConfig.length==0)
				{
					urlXmlConfig 			= Costanti.URL_XML_CONF;
				} 
				Debug.logDebug( "LoadConfigurationCommand.execute carica xml di config" );
				FactoryService.getInstance().getLoadXml( this, urlXmlConfig ).execute();
			}
	    }
	    private function next( data:Object = null ):void
	    {
	    	reference.nextCommand( data );
	    }
	    /**
	     * 
	     * @param info
	     */
		override public function fault(info:Object): void
	    {
			startConfiguration(info);
	    }
	    /**
	     * 
	     * @param data Non contiene Response
	     */
		override public function result(data:Object): void
	    {
	    	startConfiguration(data);
	    }
	    private function startConfiguration(data:Object):void
	    {
	    	var conf:Configuration;
	    	Debug.logDebug( "LoadConfigurationCommand.execute START parser xml config" );
	    	if(data is ResultEvent)
	    	{
	    		var ev:ResultEvent = data as ResultEvent;
	    		conf	=  createConfiguration(  ev.result as XML ); 
	    	}else
	    	{
	    		conf	= createDefault();
	    	}
	    	FSEModel.getInstance().destination	= conf.destination;
	    	FSEModel.getInstance().retrieveProxy(ConstDataProxy.DATA_CONFIGURATION).update( conf );
	    	Debug.logDebug( "LoadConfigurationCommand.execute STOP parser xml config" );
	    	next( );
	    }
	    
	    private function createConfiguration( x:XML = null):Configuration
	    {
	    	var conf:Configuration;
	    	if(x == null)
	    	{
	    		conf = createDefault();
	    	}else
	    	{
		    	if(x.length()>0)
		    	{
		    		var m:FSEModel					= FSEModel.getInstance();
	    			var queryParams:Dictionary		= m.queryParams;
		    		conf				 			= new Configuration();
		    		conf.autorizza					= Boolean( x.child( "autorizza" ) );
		    		conf.apriChiudiPdt				= Boolean( x.child( "apriChiudiPdt" ) );
		    		
		    		setDataFlussi(conf, queryParams, x);
		    		 
		    		var destination:String			= queryParams[QueryConst.DESTINATION];
		    		var urlGado:String				= queryParams[QueryConst.URL_GADO];
		    		  
		    		conf.destination  				= x.child( "destination" );
		    		conf.urlGado	  				= x.child( "urlGado" );
		    		 	
		    		if(destination!=null && destination.length>0)
		    		{
		    			conf.destination	= destination;
		    		} 
		    		if(urlGado!=null && urlGado.length>0)
		    		{
		    			conf.urlGado	= urlGado;
		    		} 
		    		if(conf.urlGado==null || conf.urlGado.length==0)
		    		{
		    			conf.urlGado	= Costanti.URL_GADO;
		    		} 
		    		conf.debug				= getDebugQuery( getDebug( x.child( "debug" )[0] as XML) );  
		    		conf.listaCodiciPDT		= getListaCodiciPDT( x.child( "listaCodiciPDT" )[0] as XML);
		    		conf.listCopyDCEInPdt	= getListaCodiciDCE( x.child( "listCopyDCEInPdt" )[0] as XML);
		    		conf.popup				= getPopUpQuery( getPopUpConfig( x.child( "popup" )[0] as XML) );
		    		conf.temporale			= x.child( "temporale" );		
		    	}
	    	}
	    	return conf;
	    }
	    private function getPopUpQuery(pop:PopupConfig):PopupConfig
	    {
	    	var m:FSEModel					= FSEModel.getInstance();
	    	var queryParams:Dictionary		= m.queryParams;
	    	var urlHtmlContainer:String		= queryParams[QueryConst.URL_CONTAINER];
	    	if(urlHtmlContainer!=null && urlHtmlContainer.length>0)
	    	{
	    		pop.urlHtmlContainer		= urlHtmlContainer;
	    	}
	    	var urlModuloCollector:String	= queryParams[QueryConst.URL_COLLECTOR];
	    	if(urlModuloCollector!=null && urlModuloCollector.length>0)
	    	{
	    		pop.urlModuloCollector		= urlModuloCollector;
	    	}
	    	var urlModuloComunicator:String	= queryParams[QueryConst.URL_COMUNICATOR];
	    	if(urlModuloComunicator!=null && urlModuloComunicator.length>0)
	    	{
	    		pop.urlModuloComunicator		= urlModuloComunicator;
	    	} 
	    	var urlModuloVisualizer:String	= queryParams[QueryConst.URL_VISUALIZER];
	    	if(urlModuloVisualizer!=null && urlModuloVisualizer.length>0)
	    	{
	    		pop.urlModuloVisualizer	= urlModuloVisualizer;
	    	}  
	    	return pop;
	    } 
	    private function getPopUpConfig(x:XML = null):PopupConfig 
	    {
	    	if(x==null)return getDefaultPopUpConfig();
	    	if(x.length()>0)
	    	{
	    		var pop:PopupConfig 		= new PopupConfig();
	    		pop.urlHtmlContainer		= x.child( "urlHtmlContainer" );
	    		pop.urlModuloCollector		= x.child( "urlModuloCollector" );
	    		pop.urlModuloComunicator	= x.child( "urlModuloComunicator" );
	    		pop.urlModuloVisualizer		= x.child( "urlModuloVisualizer" );
	    		return pop;
	    	}
	    	return getDefaultPopUpConfig();
	    }
	    private function getDefaultPopUpConfig():PopupConfig
	    {
	    	var pop:PopupConfig 		= new PopupConfig();
    		pop.urlHtmlContainer		= Costanti.URL_CONTAINER;
    		pop.urlModuloCollector		= Costanti.URL_COLLECTOR;
    		pop.urlModuloComunicator	= Costanti.URL_COMUNICATOR;
    		pop.urlModuloVisualizer		= Costanti.URL_VISUALIZER;
    		return pop;
	    }
	    private function getListaCodiciDCE(x:XML=null):ArrayCollection/* di DatoCodificato */
	    {
	    	if(x==null)return getDefaultListaDCE();
	    	if(x.length()>0){
		    	var children:XMLList = x.children();
		    	if(children!=null && children.length()>0)
		    	{
		    		var list:ArrayCollection = new ArrayCollection();
		    		for(var i:uint = 0;i<children.length();i++)
		    		{
		    			var cod:String 	= children[i].child("codice");
		    			var desc:String	= children[i].child("descrizione");
		    			if(cod!=null && cod.length>0 )
		    			{
		    				var dc:DatoCodificato	= new DatoCodificato(cod,desc);
		    				list.addItem( dc );
		    			}
		    		}
		    		return list;
		    	} 
	    	}
	    	return getDefaultListaDCE();
	    }
	    private function getDefaultListaDCE(x:XML=null):ArrayCollection/* di DatoCodificato */
	    {
	     	var list:ArrayCollection = new ArrayCollection();
	    	list.addItem(  new DatoCodificato("05","") );
	    	return list;
	    }
	    private function getListaCodiciPDT(x:XML=null):ArrayCollection/* di pdt */
	    {
	    	if(x==null)return getDefaultListaPDT();
	    	if(x.length()>0){
		    	var list:ArrayCollection 	= new ArrayCollection();
		    	var children:XMLList		= x.children();
	    		for(var i:uint = 0;i<children.length();i++)
	    		{
	    			var cod:String 	= children[i].child("codice");
	    			var desc:String	= children[i].child("descrizione");
	    			if(cod!=null && cod.length>0 && desc!=null && desc.length>0)
	    			{ 
	    				var pdt:PercorsoDiagnosticoTerapeutico	= new PercorsoDiagnosticoTerapeutico();
	    				pdt.PDT = new DatoCodificato( cod, desc );
	    				list.addItem( pdt );
	    			}
	    		}
	    		return list;
	    	}
	    	return getDefaultListaPDT();
	    }
	    private function getDefaultListaPDT():ArrayCollection
	    {
	    	var list:ArrayCollection = new ArrayCollection();
	    	var pdt:PercorsoDiagnosticoTerapeutico	= new PercorsoDiagnosticoTerapeutico();
	    	pdt.PDT = new DatoCodificato("A.428","SCOMPENSO CARDIACO")
	    	list.addItem( pdt );
	    	return list;
	    }
	    private function getDebug(x:XML = null):DebugConfig
	    {
	    	if(x==null)return getDebugDefault();
	    	if(x.length()>0)
	    	{
	    		var deb:DebugConfig	= new DebugConfig();
	    		deb.openDebug		= x.child( "openDebug" );
	    		deb.livello			= x.child( "livello" );
	    		deb.urlConsole		= x.child( "urlConsole" );
	    		deb.nomeConsole		= x.child( "nomeConsole" );
	    		deb.nomeDebug		= x.child( "nomeDebug" );
	    		return deb;
		    	 
	    	}
	    	return getDebugDefault();
	    }
	    private function getDebugQuery(deb:DebugConfig):DebugConfig 
	    {
	    	var m:FSEModel				= FSEModel.getInstance();
	    	var queryParams:Dictionary	= m.queryParams;
	    	var opndbg:String			= queryParams[QueryConst.OPEN_DEBUG];
	    	if(opndbg!=null && opndbg.length>0)
	    	{
	    		deb.openDebug	= Boolean(opndbg);
	    	}
	    	var liv:String		= queryParams[QueryConst.LEVEL_DEBUG];
	    	if(liv!=null && liv.length>0)
	    	{
	    		deb.livello 	= Number(liv);
	    	}
	    	var url:String		= queryParams[QueryConst.URL_CONSOLE_DEBUG];
	    	if(url!=null && url.length>0)
	    	{
	    		deb.urlConsole 	= url;
	    	}
	    	return deb;
	    }
	    private function getDebugDefault():DebugConfig 
	    {
	    	var deb:DebugConfig	= new DebugConfig();
    		deb.openDebug		= Costanti.OPEN_DEBUG;
    		deb.livello			= Costanti.DEFAULT_LEVEL_DEBUG;
    		deb.urlConsole		= Costanti.URL_CONSOLE_DEBUG
    		deb.nomeConsole		= Costanti.NOME_CONSOLE;
    		deb.nomeDebug		= Costanti.NOME_DEBUG;
    		return deb;
	    } 
	    private function setDataFlussi(conf:Configuration,queryParams:Dictionary=null,x:XML=null):void
	    {
	    	var dataFineFlussi:String		= null;
		    var dataInizioFlussi:String		= null;
		    
		    if(queryParams!=null)
		    {
		    	dataFineFlussi 		= queryParams[QueryConst.DATA_FINE_FLUSSI];
		    	dataInizioFlussi 	= queryParams[QueryConst.DATA_INIZIO_FLUSSI];
		    }
		   
	    	if(x!=null)
	    	{
	    		if(dataInizioFlussi==null || dataInizioFlussi.length==0)dataInizioFlussi 	= x.child( "dataInizioFlussi" );
	    		if(dataFineFlussi==null || dataFineFlussi.length==0)dataFineFlussi 		= x.child( "dataFineFlussi" );
	    	}	
	    	
	    	if(dataInizioFlussi==null 
	    	|| dataInizioFlussi.length==0
	    	|| dataFineFlussi==null
	    	|| dataFineFlussi.length==0)
	    	{
	    		var today:Date			= new Date();
    			var yesterday:Date		= getYesterday();
    			dataFineFlussi 			= UtilDate.formatterDate(today,UtilDate.FORMATTER_STRING_DATA);
    			dataInizioFlussi 		= UtilDate.formatterDate(yesterday,UtilDate.FORMATTER_STRING_DATA);
	    	}
		    conf.dataInizioFlussi	= dataInizioFlussi
		    conf.dataFineFlussi		= dataFineFlussi;
	    }
	    private function getYesterday():Date
	    {
	    	var today:Date			= new Date();
    		var month:Number		= today.getMonth() - 3;
    		var f:Boolean			= (month<0);
    		month					= f ? 11+month+1 : month;
    		var year:uint			= f ? today.fullYear - 1: today.fullYear;
    		return  new Date(year ,month, today.date);
	    }
	    private function createDefault():Configuration
	    {
	    	var m:FSEModel				= FSEModel.getInstance();
	    	var queryParams:Dictionary	= m.queryParams;
	    	var opndbg:String			= queryParams[QueryConst.OPEN_DEBUG];
	    	 
	    	
	    	var conf:Configuration 	= new Configuration();
    		conf.autorizza			= false;
    		conf.apriChiudiPdt		= false;
    		
    		setDataFlussi(conf);
    		
    		conf.destination  		= Costanti.DEFAULT_DESTINATION;
    		conf.temporale			= Costanti.URL_TEMPORALE;
    		
    		conf.debug				= getDebugQuery(getDebugDefault());  
    		conf.listaCodiciPDT		= getDefaultListaPDT();
    		conf.listCopyDCEInPdt	= getDefaultListaDCE();
    		conf.popup				= getPopUpQuery(getDefaultPopUpConfig());
    		return conf;
	    }
	     
	}//end LoadConfigurationCommand

}