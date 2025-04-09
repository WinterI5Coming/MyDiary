package com.legacydiary.controller.member;

import java.io.IOException;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.legacydiary.domain.MemberDTO;
import com.legacydiary.domain.MyResponse;
import com.legacydiary.service.member.MemberService;
import com.legacydiary.util.SendMailService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member") // 해당 컨트롤러는 /member로 시작하는 요청 url을 모두 담당
@RequiredArgsConstructor
@Slf4j
public class MemberController {

	private final MemberService mService;

	private final SendMailService sendMailservice; // 메일 전송 담당 객체 주입

	@GetMapping("/signup")
	public void registerForm() {

//		User user = new User.Builder().id("user1").name("홍길동").pwd("1234").build();
//		System.out.println(user);
	}

	@PostMapping("/isDuplicate")
	public ResponseEntity<MyResponse> idIsDuplicate(@RequestParam("tmpMemberId") String tmpMemberId) {

		log.info("tmpMemberId : {}", tmpMemberId + "가 중복되는지 확인하자");
		MyResponse myResponse = null;
		ResponseEntity<MyResponse> result = null;

		if (mService.idIsDuplicate(tmpMemberId)) {
			// 중복 O
			myResponse = new MyResponse(200, tmpMemberId, "duplicated");

		} else {
			// 중복 X
			myResponse = MyResponse.builder().code(200).data(tmpMemberId).msg("not-duplicated").build();

		}
		log.info("myResponse : {}", myResponse);
		result = new ResponseEntity<MyResponse>(myResponse, HttpStatus.OK);

		return result;

	}

	@PostMapping("/callSendMail")
	public ResponseEntity<String> sendMailAuthCode(@RequestParam String tmpMemberEmail, HttpSession session) {

		log.info("tempMemberEmail : {}", tmpMemberEmail);

		String result = "";

		String authCode = UUID.randomUUID().toString();
		log.info("authCode : {}", authCode);

		try {
			sendMailservice.sendMail(tmpMemberEmail, authCode); // 메일 전송

			session.setAttribute("authCode", authCode); // 인증코드를 세션객체에 저장

			result = "success";
		} catch (IOException | MessagingException e) {
			e.printStackTrace();
			result = "fail";
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	@PostMapping("/checkAuthCode")
	public ResponseEntity<String> checkAuthCode(@RequestParam String memberAuthCode, HttpSession session) {
		
		// 유저가 보낸 AuthCode와 우리가 보낸 AuthCode가 일치하는지 확인
		log.info("memberAuthCode : {}", memberAuthCode);
		log.info("session에 저장된 코드 : {}", session.getAttribute("authCode"));
		
		String result = "";
		
		if (session.getAttribute("authCode") != null ) {
			String sesAuthCode = (String) session.getAttribute("authCode");
			
			if (memberAuthCode.equals(sesAuthCode)) {
				result = "success";
			} else {
				result = "fail";
			}
		}
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/signup")
	public String registerMember(MemberDTO registerMember, RedirectAttributes rttr) {
		
		
		log.info("registerMember : {}", registerMember);
		
		String result = "";
		if (mService.saveMember(registerMember)) {
			// 가입 완료 후 index.jsp로..
			rttr.addFlashAttribute("status", "success");
			result = "redirect:/"; 
		} else {
			// 가입 실패
			rttr.addAttribute("status", "fail");
			result = "redirect:/member/signup";
		}
		
		return result;
	}

}
