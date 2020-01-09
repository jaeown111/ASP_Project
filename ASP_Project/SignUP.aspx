<%@ Page Language="C#" %>
<%@ Import Namespace="System.Data.SqlClient" %> 

<!DOCTYPE html>

<script runat="server">





    protected void Button1_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection("Data Source=.\\SQLEXPRESS_CJW; initial Catalog=MyDB;integrated Security=true");//Connection ogi 설정 
        string sql = "Insert Into Member (UserID,Password,Name,Phone)Values(@UserID, @Password, @Name, @Phone)"; //sql insert문실행 
        SqlCommand cmd = new SqlCommand(sql, con);//DB에서 수행시킬 명령어 객체를 만든다. 즉, sql을 con에 실행시키기 위해서 만든다.
        //양식 가져오기 -> Parameter 가져오기 
        cmd.Parameters.AddWithValue("@UserId", TextBox1.Text);  //textbox2 값을 sql문 @UserID 칼럼에 값을 넣는다. 
        cmd.Parameters.AddWithValue("@Password", TextBox2.Text); // "
        cmd.Parameters.AddWithValue("@Name", TextBox3.Text); // " 
        cmd.Parameters.AddWithValue("@Phone", TextBox4.Text);//textbox4 값을 sql문 @Phone 칼럼에 값을 넣는다. 
        con.Open(); // sql커넥션  사용 
        cmd.ExecuteNonQuery(); //반환되는 결과값이 없는 쿼리
        con.Close(); //커넥션 종료 

        Label1.Text = "<br/>" + TextBox1.Text + "의 입력완료";
        Response.Redirect("LoginForm.aspx"); //로긴폼으로 이동
    }

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"/>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

       <style>
    span 
    {
    font-weight: bold;
    font-size: 2em;
    }
    h1
    {
        font-weight: bold;
    font-size: 2em;
    }
</style>

      <style type="text/css">
          #Sign_div{
               position:absolute;
             top:27%;
            left:30%;
     
           
          }
 

      </style>
</head>
 
<body style="background-color: #2BC3F8">
     <a href="LoginForm.aspx"><img src="imgs/LoginForm_img.png" height="50" width="50" /><span style="font-size: small">유한뮤직</span></a>
    <form id="form1" runat="server">

     <div style="position: absolute; left: 45%;">
          <h1>회 원 가 입</h1>
           </div>
        <div style="background-color: #FFFFFF" id="Sign_div">
               
            <table style="margin: 100px">
         <tr><td> <span>아이디</span></td><td><asp:TextBox ID="TextBox1" class="form-control" runat="server" Text=""></asp:TextBox></td>
             <td> <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="아이디를 입력해주세요" ControlToValidate="TextBox1" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td></tr>
               

         <tr><td><span>비밀번호</span></td><td><asp:TextBox ID="TextBox2" class="form-control" runat="server"></asp:TextBox></td>
                 <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="비밀번호를 입력해주세요" ControlToValidate="TextBox2" Display="Dynamic" SetFocusOnError="True" TextMode="Password"></asp:RequiredFieldValidator></td></tr>
         <tr><td><span>이름</span></td><td><asp:TextBox ID="TextBox3" class="form-control" runat="server"></asp:TextBox></td>
                   <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="이름을 입력해주세요." ControlToValidate="TextBox3" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator></td></tr>
          <tr><td><span>전화번호</span></td><td><asp:TextBox ID="TextBox4" class="form-control" runat="server" placeholder="'-'를 붙여주세요"></asp:TextBox></td>
             <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="전화번호를 입력해주세요." ControlToValidate="TextBox4" Display="Dynamic" SetFocusOnError="True"></asp:RequiredFieldValidator>
                 <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="전화번호 형식이 잘못 되었습니다."
                            ControlToValidate="TextBox4" SetFocusOnError="True" ValidationExpression="\d{3}-\d{4}-\d{4}" Display="Dynamic"></asp:RegularExpressionValidator>
             </td></tr>
            <tr>
                
                <td colspan="2"><asp:Button ID="Button1" runat="server" Text="회원가입" class="btn btn-lg btn-primary btn-block" style= "width:310px; height:50px" OnClick="Button1_Click" /></td>
                 
            </tr>
              </table>
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
              
               
        </div>
    </form>
   
</body>
</html>
