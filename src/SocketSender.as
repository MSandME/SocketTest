/**
 * Created by mes on 1/4/2017.
 */
package {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.IOErrorEvent;
import flash.events.ProgressEvent;
import flash.net.Socket;

public class SocketSender extends EventDispatcher {

    private var sock:Socket ;

    public var data:String ;

    private var tosend:String ;

    private var Ip:String,Port:uint;

    public function SocketSender(ip:String,port:uint) {
        super();
        Ip = ip ;
        Port = port ;
    }

    public function send(str:String):void
    {
        tosend = str ;

        sock = new Socket();
        sock.addEventListener(ProgressEvent.SOCKET_DATA,socketDataRecevied);
        sock.addEventListener(Event.CONNECT,socketConnected);
        sock.addEventListener(IOErrorEvent.IO_ERROR,noConnectionAvailable);

        sock.connect(Ip,Port);
    }

    /**Connection fails*/
    protected function noConnectionAvailable(event:IOErrorEvent):void
    {
        trace("!! The connection fails");
        this.dispatchEvent(new Event(Event.UNLOAD));
    }


    /**Socket connection is connected*/
    private function socketConnected(e:Event):void
    {
        trace(">>Now send this : "+tosend);
        sock.writeUTFBytes(tosend);
        sock.flush();
    }

    private function socketDataRecevied(e:ProgressEvent):void
    {
        trace("Socket data returnd");
        data = sock.readUTFBytes(sock.bytesAvailable);
        sock.close();
        this.dispatchEvent(new Event(Event.COMPLETE));
    }
}
}
