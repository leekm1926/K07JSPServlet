<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chatting04.jsp</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<link rel="stylesheet" href="css/default.css"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
	var messageWindow;
	var inputMessage;
	var chat_id;
	var webSocket;
	window.onload = function(){
		messageWindow = document.getElementById("chat-container");

		//대화영역의 스크롤바를 항상 아래로 내려준다.
		messageWindow.scrollTop = messageWindow.scrollHeight;

		inputMessage = document.getElementById('inputMessage');

		chat_id = document.getElementById('chat_id').value;

		webSocket = new WebSocket(
				'ws://localhost:9999/K07JSPServlet/ChatServer02');
		webSocket.onopen = function(event) {
			wsOpen(event);
		};

		webSocket.onmessage = function(event) {
			wsMessage(event);
		};

		webSocket.onclose = function(event) {
			wsClose(event);
		};

		webSocket.onerror = function(event) {
			wsError(event);
		};
	}

	function wsOpen(event) {
		messageWindow.value += "연결성공\n";
	}

	function wsMessage(event) {
		var message = event.data.split("|");
		var sender = message[0];
		var content = message[1];
		var msg;

		if (content == "") {

		} else {
			if (content.match("/")) {
				if (content.match(("/" + chat_id))) {
					var temp = content.replace(("/" + chat_id), "[귓속말]");
					//메세지에 UI를 적용하는 부분
					msg = makeBalloon(sender, temp);
					messageWindow.innerHTML += msg;
					//대화영역의 스크롤바를 항상 아래로 내려준다.
					messageWindow.scrollTop = messageWindow.scrollHeight;
				}
			} else {
				msg = makeBalloon(sender, content);
				messageWindow.innerHTML += msg;
				//대화영역의 스크롤바를 항상 아래로 내려준다.
				messageWindow.scrollTop = messageWindow.scrollHeight;
			}
		}
	}
	
	//상대방이 보낸 메세지를 출력하기 위한 부분
	function makeBalloon(id, cont) {
		var msg = '';
		msg += '<div class="chat chat-left">';
		msg += '	<!-- 프로필 이미지 -->';
		msg += '	<span class="profile profile-img-b"></span>';
		msg += '	<div class="chat-box">';
		msg += '	<p style="font-weight:bold;font-size:1.1em;margin-bottom:5px;">'+id+'</p>';	
		msg += '	<p class="bubble">'+cont+'</p>';
		msg += '	<span class="bubble-tail"></span>';
		msg += '	</div>';
		msg += '</div>';
		return msg;
	}
	function wsClose(event) {
		messageWindow.value += "연결끊기성공\n";
	}
	function wsError(event) {
		alert(event.data);
	}
	function sendMessage() {
		//웹소켓 서버로 대화내용을 전송한다.
		webSocket.send(chat_id+'|'+inputMessage.value);
		
		//내가보낸 내용에 UI를 적용한다.
		var msg = '';
		msg += '<div class="chat chat-right">';
		msg += '	<!-- 프로필 이미지 -->';
		msg += '	<span class="profile profile-img-a"></span>';
		msg += '	<div class="chat-box">';
		msg += '		<p class="bubble-me">'+inputMessage.value+'</p>';
		msg += '		<span class="bubble-tail"></span>';
		msg += '	</div>';
		msg += '</div>';
		
		messageWindow.innerHTML += msg;
		inputMessage.value = "";
		
		//대화영역의 스크롤바를 항상 아래로 내려준다.
		messageWindow.scrollTop = messageWindow.scrollHeight;
	}
	function enterkey(){
		/*
		키보드를 눌렀다가 땠을 때 호출되며, 눌려진 키보드의
		키코드가 13일 때, 즉 엔터키일 때 아래 함수를 즉시 호출한다
		*/
		if(window.event.keyCode==13){
			sendMessage();
		}
	}
