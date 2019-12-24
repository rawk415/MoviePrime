package movie;

/* 크롤링한 영화 정보 Table */
public class MovieDTO {
    String movieTitle;
    String moviePreview;
    String comeoutDate;
    String moviePoster;
    String movieContent;

    public MovieDTO(String movieTitle, String moviePreview, String comeoutDate, String moviePoster, String movieContent) {
        this.movieTitle = movieTitle;
        this.moviePreview = moviePreview;
        this.comeoutDate = comeoutDate;
        this.moviePoster = moviePoster;
        this.movieContent = movieContent;
    }

    public String getMovieTitle() {
        return movieTitle;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }

    public String getMoviePreview() {
        return moviePreview;
    }

    public void setMoviePreview(String moviePreview) {
        this.moviePreview = moviePreview;
    }

    public String getComeoutDate() {
        return comeoutDate;
    }

    public void setComeoutDate(String comeoutDate) {
        this.comeoutDate = comeoutDate;
    }

    public String getMoviePoster() {
        return moviePoster;
    }

    public void setMoviePoster(String moviePoster) {
        this.moviePoster = moviePoster;
    }

    public String getMovieContent() {
        return movieContent;
    }

    public void setMovieContent(String movieContent) {
        this.movieContent = movieContent;
    }
}
