package viewModel

import Repositorio.RepositorioLista
import domain.Articulo
import domain.ListaDeComestibles
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class ListaDeComestiblesModel {
	RepositorioLista repo
	List<Articulo> articulosLista = newArrayList
	Articulo articulo
	Articulo seleccionado
	String descripcionTemp 
	

	new() {
		repo = RepositorioLista.instance
	}

	def getArticulos() {
		#[
			new Articulo() => [nombre = "Articulo 1"],
			new Articulo() => [nombre = "Articulo 2"],
			new Articulo() => [nombre = "Articulo 3"],
			new Articulo() => [nombre = "Articulo 4"],
			new Articulo() => [nombre = "Articulo 5"]
		]
	}

	def agregar() {
		if (!articulosLista.contains(articulo)) {
			articulosLista.add(articulo)
		}
	}

	def eliminar() {
		articulosLista.remove(seleccionado)
	}

	def void crearLista() {
		repo.update(
			new ListaDeComestibles(articulosLista, descripcionTemp)
		)
	}

}
