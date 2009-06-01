package ly.bit {
	/**
	 * The Bitly class lets you use the bit.ly webservice in 
	 * ActionScript code
	 *
	 * @author	Julien Castelain	<jcastelain@gmail.com>
	 * @version	0.1
	 * @see		http://code.google.com/p/bitly-api/wiki/ApiDocumentation
	 */	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLVariables;
	import flash.net.URLRequest;	
	
	[Event(name="error", type="ly.bit.BitlyEvent")]
	[Event(name="complete", type="ly.bit.BitlyEvent")]

	public class Bitly extends EventDispatcher {
	
	    private static const API_VERSION:String = "2.0.1";
		private static const FORMAT_JSON:String = "json";
	    private static const FORMAT_XML:String = "xml";
	    	    
	    private var _login:String;
	    private var _apiKey:String;
	      
	    protected var loader:URLLoader;
	    
	    public function Bitly(login:String, apiKey:String) {	
	    	_login = login;
	    	_apiKey = apiKey;
	    		    	
	    	loader = new URLLoader();
	    	loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorListener);
	    }
	    
	    public function get login():String {
	    	return _login;
	    }
	    
	    public function set login(value:String):void {
	    	_login = value;
	    }	
	    
	    public function get apiKey():String {
	    	return _apiKey;
	    }
	    
	    public function set apiKey(value:String):void {
	    	_apiKey = value;
	    }	
	    
	    
	    public function shorten(longUrl:String):void {
	    	loader.addEventListener(Event.COMPLETE, completeListener);
	    	var r:URLRequest = new URLRequest("http://api.bit.ly/shorten");
	    	var v:URLVariables = new URLVariables();
	    	v.version = API_VERSION;
	    	v.login = _login;
	    	v.apiKey = _apiKey;
	    	v.format = FORMAT_XML;
	    	v.longUrl = longUrl;
	    	r.data = v;
	    	loader.load(r);
	    }
	    
	    public function expand(shortUrl:String):void {
	    	loader.addEventListener(Event.COMPLETE, completeListener);
	    	var r:URLRequest = new URLRequest("http://api.bit.ly/expand");
	    	var v:URLVariables = new URLVariables();
	    	v.version = API_VERSION;
	    	v.login = _login;
	    	v.apiKey = _apiKey;
	    	v.format = FORMAT_XML;
	    	v.shortUrl = shortUrl;
	    	r.data = v;
	    	loader.load(r);
	    }
	    
	    public function info(shortUrl:String):void {
	    	loader.addEventListener(Event.COMPLETE, completeListener);
	    	var r:URLRequest = new URLRequest("http://api.bit.ly/info");
	    	var v:URLVariables = new URLVariables();
	    	v.version = API_VERSION;
	    	v.login = _login;
	    	v.apiKey = _apiKey;
	    	v.format = FORMAT_XML;
	    	v.shortUrl = shortUrl;
	    	r.data = v;
	    	loader.load(r);
	    }
	    
	    public function stats(shortUrl:String):void {
	    	loader.addEventListener(Event.COMPLETE, completeListener);
	    	var r:URLRequest = new URLRequest("http://api.bit.ly/stats");
	    	var v:URLVariables = new URLVariables();
	    	v.version = API_VERSION;
	    	v.login = _login;
	    	v.apiKey = _apiKey;
	    	v.format = FORMAT_XML;
	    	v.shortUrl = shortUrl;
	    	r.data = v;
	    	loader.load(r);
	    }
	    
	    public function errors():void {
	    	loader.addEventListener(Event.COMPLETE, completeListener);
	    	var r:URLRequest = new URLRequest("http://api.bit.ly/errors");
	    	var v:URLVariables = new URLVariables();
	    	v.version = API_VERSION;
	    	v.login = _login;
	    	v.apiKey = _apiKey;
	    	v.format = FORMAT_XML;
	    	r.data = v;
	    	loader.load(r);
	    }
	    	    
	    protected function ioErrorListener(e:IOErrorEvent):void {
	    	// TODO : handle the error here...
	    	var event:BitlyEvent = new BitlyEvent(BitlyEvent.ERROR);
	    	event.data = e.text;
	    	dispatchEvent(e);
	    }
	    
	    protected function completeListener(e:Event):void {
	    	loader.removeEventListener(e.type, arguments.callee);
	    	var d:XML = new XML(loader.data);
	    	var event:BitlyEvent;
	    	if(d.errorCode == 0 && d.statusCode == "OK") {
	    		event = new BitlyEvent(BitlyEvent.COMPLETE);
	    		event.data = d.results;
	    		dispatchEvent(event);
	    	} else {
	    		event = new BitlyEvent(BitlyEvent.ERROR);
	    		event.data = d.errorMessage;
	    		dispatchEvent(event);
	    	}
	    }
	}	
	
}
