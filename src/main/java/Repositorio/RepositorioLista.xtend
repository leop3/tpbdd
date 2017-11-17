package Repositorio

import domain.ListaDeComestibles

class RepositorioLista extends Repositorio<ListaDeComestibles> {

	static var RepositorioLista instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioLista()
		}
		return instance
	}

	override crear(ListaDeComestibles objeto) {
		if (listaRepo.size() == 0) {
			objeto.idLista = 0
			listaRepo.add(objeto)
		} else {
			val idMaximo = this.maxId()
			objeto.idLista = idMaximo + 1
			listaRepo.add(objeto)
		}

	}

	def maxId() {
		var int idMax
		val objetoTemp = listaRepo.maxBy[list|list.idLista]
		idMax = objetoTemp.idLista
		idMax
	}

	override eliminar(ListaDeComestibles objeto) {
		val listaTemp = searchById(objeto.idLista)
		if (listaTemp != null) {
			listaRepo.remove(listaTemp)
		}
	}

	override searchById(int _id) {
		listaRepo.findFirst[list|list.idLista == _id]
	}

	override update(ListaDeComestibles objeto) {
		if (objeto.idLista < 0) {
			this.crear(objeto)
		} else {
			listaRepo.set(listaRepo.indexOf(searchById(objeto.idLista)), objeto)
		}
	}

}
