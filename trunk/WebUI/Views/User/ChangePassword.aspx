﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<ChangePasswordInput>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    schimba parola
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Schimba parola</h2>
    <% using (Html.BeginForm())
       {%>
    <%= Html.ValidationSummary(true) %>
    <fieldset>
        <%= Html.HiddenFor(model => model.Id) %>
        <%=Html.EditorFor(o => o.Password) %>
        <%=Html.EditorFor(o => o.ConfirmPassword) %>        
        <% Html.RenderPartial("save"); %>
    </fieldset>
    <% } %>
    <% Html.RenderPartial("back"); %>
</asp:Content>
