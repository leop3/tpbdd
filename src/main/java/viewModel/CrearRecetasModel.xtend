package viewModel

import BDDConnection.Conexion
import Repositorio.RepositorioReceta
import domain.Articulo
import domain.Receta
import domain.UnidadDeMedida
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class CrearRecetasModel {
	RepositorioReceta repo = RepositorioReceta.instance
	List<Articulo> articulosAgregados = newArrayList
	Articulo articulo
	Articulo seleccionado
	String nombreTemp
	String descripcionTemp
	int cantidadTemp
	UnidadDeMedida medidaTemp
	Conexion conexion = new Conexion()

	new() {
		conexion.start()
	}

	def getArticulosAAgregar() {
		conexion.articulos
	}

	def getMedidas() {
		conexion.medidas
	}

	def agregar() {
		if (!articulosAgregados.contains(articulo)) {
			articulo.cantidad = cantidadTemp
			articulo.unidad = medidaTemp
			articulosAgregados.add(articulo)
		}
	}

	def eliminar() {
		articulosAgregados.remove(seleccionado)
	}

	def void crearReceta() {
		repo.update(
			new Receta(articulosAgregados, nombreTemp, descripcionTemp)
		)
	}

}
