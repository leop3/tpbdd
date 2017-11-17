package domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable

class Receta {
	int idReceta = -1
	String nombre
	String descripcion
	List<Articulo> articulos
	
	new(List<Articulo> articles,String name,String description){
		articulos = articles
		descripcion = description
		nombre = name
	}
}