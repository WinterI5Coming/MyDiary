<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		// 아이디 이벤트
		$("#memberId").on("blur", function() {
			let tmpMemberId = $("#memberId").val()
			console.log(tmpMemberId)
			
			if (tmpMemberId.length < 4 || tmpMemberId.length > 8)	 {
				outputError("아이디는 4~8자로 입력하세요", $("#memberId"), "red");
			} else {
				// 아이디 중복 체크
				$.ajax({
	          url: "/member/isDuplicate", // 데이터가 송수신될 서버의 주소
	          type: "POST", // 통신 방식 (GET, POST, PUT, DELETE)
				data: {
					"tmpMemberId" : tmpMemberId
				},
	          dataType: "json", // 수신받을 데이터 타입 (MIME TYPE)
	          // async: false, // 동기 통신 방식
	          success: function (data) {
	            // 통신이 성공하면 수행할 함수
	            console.log(data);
	            if (data.msg == "duplicated") {
	            	outputError("중복된 아이디입니다.", $("#memberId"), "red")
	            	$("#idValid").val("");
	            	
	            	
	            } else if (data.msg == "not-duplicated") {
	            	outputError("완료", $("#memberId"), "green");
	            	$("#idValid").val("checked");
	            }
	          },
	          error: function () {},
	          complete: function () {
	          },
        	});
				
				outputError("완료", $("#memberId"), "green");
			}			
		})
	
		// 비밀번호 체크
		$("#memberPwd1").blur(function() {
			// 비밀번호 4~8자
			let tmpPwd = $("#memberPwd1").val();
			
			if (tmpPwd.length < 4 || tmpPwd.length > 8) {
				outputError("비밀번호는 4~8자로 입력하세요", $("#memberPwd1"), "red");
				$("#memberPwd1").val("");			
			} else {
				outputError("완료", $("#memberPwd1"), "green");
			}		
		});

		$("#memberPwd2").blur(function() {
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

	
	
	
	});
	
		
	function idValid() {
		let result = false;
		
		if ($("#idValid").val() == "checked") {
			result = true;
		}
		
		return result;
	}

	function isValid() {
		// 아이디 : 필수, 중복 불가, 길이 (4~8자)
		let result = false;

		let idCheck = idValid();

		return false;
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
			<form action="/action_page.php" method="POST">
				<div class="mb-3 mt-3">
					<label for="memberId">아이디 : </label><span></span> <input
						type="text" class="form-control" id="memberId"
						placeholder="아이디를 입력하세요..." name="memberId"> <input
						type="hidden" id="idValid" />
				</div>
				<div class="mb-3">
					<label for="memberPwd1">비밀번호 : </label><span></span> <input
						type="password" class="form-control" id="memberPwd1"
						placeholder="비밀번호를 입력하세요..." name="memberPwd">
				</div>
				<div class="mb-3">
					<label for="memberPwd2">비밀번호 확인 : </label> <input type="password"
						class="form-control" id="memberPwd2"
						placeholder="비밀번호를 다시 한번 입력하세요..."><input type="hidden"
						id="pwdValid" />
				</div>
				<div class="mb-3">
					<label for="email">이메일 : </label><span></span> <input type="email"
						class="form-control" id="email" placeholder="이메일을 입력하세요..."
						name="email">
				</div>
				<div class="mb-3">
					<label for="memberName">이름 : </label><span></span> <input
						type="text" class="form-control" id="memberName"
						placeholder="이름을 입력하세요..." name="memberName">
				</div>


				<button type="submit" class="btn btn-success"
					onclick="return isValid();">가입</button>
				<button type="submit" class="btn btn-danger">취소</button>
			</form>

		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>
</body>
</html>