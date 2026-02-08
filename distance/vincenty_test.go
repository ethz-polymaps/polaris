package distance

import (
	"testing"

	"github.com/stretchr/testify/assert"

	"github.com/ethz-polymaps/trilop"
)

func TestVincentyDistance(t *testing.T) {
	type args struct {
		a trilop.Position
		b trilop.Position
	}
	tests := []struct {
		name  string
		args  args
		want  float64
		delta float64
	}{
		{
			name: "same point",
			args: args{
				a: trilop.NewPosition(47.413310, 8.536444),
				b: trilop.NewPosition(47.413310, 8.536444),
			},
			want:  0,
			delta: 0,
		},
		{
			name: "short distance ~5.7m",
			args: args{
				a: trilop.NewPosition(47.413310, 8.536444),
				b: trilop.NewPosition(47.413309, 8.536520),
			},
			want:  5.7366,
			delta: 0.001,
		},
		{
			name: "medium distance ~1.7km",
			args: args{
				a: trilop.NewPosition(47.463960, 8.322321),
				b: trilop.NewPosition(47.474113, 8.305055),
			},
			want:  1722.93,
			delta: 0.1,
		},
		{
			name: "long distance ~383km",
			args: args{
				b: trilop.NewPosition(39.099912, -94.581213),
				a: trilop.NewPosition(38.627089, -90.200203),
			},
			want:  383805.76,
			delta: 1,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			result := VincentyDistance(tt.args.a, tt.args.b)
			assert.InDelta(t, tt.want, result, tt.delta)
		})
	}
}
