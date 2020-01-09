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

            if(!Page.IsPostBack)
            {


                int no = int.Parse(Request["no"].ToString());
                SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true");//Connection ogi 설정 
                string sql = "select no,name,contents,time,hits,subjects from board where @no=no"; //sql insert문실행 
                string sql1 = "update board set hits = hits+1 where @no=no";
                SqlCommand cmd = new SqlCommand(sql, con);
                SqlCommand cmd1 = new SqlCommand(sql1, con);
                cmd.Parameters.AddWithValue("@no", no); //명령문의 파리미터 값을 추가한다.
                con.Open();
                SqlDataReader rd = cmd.ExecuteReader();

                if(rd.Read())
                {  Board_no.Text = rd["no"].ToString();
                    Board_name.Text = rd["name"].ToString();
                    Board_subjects.Text = rd["subjects"].ToString();
                    Contents_Label.Text = rd["contents"].ToString();
                    Board_time.Text = rd["time"].ToString();
                    Board_hits.Text += rd["hits"].ToString();
                }
                rd.Close();
                con.Close();

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




        protected void board_complete_Click(object sender, EventArgs e)
        {
            Response.Redirect("Board_ok.aspx"); //로긴폼으로 이동
        }

        protected void board_delete_Click(object sender, EventArgs e) //글삭제
        {

            Response.Redirect("board_delete.aspx"); //마이페이지로 이동
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
            height: 86px;
        }
        .auto-style2 {
            height: 89px;
        }
        .auto-style3 {
            height: 52px;
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
                <th colspan="3" class="auto-style3"> <asp:Label ID="Board_1" runat="server" Text="추천게시판" Font-Bold="True" Font-Names="Yu Gothic UI Semibold" Font-Size="X-Large" Font-Underline="True" ForeColor="Blue"></asp:Label></th>
                  <asp:Label ID="Board_no" runat="server" Text="Label"></asp:Label>
              </tr>
                <tr>
                    <th>닉네임:<asp:Label ID="Board_name" runat="server" Text="닉네임" Font-Size="Smaller"></asp:Label></th>
                </tr>
            </thead>
            <tbody>
              <tr>
                <td colspan="3" class="auto-style1" style="height: 50px" ><asp:Label ID="Board_subjects" runat="server" Text="제목"></asp:Label></td> 
              </tr>
                <tr>
                    <td><asp:Label ID="Board_time" runat="server" Text="시간"></asp:Label></td>
                    </tr>
                <tr>
                    <td><asp:Label ID="Board_hits" runat="server" Text="조회수"></asp:Label></td>
                </tr>

                 <tr>
                <td colspan="3" class="auto-style2" style="width: 1000px; height: 500px">
                    <asp:Label ID="Contents_Label" runat="server" Text="Label" Height="80%" Width="100%" TextMode="MultiLine"></asp:Label>
                   </td> 
                 </tr>
            </tbody>
              <tr>
                    <td align="right" ><asp:Button ID="board_complete" runat="server" Text="글쓰기" class="btn btn-defalut" OnClick="board_complete_Click" />  <!--글쓰기 등록-->
                        <asp:Button ID="board_delete" runat="server" Text="글삭제" class="btn btn-defalut"  OnClick="board_delete_Click" />
                        <asp:Button ID="board_cancel" runat="server" Text="목록" class="btn btn-defalut" OnClick="board_cancel_Click" />
                    </td>
                   
                </tr>
          </table>
      
          
    </form>
</body>
    
</html>

               