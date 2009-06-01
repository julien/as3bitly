package ly.bit {
	import flash.events.Event;
	
	public class BitlyEvent extends Event {
		
		public var data:Object;
		
		public static const COMPLETE:String = "complete";
		public static const ERROR:String = "error";
		
		public function BitlyEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
		}	
				
	}
}
