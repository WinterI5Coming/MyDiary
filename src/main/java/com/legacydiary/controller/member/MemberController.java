package com.legacydiary.controller.member;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/member") // 해당 컨트롤러는 /member로 시작하는 요청 url을 모두 담당
@Slf4j
public class MemberController {

	@GetMapping("/signup")
	public void registerForm() {
		
	}
	
}
