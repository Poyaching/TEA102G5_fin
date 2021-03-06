package com.sub_class.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//刪除待確認
//查詢子類別待確認

public class Sub_classJDBCDAO implements Sub_classDAO_interface {
	// 一個應用程式中,針對一個資料庫 ,共用一個DataSource即可
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/TEA102G5");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String INSERT_STMT = "INSERT INTO SUB_CLASS VALUES('SCI'||LPAD(SUB_CLASS_SEQ.NEXTVAL,5,'0'),?,?,?)";
	private static final String GET_ALL_STMT = "SELECT * FROM SUB_CLASS ORDER BY SUBCLASS_id";
	private static final String GET_ONE_STMT = "SELECT * FROM SUB_CLASS WHERE SUBCLASS_id = ?";
	private static final String GET_CLASS_INFO_BySUB_CLASS_id_STMT = "SELECT * FROM CLASS_INFO WHERE SUBCLASS_id = ? ORDER BY CLASS_id";
	private static final String GET_MEMBER_INTEREST_BySUB_CLASS_id_STMT = "SELECT * FROM MEMBER_INTEREST WHERE SUBCLASS_id = ? ORDER BY CLASS_id";

	private static final String DELETE_SUB_CLASS = "" + "DELETE FROM SUB_CLASS " + "where SUBCLASS_id = ?";

	private static final String UPDATE = "UPDATE SUB_CLASS SET SUBCLASS_NAME=?, SUBCLASS_STATUS=? , MAINCLASS_id=? WHERE SUBCLASS_id = ?";

	@Override
	public void insert(Sub_classVO sub_classVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, sub_classVO.getMainClass_id());
			pstmt.setString(2, sub_classVO.getSubClass_name());
			pstmt.setInt(3, sub_classVO.getSubClass_status());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void update(Sub_classVO sub_classVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, sub_classVO.getSubClass_name());
			pstmt.setInt(2, sub_classVO.getSubClass_status());
			pstmt.setString(3, sub_classVO.getMainClass_id());
			pstmt.setString(4, sub_classVO.getSubClass_id());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void delete(String sub_class_id) {
		int updateCount_class_info = 0;
		int updateCount_member_interest = 0;

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();

			pstmt = con.prepareStatement(DELETE_SUB_CLASS);
			pstmt.setString(1, sub_class_id);
			pstmt.executeUpdate();

			System.out.println("刪除主課程類別編號" + sub_class_id + "時,共有課程" + updateCount_class_info + "被刪除"
					+ updateCount_member_interest + "被刪除");

		} catch (SQLException se) {
			if (con != null) {
				try {
					con.close();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public Sub_classVO findByPrimaryKey(String subclass_id) {

		Sub_classVO sub_classVo = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, subclass_id);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				sub_classVo = new Sub_classVO();
				sub_classVo.setSubClass_id(rs.getString("SUBCLASS_id"));
				sub_classVo.setSubClass_name(rs.getString("SUBCLASS_NAME"));
				sub_classVo.setSubClass_status(rs.getInt("SUBCLASS_STATUS"));
				sub_classVo.setMainClass_id(rs.getString("MAINCLASS_id"));
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return sub_classVo;
	}

	@Override
	public List<Sub_classVO> getAll() {
		List<Sub_classVO> list = new ArrayList<Sub_classVO>();
		Sub_classVO sub_classVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				sub_classVO = new Sub_classVO();
				sub_classVO.setSubClass_id(rs.getString("SUBCLASS_id"));
				sub_classVO.setSubClass_name(rs.getString("SUBCLASS_NAME"));
				sub_classVO.setSubClass_status(rs.getInt("SUBCLASS_STATUS"));
				sub_classVO.setMainClass_id(rs.getString("MAINCLASS_id"));
				list.add(sub_classVO); // Store the row in the list
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}
}
