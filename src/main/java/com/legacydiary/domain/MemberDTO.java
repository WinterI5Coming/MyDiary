package com.legacydiary.domain;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.ToString;
import lombok.Getter;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class MemberDTO {
	
	private String memberId;
	private String memberPwd;
	private String email;
	private String memberName;
}
