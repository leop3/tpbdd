package viewModel

import domain.Receta

class EditarRecetasModel extends CrearRecetasModel {
	int idTemp

	new(Receta receta) {
		receta.articulos.forEach[art|articulosAgregados.add(art)]
		idTemp = receta.idReceta
		descripcionTemp = receta.descripcion
		nombreTemp = receta.nombre
	}

	override crearReceta() {
		val recetaTemp = new Receta(articulosAgregados,nombreTemp,descripcionTemp)=>[idReceta=idTemp]
		repo.update(recetaTemp)
	}
}
