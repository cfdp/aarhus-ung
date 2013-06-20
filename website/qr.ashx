<%@ WebHandler Language="C#" Class="qr" %>

using System;
using System.Web;
using umbraco.MacroEngines;
using umbraco.cms.businesslogic.member;


public class qr : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "text/plain";
        try
        {
            int frontPageId = 1076;

            string strUrlItunes = String.Empty;
            string strUrlGooglePlay = String.Empty;

            umbraco.MacroEngines.DynamicNode n = new DynamicNode(frontPageId);
            if (n != null && n.Id > 0)
            {
                //Found the node - fetch URLs
                strUrlItunes = n.HasValue("appStoreURL") ? n.GetPropertyValue("appStoreURL") : String.Empty;
                strUrlGooglePlay = n.HasValue("googlePlayURL") ? n.GetPropertyValue("googlePlayURL") : String.Empty;
            }

            //Determine device by user agent string:
            string strUA = context.Request.UserAgent;
            
            //iOS device:
            if (!String.IsNullOrEmpty(strUA) && strUA.Contains("AppleWebKit") && (strUA.Contains("iPad") || strUA.Contains("iPhone") || strUA.Contains("iPod")))
            {
                if (!String.IsNullOrEmpty(strUrlItunes))
                {
                    context.Response.Redirect(strUrlItunes, true);
                }
            }
                
            //Possibly an Android device:
            else 
            {
                if (!String.IsNullOrEmpty(strUrlGooglePlay))
                { 
                    context.Response.Redirect(strUrlGooglePlay, true);
                }
            }
        }
        catch (Exception)
        {

        }

        context.Response.Redirect("/", true);        
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}