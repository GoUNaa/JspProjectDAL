package gboard;

import java.sql.Connection;
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

public class GBoardDAO {
	
	private Connection getConnection() throws Exception {
		// throws Exception 예외처리를 함수 호출하는 곳에서 처리 함

		Connection con = null;
		
		
		//커넥션 풀(Connection Pool)
		// 데이터베이스와 연결된 Connection객체를 미리 생성하여 Pool(풀,기억장소) 저장
		// 필요할때마다 풀에 접근하여 Connection객체 사용, 작업 끝나면 반환
		// 프로그램은 서버에 미리 설치
		// 1. context.xml 만들어 미리 자원준비
		// 2. DAO 자원이름을 불러서 사용
		Context init=new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con=ds.getConnection();
		return con;
	}
	
	public ResultSet glist() {
		ResultSet rs = null;
		try {
			Connection con = getConnection();
			String sql = "select * from gboard ORDER BY num DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return rs;
	}
	
	public void insertgBoard(GBoardBeen gb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql2 = "select max(num) from gboard";
			 pstmt2 = con.prepareStatement(sql2);
			 rs = pstmt2.executeQuery();
			
			int num = 0;

			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
				String sql = "insert into gboard(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num); // parameterIndex ? 물음표 순서 , 값저장된 변수
				pstmt.setString(2, gb.getName());
				pstmt.setString(3, gb.getPass());
				pstmt.setString(4, gb.getSubject());
				pstmt.setString(5, gb.getContent());
				pstmt.setInt(6, gb.getReadcount());
				pstmt.setTimestamp(7, gb.getDate());
				pstmt.setString(8, gb.getFile());
				
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
	
	public List getgBoardList() {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List gboardList = new ArrayList();
		try {
			 con = getConnection();
			String sql = "select * from gboard ORDER BY num DESC";
			 pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GBoardBeen gb = new GBoardBeen();
				gb.setNum(rs.getInt("num"));
				gb.setName(rs.getString("name"));
				gb.setPass(rs.getString("pass"));
				gb.setSubject(rs.getString("Subject"));
				gb.setContent(rs.getString("Content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getTimestamp("date"));
				gb.setFile(rs.getString("file"));
				
				gboardList.add(gb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return gboardList;
	}
	
	public int getgBoardCount() {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from gboard";
			
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
	
	public List getgBoardList1(int startRow , int pageSize) {
		
		List GboardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
			String sql = "select * from gboard order by num desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GBoardBeen gb = new GBoardBeen();
				gb.setNum(rs.getInt("num"));
				gb.setName(rs.getString("name"));
				gb.setPass(rs.getString("pass"));
				gb.setSubject(rs.getString("subject"));
				gb.setContent(rs.getString("content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getTimestamp("date"));
				gb.setFile(rs.getString("file"));
				GboardList.add(gb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return GboardList;
	}
	
	public int gnumcheck(GBoardBeen gb) {
		int check = -1;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			 con = getConnection();
			String sql = "select * from gboard where num = ?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gb.getNum());
			
			 rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (gb.getPass().equals(rs.getString("pass"))) {
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
	
	public void gupdateBoard(GBoardBeen gb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2="update gboard set Subject=?, content=? , file=? where num=?";
			 pstmt2 = con.prepareStatement(sql2);
			pstmt2.setString(1, gb.getSubject());
			pstmt2.setString(2, gb.getContent());
			pstmt2.setNString(3, gb.getFile());
			pstmt2.setInt(4, gb.getNum());
			
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		
		
	}
	
	public void gdeleteBoard(GBoardBeen gb) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql = "delete from gboard where num =?";
			
			 pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, gb.getNum());
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
	
	
	
	
}
	
	public GBoardBeen getgBoard(int num) {
		
		GBoardBeen gb = null;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2 = "update gboard set readcount=readcount+1 where num = ?";
			pstmt2 = con.prepareStatement(sql2);
			pstmt2.setInt(1,num);
			pstmt2.executeUpdate();
			
			String sql = "select * from gboard where num = ?";
			
			 pstmt = con.prepareStatement(sql);
			
			pstmt.setInt(1, num);
			
			 rs = pstmt.executeQuery();
			
			if(rs.next()) {
				gb = new GBoardBeen();
				gb.setNum(rs.getInt("num"));
				gb.setName(rs.getString("name"));
				gb.setPass(rs.getString("pass"));
				gb.setSubject(rs.getString("Subject"));
				gb.setContent(rs.getString("Content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getTimestamp("date"));
				gb.setFile(rs.getString("file"));
			}
		} catch (Exception e) {
			e.printStackTrace();

		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
			
		return gb;
		}
	
	public int getGBoardCount(String search) {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from gboard where subject like ?";
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
	
	public List getGBoardList1(int startRow , int pageSize , String search) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
			//String sql = "select * from board order by num desc limit ?,?";
			String sql = "select * from gboard where subject like ? order by num desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, "%"+search+"%");
			 pstmt.setInt(2, startRow -1);
			 pstmt.setInt(3, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GBoardBeen gb = new GBoardBeen();
				gb.setNum(rs.getInt("num"));
				gb.setName(rs.getString("name"));
				gb.setPass(rs.getString("pass"));
				gb.setSubject(rs.getString("subject"));
				gb.setContent(rs.getString("content"));
				gb.setReadcount(rs.getInt("readcount"));
				gb.setDate(rs.getTimestamp("date"));
				gb.setFile(rs.getString("file"));
				boardList.add(gb);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		return boardList;
	}
	
}
