package com.legacydiary.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.legacydiary.domain.MemberDTO;

@Repository
public class MemberDAOImple implements MemberDAO {

	@Autowired
	SqlSession ses; // SqlSessionTemplate 주입
	
	private static String ns = "com.legacydiary.mappers.memberMapper.";
	
	@Override
	public int selectDuplicateId(String tmpMemberId) {
		
		return	ses.selectOne(ns + "selectMemberId", tmpMemberId);
	}

	@Override
	public int insertMember(MemberDTO registerMember) {
		
		return ses.insert(ns + "insertMember", registerMember);
	}

}
