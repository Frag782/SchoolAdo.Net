using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Evaluation1
{
    internal class Student
    {
        public string Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string Province { get; set; }
        public string PostalCode { get; set; }
        public string Phone { get; set; }
        public string ProgramCode { get; set; }
        public string TeacherId { get; set; }
        public string Status { get; set; }

        public Student()
        {
            
        }

        public string FullName => $"{FirstName} {LastName}";
    }
}
