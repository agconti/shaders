Shader "Custom/FlatColor" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag 

			float4 _Color; 

			struct vertexInput {
				float4 vertex: POSITION;
			};
			struct vertextOutput {
				float4 position: SV_POSITION;
			};

			vertextOutput vert(vertexInput input) {
				vertextOutput output; 
				output.position = mul(UNITY_MATRIX_MVP, input.vertex);

				return output;
			}

			float4 frag(vertextOutput input): COLOR {
				return _Color;
			}

			ENDCG
		}
	}
	FallBack "Diffuse"
}
