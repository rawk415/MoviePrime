<%@page import="movie.MovieDAO"%>
<%@page import="movie.MovieDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!--  JSP에서 jsoup을 사용하기 위해 import -->
<%@ page import="org.jsoup.Jsoup" %>
<%@ page import="org.jsoup.nodes.Document" %>
<%@ page import="org.jsoup.nodes.Element" %>
<%@ page import="org.jsoup.select.Elements" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 파싱할 사이트를 적어준다(해당 사이트에 대한 태그를 다 긁어옴)
    Document doc1 = Jsoup.connect("https://movie.naver.com/movie/running/current.nhn").get();
 	Document doc2 = Jsoup.connect("https://movie.naver.com/movie/running/premovie.nhn").get();

    // list 속성안에 li 요소 데이터들을 긁어온다
    Elements posts1 = doc1.body().getElementsByClass("lst_wrap");
    Elements file1 = posts1.select("li");
    Elements posts2 = doc2.body().getElementsByClass("lst_wrap");
    Elements file2 = posts2.select("li");

    // li 요소 데이터들 반복적으로 츨력(li 요소 끝날때까지 즉, li개수만큼 반복문)
    // select() : select()를 통해 더 구석구석 데이터에 접근
    // 구성요소.text() : 구성요소 값을 반환(태그는 포함되지 않음)
    // 구성요소.attr("속성이름") : 구성요소에 "속성이름"에 대한 값을 반환
    // 사이트 링크가 이상하게 올라가있는 관계로 문자열을 다듬어야 한다
	// substring을 사용해 원하는 문자열만큼 자르고 앞에 주소부분을 붙여주면 끝
    
    ArrayList<MovieDTO> movieList = new ArrayList<MovieDTO>();
    int i = 0;
    for(Element e : file1){
    	/* comeoutDate */
    	String etc = e.select(".info_txt1").text();
    	int begin = etc.lastIndexOf("|");
    	int end = etc.lastIndexOf("개봉");
    	String comeoutDate = etc.substring(begin+1, end); 
    	comeoutDate = comeoutDate.trim();
    	if(comeoutDate.lastIndexOf(".") != 7) {
    		comeoutDate = comeoutDate + ".01";
    	}	
    	/* movieTitle */
    	String movieTitle = e.select(".tit").text();
    	if(movieTitle.lastIndexOf("관람가") != -1) {
    		int removeAge = movieTitle.lastIndexOf("관람가") + 3;
    		movieTitle = movieTitle.substring(removeAge);
    	} else if(movieTitle.lastIndexOf("관람불가") != -1) {
    		int removeAge = movieTitle.lastIndexOf("관람불가") + 4;
    		movieTitle = movieTitle.substring(removeAge);
    	}
    	movieTitle = movieTitle.trim();
        
        /* moviePoster */
        String moviePoster = e.select(".thumb img").attr("src");
        
        String moviePreview="";
        String movieContent="";
        
        MovieDTO movieDTO = new MovieDTO(
        		movieTitle
        		, moviePreview
        		, comeoutDate
        		, moviePoster
        		, movieContent);
        movieList.add(i, movieDTO);
        MovieDAO movieDAO = new MovieDAO();
        movieDAO.write(movieDTO);
        i++;
    }
    for(Element e : file2){
    	/* comeoutDate */
    	String etc = e.select(".info_txt1").text();
    	int begin = etc.lastIndexOf("|");
    	int end = etc.lastIndexOf("개봉");
    	String comeoutDate = etc.substring(begin+1, end); 
    	comeoutDate = comeoutDate.trim();
    	if(comeoutDate.lastIndexOf(".") != 7) {
    		comeoutDate = comeoutDate + ".01";
    	}	
    	/* movieTitle */
    	String movieTitle = e.select(".tit").text();
    	if(movieTitle.lastIndexOf("관람가") != -1) {
    		int removeAge = movieTitle.lastIndexOf("관람가") + 3;
    		movieTitle = movieTitle.substring(removeAge);
    	} else if(movieTitle.lastIndexOf("관람불가") != -1) {
    		int removeAge = movieTitle.lastIndexOf("관람불가") + 4;
    		movieTitle = movieTitle.substring(removeAge);
    	}
    	movieTitle = movieTitle.trim();
        
        /* moviePoster */
        String moviePoster = e.select(".thumb img").attr("src");
        
        String moviePreview="";
        String movieContent="";
        
        MovieDTO movieDTO = new MovieDTO(
        		movieTitle
        		, moviePreview
        		, comeoutDate
        		, moviePoster
        		, movieContent);
        movieList.add(i, movieDTO);
        MovieDAO movieDAO = new MovieDAO();
        movieDAO.write(movieDTO);
        i++;
    }
    out.println("<script>");
	out.println("alert('영화 정보 업데이트를 마쳤습니다.');");
	out.println("location.href='presentScreeningMovie.jsp'");
	out.println("</script>");
%>
</body>
</html>