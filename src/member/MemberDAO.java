package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	private Connection getConnection() throws Exception {
		// throws Exception 예외처리를 함수 호출하는 곳에서 처리 함

		Connection con = null;
		// 1단계 드라이버 가져오기
		Context init=new InitialContext();
//		javax.sql.DataSourceource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		return con;
	}

	public void insertMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			// 1, 2
			 con = getConnection();
			// 3 sql
			String sql = "insert into member" + "(id,pass,name,date,email,address,roadAddress,jibunAddress,detailAddress, phone,mobile) value(?,?,?,?,?,?,?,?,?,?,?)";

			 pstmt = con.prepareStatement(sql);

			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getDate());
			pstmt.setString(5, mb.getEmail());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getRoadAddress());
			pstmt.setString(8, mb.getJibunAddress());
			pstmt.setString(9, mb.getDetailAddress());
			pstmt.setString(10, mb.getPhone());
			pstmt.setString(11, mb.getMobile());
			// 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}

	}
	
	public MemberBean getMember(String id) {
		MemberBean mb = null;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			 String sql = "select * from member where id = ?";

			  pstmt =con.prepareStatement(sql);


			 pstmt.setString(1,id);

			  rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 //mb= 객체생성 (기억장소 할당)
				 	 mb = new MemberBean();
				 	 //mb set메서드 호출 rs.get() 저장
				 	 //디비 에서 가져온값 rs.getString("id") => mb id변수 저장
				 	 mb.setId(rs.getString("id"));
				 	 mb.setName(rs.getString("name"));
				 	 mb.setPass(rs.getString("pass"));
				 	 mb.setDate(rs.getTimestamp("date"));
				 	 mb.setEmail(rs.getString("email"));
				 	 mb.setAddress(rs.getString("address"));
				 	 mb.setRoadAddress(rs.getString("roadAddress"));
				 	 mb.setJibunAddress(rs.getString("jibunAddress"));
				 	 mb.setDetailAddress(rs.getString("detailAddress"));
				 	 mb.setPhone(rs.getString("phone"));
				 	 mb.setMobile(rs.getString("mobile"));
			 }
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		return mb;
	}
	
	public int userCheck(String id, String pass) {
		int check = -1;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			//1,2
			 con = getConnection();
			//3
			String sql = "select * from member where id = ?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4
			 rs = pstmt.executeQuery();

			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					check = 1; //일치
				} else {
					check = 0; //비밀번호 틀림
				}
			} else {
				check = -1; // 아이디틀림
			}
			return check;
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;
	}
	
	public void updateMember(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		
		try {
			 con = getConnection();
			
			String sql2="update member set name=? , email=? , address=? ,roadAddress = ?,jibunAddress=?, detailAddress=?, phone=? , mobile =? where id=? and pass=?  ";
			 pstmt2=con.prepareStatement(sql2);
			pstmt2.setString(1, mb.getName());
			pstmt2.setString(2, mb.getEmail());
			pstmt2.setString(3, mb.getAddress());
			pstmt2.setString(4, mb.getRoadAddress());
		 	pstmt2.setString(5, mb.getJibunAddress());
		 	pstmt2.setString(6, mb.getDetailAddress());
		 	pstmt2.setString(7, mb.getPhone());
			pstmt2.setString(8, mb.getMobile());
			pstmt2.setString(9, mb.getId());  //parameterIndex ? 물음표 순서 ,값저장된 변수
			pstmt2.setString(10, mb.getPass());
			
			
			pstmt2.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
			
		}
	}

	public List getMemberList() {

		List memberList = new ArrayList();
		
		try {
			Connection con = getConnection();
			String sql = "select * from member ORDER BY date DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberBean mb = new MemberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setRoadAddress(rs.getString("roadAddress"));
				mb.setJibunAddress(rs.getString("jibunAddress"));
				mb.setDetailAddress(rs.getString("detailAddress"));
				mb.setDate(rs.getTimestamp("date"));
				
				memberList.add(mb);
			}
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			
		}
		return memberList;

		
		
	}

	public int dupCheck(String wid) {
		int check = -1;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			//1,2
			 con = getConnection();
			//3
			String sql = "select * from member where id = ?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setString(1, wid);
			//4
			 rs = pstmt.executeQuery();

			if (rs.next()) {
					check = 1; //일치
				} else {
					check = 0; //비밀번호 틀림
				}
		} 
		 catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;
	}
	
	public void delete(MemberBean mb) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			 con = getConnection();


			 String sql = "delete from member where id = ? ";
				
		 		PreparedStatement pstmt2 = con.prepareStatement(sql);
		 		pstmt2.setString(1, mb.getId());
		 		pstmt2.executeUpdate();
			 
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	}
	
	



}
