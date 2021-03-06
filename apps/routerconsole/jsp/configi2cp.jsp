<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html><head>
<%@include file="css.jsi" %>
<%=intl.title("config clients")%>
<style type='text/css'>
button span.hide{
    display:none;
}
input.default { width: 1px; height: 1px; visibility: hidden; }
</style>
<script src="/js/ajax.js" type="text/javascript"></script>
<%@include file="summaryajax.jsi" %>
</head><body onload="initAjax()">

<%@include file="summary.jsi" %>

<jsp:useBean class="net.i2p.router.web.ConfigClientsHelper" id="clientshelper" scope="request" />
<jsp:setProperty name="clientshelper" property="contextId" value="<%=(String)session.getAttribute(\"i2p.contextId\")%>" />
<jsp:setProperty name="clientshelper" property="edit" value="<%=request.getParameter(\"edit\")%>" />
<h1><%=intl._t("I2P Client Configuration")%></h1>
<div class="main" id="main">
 <%@include file="confignav.jsi" %>

 <jsp:useBean class="net.i2p.router.web.ConfigClientsHandler" id="formhandler" scope="request" />
<%@include file="formhandler.jsi" %>
 <div class="configure">
<h3><a name="i2cp"></a><%=intl._t("Advanced Client Interface Configuration")%></h3>
<form action="configi2cp" method="POST">
<input type="hidden" name="nonce" value="<%=pageNonce%>" >
<p>
<b><%=intl._t("External I2CP (I2P Client Protocol) Interface Configuration")%></b><br>
<input type="radio" class="optbox" name="mode" value="1" <%=clientshelper.i2cpModeChecked(1) %> >
<%=intl._t("Enabled without SSL")%><br>
<input type="radio" class="optbox" name="mode" value="2" <%=clientshelper.i2cpModeChecked(2) %> >
<%=intl._t("Enabled with SSL required")%><br>
<input type="radio" class="optbox" name="mode" value="0" <%=clientshelper.i2cpModeChecked(0) %> >
<%=intl._t("Disabled - Clients outside this Java process may not connect")%><br>
<%=intl._t("I2CP Interface")%>:
<select name="interface">
<%
       String[] ips = clientshelper.intfcAddresses();
       for (int i = 0; i < ips.length; i++) {
           out.print("<option value=\"");
           out.print(ips[i]);
           out.print('\"');
           if (clientshelper.isIFSelected(ips[i]))
               out.print(" selected=\"selected\"");
           out.print('>');
           out.print(ips[i]);
           out.print("</option>\n");
       }
%>
</select><br>
<%=intl._t("I2CP Port")%>:
<input name="port" type="text" size="5" maxlength="5" value="<jsp:getProperty name="clientshelper" property="port" />" ><br>
<b><%=intl._t("Authorization")%></b><br>
<input type="checkbox" class="optbox" name="auth" value="true" <jsp:getProperty name="clientshelper" property="auth" /> >
<%=intl._t("Require username and password")%><br>
<%=intl._t("Username")%>:
<input name="user" type="text" value="" /><br>
<%=intl._t("Password")%>:
<input name="nofilter_pw" type="password" value="" /><br>
</p><p><b><%=intl._t("The default settings will work for most people.")%></b>
<%=intl._t("Any changes made here must also be configured in the external client.")%>
<%=intl._t("Many clients do not support SSL or authorization.")%>
<i><%=intl._t("All changes require restart to take effect.")%></i>
</p><hr><div class="formaction">
<input type="submit" class="default" name="action" value="<%=intl._t("Save Interface Configuration")%>" />
<input type="submit" class="cancel" name="foo" value="<%=intl._t("Cancel")%>" />
<input type="submit" class="accept" name="action" value="<%=intl._t("Save Interface Configuration")%>" />
</div></form>
</div></div></body></html>
