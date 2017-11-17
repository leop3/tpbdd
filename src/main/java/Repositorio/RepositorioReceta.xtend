package Repositorio

import domain.Receta

class RepositorioReceta extends Repositorio<Receta> {

	static var RepositorioReceta instance

	private new() {
	}

	static def getInstance() {
		if (instance == null) {
			instance = new RepositorioReceta()
		}
		return instance
	}

	override crear(Receta objeto) {
		if (listaRepo.size() == 0) {
			objeto.idReceta = 0
			listaRepo.add(objeto)
		} else {
			val idMaximo = this.maxId()
			objeto.idReceta = idMaximo + 1
			listaRepo.add(objeto)
		}
	}

	def maxId() {
		var int idMax
		val objetoTemp = listaRepo.maxBy[receta|receta.idReceta]
		idMax = objetoTemp.idReceta
		idMax
	}

	override eliminar(Receta objeto) {
		val recetaTemp = searchById(objeto.idReceta)
		if (recetaTemp != null) {
			listaRepo.remove(recetaTemp)
		}
	}

	override searchById(int _id) {
		listaRepo.findFirst[receta|receta.idReceta == _id]
	}

	override update(Receta objeto) {
		if (objeto.idReceta < 0) {
			this.crear(objeto)
		} else {
			listaRepo.set(listaRepo.indexOf(searchById(objeto.idReceta)), objeto)
		}
	}

}
