using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Security;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace Evaluation1
{
    /// <summary>
    /// Logique d'interaction pour MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["college"].ToString());
        SqlCommand command = null;
        SqlDataReader reader = null;
        AuthenticatedUser user = null;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            ClearTextBoxes();
        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Authenticate();
        }

        private void ClearTextBoxes()
        {
            txtUser.Clear();
            txtPassword.Clear();
        }

        private void Authenticate()
        {
            string queryString = String.Format(
                "SELECT * FROM {0} WHERE {1} = {2} AND {3} = {4}",
                "tblUtilisateurs", 
                "NomUtilisateur", 
                $"'{txtUser.Text}'", 
                "MotPasse", 
                $"'{txtPassword.Password}'"
            );

            if (txtUser.Text.Length == 0 || txtPassword.Password.Length == 0) return;

            try
            {
                conn.Open();
                command = new SqlCommand(queryString, conn);
                reader = command.ExecuteReader();

                if (reader.Read())
                {
                    user = new AuthenticatedUser
                    {
                        Id = reader["IdUtilisateur"].ToString(),
                        FirstName = reader["Prenom"].ToString(),
                        LastName = reader["Nom"].ToString(),
                        Username = reader["NomUtilisateur"].ToString(),
                        Password = reader["MotPasse"].ToString()
                    };
                }
            }

            catch (Exception exc) { 
                MessageBox.Show(exc.Message, "Erreur", MessageBoxButton.OK, MessageBoxImage.Error); 
            }

            finally {
                command.Dispose();
                conn.Close();

                if (user != null)
                {
                    new StudentWindow(user) { Title = $"{user.FirstName} {user.LastName}" }.Show();

                    MessageBox.Show(
                        $"Bienvenue {user.FirstName} {user.LastName} !",
                        "Connexion Réussie",
                        MessageBoxButton.OK,
                        MessageBoxImage.Information);

                    this.Close();
                }

                else
                {
                    MessageBox.Show(
                    "Le nom d'utilisateur et/ou le mot de passe sont incorrects !",
                    "Échec de connexion",
                    MessageBoxButton.OK,
                    MessageBoxImage.Exclamation);

                    ClearTextBoxes();
                }
            }
        }
    }
}
