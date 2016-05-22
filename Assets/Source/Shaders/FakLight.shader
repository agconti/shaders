Shader "Custom/Unlit/FakeLight"
{
	Properties
	{
		_Color ("Color", Color) = (1.0, 1.0, 1.0, 1.0)
		_LightDirection ("Light Direction", Vector) = (1.0, 1.0, 1.0, 1.0)
	}
	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc" // for appdata_base


			// user defined parms
			float4 _Color;
			float4 _LightDirection;

			struct v2f
			{
				fixed4 col : Color;
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata_base v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				float4 normalizedLight = normalize(_LightDirection);
				o.col = max(0.0, dot(v.vertex, _LightDirection)) * _Color;
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				return i.col;
			}
			ENDCG
		}
	}
}