</script>
</head>
<body>
	<div id="chat-wrapper">
		<header id="chat-header">
			<h1>채팅창 - KOSMO1강의실</h1>
		</header>
		<input type="hid-den" id="chat_id" value="${param.chat_id }"
			style="border: 1px dotted red;" />
		<div id="chat-container" class="chat-area"
			style="height: 500px; overflow: auto;">

			<!-- 왼쪽 채팅 -->
			<!-- <div class="chat chat-left">
				<span class="profile profile-img-b"></span>
				<div class="chat-box">
					<p style="font-weight: bold; font-size: 1.1em; margin-bottom: 5px;">미르</p>
					<p class="bubble">
						낙자<br />뭐해?
					</p>
					<span class="bubble-tail"></span>
				</div>
			</div> -->
			<!-- 오른쪽 채팅 -->
			<!-- <div class="chat chat-right">
				<span class="profile profile-img-a"></span>
				<div class="chat-box">
					<p class="bubble-me">그냥 쉬고있는 중ㅋ</p>
					<span class="bubble-tail"></span>
				</div>
			</div> -->

		</div>
		<footer id="chat-footer">
			<p class="text-area">
				<!-- 메세지 입력창 -->
				<input type="text" id="inputMessage" onkeyup="enterkey();"
					style="width: 450px; height: 60px; font-size: 1.5em; border: 0px;" />
				<button type="button" onclick="sendMessage();">보내기</button>
			</p>
		</footer>
	</div>
</body>

<!-- <script>
	//대화가 디스플레이 되는 영역	
	var messageWindow = document.getElementById("messageWindow");
	//대화내용을 입력하는 부분
	var inputMessage = document.getElementById('inputMessage');
	//접속자 ID를 가져오는 부분(현재는 랜덤하게 생성되는 세션아이디를 사용)
	var chat_id = document.getElementById('chat_id').value;
	//웹소켓 객체를 생성하여 채팅서버에 접속
	var webSocket = new WebSocket(
			'ws://localhost:9999/K07JSPServlet/ChatServer02');

	/*
		웹소켓 서버에 연결한 후 메세지 전송, 에러발생 등은 모두 이벤트를 통해
		각각의 함수를 호출한다. 이때 각 함수쪽으로 이벤트 객체가 매개변수로 전달된다.
	 */
	webSocket.onopen = function(event) {
		wsOpen(event);
	};

	webSocket.onmessage = function(event) {
		wsMessage(event);
	};

	webSocket.onclose = function(event) {
		wsClose(event);
	};

	webSocket.onerror = function(event) {
		wsError(event);
	};

	function wsOpen(event) {
		messageWindow.value += "연결성공\n";
	}
	function wsClose(event) {
		messageWindow.value += "연결끊기 성공\n";
	}
	function wsError(event) {
		alert(event.data);
	}
	//웹소켓서버가 메세지를 받은 후 클라이언트에게 Echo할 때 처리부분.
	function wsMessage(event) {
		//메세지를 | 구분자로 split(분리)한다.
		var message = event.data.split("|");
		//첫번째 부분은 전송한 사람의 아이디
		var sender = message[0];
		//두번째 부분은 채팅내용
		var content = message[1];
		if (content == "") {

		} else {
			//보낸 메세지에...
			if (content.match("/")) {
				//슬러시가 포함되어 있다면 명령어로 인식하고...
				if (content.match(("/" + chat_id))) {
					//귓속말 명령어를 한글로 대체한 후 ...
					var temp = content.replace(("/" + chat_id), "[귓속말]:");
					//귓속말을 받을 클라이언트한테만 내용을 출력한다.
					messageWindow.value += sender + "" + temp + "\n";
				}
			} else {
				//슬러시가 없다면 일반 메세지이므로 클라이언트 전체에게 출력한다.
				messageWindow.value += sender + ":" + content + "\n";
			}
		}
	}
	//클라이언트가 메세지를 입력 후 '보내기' 버튼을 누를 때 호출
	function sendMessage() {
		//대화창에 입력한 내용에 Me를 추가한다.
		messageWindow.value += "나(Me):" + inputMessage.value + "\n";
		/*
		대화내용에 접속자 아이디(세션아이디)를 파이프기호로 연결한 후
		send()를 통해 서버로 전송한다.
		 */
		webSocket.send(chat_id + '|' + inputMessage.value);
		//입력했던 대화내용을 지워준다.
		inputMessage.value = "";
	} 
</script>-->
</html>