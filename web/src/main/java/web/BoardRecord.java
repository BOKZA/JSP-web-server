package web;

import java.util.Date;

public class BoardRecord {
	private int num;
	private String name;
	private String pwd;
	private String subject;
	private int hits;
	private Date regdate;
	private String content;
	
	public Date getRegdate() {return regdate;}
	public void setRegdate(Date regdate) {this.regdate = regdate;}
	public int getNum () {return num;}
	public void setNum (int num) { this.num = num;}
	public int getHits() {return hits;}
	public void setHits(int hits) {this.hits = hits;}
	public String getName() {return name;}
	public void setName(String name) { this.name = name;}
	public String getPwd() {return pwd;}
	public void setPwd(String pwd) { this.pwd = pwd;}
	
	public String getSubject() {return subject;}
	public void setSubject(String subject) { this.subject = subject;}
	
	public String getContent() {return content;}
	public void setContent(String content) { this.content = content;}
}