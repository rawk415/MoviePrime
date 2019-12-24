package freepost;

/* 자유 게시판 Table */
public class FreePostDTO {
    int postID;
    String userID;
    String postTitle;
    String postContent;

    public FreePostDTO(int postID, String userID, String postTitle, String postContent) {
        this.postID = postID;
        this.userID = userID;
        this.postTitle = postTitle;
        this.postContent = postContent;
    }

    public int getPostID() {
        return postID;
    }

    public void setPostID(int postID) {
        this.postID = postID;
    }

    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public void setPostTitle(String postTitle) {
        this.postTitle = postTitle;
    }

    public String getPostContent() {
        return postContent;
    }

    public void setPostContent(String postContent) {
        this.postContent = postContent;
    }
}