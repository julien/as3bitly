package {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import ly.bit.Bitly;
	import ly.bit.BitlyEvent;
	
	public class BitlyDemo extends Sprite {
					
		protected var b:Bitly;
				
		public function BitlyDemo() {
			
			b = new Bitly("BITLY_LOGIN", "BITLY_API_KEY");
			
			b.addEventListener(BitlyEvent.ERROR, errorListener);
			b.addEventListener(BitlyEvent.COMPLETE, completeListener);
			
			b.shorten("SOME_URL");
			// other examples
			//  b.expand("http://bit.ly/tdqUo");
           	//  b.info("http://bit.ly/tdqUo");
        	// b.stats("http://bit.ly/tdqUo");
			// b.errors();
		}			
		
		protected function completeListener(e:BitlyEvent):void {
			trace("complete : ", e.data);		
		}
		
		protected function errorListener(e:BitlyEvent):void {
			trace("an error occured ...", e.data);
		}
	}	
}
