package web;

import java.sql.*; 
import javax.sql.DataSource;
import javax.naming.InitialContext ;
import java.util.ArrayList;

public class FormDB {
	private Connection conn=null;
	private PreparedStatement stmt = null;
	private DataSource ds = null;
	private InitialContext initContext;
	
	public FormDB() {
		try {
			initContext = new InitialContext();
			ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/mysql");
			System.out.println("DBCP:MySQL db�� ���� ����!");
		} catch(Exception ex) {
			System.out.println("SQLException" + ex.getMessage());
		}
	}
	void connect() {
		try {conn = ds.getConnection();}
		catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage());
		}
	}
	
	void disconnect() {
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

public ArrayList<FormBoard>getList(){
	connect();
	ArrayList<FormBoard>formBoardList = new ArrayList<FormBoard>();
	String sql = "select * from form_board";
	try {
		stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			FormBoard brecord = new FormBoard();
			brecord.setNum(rs.getInt("num"));
			brecord.setName(rs.getString("name"));
			brecord.setId(rs.getString("id"));
			brecord.setPwd(rs.getString("name"));
			brecord.setPhone(rs.getString("phone"));
			brecord.setEmail(rs.getString("email"));
			brecord.setBirth(rs.getString("birth"));
			formBoardList.add(brecord);
		}
		rs.close();
	}catch(SQLException ex) {
		System.out.println("SQLException" + ex.getMessage());
	}finally{disconnect();
	}
	return formBoardList;
	}
	public FormBoard getFormBoard(String id) {
		connect();
		FormBoard brecord = new FormBoard();
		String sql = "select * from form_board where id=?";
		//id�� �Է¹޾� �ش��ϴ� ���� ���̺��� �����ϴ� ������ �Ѵ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, id);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			brecord.setName(rs.getString("name"));
			brecord.setId(rs.getString("id"));
			brecord.setPwd(rs.getString("name"));
			brecord.setPhone(rs.getString("phone"));
			brecord.setEmail(rs.getString("email"));
			brecord.setBirth(rs.getString("birth"));
			rs.close();
		}catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage());
		}finally {disconnect();
		}
		return brecord;
	}
	
	public void insertDB(FormBoard brecord) {
		connect();
		String sql = "insert into form_board(num, name, id, pwd, phone, email, birth)"
				+ "values(0, ?, ?, ?, ?, ?, ?)";
		//num�� �Է��� �� ���� ?�� �ش��ϴ� ���� �Է��� �� �ִ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, brecord.getName());
			stmt.setString(2, brecord.getId());
			stmt.setString(3, brecord.getPwd());
			stmt.setString(4, brecord.getPhone());
			stmt.setString(5, brecord.getEmail());
			stmt.setString(6, brecord.getBirth());
			stmt.executeUpdate();
			System.out.println("���ο� ����� ���̺� ���ԵǾ����ϴ�!");
			
		}catch(SQLException ex) {
			System.out.println("���̺� ������ �����߽��ϴ�!");
			System.out.println("SQLException"+ex.getMessage());
		}finally {
			disconnect();
		}
	}
	public void updateDB(FormBoard brecord) {
		connect();
		String sql = "update form_board set name=?, pwd=?, phone=?, email=?, birth=? where id=?";
		//?�� �ش��ϴ� �κ��� �����Ѵ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, brecord.getName());
			stmt.setString(2, brecord.getPwd());
			stmt.setString(3, brecord.getPhone());
			stmt.setString(4, brecord.getEmail());
			stmt.setString(5, brecord.getBirth());
			stmt.setString(6, brecord.getId());
			stmt.executeUpdate();
			System.out.println("���̺��� ������Ʈ�Ǿ����ϴ�!");
		}catch(SQLException ex) {
			System.out.println("���̺� ������Ʈ�� �����߽��ϴ�!");
			System.out.println("SQLException" +ex.getMessage());
		}finally {
			disconnect();
		}
	}
	
	public void deleteDB(String userid) {
		connect();
		System.out.println("deleteDB");
		String sql = "delete from form_board where id=?";
		//?�� �ش��ϴ� ���� ���̺��� �����Ѵ�.
		try {
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, userid);
			stmt.executeUpdate();
			System.out.println("���̺� ���ڵ尡 �����Ǿ����ϴ�!");
		}catch(SQLException ex) {
			System.out.println("���̺� ���ڵ� ������ �����߽��ϴ�!");
			System.out.println("SQLException" + ex.getMessage());
		}finally {
			disconnect();
		}
	}
	
	public boolean isEqualPwd(String userid, String userpwd) {
		boolean flag = false;
		//�н����尡 ��ġ�ϴ��� Ȯ���ϴ� �Լ�
		connect();
		String sql = "select pwd from form_board where id=?";
		try {
			stmt=conn.prepareStatement(sql);
			stmt.setString(1, userid);
			ResultSet rs = stmt.executeQuery();
			rs.next();
			String oldpwd = rs.getString(1);
			if(userpwd.equals(oldpwd)) flag = true;
			rs.close();
		}catch(SQLException ex) {
			System.out.println("SQLException" + ex.getMessage()); 
			return flag;
		}finally {
			disconnect();
		}
		return flag;
	}

}
