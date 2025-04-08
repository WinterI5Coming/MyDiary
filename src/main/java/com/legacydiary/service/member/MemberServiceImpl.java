package com.legacydiary.service.member;

import org.springframework.stereotype.Service;

import com.legacydiary.persistence.MemberDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberDAO dao; // 생성자 주입 방식
	
	@Override
	public boolean idIsDuplicate(String tmpMemberId) {
		// 중복이면 true, 중복아니면 false
		boolean result = false;
		
		if (dao.selectDuplicateId(tmpMemberId) == 0) {
			result = true;
			
		}
		return result;
	}

}
