namespace MRGSP.ASMS.WebUI
{
    public class PopupInfo
    {
        public PopupInfo()
        {
            Parameters = new string[]{};
        }

        public string Controller { get; set; }
        public string Action { get; set; }
        public int Height { get; set; }
        public int Width { get; set; }
        public string Title { get; set; }
        public string Div { get { return "Dialog" + Action + Controller; } }
        public string CancelText { get; set; }
        public string SaveText { get; set; }
        public bool RefreshOnSuccess { get; set; }
        public string[] Parameters { get; set; }
    }
}