﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MRGSP.ASMS.Infra.Dto.UserCreateInput>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Create
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2>
        Adauga utilizator</h2>
    <% using (Html.BeginForm())
       {%>
    <%= Html.ValidationSummary(true) %>
    <%=Html.ValidationMessage("roles") %>
    <fieldset>
        <%=Html.Input(o => o.Name) %>
        <%=Html.Input(o => o.Password) %>
        <%=Html.Input(o => o.ConfirmPassword) %>
        <div class="efield">
            <div class="elabel">
                <label>
                    Roluri</label>
            </div>
            <div class="einput">
                <% foreach (var role in Model.Roles as IEnumerable<SelectListItem>)
                   {
                %>
                <p>
                    <input <%if(role.Selected) Response.Write("checked='checked'");%> id='role<%=role.Value %>'
                        type="checkbox" name='roles' value='<%=role.Value %>' />
                    <label for="<%="role"+role.Value %>">
                        <%=role.Text %></label>
                </p>
                <%
                    } %>
            </div>
        </div>
        <br class="cbt" />
        <div class="esubmit">
            <input type="submit" value="Salveaza" />
        </div>
    </fieldset>
    <% } %>
    <div>
        <%= Html.ActionLink("Inapoi la lista", "Index") %>
    </div>
    <%=Html.ClientSideValidation<UserCreateInput>() %>
</asp:Content>