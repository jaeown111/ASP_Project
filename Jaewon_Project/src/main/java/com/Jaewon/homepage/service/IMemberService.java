package com.Jaewon.homepage.service;

import javax.servlet.http.HttpServletResponse;

import com.Jaewon.homepage.db.MemberDTO;

public interface IMemberService {

	
	//���̵� üũ
	public void check_id(String id,HttpServletResponse response) throws Exception;
	//�̸��� üũ
	public void check_email(String email,HttpServletResponse response) throws Exception;
	//ȸ������
	public int join_member(MemberDTO member,HttpServletResponse response) throws Exception;
    //�α��α��
	public MemberDTO login(MemberDTO member, HttpServletResponse response) throws Exception;
	//�α׾ƿ�
	public void logout(HttpServletResponse response) throws Exception;
	//ȸ����������
	public MemberDTO update_mypage(MemberDTO member) throws Exception;
	//ȸ��Ż��
	public boolean delete(MemberDTO member, HttpServletResponse response) throws Exception;


}
