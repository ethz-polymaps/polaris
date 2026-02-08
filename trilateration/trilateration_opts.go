package trilateration

import "github.com/ethz-polymaps/trilop"

func WithDistanceFunc(vincentyDistance func(a trilop.Position, b trilop.Position) float64) TrilateratorOpt {
	return func(t *TrilateratorConfig) {
		t.DistanceFunc = vincentyDistance
	}
}
