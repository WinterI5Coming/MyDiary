package com.legacydiary.domain;

public class User {

	private final String id;
	private final String pwd;
	private final String name;

	private User(Builder builder) {
		this.id = builder.id;
		this.pwd = builder.pwd;
		this.name = builder.name;
	}

	public static Builder builder() {
		return new Builder();
	}

	public String getId() {
		return id;
	}

	public String getPwd() {
		return pwd;
	}

	public String getName() {
		return name;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", pwd=" + pwd + ", name=" + name + "]";
	}

	// Builder 클래스
	public static class Builder {
		private String id;
		private String pwd;
		private String name;

		public Builder id(String id) {
			this.id = id;
			return this;
		}

		public Builder pwd(String pwd) {
			this.pwd = pwd;
			return this;
		}

		public Builder name(String name) {
			this.name = name;
			return this;
		}

		public User build() {
			return new User(this);
		}
	}
}
