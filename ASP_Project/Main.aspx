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

    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("https://www.ligeta.co.kr/product/detail.html?product_no=16&cate_no=46&display_group=1&mac_ad_key=2100471761");
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
   
        <div style= "font-family: HY엽서L; font-size: 50px"><center >주관적음악</center> </div> 

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
       <center><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/imgs/ad_img1.jpg" Height="100" Width="800" OnClick="ImageButton1_Click"></asp:ImageButton></center> <!--광고함수 -->
        <br /><br /><br /><br />
         <table align="center" border="0" style="width: 100%; height: 500px; background-image: url('imgs/main_background.jpg');">
             <tr>
                 <td colspan="2" align="center">
                     <asp:Label ID="Main_Background_Label" runat="server" Text="Subjective Music" Font-Bold="True" Font-Names="Yu Gothic UI Semibold" Font-Size="XX-Large" ForeColor="White"></asp:Label>
                 </td>
             </tr>
             <tr>
                 <td align="center">
                     <iframe width="853" height="480" src="https://www.youtube.com/embed/3wHRqGpetq8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                 </td>
             </tr>
             <tr>
                 <td><center><asp:LinkButton ID="LinkButton1" runat="server" Font-Bold="True" Font-Size="Medium" OnClientClick="https://www.youtube.com/watch?v=3wHRqGpetq8">BTS Win Top Duo/Group | Backstage Interview | BBMAs 2019
                             </asp:LinkButton>
                     </center></td>
             </tr>

         </table>    
        
    
     
        
    </form>
</body>
    
</html>
