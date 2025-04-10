package com.legacydiary.controller.diary;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.legacydiary.domain.DiaryDTO;
import com.legacydiary.domain.DiaryVO;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/diary")
@RequiredArgsConstructor
@Slf4j
public class DiaryController {
	
	private final DiaryService diaryService;

	@GetMapping("/register")
	public String registerForm() {

		return "/diary/register";
	}

	@PostMapping("/register")
	public String register(DiaryDTO diaryDTO, RedirectAttributes rttr) {

		log.info("diaryDTO : {}", diaryDTO);
		
		String resultPage = "redirect:/diary/list";
		// 서비스에 넘길 VO 객체 생성 & 저장
		DiaryVO diaryVO = DiaryVO.builder().dno(diaryDTO.getDno()).title(diaryDTO.getTitle()).dueDate(diaryDTO.getDueDate())
				.writer(diaryDTO.getWriter()).finished(diaryDTO.isFinished()).build();
		
		if (diaryService.register(diaryVO) == 1) {
			log.info("등록성공");
			rttr.addFlashAttribute("status", "success");
		}
		
		return resultPage;
	}
	
	@GetMapping("/list")
	public String viewAll(Model model) {
		
		List<DiaryVO> list = diaryService.viewAll();
		
		model.addAttribute("diaryList", list);
		
		return "/diary/list";
	}
	
	@PostMapping("/updateFinished")
	@ResponseBody
	public String updateFinished(@RequestParam("dno") int dno, @RequestParam("finished") boolean finished) {
		
		log.info("dno : {}", dno);
		log.info("finished : {}", finished);
		
		diaryService.updateFinished(dno, finished);
		
		return "success";
	}

}
