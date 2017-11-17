package viewModel

import BDDConnection.Conexion
import Repositorio.RepositorioLista
import Repositorio.RepositorioReceta
import domain.Articulo
import domain.ListaDeComestibles
import domain.Receta
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class MenuModel {
	RepositorioReceta repo
	RepositorioLista repoLista
	Receta receta
	ListaDeComestibles lista
	List<Receta> recetas = newArrayList
	List<ListaDeComestibles> listas = newArrayList
	List<Articulo> articulos = newArrayList
	boolean almacenadoSatisfactorio = false
	Conexion conexion = new Conexion()

	new() {
		repo = RepositorioReceta.instance
		repoLista = RepositorioLista.instance
	}

	def refreshAll() {
		this.refreshRecetas
		this.refreshListas
	}

	def refreshRecetas() {
		val recetasTemp = newArrayList
		repo.listaRepo.forEach[rec|recetasTemp.add(rec)]
		recetas = recetasTemp

	}

	def refreshListas() {
		val listasTemp = newArrayList
		repoLista.listaRepo.forEach[list|listasTemp.add(list)]
		listas = listasTemp
	}
	
	def almacenar(){
		almacenadoSatisfactorio = true
		conexion.insertarReceta(receta)
	}
	
	def obtenerArticulos(){
		conexion.obtenerArticulos()
		articulos = conexion.articulos
	}
}
