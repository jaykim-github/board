package com.ojt.login;

import java.util.HashMap;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDaoMapperRepository implements LoginDaoMapper{


	@Autowired
	@Resource(name="sql")
	SqlSessionTemplate sqlSession;
	
	@Override
	public String Login(String id) throws Exception{
		return sqlSession.selectOne("login", id);
	}
	
	@Override
	public int IDExist(String id){
		//ID 중복체크 - 값이 있으면 1, 없으면 0.
		return sqlSession.selectOne("IDExist", id);
	}
	
	public String PnumberExist(String phonenumber) {
		return sqlSession.selectOne("PnumberExist", phonenumber);
	}
	
	@Override
	public int Register(HashMap<String, Object> req_data)throws Exception{
		return sqlSession.insert("register", req_data);
	}
	
	@Override
	public int ChangePw(HashMap<String, Object> req_data) throws Exception{
		return sqlSession.update("changepw", req_data);
	}
}
