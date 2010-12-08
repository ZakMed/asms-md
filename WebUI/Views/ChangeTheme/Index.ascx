<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<System.Collections.Generic.IEnumerable<System.Web.Mvc.SelectListItem>>" %>
<form id="themesform" action="<%=Url.Action("Change", "ChangeTheme") %>" method="post">
<%=Html.DropDownList("themes", Model,new{style="width:100px;float:right;"})  %>
</form>
<script type="text/javascript">
    $(function () {
        $('#themes').change(function () {
            $(this.form).ajaxSubmit();
            $("#siteThemeLink").attr("href", "http://ajax.googleapis.com/ajax/libs/jqueryui/1.8.5/themes/" + $("#themes").val() + "/jquery-ui.css");
            setTimeout('colorfix()', 100);
            setTimeout('colorfix()', 400);
        });
    });
    function colorfix() { $('.ui-state-highlight a').css('color', $('.ui-state-default').css('color')); }
</script>
