using System.Data;
using MySql.Data.MySqlClient;
using Dapper;
using WebApi.Models;

namespace WebApi.Repository
{
    public class PersonaRepository
    {
        public  void Insertar(Persona persona)
        {
            string connectionString = "Server=localhost;Database=constituyentes;Uid=root;Pwd=Fernand0441363;";

            using (IDbConnection db = new MySqlConnection(connectionString))
            {
                var parameters = new DynamicParameters();
                parameters.Add("_idPersona", persona.idPersona);
                parameters.Add("_dni", persona.dni);
                parameters.Add("_nombre", persona.nombre);
                parameters.Add("_apellidos", persona.apellidos);
                parameters.Add("_genero", persona.genero);
                parameters.Add("_foto", persona.foto);
                parameters.Add("_direccionActual", persona.direccionActual);
                parameters.Add("_nroCelular", persona.nroCelular);
                parameters.Add("_correo", persona.correo);
                parameters.Add("_contraseña", persona.contraseña);
                parameters.Add("_tipoUsuario", persona.tipoUsuario);
                parameters.Add("_descripcion", persona.descripcion);
                parameters.Add("_estado", persona.estado);

                db.Execute("sp_InsertarPersona", parameters, commandType: CommandType.StoredProcedure);
            }
        }
    }
}
