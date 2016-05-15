Shader "Custom/Lambert"
{
	Properties
	{
		_Color ("Color", Color) = (1.0,1.0,1.0,1.0)
	}
	SubShader
	{
		Pass
		{
			// indicate that our pass is the "base" pass in forward
			// rendering pipeline. It gets ambient and main directional
			// light data set up; light direction in _WorldSpaceLightPos0
			// and color in _LightColor0
			Tags {"LightMode"="ForwardBase"}
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc" // for UnityObjectToWorldNormal
			#include "UnityLightingCommon.cginc" // for _LightColor0

			// user defined variables
			float4 _Color;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 pos : SV_POSITION;
				float4 col : Color;
			};


			v2f vert (vertexInput v)
			{
				v2f o;

				float atten = 1.0; //attenuation = 1 for directional lights
				float3 normalDirection = normalize(  float3( mul(  float4(v.normal, 0.0), _World2Object).rgb ));

				//ambient Light
				float3 ambientLight = UNITY_LIGHTMODEL_AMBIENT.rgb;
				float3 lightDirection = normalize( float3(_WorldSpaceLightPos0.rgb));
				float3 diffuseReflection = atten * float3(_LightColor0.rgb) * max(0.0, dot(normalDirection, lightDirection));

				float3 lightFinal = ambientLight + diffuseReflection;
				o.col = float4(lightFinal * float3(_Color.rgb), 1.0);
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				return i.col;
			}

			ENDCG
		}
	}
	Fallback "Diffuse"
}
