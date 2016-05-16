Shader "Custom/Debug/Show Normals"
{
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct v2f {
				float4 pos : SV_POSITION;
				fixed4 color : COLOR;
			};

			// Pull from appdata_base defined in UnityCG.cginc
			// contains: position, normal and one texture coordinate.
			v2f vert (appdata_base v)
			{
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);

				// ensure vector is within acceptable rgb color values, 0 - 1, by
				// normalizing it.
				o.color.xyz = normalize(v.normal);

				// Set the alpha channel to 1.0, so its visible
				o.color.w = 1.0; 
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.color;
			}
			ENDCG
		}
	}
}
