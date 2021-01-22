package board;

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

public class BoardDAO {
	
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
	
	public void insertBoard(BoardBean bb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		try {
			con = getConnection();
			
			String sql2 = "select max(num) from board";
			 pstmt2 = con.prepareStatement(sql2);
			 rs = pstmt2.executeQuery();
			
			int num = 0;

			if (rs.next()) {
				num = rs.getInt("max(num)") + 1;
				String sql = "insert into board(num,name,pass,subject,content,readcount,date,re_ref,re_lev,re_seq) values(?,?,?,?,?,?,?,?,?,?)";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,num); // parameterIndex ? 물음표 순서 , 값저장된 변수
				pstmt.setString(2, bb.getName());
				pstmt.setString(3, bb.getPass());
				pstmt.setString(4, bb.getSubject());
				pstmt.setString(5, bb.getContent());
				pstmt.setInt(6, bb.getReadcount());
				pstmt.setTimestamp(7, bb.getDate());
				pstmt.setInt(8,num);
				pstmt.setInt(9,bb.getRe_lev());
				pstmt.setInt(10,bb.getRe_seq());
				
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
	
	public void reInsertBoard(BoardBean bb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;

		try {
			// 1,2 단계 디비연결 메서드 호출
			  con=getConnection();
			//3단계 num구하기 기존글에서 최대 num 값을 구해서 +1 
			String sql2="select max(num) from board";
			 pstmt2=con.prepareStatement(sql2);
			//4단계 실행 => rs 저장
			 rs=pstmt2.executeQuery();
			//5단계 rs 첫행이동 max(num) 가져오기 +1
			int num=0;
			if(rs.next()){
				num=rs.getInt("max(num)")+1;
			}
			//  같은 그룹안에 내밑에 답글이 달려있으면 한칸더 아래로 내려가도록 순서값 1증가
			//  조건 re_ref=?(같은그룹)  re_seq >?(내글 아래  답글이있으면) 
			//  수정 re_seq=re_seq+1   순서값 1증가 (한칸아래로 내려감)
			String sql3="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
		   pstmt3=con.prepareStatement(sql3);
			pstmt3.setInt(1, bb.getRe_ref());
			pstmt3.setInt(2, bb.getRe_seq());
			pstmt3.executeUpdate();

			// 3단계 - 접속정보를 이용해서 insert sql 구문 만들고 실행할수 있는 자바프로그램 생성
			String sql="insert into board(num,name,pass,subject,content,readcount,date,re_ref,re_lev,re_seq) values(?,?,?,?,?,?,?,?,?,?)";
		    pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);  //parameterIndex ? 물음표 순서 ,값저장된 변수
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, bb.getReadcount());
			pstmt.setTimestamp(7, bb.getDate());
			// 답글에 관한 답글 관련 추가
			pstmt.setInt(8, bb.getRe_ref());  //re_ref 그대로 넣기
			pstmt.setInt(9, bb.getRe_lev()+1);  //re_lev +1
			pstmt.setInt(10, bb.getRe_seq()+1);  //re_seq +1
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}		}
		if(pstmt3!=null) try{pstmt2.close();}catch(SQLException ex){}

	}//메서드
	
	public BoardBean getBoard(int num) {
		
	BoardBean bb = null;
	Connection con = null;
	ResultSet rs = null;
	PreparedStatement pstmt = null;
	PreparedStatement pstmt2 = null;
	try {
		 con = getConnection();
		
		String sql2 = "update board set readcount=readcount+1 where num = ?";
		pstmt2 = con.prepareStatement(sql2);
		pstmt2.setInt(1,num);
		pstmt2.executeUpdate();
		
		String sql = "select * from board where num = ?";
		
		 pstmt = con.prepareStatement(sql);
		
		pstmt.setInt(1, num);
		
		 rs = pstmt.executeQuery();
		
		if(rs.next()) {
			bb = new BoardBean();
			bb.setNum(rs.getInt("num"));
			bb.setName(rs.getString("name"));
			bb.setPass(rs.getString("pass"));
			bb.setSubject(rs.getString("Subject"));
			bb.setContent(rs.getString("Content"));
			bb.setReadcount(rs.getInt("readcount"));
			bb.setDate(rs.getTimestamp("date"));
			bb.setRe_lev(rs.getInt("re_lev"));
			bb.setRe_ref(rs.getInt("re_ref"));
			bb.setRe_seq(rs.getInt("re_seq"));
		}
	} catch (Exception e) {
		e.printStackTrace();

	}finally {
		if(rs!=null) try{rs.close();}catch(SQLException ex){}
		if(pstmt!=null) try{pstmt.close();}catch(SQLException ex){}
		if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
		if(con!=null) try{con.close();}catch(SQLException ex){}
	}
		
	return bb;
	}
	
	public ResultSet list() {
		ResultSet rs = null;
		try {
			Connection con = getConnection();
			String sql = "select * from board ORDER BY num DESC";
			PreparedStatement pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			 
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			
		}
		
		return rs;
	}
	
	public int numcheck(BoardBean bb) {
		int check = -1;
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			 con = getConnection();
			String sql = "select * from board where num = ?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			
			 rs = pstmt.executeQuery();
			
			if (rs.next()) {
				if (bb.getPass().equals(rs.getString("pass"))) {
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
	
	public void updateBoard(BoardBean bb) {
		Connection con = null;
		ResultSet rs = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2="update board set Subject=?, content=? where num=?";
			 pstmt2 = con.prepareStatement(sql2);
			pstmt2.setString(1, bb.getSubject());
			pstmt2.setString(2, bb.getContent());
			pstmt2.setInt(3, bb.getNum());
			
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			if(rs!=null) try{rs.close();}catch(SQLException ex){}
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
		
		
	}
	
	public void deleteBoard(BoardBean bb) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql = "delete from board where num = ?";
			
			 pstmt2 = con.prepareStatement(sql);
			pstmt2.setInt(1, bb.getNum());
			pstmt2.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt2!=null) try{pstmt2.close();}catch(SQLException ex){}
			if(con!=null) try{con.close();}catch(SQLException ex){}
		}
}
	
	public List getBoardList() {
		Connection con =  null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		List boardList = new ArrayList();
		try {
			 con = getConnection();
			String sql = "select * from board ORDER BY re_ref desc, re_seq asc ";
			 pstmt = con.prepareStatement(sql);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("Subject"));
				bb.setContent(rs.getString("Content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				
				boardList.add(bb);
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
	
	//조회수
	public void updateReadcount(int num) {
		Connection con = null;
		PreparedStatement pstmt2 = null;
		try {
			 con = getConnection();
			
			String sql2 = "update board set readcount = readcount+1 where num = ?";
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
	
	
	public int getBoardCount() {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from board";
			
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
	
	public int getBoardCount(String search) {
		int count=0;
		Connection con = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;
		try {
			
			 con = getConnection();
			
			String sql2 = "select count(*) from board where subject like ?";
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
	
	public List getBoardList1(int startRow , int pageSize) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
			String sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow -1);
			pstmt.setInt(2, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_seq(rs.getInt("re_seq"));
				boardList.add(bb);
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
	
	
	public List getBoardList1(int startRow , int pageSize , String search) {
		
		List boardList = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			
			 con = getConnection();
			
			//String sql = "select * from board order by num desc limit ?,?";
			String sql = "select * from board where subject like ? order by num desc limit ?,?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow -1);
			pstmt.setInt(3, pageSize);
			 rs = pstmt.executeQuery();
			
			while(rs.next()) {
				BoardBean bb = new BoardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getTimestamp("date"));
				boardList.add(bb);
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

    