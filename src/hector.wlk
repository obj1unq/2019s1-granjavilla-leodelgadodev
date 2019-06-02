import wollok.game.*
import mercado.*

object hector {
	var property oro = 0
	var imagen = "player.png"
	const property plantasCosechadas = []
	var property position = game.at(1,1)
	
	method image() = imagen
	
	method move(nuevaPos) {
		self.position(nuevaPos)
	}
	
	method queTengoEnMiInventario() {
		game.say(self,"tengo " + oro + " monedas y " + plantasCosechadas.size() + " plantas para vender." )
	}
	
	method guardarPlantaCosechada(aPlantita) {
		plantasCosechadas.add(aPlantita)
	}
	
	method vender() {
		if (self.hayMercado()) {
		var unMercado = game.colliders(self).head()
		unMercado.comprarA(self)
		}
	}
	
	method registrarVenta() {
		oro += self.valorDeMercaderia()
		plantasCosechadas.forEach { planta=> plantasCosechadas.remove(planta) }
	}
	
	method valorDeMercaderia() {
		return plantasCosechadas.map{planta=> planta.valor()}.sum()
	}

	method cosechar() {
		if (self.hayPlanta())
		{self.returnObjetos().forEach({planta=> planta.serCosechada()})}
		else { game.say(self, "No hay nada para cosechar ):")} //En lugar de un say, deberia tirar una excepcion
	}
	
	method regar() {
		if (self.hayPlanta())
		{self.returnObjetos().forEach({planta=> planta.serRegada()})}
		else { game.say(self, "No hay nada para regar ):")} //En lugar de un say, deberia tirar una excepcion
	}
	
	
	
	method sembrar(aPlanta) {
		if (not self.hayMercado() and (self.hayPlantaDe(aPlanta) or not self.hayPlanta()))
		{
			var plantita = aPlanta.crear()
			plantita.serPlantadaEn(self.position())
		}
		else { game.say(self,"No puedo plantar eso aca kpo")}
	}


	method returnObjetos() {
//		return game.getObjectsIn(self.position())
	return game.colliders(self)
	} 
	
	method hayPlantaDe(aPlanta) {
		if (self.hayPlanta()) {
		return self.returnObjetos().map{unaPlanta=> unaPlanta.tipo()}.contains(aPlanta.tipo())		
		} else {
			return false
		}
	
	}
	
	method hayPlanta() {
		var plantas = ["maiz","trigo","tomaco"]
		return self.returnObjetos().any {obj => plantas.contains( obj.tipo() )}
	}
	
	method hayMercado() {
		
		return self.returnObjetos().map{obj=> obj.tipo()}.contains("mercado")
	}
}