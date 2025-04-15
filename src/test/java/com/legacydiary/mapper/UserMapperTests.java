package com.legacydiary.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.legacydiary.domain.User;

import lombok.extern.slf4j.Slf4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/**/root-context.xml" })
@Slf4j
public class UserMapperTests {

	@Autowired
	private UserMapper userMapper;

	@Test
	public void testInsertUser() {

		User user = User.builder().username("ysu").email("dutjddnr1224@naver.com").state("ACTIVE").build();
		
		log.info("user : {}", user);
		
		userMapper.insertUser(user);
		
		log.info("저장된 id : {}", user.getId());
	}
	
	@Test
	public void testSearchUser() {
		List<User> list = userMapper.searchUser("email", "dutjddnr1224@naver.com");
		log.info("list : {}", list);
	}

}
