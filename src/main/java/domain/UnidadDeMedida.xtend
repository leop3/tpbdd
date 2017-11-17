package domain

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class UnidadDeMedida {
	int id
	String nombre
	
	new (String name){
		nombre = name
	}
	
}