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
        Response.Redirect("Check_mypage_pw.aspx"); //마이페이지 확인절차

    }

    protected void lbl3_Click(object sender, ImageClickEventArgs e) //회원리스트
    {
        if (Session["UserID"].ToString() == "admin")
        {
            Response.Redirect("Member_List.aspx"); //회원리스트로 이동
        }
        else
        {
            Label1.Text = "관리자가 아니라 사용할 수 없습니다.";
        }

    }


    //게시판 글 쓰기 
    protected void board_cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("recommendBoard.aspx"); //게시판글쓰기로 이동
    }


    protected void check_btn_Click(object sender, EventArgs e)
    {
        int no = int.Parse(Request["no"].ToString());
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true");//Connection ogi 설정 
        string sql = "delete from board where no=@no;"; 
        SqlCommand cmd = new SqlCommand(sql, con);
        String pw = check_pw.Text;

        cmd.Parameters.AddWithValue("@no", no); //명령문의 파리미터 값을 추가한다.
        cmd.Parameters.AddWithValue("@Password", pw); //명령문의 파라미터 값을 추가
        con.Open();
        SqlDataReader rd = cmd.ExecuteReader();
        if (rd.Read())
        {
            if(pw== rd["Password"].ToString())
            {

                Response.Redirect("recommendBoard.aspx");
            }
            else
            {
                Label2_check.Text = "비밀번호가 틀립니다.";
            }

        }
        rd.Close();
        con.Close();
    }
</script>





<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>주관적음악</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

 
    <style type="text/css">
        .auto-style1 {
            height: 49px;
        }
        .auto-style2 {
            height: 89px;
        }
    </style>

 
    </head>
<body>
    <form id="form1" runat="server">
   
        <div style="font-family: HY엽서L; font-size: 50px"><center>주관적음악 </center> </div> 

        <div align="right">
            <asp:ImageButton ID="lbl1" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl1_Click" /> <!-- 마이페이지 버튼-->
            <asp:ImageButton ID="lbl2" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl2_Click" />  <!--로그아웃 버튼-->
            <asp:ImageButton ID="lbl3" runat="server"  Font-Size="Small"  AlternateText=""  OnClick="lbl3_Click" /><br /> 
            <asp:Label ID="Label1" runat="server" Text="" Font-Size="X-Small"></asp:Label><!-- 회원리스트 -->
        </div>
          
            <div>
              <nav class="navbar navbar-inverse">
        <div class="container">

          <div class="navbar-header" style="font-family:HY엽서L">
          
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
    
        <center>
        <asp:TextBox ID="check_pw" runat="server" Width="200px" TextMode="Password"></asp:TextBox>
        <asp:Button ID="check_btn" runat="server" Text="확인" class="btn btn-defalut" OnClick="check_btn_Click" /><br />
            <asp:Label ID="Label2_check" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="Red"></asp:Label>
            </center>
      
          
    </form>
</body>
    
</html>

               