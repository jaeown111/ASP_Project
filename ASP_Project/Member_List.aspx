<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %> 
<%@ Import Namespace="System.Data" %>

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
        }
        //어드민 접속시 
        if (Session["UserID"].ToString() == "admin")
        {
            lbl1.AlternateText = "관리자 접속하셨습니다.";
            lbl2.AlternateText = "로그아웃";
            lbl3.AlternateText = "회원리스트";
        }

        if(!Page.IsPostBack)
        {
            BindList();
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



    protected void lbl3_Click(object sender, ImageClickEventArgs e) //회원리스트로 이동
    {
        Response.Redirect("Member_List.aspx"); //회원리스트로 이동

    }

    void BindList()
    {
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true" );
        string sql = "Select UserID, Password, Name , Phone from Member";
        SqlCommand cmd = new SqlCommand(sql,con);
        SqlDataAdapter sql_ad = new SqlDataAdapter();
        // 데이터 들고와 어댑터로 들고온다 연결잭같은거(가상디비와 연결한다.)

        sql_ad.SelectCommand = cmd;
        DataSet ds = new DataSet(); //가상데이터
        sql_ad.Fill(ds); //ds에 sql_ad를 채운다


        GridView1.DataSource = ds;  //가상데이터를 GridView1에 넣는다.carousel-example-generic
       



    }


    protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {

        GridView1.PageIndex = e.NewPageIndex;
        BindList();

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
            span  
    {
              font-weight: bold;
              font-size: 2em;
              position:absolute;
            top: 27px;
            left: 1078px;
            height: 25px;
            width: 217px;
        } 
     </style>
</head>
<body>
    <form id="form1" runat="server">
   
        <div style="font-family: HY엽서L; font-size: 50px"><center>주관적음악 </center> </div> 

        <div align="right">
            <asp:ImageButton ID="lbl1" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl1_Click" /> <!-- 마이페이지 버튼-->
            <asp:ImageButton ID="lbl2" runat="server"  Font-Size="Small"  AlternateText="" OnClick="lbl2_Click" />  <!--로그아웃 버튼-->
            <asp:ImageButton ID="lbl3" runat="server"  Font-Size="Small"  AlternateText=""  OnClick="lbl3_Click" />  <!-- 회원리스트 -->
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
         <div>
             <center> <h1>현재 가입한 회원들의 목록입니다.</h1><br />

             <asp:GridView ID="GridView1" runat="server" AllowPaging="True" PageSize="10"  AutoGenerateColumns="False"  OnPageIndexChanging="GridView1_PageIndexChanging" align="center"> 
                <Columns>
                     <asp:BoundField DataField="UserId" ReadOnly="True" HeaderText="아이디" />
                     <asp:BoundField DataField="Password" HeaderText="비밀번호"/>
                     <asp:BoundField DataField="Name"  HeaderText="이름"/>
                     <asp:BoundField DataField="Phone"  HeaderText="연락처"/>
                </Columns>
                <SelectedRowStyle  BackColor="LightPink"/>
               
            </asp:GridView>
             </center>
         </div>
     
    
     
        
    </form>
</body>
    
</html>
