<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buy</title>
<link rel="stylesheet" href="css/Buy.css">
</head>
<body>
<div class="main">
	<div class="topbar1"></div>
	<div class="topbar2">
		<div class="container1">
			<div class="logout-btn">
				<a href="Logout.jsp">Logout</a>
			</div>
		</div>
	</div>
	<div class="header">
		<div class="container2">
			<div class="navbar">
				<a href="Homepage.jsp">HOME</a>
				<a href="Buy.jsp">BUY</a>
				<a href="Orders.jsp">ORDERS</a>
				
				
				<div class="search-box">
				<form action ="" method="get">
			<input  type="text" class="form-control" name="q" placeholder="Search medicine by Name..."/> 
			</form>
			
			<form action ="" method="get">
			<input  type="text" class="form-control" name="q1" placeholder="Search medicine by location..."/> 
			</form>
			</div>
			
			</div>
			
		</div>
	</div>
</div>
<div class="active">
	<%@ page import="java.sql.*" %>
	<%@ page import="javax.sql.*" %>
	<%
	HttpSession httpSession = request.getSession();
    String uid=(String)httpSession.getAttribute("currentuser");
    %>
    
    <div class="filler"></div>
    
    <%
    int flag=0;
	ResultSet rs=null;
	ResultSet rs1=null;
	ResultSet rs2=null;
	Statement stat2=null;
	PreparedStatement ps=null;
	Statement stat=null;
	java.sql.Connection conn=null;
	String query="select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid";
	
	try{
		Class.forName("com.mysql.jdbc.Driver");
		conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/drugdatabase","root","Change@3011");
		String query1= request.getParameter("q");
		String query2= request.getParameter("q1");
		String data2;
		String data;
		
		
if(query2!=null){
			
			stat2= conn.createStatement();
			
			data2= "select DISTINCT p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity,s.sname from product p,inventory i,seller s  where (p.pid,i.quantity,s.sname) IN (select i1.pid,i1.quantity,s1.sname from inventory i1,seller s1 where i1.sid=s1.sid and s1.address like '%"+query2+"%')";
			rs2= stat2.executeQuery(data2);
			%><div class="filler2"></div>
			<div class="block">
			<%
			
			while(rs2.next())
			{
				if(flag==4)
					{
					flag=1; 
					%></div><div class="filler2"></div><%
					}
				else
				flag++;
			%>
				<div class="row">
	 				<div class="column">
	    				<div class="card">
	    				<img src="images/pills.png" width=180 height=200>
	  					<h1><%=rs2.getString("pname") %></h1>
	  					<p><b>ID: </b><%=rs2.getString("pid") %></p>
						<p><b>Manufacturer: </b><%=rs2.getString("manufacturer") %></p>
						<p><b>Mfg Date: </b><%=rs2.getDate("mfg") %></p>
						<p><b>Stock: </b><%=rs2.getInt("quantity") %></p>
						<p><b>Price: </b><%=rs2.getInt("price") %></p>
						<p><b>Seller: </b><%=rs2.getString("sname") %></p>
						<%if (rs2.getInt("quantity")>0) 
						{
						%>
	  					<form action="PlaceOrder.jsp" method="post">
	  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs2.getInt("quantity") %>" required >
	  					<input type="hidden" name="pid" value="<%=rs2.getString("pid") %>">
	  					<p></p>
	  					<button>Buy</button></form></div>
	  					<%
	  					}
	  					else	
	  						{
	  						%>
	  					
	  					<button>Out Of Stock</button></div>
	  					<% 
	  						} 
	  					%>
	  				</div>
	  				<%
	  				}
					%>
				</div>
			<%
		}
		
		
		
//---------------------------------------------------------------------------------------------------------------------------------
		
		
		
		
		
else if(query1!=null){
			
			stat= conn.createStatement();
			
			data= "select p.pname,p.pid,p.manufacturer,p.mfg,p.price,i.quantity from product p,inventory i where p.pid=i.pid and p.pname like '%"+query1+"%' ";
			rs1= stat.executeQuery(data);
			%><div class="filler2"></div>
			<div class="block">
			<%
			
			while(rs1.next())
			{
				if(flag==4)
					{
					flag=1;
					%></div><div class="filler2"></div><%
					}
				else
				flag++;
			%>
				<div class="row">
	 				<div class="column">
	    				<div class="card">
	    				<img src="images/pills.png" width=180 height=200>
	  					<h1><%=rs1.getString("pname") %></h1>
	  					<p><b>ID: </b><%=rs1.getString("pid") %></p>
						<p><b>Manufacturer: </b><%=rs1.getString("manufacturer") %></p>
						<p><b>Mfg Date: </b><%=rs1.getDate("mfg") %></p>
						<p><b>Stock: </b><%=rs1.getInt("quantity") %></p>
						<p><b>Price: </b><%=rs1.getInt("price") %></p>
						<%if (rs1.getInt("quantity")>0) 
						{
						%>
	  					<form action="PlaceOrder.jsp" method="post">
	  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs1.getInt("quantity") %>" required >
	  					<input type="hidden" name="pid" value="<%=rs1.getString("pid") %>">
	  					<p></p>
	  					<button>Buy</button></form></div>
	  					<%
	  					}
	  					else	
	  						{
	  						%>
	  					
	  					<button>Out Of Stock</button></div>
	  					<% 
	  						} 
	  					%>
	  				</div>
	  				<%
	  				}
					%>
				
				<!--</div>  -->
			<%
		}
	
		
			
			
		
		
		else{
		
		ps=conn.prepareStatement(query);
		rs=ps.executeQuery();
		%><div class="filler2"></div>
				<div class="block">
				<%
		while(rs.next())
		{
			if(flag==4)
				{
				flag=1;
				%></div><div class="filler2"></div><%
				}
			else
			flag++;
		%>
			<div class="row">
 				<div class="column">
    				<div class="card">
    				<img src="images/pills.png" width=180 height=200>
  					<h1><%=rs.getString("pname") %></h1>
  					<p><b>ID: </b><%=rs.getString("pid") %></p>
					<p><b>Manufacturer: </b><%=rs.getString("manufacturer") %></p>
					<p><b>Mfg Date: </b><%=rs.getDate("mfg") %></p>
					<p><b>Stock: </b><%=rs.getInt("quantity") %></p>
					<p><b>Price: </b><%=rs.getInt("price") %></p>
					<%if (rs.getInt("quantity")>0) 
					{
					%>
  					<form action="PlaceOrder.jsp" method="post">
  					<input type="number" name="orderquantity" onkeypress="return event.charCode>= 48 && event.charCode<= 57" placeholder="Enter quantity" max="<%=rs.getInt("quantity") %>" required >
  					<input type="hidden" name="pid" value="<%=rs.getString("pid") %>">
  					<p></p>
  					<button>Buy</button></form></div>
  					<%
  					}
  					else	
  						{
  						%>
  					
  					<button style=" background-color:RED;">Out Of Stock</button></div>
  					<% 
  						} 
  					%>
  				</div>
  				<%
  				}
				%>
			<!--</div>  -->
		<%
	}}
	catch(Exception e)
	{
		out.println("error: "+e);
	}
	finally {
	    try { if (rs != null) rs.close(); } catch (Exception e) {};
	    try { if (ps != null) ps.close(); } catch (Exception e) {};
	    try { if (conn != null) conn.close(); } catch (Exception e) {};
}
	
	%>
</body>
</html>
