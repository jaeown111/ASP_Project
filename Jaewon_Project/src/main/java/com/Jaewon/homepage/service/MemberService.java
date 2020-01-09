package com.Jaewon.homepage.service;

import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.Jaewon.homepage.db.MemberDAO;
import com.Jaewon.homepage.db.MemberDTO;

@Service
public class MemberService implements IMemberService {

	@Inject
	private MemberDAO manager;
	
	//ID �ߺ� �˻� (AJAX)
	@Override
	public void check_id(String id, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		out.println(manager.check_id(id));
		out.close(); //�ݱ�  
	}

	
	 // email �ߺ� �˻�(AJAX)
	@Override
	public void check_email(String email, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter(); 
		out.println(manager.check_email(email));
		out.close(); //�ݱ�  
	}
	
	
	
    //ȸ������  ������ ���̵� �� �̸��� �����ϴ��� ���ϴ��� �˻�  
	@Override
	public int join_member(MemberDTO member, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		if (manager.check_id(member.getId()) == 1)  
		{
			out.println("<script>");
			out.println("alert('������ ���̵� �ֽ��ϴ�.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return 0;
		} 
		
		else if (manager.check_email(member.getEmail()) == 1)
		{
			out.println("<script>");
			out.println("alert('������ �̸����� �ֽ��ϴ�.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return 0;
		}
		
		else
		{
			manager.join_member(member);
			return 1;
		}
			
	}
	
	
	
	//�α��� üũ 
	@Override
	public MemberDTO login(MemberDTO member,HttpServletResponse response) throws Exception{
		response.setContentType("text/html;charset=utf-8");
		
		System.out.println("���̵�üũ ����(memberservice)");
		PrintWriter out = response.getWriter();
		
		//���� ���̵��� ���
		if(manager.check_id(member.getId()) == 0) 
		{
			out.println("<script>");
			out.println("alert('�������� �ʴ� ���̵��Դϴ�.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		}
		else 
		{
			String pw = member.getPw();
			member = manager.login(member.getId());
			// ��й�ȣ�� �ٸ� ���
			if(!member.getPw().equals(pw)) 
			{
				out.println("<script>");
				out.println("alert('��й�ȣ�� �ٸ��ϴ�.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
		
			}
			else
			{
				return member;  //member ��ȯ
			}			
		
	      }
	}
	
	//�α׾ƿ� ����
    @Override
    public void logout(HttpServletResponse response)throws Exception{
    	response.setContentType("text/html;charset=utf-8");

		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("location.href=document.referrer;"); //���ΰ�ħ  
		out.println("</script>");
    	System.out.println("�α׾ƿ� üũ ����(memberservice)");
		out.close();
    	
    }
    
    //ȸ������ ���� 
    @Override
    public MemberDTO update_mypage(MemberDTO member)throws Exception{
		manager.update_mypage(member);
    	return manager.login(member.getId());
    }
    
    //ȸ�� Ż�� 
    @Override
    public boolean delete(MemberDTO member, HttpServletResponse response) throws Exception{
    	
		return true;
		
		
	
    }




	
	
    
	


}
