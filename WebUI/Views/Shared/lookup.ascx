﻿<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl<LookupInfo>" %>
<script type="text/javascript">

    function grow<%=Model.For %>Click() {
        $(".selected", $(this).parent()).removeClass('selected').unbind('click').click(grow<%=Model.For %>Click);
        $(this).addClass('selected');

        $(this).click(function () {
            choose<%=Model.For%>Click("#select-<%=Model.For%>-dialog", "#<%=Model.For%>list", '<%:Url.Action("Get", Model.For + "Lookup")%>', '#display<%=Model.For%>', '#<%=Model.For%>Id');
        });
    }

    function choose<%=Model.For%>Click(theDialog, list, url, display, input) {
        var v = $(list + " table .selected").attr("value");
        if (v != null)
            $.post(url, { id: v },
                            function (data) { $(display).val(data); $(input).val(v); $(display+"x").val(data); });
        $(theDialog).dialog('close');
    }

    $(function () { 
        $("#select-<%=Model.For %>-dialog").dialog({    
            resizable: true,
            height: 400,
            width: 700,
            modal: true,           
            buttons: {
                'Alege': function () {
                    choose<%=Model.For%>Click("#select-<%=Model.For%>-dialog", "#<%=Model.For%>list", '<%:Url.Action("Get", Model.For + "Lookup")%>', '#display<%=Model.For%>', '#<%=Model.For%>Id');
                },
                'Anuleaza': function () { $(this).dialog('close'); }
            },            
            autoOpen: false
        }); // end dialog

        $("#open-<%=Model.For %>").click(function () {
            $("#create-<%=Model.For %>-dialog").remove();

            $.get(
                '<%=Url.Action("Index", Model.For + "Lookup") %>',
                function (data) { $("#select-<%=Model.For %>-dialog").html(data).dialog('open'); }
                );
        });        
    });
        
</script>
<div id="select-<%=Model.For %>-dialog" title="<%=Model.Title %>" class="popup">
</div>
<input type="text" id="display<%=Model.For %>x" disabled="disabled" value='<%=Model.Display %>' />
<%=Html.Hidden("display"+Model.For) %>
<%=Html.Hidden(Model.For+"Id") %>
<a class=" abtn btn fl" id="open-<%=Model.For %>" href="#"><span class="ui-icon ui-icon-newwin">
</span></a>