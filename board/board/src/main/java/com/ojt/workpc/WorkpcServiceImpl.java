package com.ojt.workpc;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("WorkpcService")
public class WorkpcServiceImpl implements WorkpcService{
	
	@Autowired
	private WorkpcDaoMapper WorkpcDaoMapper;
	
	public List SelectBoardList(String location ,int page) throws Exception{
		if(location.equals("location1")) {
			location = "본사";
			System.out.println("본사 리스트");
		}else if(location.equals("본사")) {
			System.out.println("본사 리스트");
		}else{
			System.out.println("석포 리스트");
			location = "석포";
		}
		
		int limit = 10;
		int listcount = WorkpcDaoMapper.countboard(location);
		
		int maxpage = (listcount + limit -1) / limit;
		
		int startpage = ((page -1)/10)*10+1;
		int endpage = startpage + 10 -1;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		
		HashMap<String, Object> map = new HashMap<>();
		map.put("page", page);
		map.put("location",location);
		
		
		List<Map<String, Object>> result = WorkpcDaoMapper.SelectBoardList(map);
		map.put("endpage",endpage);
		map.put("startpage",startpage);
		result.add(map);
		
		return result;
	}
	
	public List searchList(String searchid, String searchtxt)throws Exception{
		System.out.println("검색");
		HashMap<String, Object> map = new HashMap<>();
		
		if(searchid.equals("PRIVATE_IP")) {
			map.put("PRIVATE_IP", searchtxt);
		}else if(searchid.equals("SERVER_NAME")) {
			map.put("SERVER_NAME", searchtxt);
		}else if(searchid.equals("MANAGER")) {
			map.put("MANAGER", searchtxt);
		}
		
		System.out.println(map);
		
		List<Map<String, Object>> result = WorkpcDaoMapper.searchList(map);
		
		System.out.println(result);
		return result;
	};
	
	public int Register(HashMap<String, Object> req_data)throws Exception{
		System.out.println("저장");
		
		int seq = WorkpcDaoMapper.GetSEQ();
		seq++;
		
		req_data.put("seq", seq);
		System.out.println(req_data);
		
		int result = WorkpcDaoMapper.Register(req_data);
		
		return result;
	}
	
	public List DetailBoard(int seq) throws Exception{
		System.out.println("상세페이지");

		List<Map<String, Object>> result = WorkpcDaoMapper.DetailBoard(seq);
		return result;
	};
	
	public List DetailHistory(int seq) throws Exception{
		List<Map<String, Object>> result = WorkpcDaoMapper.DetailHistory(seq);
		return result;
	};
	
	public int DeleteBoard(int seq) throws Exception{
		int num = WorkpcDaoMapper.DeleteBoard(seq);
		return num;
	};
	
	public int Updateboard(HashMap<String, Object> req_data)throws Exception{
		System.out.println("수정");
		//수정한 내역 다 가져온 것
		System.out.println(req_data);
		//여기서 selectdetail 값과 올파라미터 값을 비교해서 다른 것 -> 문자열화 시켜 server history에 저장(변경내역)
		//List<Map<String, Object>> result = BoardDaoMapper.DetailBoard(seq);

		
		int seq = Integer.parseInt(req_data.get("SEQ").toString());

		int result2 = WorkpcDaoMapper.Updateboard(req_data);
		
		Map<String, String> change = new HashMap<>();
		
		String pattern = "yyyy-MM-dd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
		
		HashMap<String, Object> history = new HashMap<>();
		int num = WorkpcDaoMapper.GetHSEQ(seq);
		num++;
		
		history.put("SEQ",seq);
		history.put("CHANGE_DATE",date);
		history.put("CHANGE_CONTENT",req_data.get("changecontent"));
		history.put("CHANGE_USER",req_data.get("ID"));
		history.put("H_SEQ",num);
		int result3 = 0;
		
		System.out.println(history);
		
		
		if (result2 == 1) {
			//수정 성공시 1 
			result3 = WorkpcDaoMapper.InsertHistory(history);
		}
		
		return result3;
	};
}
