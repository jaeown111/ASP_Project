<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {

        if(!Page.IsPostBack)
        {
            BindList();
        }


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


    protected void Button1_Click(object sender, EventArgs e)
    {
        Response.Redirect("Board_ok.aspx"); //게시판글쓰기로 이동
    }

    void BindList()
    {
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true" );
        string sql = "Select * from board";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataAdapter sql_ad = new SqlDataAdapter();
        // 데이터 들고와 어댑터로 들고온다 연결잭같은거(가상디비와 연결한다.)

        sql_ad.SelectCommand = cmd;
        DataSet ds = new DataSet(); //가상데이터
        sql_ad.Fill(ds); //ds에 sql_ad를 채운다


        GridView1.DataSource = ds;  //가상데이터를 GridView1에 넣는다.

        GridView1.DataBind();

    }



    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e) //바뀌는중 changed는 바뀌었을 때
    {
        GridView1.PageIndex = e.NewPageIndex;
        BindList();
    }

    protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
    {
        GridView1.EditIndex = e.NewEditIndex;
        BindList();

    }

    protected void write_board_Click(object sender, EventArgs e)
    {
        Response.Redirect("Board_ok.aspx"); 
    }
</script>





<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>주관적음악</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

 
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
     <div align="center">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True"
                PageSize="3" OnPageIndexChanging="GridView1_PageIndexChanging" AutoGenerateColumns="False" OnRowEditing="GridView1_RowEditing"
                DataKeyNames="Name"   class="table">
            <Columns>
                    <asp:BoundField DataField="no" ReadOnly="True" HeaderText="번호" />
                   <asp:HyperLinkField  DataTextField="subjects"  DataNavigateUrlFields="no" DataNavigateUrlFormatString="~/board_check.aspx?no={0}" /><asp:BoundField DataField="subjects" HeaderText="제목"/>
                     <asp:BoundField DataField="name"  HeaderText="글쓴이"/>
                     <asp:BoundField DataField="time"  HeaderText="날짜"/>
                <asp:BoundField DataField="hits"  HeaderText="조회수"/>
                
                </Columns>
            
            <SelectedRowStyle  BackColor="LightPink"/>
        </asp:GridView><br />
         <td colspan="4">   <asp:Button ID="write_board" runat="server" Text="글쓰기"  class="btn btn-defalut" OnClick="write_board_Click" />
      </div>
          
    </form>
</body>
    
</html>
