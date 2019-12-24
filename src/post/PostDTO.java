package post;

/* 리뷰 게시판 Table */
public class PostDTO {
    int postID;
    String userID;
    String movieTitle;
    String postTitle;
    String postContent;
    int movieTotalScore;
    boolean spoiler;
    int likeCount;

    public PostDTO(int postID, String userID, String movieTitle, String postTitle, String postContent, int movieTotalScore, boolean spoiler, int likeCount) {
        this.postID = postID;
        this.userID = userID;
        this.movieTitle = movieTitle;
        this.postTitle = postTitle;
        this.postContent = postContent;
        this.movieTotalScore = movieTotalScore;
        this.spoiler = spoiler;
        this.likeCount = likeCount;
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

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
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

    public int getMovieTotalScore() {
        return movieTotalScore;
    }

    public void setMovieTotalScore(int movieTotalScore) {
        this.movieTotalScore = movieTotalScore;
    }

    public boolean isSpoiler() {
        return spoiler;
    }

    public void setSpoiler(boolean spoiler) {
        this.spoiler = spoiler;
    }

    public int getLikeCount() {
        return likeCount;
    }

    public void setLikeCount(int likeCount) {
        this.likeCount = likeCount;
    }
}