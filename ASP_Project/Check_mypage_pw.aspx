<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %> 

<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        String ID = Session["UserID"].ToString();


        if(Session["UserID"] == null)
        {
            Response.Redirect("LoginForm.aspx");
        }
        else
        {
            lbl1.AlternateText = ID + "님 환영합니다";
            lbl2.AlternateText = "로그아웃";
            lbl3.AlternateText = "회원리스트";

        }

        //어드민 접속시 
        if (Session["UserID"].ToString() == "admin")
        {
            lbl1.AlternateText = "관리자 접속하셨습니다.";
            lbl2.AlternateText = "로그아웃";
            lbl3.AlternateText = "회원리스트";
        }

    }

    protected void lbl2_Click(object sender, ImageClickEventArgs e)
    {
        Session["UserID"] = null;   //세션 null값으로 초기화 
        Response.Redirect("LoginForm.aspx"); //후에 로긴폼으로 이동


    }

    protected void lbl1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Check_mypage_pw.aspx"); //마이페이지로 이동
    }

    protected void Button1_Click(object sender, EventArgs e) //마이페이지 비번 확인절차
    {
        String ID = Session["UserID"].ToString();
         SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true" );//Connection ogi 설정 
        string sql = "Select UserID, Password from Member Where UserID=@UserID ";
        SqlCommand cmd = new SqlCommand(sql, con);//DB에서 수행시킬 명령어 객체를 만든다. 즉, sql을 con에 실행시키기 위해서 만든다
        String pw = input_pw.Text;

        cmd.Parameters.AddWithValue("@UserID",ID); //명령문의 파리미터 값을 추가한다.
        cmd.Parameters.AddWithValue("@Password", input_pw.Text); //명령문의 파라미터 값을 추가
        con.Open(); //서버를 연다.
        SqlDataReader rd = cmd.ExecuteReader();

        if (rd.Read())
        {
            if(pw == rd["Password"].ToString())
            {
               
                Response.Redirect("Mypage.aspx");
            }
             else
               {
            Label1.Text = "비밀번호가 틀립니다.";
               }

        }
       
        rd.Close();
        con.Close();


    }

     protected void lbl3_Click(object sender, ImageClickEventArgs e) //회원리스트
    {
        if (Session["UserID"].ToString() == "admin")
        {
            Response.Redirect("Member_List.aspx"); //회원리스트로 이동
        }
        else
        {
            Label2.Text = "관리자가 아니라 사용할 수 없습니다.";
        }

    }
</script>





<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>주관적음악</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

    <style>
   
     </style>
</head>
<body>
    <form id="form1" runat="server">
   
        <div style="font-family: HY엽서L; font-size: 50px"><center>주관적음악 </center> </div> 

        <div align="right">
            <asp:ImageButton ID="lbl1" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl1_Click" /> <!-- 마이페이지 버튼-->
            <asp:ImageButton ID="lbl2" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl2_Click" />  <!--로그아웃 버튼-->
            <asp:ImageButton ID="lbl3" runat="server"  Font-Size="Small"  AlternateText=""  OnClick="lbl3_Click" /><br />
                 <asp:Label ID="Label2" runat="server" Text="" EnableTheming="True" Font-Size="X-Small"></asp:Label>
        </div>

   
            <div>
              <nav class="navbar navbar-inverse">
        <div class="container">

          <div class="navbar-header" style="font-family: HY엽서L">
          
            <a class="navbar-brand" href="Main.aspx" style="padding-right: 80px">MUSIC</a>
          </div>

          <div class="navbar-collapse collapse" style="font-family: HY엽서L">
            <ul class="nav navbar-nav">
                 <li class="active" style="padding-right: 80px"><a href="Main.aspx">Home</a></li>
                <li style="padding-right: 80px"><a href="News.aspx">News</a></li>
              <li style="padding-right: 80px"><a href="recommendBoard.aspx">RecommendBoard</a></li>
             <li><a href="Month_Music.aspx" style="padding-right: 80px">Song of This Month</a></li>          
                </ul>
          </div>
        </div>
      </nav>
        </div> 

          <!--마이페이지 클릭시 패스워드 확인절차-->
        <div align="center">   
            <asp:TextBox ID="input_pw" runat="server"></asp:TextBox>
            <asp:Button ID="Button1" runat="server" Text="확인" OnClick="Button1_Click" /><br />
            <asp:Label ID="Label1" runat="server" align="center" Font-Size="Small" ForeColor="Red" ></asp:Label>
        </div>
        
     
    
     
        
    </form>
</body>
    
</html>
