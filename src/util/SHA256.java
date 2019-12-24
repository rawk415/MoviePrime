package util;

import java.security.MessageDigest;

import user.UserDAO;

public class SHA256 {

	public static String getSHA256(String input) {
		StringBuffer result = new StringBuffer();
		try {
			MessageDigest digest = MessageDigest.getInstance("SHA-256"); // SHA-256 방식으로
			byte[] salt = "Salt".getBytes();
			digest.reset();
			digest.update(salt); // 문자열에 SALT값 추가
			byte[] chars = digest.digest(input.getBytes("UTF-8")); // 문자열에 INPUT값 추가
			for (int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString(0xff & chars[i]);
				if(hex.length() == 1) result.append('0');
				result.append(hex);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result.toString();
	}
}
