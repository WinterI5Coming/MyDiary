package com.legacydiary.service.member;

public interface MemberService {
	
	// 아이디 중복 검사
	boolean idIsDuplicate(String tmpMemberId);
	
}
