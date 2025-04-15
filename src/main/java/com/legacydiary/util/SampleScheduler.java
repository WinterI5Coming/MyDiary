package com.legacydiary.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SampleScheduler {

	private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

//	@Scheduled(cron = "0/10 * * * * *") // 매 10초 마다
//	@Scheduled(cron = "0 0/1 * * * *") // 매 분 0초 마다
	public void sampleSchedule() {
		LocalDateTime now = LocalDateTime.now();
		String fmtNow = now.format(formatter);

		log.info("--------------------------scheduler--------------------------");
		log.info("현재 서버 시간 : {}", fmtNow);
	}
};