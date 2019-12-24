package freepost;

import movie.MovieDTO;
import post.PostDTO;
import util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class FreePostDAO {
    /* 게시글 작성 */
    public int write(FreePostDTO freePostDTO) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        String SQL = "INSERT INTO FREEPOST (userID, postTitle, postContent) VALUES (?, ?, ?);";
        try {
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, freePostDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
            pstmt.setString(2, freePostDTO.getPostTitle().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
            pstmt.setString(3, freePostDTO.getPostContent().replaceAll("<", "&lt;").replaceAll(">", " &gt;"));
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
    public ArrayList<FreePostDTO> getList (String search) {
        ArrayList<FreePostDTO> postList = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            SQL = "SELECT * FROM FREEPOST WHERE CONCAT(postTitle, postContent, userID) LIKE ? ORDER BY postID DESC";
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, "%" + search + "%");
            rs = pstmt.executeQuery();
            postList = new ArrayList<FreePostDTO>();
            while(rs.next()) {
                FreePostDTO post = new FreePostDTO(
                        rs.getInt(1)
                        , rs.getString(2)
                        , rs.getString(3)
                        , rs.getString(4)
                );
                postList.add(post);
            }
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
        return postList;
    }

    /* 게시글 작성자 ID 가져오기 */
    public String getUserID(String postID) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String SQL = "SELECT userID FROM FREEPOST WHERE postID = ?";
            conn = DatabaseUtil.getConnection();
            assert conn != null;
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            rs = pstmt.executeQuery();
            while (rs.next()) {
                return rs.getString(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return null;
    }

    /* 게시글 Detail 가져오기 */
    public FreePostDTO getFreePost(String postID) {
    	FreePostDTO freePostDTO = null;
        String SQL = "";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = DatabaseUtil.getConnection();
            SQL = "SELECT * FROM FreePost WHERE postID = ?";
            pstmt = conn.prepareStatement(SQL);
            pstmt.setInt(1, Integer.parseInt(postID));
            rs = pstmt.executeQuery();
           if(rs.next()) {
               freePostDTO = new FreePostDTO(
                       rs.getInt(1)
                       , rs.getString(2)
                       , rs.getString(3)
                       , rs.getString(4)
               );
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(conn != null) conn.close();
                if(pstmt != null) pstmt.close();
                if(rs != null) rs.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } return freePostDTO;
    }
}


