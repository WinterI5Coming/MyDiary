<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="../header.jsp"></jsp:include>
	<div class="container mt-5">
		<div class="row">
			<h1>로그인</h1>

			<form action="login" method="POST">
				<div class="mb-3 mt-3">
					<label for="memberId">Id :</label> <input type="text"
						class="form-control" id="memberId" placeholder="아이디를 입력하세요..."
						name="memberId"
					>
				</div>
				<div class="mb-3">
					<label for="memberPwd">Password:</label> <input type="password"
						class="form-control" id="memberPwd" placeholder="비밀번호를 입력하세요..."
						name="memberPwd"
					>
				</div>
				
				<div class="form-check mb-3">
					<label class="form-check-label"> <input
						class="form-check-input" type="checkbox" name="remember"
					> Remember me
					</label>
				</div>
				
				<button type="submit" class="btn btn-primary">로그인</button>
				<button type="submit" class="btn btn-secondary">취소</button>
			</form>

		</div>
	</div>
	<jsp:include page="../footer.jsp"></jsp:include>


</body>
</html>