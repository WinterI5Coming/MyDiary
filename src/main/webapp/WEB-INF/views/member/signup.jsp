<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
></script>
<title>Insert title here</title>
<script>
$(function () {
	  // 아이디 이벤트
	  $("#memberId").on("blur", function () {
	    let tmpMemberId = $("#memberId").val();
	    console.log(tmpMemberId);

	    if (tmpMemberId.length < 4 || tmpMemberId.length > 8) {
	      outputError("아이디는 4~8자로 입력하세요", $("#memberId"), "red");
	    } else {
	      // 아이디 중복 체크
	      $.ajax({
	        url: "/member/isDuplicate", // 데이터가 송수신될 서버의 주소
	        type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
	        data: {
	          tmpMemberId: tmpMemberId,
	        },
	        dataType: "json", // 수신받을 데이터 타입 (MIME TYPE)
	        // async: false, // 동기 통신 방식
	        success: function (data) {
	          // 통신이 성공하면 수행할 함수
	          console.log(data);
	          if (data.msg == "duplicated") {
	            outputError("중복된 아이디입니다.", $("#memberId"), "red");
	            $("#idValid").val("");
	          } else if (data.msg == "not-duplicated") {
	            outputError("완료", $("#memberId"), "green");
	            $("#idValid").val("checked");
	          }
	        },
	        error: function () {},
	        complete: function () {},
	      });

	      outputError("완료", $("#memberId"), "green");
	    }
	  });

	  // 비밀번호 체크
	  $("#memberPwd1").blur(function () {
	    // 비밀번호 4~8자
	    let tmpPwd = $("#memberPwd1").val();

	    if (tmpPwd.length < 4 || tmpPwd.length > 8) {
	      outputError("비밀번호는 4~8자로 입력하세요", $("#memberPwd1"), "red");
	      $("#memberPwd1").val("");
	    } else {
	      outputError("완료", $("#memberPwd1"), "green");
	    }
	  });

	  $("#memberPwd2").blur(function () {
	    let tmpPwd2 = $("#memberPwd2").val();
	    let tmpPwd1 = $("#memberPwd1").val();

	    if (tmpPwd1.length < 4 || tmpPwd1.length > 8) {
	      return;
	    }

	    if (tmpPwd1 != tmpPwd2) {
	      outputError("비밀번호가 다릅니다.", $("#memberPwd1"), "red");
	      outputError("비밀번호가 다릅니다.", $("#memberPwd2"), "red");

	      $("#memberPwd1").val("");
	      $("#memberPwd2").val("");
	      $("#memberPwd1").focus();
	      $("#pwdValid").val("");
	    } else {
	      outputError("일치", $("#memberPwd1"), "green");
	      outputError("일치", $("#memberPwd2"), "green");
	      $("#pwdValid").val("checked");
	    }
	  });

	  // 이메일
	  $("#email").blur(function () {
	    if ($("#email").val().length > 0) {
	      checkEmail();
	    } else {
	      outputError("이메일은 필수항목입니다.", $("#email"), "red");
	    }
	  });
	});
	/////////////////////////////////////////////////////////////////////////////////

	function checkEmail() {
	  // 		alert("checkEmail");
	  // 1) 정규표현식을 활용하여 이메일 주소 형식인지 확인 + 중복체크 (유니크 제약조건)
	  // 2) 이메일 주소 형식이면, 인증번호를 이메일로 보내고
	  // 인증번호를 입력받을 태그 생성해서 다시 입력받아서 보낸 인증번호와 유저가 입력한 인증번호가 일치하는지 검증

	  let tmpMemberEmail = $("#email").val();
	  let emailRegExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	  if (!emailRegExp.test(tmpMemberEmail)) {
	    outputError("이메일 형식이 아닙니다", $("#email"), "red");
	  } else {
	    outputError("이메일 형식입니다", $("#email"), "green");

	    callSendMail(); // 이메일 발송
	  }
	}

	function callSendMail() {
	  $.ajax({
	    url: "/member/callSendMail", // 데이터가 송수신될 서버의 주소
	    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
	    data: {
	      tmpMemberEmail: $("#email").val(),
	    },
	    dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
	    // async: false, // 동기 통신 방식
	    success: function (data) {
	      // 통신이 성공하면 수행할 함수
	      console.log(data);
	      if (data == "success") {
	        if ($(".authenticationDiv").length == 0) {
	          showAuthenticateDiv(); //// 인증번호 입력받을 태그 요소 출력
	        }
	        startAuthTimer(); // 타이머 동작
	      }
	    },
	    error: function () {},
	    complete: function () {},
	  });
	}

	let timeInterval; // 전역 변수

	function showAuthenticateDiv() {
	  clearInterval(timeInterval); // 기존 타이머 제거

	  let authDiv = `
	        <div class="authenticationDiv mt-2">
	            <input type="text" class="form-control mb-2" id="memberAuthCode" placeholder="인증번호를 입력하세요..." />
	            <div><span id="authTimer" style="color: red; font-weight: bold;">03:00</span> 남음</div>
	            <button type="button" id="reAuth" class="btn btn-info mt-2">재인증</button>
	            <button type="button" id="authBtn" class="btn btn-info mt-2" onclick="checkAuthCode()">인증하기</button>
	        </div>`;

	  $(authDiv).insertAfter("#email");

	  // 재인증 버튼
	  $("#reAuth").on("click", function () {
	    callSendMail(); // 이메일 발송
	  })
	}

	function startAuthTimer() {
	  alert("이메일 인증번호를 전송했습니다.");

	  let timeLeft = 10; // 5분

	  timeInterval = setInterval(function () {
	    let min = String(Math.floor(timeLeft / 60)).padStart(2, "0");
	    let sec = String(timeLeft % 60).padStart(2, "0");

	    console.log(min, sec);
	    console.log($("#authTimer"));

	    let remainTime = min + ":" + sec;

	    $("#authTimer").html(remainTime);
	    console.log($("#authTimer").text());

	    if (timeLeft <= 0) {
	      clearInterval(timeInterval);
	      $("#authTimer").text("시간초과");
	      outputError("인증 시간이 초과되었습니다.", $("#email"), "red");
	      $(".authenticationDiv").remove();
	      $("#emailValid").val(""); // 인증 실패 처리

	      expiredTimer();
	    }

	    timeLeft--;
	  }, 1000);
	}

	function expiredTimer() {
	    // 인증 버튼 비활성화
	    $("#authBtn").

	  // 타이머 종료시 백앤드에 인증시간이 만료되었음을 알리기.
	  if ($("#emailValid").val() != "checked") {
	    $.ajax({
	      url: "/member/clearAuthCode", // 데이터가 송수신될 서버의 주소
	      type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
	      dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
	      // async: false, // 동기 통신 방식
	      success: function (data) {
	        // 통신이 성공하면 수행할 함수
	        console.log(data);
	        alert("인증시간이 만료되었습니다. ");
	        $(".authenticationDiv").remove();
	        $(".email").val("").focus();
	      },
	      error: function () {},
	      complete: function () {},
	    });
	  }
	}

	function checkAuthCode() {
	  let memberAuthCode = $("#memberAuthCode").val();
	  // 		alert(memberAuthCode);

	  $.ajax({
	    url: "/member/checkAuthCode", // 데이터가 송수신될 서버의 주소
	    type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
	    data: {
	      memberAuthCode: memberAuthCode,
	    },
	    dataType: "text", // 수신받을 데이터 타입 (MIME TYPE)
	    // async: false, // 동기 통신 방식
	    success: function (data) {
	      // 통신이 성공하면 수행할 함수
	      console.log(data);
	      if (data == "success") {
	        outputError("인증완료", $("#email"), "green");
	        $(".authenticationDiv").remove();
	        $("#emailValid").val("checked");
	      }
	    },
	    error: function () {},
	    complete: function () {},
	  });
	}

	function idValid() {
	  let result = false;

	  if ($("#idValid").val() == "checked") {
	    result = true;
	  }

	  return result;
	}

	function pwValid() {
	  let result = false;

	  if ($("#pwdValid").val() == "checked") {
	    result = true;
	  }

	  return result;
	}

	function emailValid() {
	  let result = false;

	  if ($("#emailValid").val() == "checked") {
	    result = true;
	  }

	  return result;
	}

	function nameValid() {
	  if ($("#memberName").val().length == 0) {
	    outputError("이름은 필수 항목입니다.", $("#memberName"), "red");
	    return false;
	  } else {
	    outputError("", $("#memberName"), "");
	  }

	  return true;
	}

	function isValid() {
	  // 아이디 : 필수, 중복 불가, 길이 (4~8자)
	  let result = false;

	  let idCheck = idValid();
	  let pwCheck = pwValid();
	  let emailCheck = emailValid();
	  let nameCheck = nameValid();

	  if (idCheck && pwCheck && emailCheck && nameCheck) {
	    console.log(idCheck, pwCheck, emailCheck, nameCheck);
	    result = true;
	  }

	  return result;
	}

	function outputError(errorMsg, tagObj, color) {
	  let errTag = $(tagObj).prev(); // <span></span>
	  $(errTag).html(errorMsg).css("color", color);
	  $(tagObj).css("border-color", color);
	}

