using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.Net.Mail;
using System.Configuration;
using System.Web.Configuration;
using System.Net.Configuration;
using System.Net;


/// <summary>
/// Summary description for MailUtilities
/// </summary>
namespace Utilities
{
    public static class MailUtilities
    {


        /// <summary>
        /// Check if a given email adddress is valid.
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static bool IsEmailAddress(string s)
        {
            try
            {
                MailAddress ma = new MailAddress(s);
                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        public static void SendEmail(string to, string replyTo, List<string> cc, List<string> bcc, string subject, string body)
        {
            Configuration config = WebConfigurationManager.OpenWebConfiguration(HttpContext.Current.Request.ApplicationPath);
            MailSettingsSectionGroup settings = (MailSettingsSectionGroup)config.GetSectionGroup("system.net/mailSettings");

            MailAddress sender = new MailAddress(settings.Smtp.Network.UserName, ConfigurationManager.AppSettings["EmailFromText"]);
            MailAddress from = new MailAddress(settings.Smtp.Network.UserName, ConfigurationManager.AppSettings["EmailFromText"]);

            MailAddressCollection ccs = new MailAddressCollection();
            if (cc != null && cc.Count > 0)
            {
                foreach (var address in cc)
                {
                    if (IsEmailAddress(address))
                    {
                        ccs.Add(new MailAddress(address));
                    }
                }
            }

            MailAddressCollection bccs = new MailAddressCollection();
            if (bcc != null && bcc.Count > 0)
            {
                foreach (var address in bcc)
                {
                    if (IsEmailAddress(address))
                    {
                        bccs.Add(new MailAddress(address));
                    }
                }
            }

            //FIXME: forced/hardcoded BCCs?

            var smtp = new SmtpClient();

            using (var message =
                new MailMessage(settings.Smtp.Network.UserName, to)
                {
                    Subject = subject,
                    Body = body,
                    Sender = sender,
                    IsBodyHtml = true,
                    From = from

                })
            {
                foreach (var mycc in ccs)
                {
                    message.CC.Add(mycc);
                }

                foreach (var mybcc in bccs)
                {
                    message.Bcc.Add(mybcc);
                }

                if (IsEmailAddress(replyTo))
                {
                    message.ReplyToList.Add(replyTo);
                }

                smtp.Send(message);
            }
        }

    }
}