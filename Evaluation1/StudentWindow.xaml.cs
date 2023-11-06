using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;

namespace Evaluation1
{
    /// <summary>
    /// Logique d'interaction pour StudentWindow.xaml
    /// </summary>
    public partial class StudentWindow : Window
    {
        public AuthenticatedUser User { get; set; }

        SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["college"].ToString());

        public StudentWindow(AuthenticatedUser user)
        {
            InitializeComponent();
            User = user;
            RemplirListeEtudiants();
        }

        /********** LISTE DES ETUDIANTS **********/
        private void RemplirListeEtudiants()
        {
            if (User == null) return;

            List<Student> students = new List<Student>();
            string queryString = String.Format(
                "SELECT * FROM {0} WHERE {1} = {2};",
                "tblEtudiants", "IdInstructeur", $"'{User.Id}'"
            );
            var command = new SqlCommand(queryString, conn);

            try
            {
                conn.Open();
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    students.Add(new Student
                    {
                        Id = reader["IdEtudiant"].ToString(),
                        FirstName = reader["Prenom"].ToString(),
                        LastName = reader["Nom"].ToString(),
                        Address = reader["Adresse"].ToString(),
                        Province = reader["Ville"].ToString(),
                        City = reader["Province"].ToString(),
                        PostalCode = reader["CodePostal"].ToString(),
                        Phone = reader["Telephone"].ToString(),
                        ProgramCode = reader["CodeProgramme"].ToString(),
                        TeacherId = reader["IdInstructeur"].ToString(),
                        Status = reader["Statut"].ToString(),
                    });
                }

                cmbStudents.DataContext = students;
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur RemplirListeEtudiants", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
                conn.Close();
            }
        }

        /********** SELECTION DE L'ETUDIANT **********/
        private void cmbStudents_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            RemplirInfosEtudiant();
        }

        private void RemplirInfosEtudiant() {
            if (cmbStudents.SelectedIndex == -1) return;

            Student student = cmbStudents.SelectedItem as Student;

            lblID.Content = student.Id;
            txtPrenom.Text = student.FirstName;
            txtNom.Text = student.LastName;
            txtAdresse.Text = student.Address;
            txtVille.Text = student.City;
            txtProvince.Text = student.Province;
            txtCodePostal.Text = student.PostalCode;
            txtTelephone.Text = student.Phone;

            try
            {
                conn.Open();
                RemplirInstructeur(student.TeacherId);
                RemplirProgramme(student.ProgramCode);
                RemplirStatut(student.Status);
                RemplirCours(student.Id);
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur RemplirInfosEtudiant", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                conn.Close();
            }
        }


        private void RemplirInstructeur(string instructeurId) {
            string query = String.Format(
                "SELECT {0}, {1} FROM {2} WHERE {3} = {4};",
                "Prenom", "Nom", "tblUtilisateurs", "IdUtilisateur", $"'{instructeurId}'"
            );
            var command = new SqlCommand(query, conn);

            try
            {
                var reader = command.ExecuteReader();
                if (reader.Read())
                    lblInstructeur.Content = String.Format(
                        "{0} {1}",
                        reader["Prenom"].ToString(), reader["Nom"].ToString()
                    );
                reader.Close();
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur RemplirInstructeur", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
            }
        }

        private void RemplirProgramme(string programmeCode)
        {
            string query = String.Format(
                "SELECT {0} FROM {1} WHERE {2} = {3};",
                "Titre",  "tblProgrammes", "IdProgramme", $"'{programmeCode}'"
            );
            var command = new SqlCommand(query, conn);

            try
            {
                var reader = command.ExecuteReader();
                if (reader.Read()) lblProgramme.Content = reader["Titre"].ToString();
                reader.Close();
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur RemplirProgramme", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
            }
        }

        private void RemplirStatut(string statut)
        {
            switch (statut)
            {
                case "0":
                    rbActif.IsChecked = true;
                    break;
                case "1":
                    rbArret.IsChecked = true;
                    break;
                case "2":
                    rbGradue.IsChecked = true;
                    break;
            }
        }

        private void RemplirCours(string etudiantId) {
            List<string> cours = new List<string>();
            string query = String.Format(
                "SELECT {0} FROM {1}, {2}, {3} WHERE {4} = {5} AND {6} = {7} AND {8} = {9};",
                "crs.NomDuCours", "tblEtudiants etu", "tblProgrammes prg", "tblCourses as crs",
                "etu.IdEtudiant", $"'{etudiantId}'", "etu.CodeProgramme", "prg.IdProgramme",
                "prg.IdProgramme", "crs.IdProgramme"
            );
            var command = new SqlCommand(query, conn);

            try
            {
                var reader = command.ExecuteReader();
                while (reader.Read()) {
                    cours.Add(reader["NomDuCours"].ToString());
                }
                reader.Close();
                lstCours.DataContext = cours;
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur RemplirCours", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
            }
        }

        /********** BOUTONS **********/
        private void ModifierStatut(object sender, RoutedEventArgs e)
        {
            if (cmbStudents.SelectedIndex == -1) return;

            Student student = cmbStudents.SelectedItem as Student;
            string nouveauStatut = "";

            if (rbActif.IsChecked == true) nouveauStatut = "0";
            else if (rbArret.IsChecked == true) nouveauStatut = "1";
            else if (rbGradue.IsChecked == true) nouveauStatut = "2";
            else return;

            string query = String.Format(
                "UPDATE {0} SET {1} = {2} WHERE {3} = {4};",
                "tblEtudiants", "Statut", nouveauStatut, "IdEtudiant", $"'{student.Id}'"
            );
            var command = new SqlCommand(query, conn);

            try
            {
                conn.Open();
                command.ExecuteNonQuery();
                MessageBox.Show("Statut modifié !", "Confirmation de modification", MessageBoxButton.OK, MessageBoxImage.Information);
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur ModifierStatut", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
                conn.Close();
            }
        }

        private void SupprimerEtudiant(object sender, RoutedEventArgs e)
        {
            if (cmbStudents.SelectedIndex == -1) return;

            Student student = cmbStudents.SelectedItem as Student;
            string query = String.Format(
                "DELETE FROM {0} WHERE {1} = {2};",
                "tblEtudiants", "IdEtudiant", $"'{student.Id}'"
            );
            var command = new SqlCommand(query, conn);

            try
            {
                conn.Open();
                command.ExecuteNonQuery();
                ReinitialiserFormulaire();
                MessageBox.Show("Etudiant supprimé !", "Confirmation de suppression", MessageBoxButton.OK, MessageBoxImage.Information);
            }

            catch (Exception exc)
            {
                MessageBox.Show(exc.Message, "Erreur SupprimerEtudiant", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            finally
            {
                command.Dispose();
                conn.Close();
                RemplirListeEtudiants();
            }
        }

        private void AjouterEtudiant(object sender, RoutedEventArgs e)
        {

        }

        private void ReinitialiserFormulaire() {
            cmbStudents.SelectedIndex = -1;
            foreach (Label label in new List<Label>{ lblID, lblInstructeur, lblProgramme }) label.Content = "";
            foreach (TextBox textbox in new List<TextBox> { txtPrenom, txtNom, txtAdresse, txtVille, txtProvince, txtCodePostal, txtTelephone }) textbox.Text = "";
            foreach (RadioButton radio in new List<RadioButton> { rbActif, rbArret, rbGradue }) radio.IsChecked = false;
            lstCours.DataContext = new List<string>();
        }

        private void Quitter(object sender, RoutedEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Êtes-vous sûr de vouloir quitter ?", "Quitter", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.Yes) Close();
        }

        private void Window_Closing(object sender, System.ComponentModel.CancelEventArgs e)
        {
            MessageBoxResult result = MessageBox.Show("Êtes-vous sûr de vouloir quitter ?", "Quitter", MessageBoxButton.YesNo, MessageBoxImage.Question);
            if (result == MessageBoxResult.No) e.Cancel = true;
        }
    }
}
