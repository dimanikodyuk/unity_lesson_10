Shader "Custom/SimpleShader"
{
    Properties
    {
        //_Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Texture1 (RGB)", 2D) = "white" {}
        _SecondTex("Texture2 (RGB", 2D) = "white" {}
        _T1("OpacityTexture1", Range(0,1)) = 0.0
        _Glossiness ("Smoothness", Range(0,1)) = 0.5
        _Metallic ("Metallic", Range(0,1)) = 0.0
        
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _SecondTex;
        struct Input
        {
            float2 uv_MainTex;
            float2 uv_SecondTex;
        };
        half _T1;
        half _Glossiness;
        half _Metallic;
        
        //fixed4 _Color;

        float3 blend(float4 texture1, float a, float4 texture2)
        {
            float a2 = 1 - a;
            return texture1.rgb * a2 + texture2.rgb * a;
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {

            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            fixed4 t = tex2D(_SecondTex, IN.uv_SecondTex);
            
            o.Albedo = blend(c, _T1, t);

            o.Metallic = _Metallic;
            o.Smoothness = _Glossiness;
            o.Alpha = c.a;

        }
        ENDCG
    }
    FallBack "Diffuse"
}
