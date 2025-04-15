package com.legacydiary.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.SearchDTO;
import com.legacydiary.persistence.MemberDAO;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
@Slf4j
public class DIaryMapperTest {

	@Autowired
	private DiaryMapper diaryMapper;

	@Autowired
	private MemberDAO memberDAO;

//	@Test
//	public void selectNowTest() {
//		
//		log.info(diaryMapper.selectNow());
//		
//	}

	@Test
	public void selectDiaryDueTomorrowTest() {
		List<DiaryVO> list = diaryMapper.selectDiaryDueTomorrow();
		log.info("list : {}", list);

		// writer의 이메일, 내일 마감인 글들
		Map<String, List<DiaryVO>> memberDiaryMap = new HashMap<>();

		for (DiaryVO vo : list) {
			if (!memberDiaryMap.containsKey(vo.getWriter())) {
				memberDiaryMap.put(vo.getWriter(), new ArrayList<DiaryVO>());
			}

			memberDiaryMap.get(vo.getWriter()).add(vo);
		}

		for (Map.Entry<String, List<DiaryVO>> entry : memberDiaryMap.entrySet()) {
			String memberId = entry.getKey();
			log.info("writer : {}", memberId);
			log.info("list : {}", entry.getValue());

			String email = memberDAO.selectEmailByMemberId(memberId);
			log.info("email : {}", email);

			// 메일 본문
			StringBuilder sb = new StringBuilder();

			sb.append("안녕하세요. 내일까지 해야할 일이 있어요.");

			for (DiaryVO vo : entry.getValue()) {
				sb.append("---").append(vo.getTitle());
			}

			sb.append(memberId + "님, 꼭 완료하세요.");

			log.info(sb.toString());
		}
	}

	@Test
	public void testSearch() {
		SearchDTO searchDTO = SearchDTO.builder().writer("홍길동").searchTypes("title").searchWord("글")
//				.finished("false")
				.from("2025-04-01").to("2025-04-30").build();
		
		List<DiaryVO> result = diaryMapper.selectSearchList(searchDTO);
		
		for (DiaryVO diary : result) {
			log.info("diary: {}", diary);
		}
	}

}