</script>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">

			<h1>회원가입</h1>
			<form action="/member/signup" method="POST">
				<div class="mb-3 mt-3">
					<label for="memberId">아이디 : </label><span></span> <input
						type="text" class="form-control" id="memberId"
						placeholder="아이디를 입력하세요..." name="memberId"
					> <input type="hidden" id="idValid" />
				</div>
				<div class="mb-3">
					<label for="memberPwd1">비밀번호 : </label><span></span> <input
						type="password" class="form-control" id="memberPwd1"
						placeholder="비밀번호를 입력하세요..." name="memberPwd"
					>
				</div>
				<div class="mb-3">
					<label for="memberPwd2">비밀번호 확인 : </label> <input type="password"
						class="form-control" id="memberPwd2"
						placeholder="비밀번호를 다시 한번 입력하세요..."
					><input type="hidden" id="pwdValid" />
				</div>
				<div class="mb-3">
					<label for="email">이메일 : </label><span></span> <input type="email"
						class="form-control" id="email" placeholder="이메일을 입력하세요..."
						name="email"
					><input type="hidden" id="emailValid" />
				</div>
				<div class="mb-3">
					<label for="memberName">이름 : </label><span></span> <input
						type="text" class="form-control" id="memberName"
						placeholder="이름을 입력하세요..." name="memberName"
					>
				</div>


				<button type="submit" class="btn btn-success"
					onclick="return isValid()"
				>가입</button>
				<button type="submit" class="btn btn-danger">취소</button>
			</form>

		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>