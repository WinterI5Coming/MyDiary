CREATE TABLE `ysu`.`member` (
  `memberId` VARCHAR(8) NOT NULL,
  `memberPwd` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `memberName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`memberId`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);
