package Repositorio

import java.util.List

abstract class Repositorio<Tipo> {

	List<Tipo> listaRepo = newArrayList

	def void crear(Tipo objeto)

	def void eliminar(Tipo objeto)

	def Tipo searchById(int _id)

	def void update(Tipo objeto)

	def getListaRepo() { listaRepo }

}
