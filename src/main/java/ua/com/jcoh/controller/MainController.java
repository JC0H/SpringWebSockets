package ua.com.jcoh.controller;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import ua.com.jcoh.models.Greeting;
import ua.com.jcoh.models.HelloMessage;

@Controller
public class MainController {

    @GetMapping("/")
    public String index(){
        return "index";
    }

    @GetMapping("/chat")
    public String chat(){
        return "chat";
    }

    @MessageMapping("/hello")
    @SendTo("/topic/greeting")
    public Greeting greeting(HelloMessage helloMessage){
        return new Greeting("Hello" + helloMessage.getName());
    }
}
