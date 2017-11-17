package domain

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class ListaDeComestibles {
	int idLista = -1
	String descripcion
	List<Articulo> articulos
	
	new (List<Articulo> articles,String description){
		descripcion = description
		articulos = articles
	}
}