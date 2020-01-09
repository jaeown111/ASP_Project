<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %> 

<!DOCTYPE html>

<script runat="server">

            protected void Page_Load(object sender, EventArgs e)
            {

            }

            // Response.Redirect("Main.aspx"); <--페이지 이동

            protected void Button2_Click(object sender, EventArgs e) //로그인 버튼
            {
                SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true");//Connection ogi 설정 
                string sql = "Select UserID, Password from Member Where UserID=@UserID";
                SqlCommand cmd = new SqlCommand(sql, con);//DB에서 수행시킬 명령어 객체를 만든다. 즉, sql을 con에 실행시키기 위해서 만든다.
                String id = input_id.Text;
                String pw = input_pw.Text;

              cmd.Parameters.AddWithValue("@UserID", id); //명령문의 파리미터 값을 추가한다.
          
            
                con.Open(); //서버를 연다.
                SqlDataReader rd = cmd.ExecuteReader();

                if(rd.Read())
                {
                    if (id == rd["UserID"].ToString() && pw == rd["Password"].ToString())
                    {
                
                        Session["UserID"] = input_id.Text;
                        Response.Redirect("Main.aspx");
                    }
                    else 
                    {
                        Label1.Text = "로그인실패";
                    }
                   
                }
                 else 
                    {
                        Label1.Text = "로그인실패";
                    }
                       rd.Close();
                      con.Close();
            }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>로그인폼</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    

    <style type="text/css">

        #login_id img{
             position:absolute;
             top:20%;
            left:45%;
            margin-top:-25px;
           margin-left:-25px;

        }
        #login_text{
          
        }

        #login_input_text{
           position:absolute;
           top:55%;
           left:45%;
            margin-top:-25px;
           margin-left:-25px;
        }

         #signup_btn{
           position:absolute;
           top:70%;
           left:46%;
            margin-top:-25px;
           margin-left:-25px;
        }

           span 
    {
             font-weight: bold;
            font-size: 2em;
              position:absolute;
           top:48%;
           left:48%;
            margin-top:-25px;
           margin-left:-25px;
    }

    

          
   </style>


   <script type="text/javascript">
</script>
    
</head>
<body style="background-color: #2BC3F8">
    <form id="form1" runat="server">
        <div id="login_id" >
            <a href="LoginForm.aspx"><asp:Image ID="Image1" runat="server" ImageUrl="~/imgs/LoginForm_img.png" /></a>
            <span>로그인 화면</span>
             </div>
        
          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ControlToValidate="input_id" Display="Dynamic" Font-Size="Smaller" SetFocusOnError="True"></asp:RequiredFieldValidator>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ControlToValidate="input_pw" Display="Dynamic" Font-Size="Smaller" SetFocusOnError="True"></asp:RequiredFieldValidator>
       
        <div id="login_input_text">
            <table border="0" >
                <tr>
                   <td><asp:TextBox ID="input_id" name="id" value=""  runat="server"  class="form-control" placeholder="Input Your ID" style= "width:200px; height:50px"/> 
                         
                   </td> 
                    <td rowspan="2"><asp:Button ID="Button2" runat="server"  class="btn btn-lg btn-primary btn-block" Text="로그인" style= "width:100px; height:100px"  OnClick="Button2_Click" />
                        <asp:Label ID="Label1" runat="server" Size="Small" Font-Size="Small"/>  <!--로그인 성공여부-->
                    </td>              
                 
                </tr>
                <tr>
                    <td> <asp:TextBox ID="input_pw" runat="server"  class="form-control" placeholder="Input Your Password" style= "width:200px; height:50px" TextMode="Password"/></td>
                 
                </tr>
           
                </table>
             
       </div>
        <div id="signup_btn">
            <input type="button" class="btn btn-lg btn-primary btn-block" value="회원가입하기"  style= "width:250px; height:50px" onclick="window.location='SignUp.aspx'" />      
             <p class="mt-5 mb-3 text-muted">&copy; 201507030최재원</p>
               </div>
            
    
     
            
       
           
              
        
     
    </form>
</body>
</html>
