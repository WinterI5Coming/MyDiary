package com.legacydiary.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.legacydiary.domain.DiaryVO;

public interface DiaryMapper {

	String selectNow();

	int insert(DiaryVO diaryVO);

	List<DiaryVO> selectAllList();

	void updateFinished(@Param("dno") int dno, @Param("finished") boolean finished);

	int updateDiary(DiaryVO diaryVO);

	List<DiaryVO> selectAllListById(String memberId);

}
