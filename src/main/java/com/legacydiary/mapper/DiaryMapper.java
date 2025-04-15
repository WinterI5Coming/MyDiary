package com.legacydiary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.legacydiary.domain.DiaryVO;
import com.legacydiary.domain.SearchDTO;

public interface DiaryMapper {

	String selectNow();

	int insert(DiaryVO diaryVO);

	List<DiaryVO> selectAllList();

	void updateFinished(@Param("dno") int dno, @Param("finished") boolean finished);

	int updateDiary(DiaryVO diaryVO);

	List<DiaryVO> selectAllListById(String memberId);
	
	List<DiaryVO> selectDiaryDueTomorrow();
	
	// 검색
	List<DiaryVO> selectSearchList(SearchDTO searchDTO);

}
