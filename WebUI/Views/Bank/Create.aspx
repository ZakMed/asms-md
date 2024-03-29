﻿<%@ Page Title="" Language="C#" Inherits="System.Web.Mvc.ViewPage<MRGSP.ASMS.Infra.Dto.BankCreateInput>" %>

<% using (Html.BeginForm())
   {%>
   <div class="short">
<div class="efield">
    <div class="elabel">
        <%= Html.LabelFor(model => model.Name) %>
    </div>
    <div class="einput">
        <%= Html.TextBoxFor(model => model.Name) %>
        <%= Html.ValidationMessageFor(model => model.Name) %>
    </div>
</div>
<div class="efield">
    <div class="elabel">
        <%= Html.LabelFor(model => model.Code) %>
    </div>
    <div class="einput">
        <%= Html.TextBoxFor(model => model.Code) %>
        <%= Html.ValidationMessageFor(model => model.Code) %>
    </div>
</div>
</div>
<button type="submit" class="hidden" />
<% } %>
