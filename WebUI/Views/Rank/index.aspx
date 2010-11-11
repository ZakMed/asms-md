<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<MRGSP.ASMS.Core.Model.Fpi>"
    MasterPageFile="~/Views/Shared/Site.Master" %>
<%@ Import Namespace="MRGSP.ASMS.WebUI.Controllers" %>
<asp:Content runat="server" ID="Title" ContentPlaceHolderID="TitleContent">
</asp:Content>
<asp:Content runat="server" ID="Main" ContentPlaceHolderID="MainContent">
    <h2>
        <%= Model.Amount.Display() %></h2>
    <%=Html.MakePopupForm<RankController>(o => o.ChangeAmount(0),height:200) %>
    <%=Html.PopupFormActionLink<RankController>(o => o.ChangeAmount(Model.Id), "schimba suma", new{@class = "abtn"}) %>
    <hr />
    <%=Html.Confirm("Toate valorile coeficientilor vor fi sterse si recalculate din nou, sunteti sigur ?") %>
    <form method="post" action='<%=Url.Action("recalculate", new{FpiId = Model.Id}) %>'>
    <input type="submit" value="recalcul" class="confirm" />
    </form>
    <br />
    <h3>
        autorizat spre plata</h3>

    <a target="_blank" href="Repor.aspx?report=auth&fpiId=<%=Model.Id %>" class="abtn">raport</a>
    <% Html.RenderAction("authorized", new { fpiId = Model.Id });%>
    <h3>
        castigatori</h3>
    <% Html.RenderAction("winners", new { fpiId = Model.Id });%>
    <h3>
        rest</h3>
        <a target="_blank" href="Repor.aspx?report=losers&fpiId=<%=Model.Id %>" class="abtn">raport</a>
    <% Html.RenderAction("losers", new { fpiId = Model.Id });%>
    <h3>
        discalificati</h3>
    <% Html.RenderAction("disqualified", new { fpiId = Model.Id });%>
</asp:Content>
