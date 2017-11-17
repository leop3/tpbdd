package BDDConnection

import domain.Articulo
import domain.Receta
import domain.UnidadDeMedida
import java.sql.Connection
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.Statement
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.LocalTime
import java.time.format.DateTimeFormatter
import java.util.List

class Conexion {

	// JDBC Driver nombre y direccion de la BBDD
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver"
	static final String DB_URL = "jdbc:mysql://localhost:3306/mydb"

	// Credenciales
	static final String USER = "root"
	static final String PASS = "159159"

	// Fecha
	LocalDateTime fecha
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm:ss")
	String formattedDateTime

	Connection conn
	Statement stment
	ResultSet rs
	List<Articulo> articulos = newArrayList
	List<UnidadDeMedida> medidas = newArrayList

	new() {
		Class.forName(JDBC_DRIVER)
	}

	def obtenerArticulos() {
		val sql = "select * from articulo;"
		val rs = this.ejecutarQuery(sql)
		articulos = newArrayList

		while (rs.next()) {
			val unidadIDTemp = rs.getInt("unidadMedida_idUnidadMedida")
			val unidadTemp = medidas.findFirst[unit|unit.id == unidadIDTemp]
			articulos.add(new Articulo() => [

				idArticulo = rs.getInt("idArticulo")
				nombre = rs.getString("nombre")
				descripcion = rs.getString("descripcion")
				cantidad = rs.getInt("stock")
				unidad = unidadTemp
			])
		}

		rs.close
		this.cerrarQuery
	}

	def obtenerUnidadDeMedida() {
		val sql = "select * from unidadmedida;"
		val rs = this.ejecutarQuery(sql)
		medidas = newArrayList

		while (rs.next()) {
			medidas.add(new UnidadDeMedida(rs.getString("descripcion")) => [
				id = rs.getInt("idUnidadMedida")
			])
		}
		rs.close
		this.cerrarQuery
	}

	def insertarReceta(Receta receta) {
		val StringBuilder sql = new StringBuilder
		fecha = LocalDateTime.of(LocalDate.now, LocalTime.now)
		formattedDateTime = fecha.format(formatter)

		sql.append("insert into receta ")
		sql.append("values (")
		sql.append(receta.idReceta + ",")
		sql.append("'" + receta.nombre + "');")
		this.ejecutarUpdate(sql.toString)
		this.cerrarQuery

	}

	def cerrarQuery() {
		conn.close
		stment.close
	}

	def ejecutarUpdate(String sqlQuery) {
		conn = DriverManager.getConnection(DB_URL, USER, PASS)
		stment = conn.createStatement()
		stment.executeUpdate(sqlQuery)
	}

	def ejecutarQuery(String sqlQuery) {
		conn = DriverManager.getConnection(DB_URL, USER, PASS)
		stment = conn.createStatement()
		rs = stment.executeQuery(sqlQuery)
	}

	def start() {
		this.obtenerUnidadDeMedida()
		this.obtenerArticulos()
	}

	def getMedidas() {
		medidas
	}

	def getArticulos() {
		articulos
	}

}
