import wollok.game.*

class Mercado {
	var property oro = 0
	const mercaderia = []
	method image() = "market.png"
	
	method tipo() = "mercado"
	
	method comprarA(hector) {
		if (not self.puedeComprarA(hector)) {
			game.say(self, "Disculpa maquina no tengo plata ):")
		} else {
			oro -= hector.valorDeMercaderia()
			hector.plantasCosechadas().forEach { plantita => mercaderia.add(plantita) }
			hector.registrarVenta()
		}
	}
	
	method puedeComprarA(unHector) {
		return self.oro() >= unHector.valorDeMercaderia()
	}
	
}