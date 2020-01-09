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
        Board_name.Text = ID;


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

    protected void board_complete_Click(object sender, EventArgs e)
    {
        String ID = Session["UserID"].ToString();
        int hits = 0;
        string date = System.DateTime.Now.ToString();

        DateTime real = Convert.ToDateTime(date);


        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true");//Connection ogi 설정 
        string sql = "Insert Into board (name,contents,time,hits,subjects)Values(@name,@contents,@time,@hits,@subjects)"; //sql insert문실행 
        SqlCommand cmd = new SqlCommand(sql, con);//DB에서 수행시킬 명령어 객체를 만든다. 즉, sql을 con에 실행시키기 위해서 만든다.
                                                  //양식 가져오기 -> Parameter 가져오기 




        Board_name.Text = ID;
        cmd.Parameters.AddWithValue("@name",Board_name.Text);  //이름 
        cmd.Parameters.AddWithValue("@contents",Board_contents.Text); //본문
        cmd.Parameters.AddWithValue("@time", real); //시간
        cmd.Parameters.AddWithValue("@hits", hits);//조회수
        cmd.Parameters.AddWithValue("@subjects", Board_Subject.Text);//제목
        con.Open(); // sql커넥션  사용 
        cmd.ExecuteNonQuery(); //반환되는 결과값이 없는 쿼리
        con.Close(); //커넥션 종료 


        Response.Redirect("recommendBoard.aspx"); //로긴폼으로 이동
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
    
          <table class="table" align="center" style="width: 1000px; height: 500px" border="0">
            <thead>
              <tr>
                <th colspan="3"> <asp:Label ID="Board_1" runat="server" Text="추천게시판" Font-Bold="True" Font-Names="Yu Gothic UI Semibold" Font-Size="X-Large" Font-Underline="True" ForeColor="Blue"></asp:Label></th>
              </tr>
                <tr>
                    <th>닉네임:<asp:Label ID="Board_name" runat="server" Text="" Font-Size="Smaller"></asp:Label></th>
                </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="3" class="auto-style1"><asp:TextBox ID="Board_Subject" runat="server" BorderStyle="Solid" Width="100%" placeholder="제목을 입력해주세요." ></asp:TextBox></td> 
              </tr>
                 <tr>
                <td colspan="3" class="auto-style2" style="width: 1000px; height: 500px">
                    <asp:TextBox ID="Board_contents" runat="server" Height="80%" Width="100%" TextMode="MultiLine"></asp:TextBox></td> 
                 </tr>
            </tbody>
              <tr>
                    <td align="right" ><asp:Button ID="board_complete" runat="server" Text="등록" class="btn btn-defalut" OnClick="board_complete_Click" />  <!--글쓰기 등록-->
                        <asp:Button ID="board_cancel" runat="server" Text="목록" class="btn btn-defalut" OnClick="board_cancel_Click" />
                    </td>
                   
                </tr>
          </table>
      
          
    </form>
</body>
    
</html>

               