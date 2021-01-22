package fboard;

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

import board.BoardBean;
import fboard.fboardBean;

public class fboardDAO {

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
	
	public ResultSet flist() {
		ResultSet rs = null;
		try {
			Connection con = getConnection();
			String sql = "select * from fboard ORDER BY num DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
		}
		
		return rs;
	}
	
	public int fnumcheck(fboardBean fb) {
		int check = -1;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			 con = getConnection();
			String sql = "select * from fboard where num = ?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, fb.getNum());
			
			 rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (fb.getPass().equals(rs.getString("pass"))) {
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
			
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return check;

	}
	
	public void insertfBoard(fboardBean fb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql2 = "select max(num) from fboard";
			 pstmt2 = con.prepareStatement(sql2);
			 rs = pstmt2.executeQuery();
			
			int num = 0;

			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
				String sql = "insert into fboard(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num); // parameterIndex ? 물음표 순서 , 값저장된 변수
				pstmt.setString(2, fb.getName());
				pstmt.setString(3, fb.getPass());
				pstmt.setString(4, fb.getSubject());
				pstmt.setString(5, fb.getContent());
				pstmt.setInt(6, fb.getReadcount());
				pstmt.setTimestamp(7, fb.getDate());
				pstmt.setString(8, fb.getFile());
				
				pstmt.executeUpdate();

			}

			
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			//마무리 기억장소 해제
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
			
		}
	}
	
	public fboardBean getFBoard(int num) {
		
		fboardBean fb = null;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2 = "update fboard set readcount=readcount+1 where num = ?";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1,num);
			pstmt2.executeUpdate();
			
			String sql = "select * from fboard where num = ?";
			
			 pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			 rs = pstmt.executeQuery();
			
			if(rs.next()) {
				fb = new fboardBean();
				fb.setNum(rs.getInt("num"));
				fb.setName(rs.getString("name"));
				fb.setPass(rs.getString("pass"));
				fb.setSubject(rs.getString("Subject"));
				fb.setContent(rs.getString("Content"));
				fb.setReadcount(rs.getInt("readcount"));
				fb.setDate(rs.getTimestamp("date"));
				fb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		return fb;
		}
	
	public void fupdateBoard(fboardBean fb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2="update fboard set Subject=?, content=? , file=? where num=?";
			 pstmt2 = con.prepareStatement(sql2);
			pstmt2.setString(1, fb.getSubject());
			pstmt2.setString(2, fb.getContent());
			pstmt2.setNString(3, fb.getFile());
			pstmt2.setInt(4, fb.getNum());
			
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		
		
	}
	
	public void fdeleteBoard(fboardBean fb) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql = "delete from fboard where num =?";
			
			 pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, fb.getNum());
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	
	
	
	
}
	
	public List getFBoardList() {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List fboardList = new ArrayList();
		try {
			 con = getConnection();
			String sql = "select * from fboard ORDER BY num DESC";
			 pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				fboardBean fb = new fboardBean();
				fb.setNum(rs.getInt("num"));
				fb.setName(rs.getString("name"));
				fb.setPass(rs.getString("pass"));
				fb.setSubject(rs.getString("Subject"));
				fb.setContent(rs.getString("Content"));
				fb.setReadcount(rs.getInt("readcount"));
				fb.setDate(rs.getTimestamp("date"));
				fb.setFile(rs.getString("file"));
				
				fboardList.add(fb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return fboardList;
	}
	
	public int getFBoardCount() {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from fboard";
			
			 pstmt2 = con.prepareStatement(sql2);
			
			 rs = pstmt2.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		return count;
	}
	
	public void updatefReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2 = "update fboard set readcount = readcount+1 where num = ?";
			 pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1,num);
			
			pstmt2.executeUpdate();
			
		
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		
		}
	
	public List getFBoardList1(int startRow , int pageSize) {
		
		List fboardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
			String sql = "select * from fboard order by num desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				fboardBean fb = new fboardBean();
				fb.setNum(rs.getInt("num"));
				fb.setName(rs.getString("name"));
				fb.setPass(rs.getString("pass"));
				fb.setSubject(rs.getString("subject"));
				fb.setContent(rs.getString("content"));
				fb.setReadcount(rs.getInt("readcount"));
				fb.setDate(rs.getTimestamp("date"));
				fb.setFile(rs.getString("file"));
				fboardList.add(fb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return fboardList;
	}
	
	public List getFBoardList1(int startRow , int pageSize , String search) {
		
		List fboardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
				String sql = "select * from fboard where subject like ? order by num desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow -1);
			pstmt.setInt(3, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				fboardBean fb = new fboardBean();
				fb.setNum(rs.getInt("num"));
				fb.setName(rs.getString("name"));
				fb.setPass(rs.getString("pass"));
				fb.setSubject(rs.getString("subject"));
				fb.setContent(rs.getString("content"));
				fb.setReadcount(rs.getInt("readcount"));
				fb.setDate(rs.getTimestamp("date"));
				fb.setFile(rs.getString("file"));
				fboardList.add(fb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return fboardList;
	}

	public int getFBoardCount(String search) {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from fboard where subject like ?";
			 pstmt2 = con.prepareStatement(sql2);
			 pstmt2.setString(1, "%"+search+"%");
			 rs = pstmt2.executeQuery();
			
			if (rs.next()) {
				count = rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		return count;
	}
	



}
