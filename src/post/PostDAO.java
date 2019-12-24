package post;

import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class PostDAO {

    /* 리뷰 게시글 작성 */
    public int write(PostDTO postDTO) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL = "INSERT INTO POST(userID, movieTitle, postTitle, postContent, movieTotalScore, spoiler, likecount) " +
                "VALUES(?, ?, ?, ?, ?, ?, 0);";
        try {
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, postDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
            pstmt.setString(2, postDTO.getMovieTitle());
            pstmt.setString(3, postDTO.getPostTitle().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
            pstmt.setString(4, postDTO.getPostContent().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
            pstmt.setInt(5, postDTO.getMovieTotalScore());
            pstmt.setBoolean(6, postDTO.isSpoiler());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (conn != null)
                    conn.close();
                if (pstmt != null)
                    pstmt.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    /* 게시글 리스트 가져오기 */
    public ArrayList<PostDTO> getList(String search) {
        ArrayList<PostDTO> postList = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            SQL = "SELECT * FROM POST WHERE CONCAT(movieTitle, postTitle, postContent, userID) LIKE ? ORDER BY postID DESC";
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + search + "%");
            rs = pstmt.executeQuery();
            postList = new ArrayList<PostDTO>();
            while (rs.next()) {
                PostDTO post = new PostDTO(
                    rs.getInt(1)
                    , rs.getString(2)
                    , rs.getString(3)
                    , rs.getString(4)
                    , rs.getString(5)
                    , rs.getInt(6)
                    , rs.getBoolean(7)
                    , rs.getInt(8)
                );
                postList.add(post);
            }
            return postList;
        }catch (Exception e) {
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
        return postList;
    }

    /* 게시글 추천 */
    public int like(String postID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = DatabaseUtil.getConnection();
            String SQL = "UPDATE POST SET likeCount = likeCount + 1 WHERE postID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    /* 게시글 삭제 */
    public int delete(String postID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            String SQL = "DELETE FROM POST WHERE postID = ?";
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return -1;
    }

    /* 게시글 작성자 ID 가져오기 */
    public String getUserID(String postID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String SQL = "SELECT userID FROM POST WHERE postID = ?";
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            rs = pstmt.executeQuery();
            while(rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /* 게시글 Detail 가져오기 */
    public PostDTO getPost(String postID) {
        PostDTO postDTO = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            SQL = "SELECT * FROM POST WHERE postID = ?";
            conn = DatabaseUtil.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            rs = pstmt.executeQuery();
            if(rs.next()) {
                postDTO = new PostDTO(
                        rs.getInt(1)
                        , rs.getString(2)
                        , rs.getString(3)
                        , rs.getString(4)
                        , rs.getString(5)
                        , rs.getInt(6)
                        , rs.getBoolean(7)
                        , rs.getInt(8)
                    );
            }
        }catch (Exception e) {
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
        return postDTO;
    }
        
}


