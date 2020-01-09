package com.Jaewon.homepage.controller;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.Jaewon.homepage.db.MemberDTO;
import com.Jaewon.homepage.service.MemberService;


//�α��� ,�α׾ƿ� 
@Controller
@RequestMapping("/login/*")
public class LoginController {
	
	@Autowired
	private MemberService service;
	
	
	    //�α��� �� �̵� 
		@RequestMapping(value="/loginForm.do",method = RequestMethod.GET)
		public String login_form() throws Exception{
			System.out.println("going to loginform");
			return "/login/loginForm"; 
		}
		
		//�α��� ����  
		@RequestMapping(value="/login.do", method=RequestMethod.POST)
		public String login(@ModelAttribute MemberDTO member,HttpSession session,
				HttpServletResponse response) throws Exception{
			member = service.login(member, response);
			session.setAttribute("member",member); //�����߰� 
			System.out.println("start login");
			return "redirect:../index.jsp";
		}
		
		//�α׾ƿ� ����  /login/logout.do�� ã�ƶ� 
		@RequestMapping(value ="/logout.do", method= {RequestMethod.GET, RequestMethod.POST})
		public String logout(HttpSession session, HttpServletResponse response)throws Exception{
			//session.invalidate(); //invalidate �Ǵ� removeAttribute ���� �ϳ��� ����ϸ� �ȴ�.
			session.removeAttribute("member");
			System.out.println("�α׾ƿ�����(controller)");
			return "redirect:/";
		}
	
	

}
