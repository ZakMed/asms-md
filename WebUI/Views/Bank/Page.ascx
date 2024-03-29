﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<IPageable<Bank>>" %>
<table>
    <thead class="ui-state-default">
        <tr>
            <th>
                Nume
            </th>
            <th>
                Cod
            </th>
        </tr>
    </thead>
    <% foreach (var bank in Model.Page)
       {
    %>
    <tr class="grow" value="<%:bank.Id %>">
        <td>
            <%:bank.Name %>
        </td>
        <td>
            <%:bank.Code %>
        </td>
    </tr>
    <%
        } %>
</table>

<%:Html.AjaxPagination(Model.PageCount, Model.PageIndex, "getBankPage") %>

<script type="text/javascript">
    $("#banklist table .grow").click(growbankClick);
</script>
