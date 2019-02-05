package it.lisit.siss.flex.communication.crm.voRichiediURLImagine
{
	import it.lisit.siss.flex.communication.ValueObject;

	public class VoOutputRichiediURLImmagine extends ValueObject
	{
		/**
		 * Definizione:		Codice fiscale del cittadino.
		 * Vincoli:			Stringa alfanumerica di lunghezza 16 con lettere maiuscole .
		 * Obbligatorio:	SI
		 */		
		public var codiceFiscale:String;
		
		/**
		 * Definizione:		URI che identifica univocamente il referto.
		 * Vincoli:			Stringa alfanumerica .
		 * Obbligatorio:	SI
		 */		
		public var linkReferto:String;
		
		/**
		 * Definizione:		Codice che identifica univocamente l’immagine nel sistema di archiviazione di pertinenza.Il codice rappresenta lo Study-id dell’immagine.
		 * Vincoli:			Stringa alfanumerica .
		 * Obbligatorio:	SI
		 */		
		public var linkImmagine:String;
		
		/**
		 * Definizione:		Codice che identifica la tipologia dell’immagine . 
		 * Vincoli:			Stringa alfanumerica che codifica il tipo/tecnologia usata 
		 * 	per la visualizzazione. Per una più esaustiva trattazione si veda il documento 
		 * 	di riferimento DC-SEBC_CRM-SIAA#01 (e.g tipoImmagine =”01” per la tecnologia 
		 * 	di immagini visualizzabili tramite web browser).
		 * Obbligatorio:	SI
		 */		
		public var tipoImmagine:String;
		
		/**
		 * Definizione: 	URL dell’immagine riferita all’applicazione WEB in grado di 
		 * 	visualizzare l’immagine associata ad un referto medico precedentemente registrato .
		 * Vincoli:			‘URLimmagine’ è un dato che deve poter essere fruibile direttamente 
		 * 	in una istanza di browser operante da un Pdl SISS attestato sulla EXTRANET. 
		 * 	Il dato URLimmagine include il ‘gettone’ che rende la richiesta del Client 
		 * 	spendibile in un periodo di tempo limitato e per una unica consultazione, 
		 * 	Stringa alfanumerica (e.g. :”https:// xxx.yyy.zzz/kkk/…”) .
		 * Obbligatorio:	SI
		 */		
		public var urlImmagine:String;
		
		public function VoOutputRichiediURLImmagine()
		{
			super();
		}
		
	}
}