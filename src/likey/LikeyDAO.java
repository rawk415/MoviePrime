package likey;

import util.DatabaseUtil;

import java.sql.*;

public class LikeyDAO {
	private Connection conn;

	/*
	*  게시글 추천 중복 확인
	*  중복 추천을 할 수 없도록 UserID와 PostID를 저장
	*/
	public int like(String userID, String postID, String userIP) {
		String SQL = "INSERT INTO LIKEY VALUES (?, ?, ?)";
		try {
			conn = DatabaseUtil.getConnection();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setString(2, postID);
			pstmt.setString(3, userIP);
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1; // 추천 중복 오류
	}
}
