package {

import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldType;

[SWF(width="300",height="600")]
public class Main extends Sprite {

    private var sock:SocketSender ;
    var textField:TextField = new TextField();
    var textField2:TextField = new TextField();

    public function Main() {
        textField.border = true ;
        textField.embedFonts = false ;
        textField.type = TextFieldType.INPUT ;
        textField.width = 300 ;
        textField.height = 300 ;

        textField2.border = true ;
        textField2.embedFonts = false ;
        textField2.type = TextFieldType.INPUT ;
        textField2.width = 300 ;
        textField2.height = 300 ;
        textField2.y = 300 ;

        addChild(textField);
        addChild(textField2);

        textField.addEventListener(Event.CHANGE,sendNewSocket);
    }

    private function sendNewSocket(e:Event):void
    {
        trace("Text changed");
        sock = new SocketSender("37.156.28.129",31001);
        sock.addEventListener(Event.COMPLETE,onDataRecevedFromSocket);
        sock.addEventListener(Event.UNLOAD,noInternet);
        sock.send(textField.text);
    }

    private function noInternet(e:Event):void
    {
        textField2.text = "No internet";
    }

    private function onDataRecevedFromSocket(e:Event):void
    {
        textField2.text = sock.data ;
    }
}
}
