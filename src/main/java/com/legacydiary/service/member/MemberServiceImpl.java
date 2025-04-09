package com.legacydiary.service.member;

import org.springframework.stereotype.Service;

import com.legacydiary.domain.MemberDTO;
import com.legacydiary.persistence.MemberDAO;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {

	private final MemberDAO dao; // 생성자 주입 방식
	
	@Override
	public boolean idIsDuplicate(String tmpMemberId) {
		// 중복이면 true, 중복아니면 false
		boolean result = true;
		
		if (dao.selectDuplicateId(tmpMemberId) == 0) {
			result = false;
			
		}
		return result;
	}

	@Override
	public boolean saveMember(MemberDTO registerMember) {
		boolean result = false;
		
		if (dao.insertMember(registerMember) == 1) {
			// 가입 성공
			result = true;
			
		}
		return false;
	}

}
