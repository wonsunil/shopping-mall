package shopping;

import java.sql.*;

public class DB {
	public static Connection getDB() throws Exception {
		Class.forName("oracle.jdbc.OracleDriver");
        
        return DriverManager.getConnection("jdbc:oracle:thin:@//localhost/xe", "center_jsp", "1234");
	};
	public static boolean execute(String query, String[] datas) {
		Connection db = null;
		
		try {
			db = getDB();
			
			PreparedStatement pstmt = db.prepareStatement(query);
			
			int index = 1;
			for(String data : datas) {
				pstmt.setString(index, data);
				
				index++;
			}
			
			return pstmt.execute();
		} catch (Exception ignored) {
			return false;
		} finally {
			try {
				db.close();
			} catch (SQLException ignored) {}
		}
	};
	public static ResultSet fetch(String query) throws Exception {
		Connection db = getDB();
		ResultSet rs = db.prepareStatement(query).executeQuery();
		
		return rs;
	};
	public static ResultSet fetch(String query, String[] datas) throws Exception {
		Connection db = getDB();
		PreparedStatement pstmt = db.prepareStatement(query);
		
		int index = 1;
		for(String data : datas) {
			pstmt.setString(index, data);
			
			index++;
		}
		
		ResultSet rs = pstmt.executeQuery();
		
		return rs;
	};
}
