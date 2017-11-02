using LinqToTwitter;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;

namespace AcessoTwitter
{
    public partial class Default : System.Web.UI.Page
    {
        string strFile = System.Web.HttpContext.Current.Server.MapPath("~/App_Data/log-BuscaTwitter.txt");

        protected void Page_Load(object sender, EventArgs e)
        {
            AtualizaUltimasBuscas();
        }
        
        public List<Status> GetTwitterFeeds(string palavra)
        {
            var auth = new SingleUserAuthorizer
            {
                CredentialStore = new InMemoryCredentialStore()
                {
                    ConsumerKey = ConfigurationManager.AppSettings["consumerkey"],
                    ConsumerSecret = ConfigurationManager.AppSettings["consumersecret"],
                    OAuthToken = ConfigurationManager.AppSettings["accessToken"],
                    OAuthTokenSecret = ConfigurationManager.AppSettings["accessTokenSecret"]
                }
            };

            var twitterCtx = new TwitterContext(auth);
            var ownTweets = new List<Status>();

            var searchResponse =
                (from tweet in twitterCtx.Search
                 where tweet.Type == SearchType.Search &&
                       tweet.Query == palavra && 
                       tweet.Count == 5
                 select tweet).FirstOrDefault();

            if (searchResponse != null && searchResponse.Statuses != null)
                ownTweets = searchResponse.Statuses;
            
            return ownTweets;
        }

        protected void btnPesquisar_Click(object sender, EventArgs e)
        {
            List<Status> tweetList = null;

            if (!string.IsNullOrWhiteSpace(txtPalavra.Text))
            {
                if (!File.Exists(strFile))
                {
                    FileStream fs = File.Create(strFile);
                }
                StreamWriter w = File.AppendText(strFile);
                w.WriteLine(txtPalavra.Text);
                w.Close();

                AtualizaUltimasBuscas();

                tweetList = GetTwitterFeeds(txtPalavra.Text);
            }

            ListView1.DataSource = tweetList;
            ListView1.DataBind();
        }

        protected void btnLimpar_Click(object sender, EventArgs e)
        {
            if (File.Exists(strFile))
            {
                File.WriteAllText(strFile, "");
                lstBusca.Text = "";
            }
        }

        private void AtualizaUltimasBuscas()
        {
            if (File.Exists(strFile))
            {
                string arq = File.ReadAllText(strFile);
                lstBusca.Text = arq;
            }
        }
    }
}