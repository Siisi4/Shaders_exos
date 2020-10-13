Shader "Interface3/06-Masked Textures"
{
    Properties
    {
		_MainTex("Main Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		_Mask("Mask", 2D) = "white" {}
	}

	SubShader
	{
		Tags
		{
			"Queue" = "Geometry"
			"RenderType" = "Opaque"
		}

		CGPROGRAM
		#pragma surface surf Lambert

		sampler2D _MainTex;
		sampler2D _SecondTex;
		sampler2D _Mask;

		struct Input {
			float2 uv_MainTex;
			float2 uv_SecondTex;
			float2 uv_Mask;
		};

		void surf(Input IN, inout SurfaceOutput o) {
			//float m = tex2D(_Mask, IN.uv_Mask);
			float m = 0.5 * (1 + sin(IN.uv_MainTex.y * 6.28 * 10));

			// m * col1 + (1-m) * col2
			o.Albedo = m * tex2D(_MainTex, IN.uv_MainTex).rgb + (1-m) * tex2D(_SecondTex, IN.uv_SecondTex).rgb;
		}

		ENDCG

    }
    FallBack "Diffuse"
}
