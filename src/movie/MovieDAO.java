package movie;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class MovieDAO {
    /* 크롤링 정보 저장 */
    public int write(MovieDTO movieDTO) {
        String SQL = "INSERT INTO MOVIE VALUES(?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, movieDTO.getMovieTitle().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(2, movieDTO.getMoviePreview().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(3, movieDTO.getComeoutDate().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(4, movieDTO.getMoviePoster().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
            pstmt.setString(5, movieDTO.getMovieContent().replaceAll("<", "&lt;").replaceAll(">", " &gt;").replaceAll("\r\n", "<br>"));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null)
                    pstmt.close();
                if(conn != null)
                    conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    /* 영화 리스트 가져오기 */
    public ArrayList<MovieDTO> getList (String search) {
        ArrayList<MovieDTO> movieList = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
        	if(search.equals("=")) {
        		SQL = "SELECT * FROM MOVIE WHERE comeoutDate < sysdate() ORDER BY comeoutDate"; // 개봉작
        	} else if(search.equals("+")){
        		SQL = "SELECT * FROM MOVIE WHERE comeoutDate > sysdate() ORDER BY comeoutDate"; // 개봉 예정작
        	} else {
        		SQL = "SELECT * FROM MOVIE WHERE movieTitle LIKE ? ORDER BY comeoutDate";
        	}
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            if(!search.equals("=") && !search.equals("+")) pstmt.setString(1, "%" + search + "%");
            rs = pstmt.executeQuery();
            movieList = new ArrayList<MovieDTO>();
            while(rs.next()) {
                MovieDTO movie = new MovieDTO(
                        rs.getString(1)
                        , rs.getString(2)
                        , rs.getString(3)
                        , rs.getString(4)
                        , rs.getString(5)
                );
                movieList.add(movie);
            }
            return movieList;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null)
                    conn.close();
                if (pstmt != null)
                    pstmt.close();
                if (rs != null)
                    rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return movieList;
    }

}
