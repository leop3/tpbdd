package viewModel

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Accessors
@Observable
class MensajeModel {
		String msj
		
		new (String _msj){
			msj = _msj
		}	
}