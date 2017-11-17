package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class Articulo {
	int idArticulo
	String descripcion
	String nombre
	UnidadDeMedida unidad
	int cantidad
}
