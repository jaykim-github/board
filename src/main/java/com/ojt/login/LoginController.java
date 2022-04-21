package com.ojt.login;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class LoginController {

	@Autowired
	LoginService service;

	@RequestMapping("/")
	public String home() {
		return "index";
	}
	
	@ResponseBody
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public Map<String,String> login(HttpServletRequest request) throws Exception {
		String id = request.getParameter("id");
		String password = request.getParameter("password");
		int result = service.Login(id, password);
		
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("value", Integer.toString(result));

		return resultMap;
	}
	
	@RequestMapping(value = "/register",  method = {RequestMethod.GET,RequestMethod.POST})
	public String registerPage() {
		return "register";
	}

	@ResponseBody
	@RequestMapping(value = "/registercheck",  method = RequestMethod.POST)
	public Map<String,String> registerCheck(HttpServletRequest request) throws Exception {

		HashMap<String, Object> map = new HashMap<>();

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phonenumber = request.getParameter("phonenumber");

		map.put("id", id);
		map.put("password", password);
		map.put("name", name);
		map.put("email", email);
		map.put("phonenumber", phonenumber);

		// result가 0이면 가입 가능, 1이면 가입 불가
		int result = service.IdExist(id);
		int result2;
		
		if(service.PExist(phonenumber)== null) {
			result2 = 0;
		}else {
			result2 = 1;
		}

		if (result == 0 && result2 == 0) {
			result = service.Register(map);
		}else if (result2 == 1) {
			//전화번호 중복
			result = 2;
		}else if(result == 1) {
			// ID 중복
			result = 3;
		}
		
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("value", Integer.toString(result));
		
		//1이면 가입 가능, ID중복 = 3, 전화번호 중복 = 2, 등록실패 = 0
		return resultMap;
	}
	
	@RequestMapping(value = "/findid",  method = {RequestMethod.GET,RequestMethod.POST})
	public String findid() {
		return "findid";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findpn", method = RequestMethod.POST)
	public Map<String,String> findpn(HttpServletRequest request)
			throws Exception {
		
		String phonenumber = request.getParameter("phonenumber");
		
		String result = service.PExist(phonenumber);
		
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("value", result);
		
		return resultMap;
	}
	
	@RequestMapping(value = "/findpw",  method = {RequestMethod.GET,RequestMethod.POST})
	public String findpw() {
		return "findpw";
	}
	
	@ResponseBody
	@RequestMapping(value = "/findpwinput",  method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String,String> findpwinput(HttpServletRequest request) throws Exception {
		String phonenumber = request.getParameter("phonenumber");
		String id = request.getParameter("id");
		
		String result = service.PExist(phonenumber);

		if(id.equals(result) == true) {
			result = "1";
		}else {
			result = "0";
		}
		
		System.out.println(result);
		Map<String, String> resultMap = new HashMap<>();
		resultMap.put("value", result);
		
		//1이면 pw 재입력 화면으로, 0이면 아이디 비밀번호 체크할 것.
		return resultMap;
	}
	
	@RequestMapping(value = "/changepw",  method = {RequestMethod.GET,RequestMethod.POST})
	public String channgepw() {
		return "changepw";
	}
	
	@ResponseBody
	@RequestMapping(value = "/changepwinput",  method = {RequestMethod.GET,RequestMethod.POST})
	public Map<String,String> changepwinput(HttpServletRequest request) throws Exception {
		String password = request.getParameter("password");
		String id = request.getParameter("id");
		HashMap<String, Object> map = new HashMap<>();
		Map<String, String> resultMap = new HashMap<>();
		int num = 0;
		
		map.put("password", password);
		map.put("id", id);
		
		//1일경우 기존pw, -1일경우 변경 가능
		int presentpw = service.Login(id, password);
		int result = 0;
		
		if(presentpw ==1) {
			//기존 사용 pw
			num = 2;
			resultMap.put("value", Integer.toString(num));
		}else {
			//1이면, 변경완료/ 0 이면 변경 x
			result = service.ChangePW(map);
			resultMap.put("value", Integer.toString(result));
		}
		
		return resultMap;
	}
	
	
}
