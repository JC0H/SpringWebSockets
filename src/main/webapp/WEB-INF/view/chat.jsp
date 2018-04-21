<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Chat</title>
    <script src="/resources/sockjs-0.3.4.js"></script>
    <script src="/resources/stomp.js"></script>
    <script>
        var stompClient = null;
        function connect() {
            var socket = new SockJS('/hello');
            stompClient.Stomp.over(socket);
            stompClient.connect({}, function (frame) {
                setConnected(true);//!!!!!!!!!!!!!!!!!!!
                console.log("Connected" + frame);
                stompClient.subscribe('/topic/greetings',function (greeting) {
                    showGreeting(JSON.parse(greeting.body).content())//!!!!!!!!!!!!!!!!!!!!!!!!!
                    console.log(JSON.parse(greeting.body).content);
                })
            })
        }
        function setConnected(connected) {
            console.log(connected);
            document.getElementById("connect").disable = connected;
            document.getElementById("disconnect").disable = !connected;
            document.getElementById('conversationDiv').style.visibility = connected ? 'visible' : 'hidden';
            document.getElementById('response').innerHTML = '';
        }
        function showGreeting(message) {
            var response = document.getElementById('response');
            var p = document.createElement('p');
            p.style.wordWrap = "break-word";
            p.appendChild(document.createTextNode(message))
            response.appendChild(p);
        }
        
        function disconnect() {
            stompClient.disconnect();
            setConnected(false);
            console.log("Disconnected");

        }
        
        function sendName() {
            var name = document.getElementById("name").value;
            stompClient.send("/app/hello" , {} , JSON.stringify({'name':name}));
        }
    </script>
</head>
<body>
    <div>
        <button id="connect" onclick="connect()">Connect</button>
        <button id="disconnect" disabled = "disabled" onclick="disconnect()">Disconnect</button>
    </div>
    <div id="conversationDiv">
        <input type="text" id="name">
        <button id="sendName" onclick="sendName()">send name</button>
        <p id="response"></p>
    </div>
</body>
</html>
