package com.ojt.board;

import java.util.HashMap;
import java.util.List;

public interface BoardDaoMapper {

	public List SelectBoardList(HashMap<String, Object> req_data) throws Exception;
	//public List SelectBoardList2() throws Exception;
	
	public List DetailBoard(int seq) throws Exception;
	
	public List searchList(HashMap<String, Object> req_data)throws Exception;
	
	public int Register(HashMap<String, Object> req_data)throws Exception;
	
	public int GetSEQ();
	
	public int Saveboard(HashMap<String, Object> req_data)throws Exception;
	
	public int Updateboard(HashMap<String, Object> req_data)throws Exception;
	
	public int InsertHistory(HashMap<String, Object> req_data)throws Exception;
	
	public List DetailHistory(int seq) throws Exception;
	
	public int GetHSEQ(int num);
	
	public int DeleteBoard(int seq) throws Exception;
	
	public int countboard(String location);
	
}
