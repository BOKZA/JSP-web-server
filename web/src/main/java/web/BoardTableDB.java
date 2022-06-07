package web;

import java.sql.*; 
import javax.sql.DataSource;
import javax.naming.InitialContext ;
import java.util.ArrayList;

public class BoardTableDB {
	private Connection conn=null;
	private PreparedStatement stmt = null;
	private DataSource ds = null;
	private InitialContext initContext;
	
	public BoardTableDB() {
		try {
			initContext = new InitialContext();
			ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/mysql");
			System.out.println("DBCP:MySQL db�� ���� ����!");
		} catch(Exception ex) {
			System.out.println("SQLException" + ex.getMessage());
		}
	}
	void connect() {
		//����
		try {conn = ds.getConnection();}
		catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage());
		}
	}
	
	void disconnect() {
		//������� ����
		if(stmt != null) {
			try {stmt.close();}
			catch(SQLException ex) {
			System.out.println("SQLException"+ ex.getMessage());
			}
		}
		if (conn!=null) {
			try {conn.close();
			}catch(SQLException ex) {
				System.out.println("SQLException"+ ex.getMessage());
				}
			}
		}

public ArrayList<BoardRecord>getList(){
	connect();
	ArrayList<BoardRecord>boardRecordList = new ArrayList<BoardRecord>();
	String sql = "select * from tableboard";
	try {
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			BoardRecord brecord = new BoardRecord();
			brecord.setNum(rs.getInt("num"));
			brecord.setHits(rs.getInt("hits"));
			brecord.setName(rs.getString("name"));
			brecord.setPwd(rs.getString("pwd"));
			brecord.setRegdate(rs.getTimestamp("regdate"));
			brecord.setContent(rs.getString("content"));
			brecord.setSubject(rs.getString("subject"));
			boardRecordList.add(brecord);
		}
		rs.close();
	}catch(SQLException ex) {
		System.out.println("SQLException" + ex.getMessage());
	}finally{disconnect();
	}
	return boardRecordList;
	}
	public BoardRecord getBoardRecord(int num) {
		//num�� �ش��ϴ� ���̺�
		connect();
		BoardRecord brecord = new BoardRecord();
		String sql = "select * from tableboard where num=?";
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1, num);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			brecord.setNum(rs.getInt("num"));
			brecord.setHits(rs.getInt("hits"));
			brecord.setName(rs.getString("name"));
			brecord.setPwd(rs.getString("pwd"));
			brecord.setRegdate(rs.getTimestamp("regdate"));
			brecord.setContent(rs.getString("content"));
			brecord.setSubject(rs.getString("subject"));
			rs.close();
		}catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage());
		}finally {disconnect();
		}
		return brecord;
	}
	
	public void insertDB(BoardRecord brecord) {
		//�Խù� �Է�
		connect();
		String sql = "insert into tableboard(num, hits, name, pwd, subject, regdate, content)"
				+ "values(0,0,?,?,?,sysdate(), ?)";
		//0�� �Է��� �� ���� ?���� �ش��ϴ� ���� �Է¹޴´�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, brecord.getName());
			stmt.setString(2, brecord.getPwd());
			stmt.setString(3, brecord.getSubject());
			stmt.setString(4, brecord.getContent());
			stmt.executeUpdate();
			System.out.println("���ο� ����� ���̺� ���ԵǾ����ϴ�!");
			
		}catch(SQLException ex) {
			System.out.println("���̺� ������ �����߽��ϴ�!");
			System.out.println("SQLException"+ex.getMessage());
		}finally {
			disconnect();
		}
	}
	public void updateDB(BoardRecord brecord) {
		//���̺� ������Ʈ
		connect();
		String sql = "update tableboard set subject=?, hits=?, content=? where num=?";
		//?�� �ش��ϴ� num��° ���̺��� ������Ʈ�Ѵ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, brecord.getSubject());
			stmt.setInt(2,  brecord.getHits());
			stmt.setString(3, brecord.getContent());
			stmt.setInt(4, brecord.getNum());
			stmt.executeUpdate();
			System.out.println("���̺��� ������Ʈ�Ǿ����ϴ�!");
		}catch(SQLException ex) {
			System.out.println("���̺� ������Ʈ�� �����߽��ϴ�!");
			System.out.println("SQLException" +ex.getMessage());
		}finally {
			disconnect();
		}
	}
	
	public void deleteDB(int tnum) {
		//�Խ��� ����
		connect();
		System.out.println("deleteDB");
		String sql = "delete from tableboard where num=?";
		//?�� �ش��ϴ� num��° ���̺��� �����Ѵ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setInt(1,tnum);
			stmt.executeUpdate();
			System.out.println("���̺� ���ڵ尡 �����Ǿ����ϴ�!");
		}catch(SQLException ex) {
			System.out.println("���̺� ���ڵ� ������ �����߽��ϴ�!");
			System.out.println("SQLException" + ex.getMessage());
		}finally {
			disconnect();
		}
	}
	
	public boolean isEqualPwd(int tnum, String userpwd) {
		boolean flag = false;
		
		connect();
		String sql = "select pwd from tableboard where num=?";
		try {
			stmt=conn.prepareStatement(sql);
			stmt.setInt(1,tnum);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			String oldpwd = rs.getString(1);
			if(userpwd.equals(oldpwd)) flag = true;
			rs.close();
		}catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage()); return flag;
		}finally {
			disconnect();
		}
		return flag;
	}
}