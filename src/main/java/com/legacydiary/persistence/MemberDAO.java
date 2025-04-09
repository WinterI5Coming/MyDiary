package com.legacydiary.persistence;

import com.legacydiary.domain.MemberDTO;

public interface MemberDAO {

	// 아이디 중복검사
	int selectDuplicateId(String tmpMemberId);
	
	// 회원 가입
	int insertMember(MemberDTO registerMember);
}
