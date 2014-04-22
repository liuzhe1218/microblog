package mb;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import dbm.*;

public class Umbid {
	private Conndb mydb;
	private ResultSet rs;
	private PreparedStatement pst;
	public Umbid(){
		mydb = new Conndb();
	}
	public ResultSet getmb(String uid,String mbid) throws SQLException{
		//更具uid,mbid获得content，time
		String sql = "select content,DATE_FORMAT(time,'%Y-%m-%d %H:%i') from mb where uid=? and mbid=?";
		pst = mydb.conn.prepareStatement(sql);
		pst.setString(1,uid);
		pst.setString(2,mbid);
		rs = pst.executeQuery();
		return rs;
	}
	public void destory(){
		mydb.destory();
	}
}
