Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E283F63635D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236344AbiKWPXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiKWPXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:23:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E8A62C2;
        Wed, 23 Nov 2022 07:23:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id p16so13315244wmc.3;
        Wed, 23 Nov 2022 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRsDugZQHZ3cAp8Uo4BX8m8iIIGYim123jYJVHkkzNM=;
        b=JTS32H5Rl1FRQ5qQGs7q0aes2NHFbc/tVU1PRG9uzTWCLptD9c3MBLc2IqYddt3s+j
         9Of0wCplecvcC/ZN1lmfkazZqsy11weqsJhVk4QzwDldCoYxshlc7rC+qRSCf9Y/SqWB
         v/saVhfl+UuoPYhBVsTcqPPB1s6kP/enS0YerURQUZMzmRXmcAtyZYWjr5bPNnE9wIDH
         VW49UWoCb5VTT2rNTAVnEMk9qRuYv594NWL0wRMEci2KxO0FRzeZNCtNLbScBe0Xo0p7
         8H7kU9A+dvHezIaVrs3sjWhaXVIIBafgl/QMvsjn7GYdWVgzQ/Pi5mVzH95DYjng5LzN
         Pwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRsDugZQHZ3cAp8Uo4BX8m8iIIGYim123jYJVHkkzNM=;
        b=UttgYdID17rzYxZMQrDCv5NC+KSWYmeYDWIqVj0AZaldFV7boB3u5h4ayWud3QoNh+
         A7FlRFC0MKhWB7INEc5X6YSoQgSm2hJITruoSd/Zl3txDNX8qn+fkXst3l1ve86Uhk15
         EwEuVgy3hxnYTadQvV7ffNsNSOR52DBKuLhwvy6KfNu6ZN2mybytLhhooz4HvmAxqBPs
         RfiAczQ5uzqTsxo7fNF7nPOPoGkQkaQ6yJQ8EN6uOhbAFdGmF7/qJfz3gTSQ/mDivtw6
         tDAbshPr3FYsoX61dOUJ+GqZZ/YOwEiSh4dpoESRk8p+9ROYEbf/VrweZblYUSwfaCrw
         KIRQ==
X-Gm-Message-State: ANoB5pl0ChlssDtBW7lvDD/p/7a1c93v/2u7k0e4Y+txlDGol2LNlxNt
        dXc7l+CpHgb9yrkW3Kpg8ic=
X-Google-Smtp-Source: AA0mqf4GOX3D3H86tdcDE4TkSHPMY+S13P3j1Dp/lKoItpeUJRYos1PzrSOxOWOfWevsQEXVOhunCg==
X-Received: by 2002:a05:600c:2309:b0:3c6:f252:f072 with SMTP id 9-20020a05600c230900b003c6f252f072mr7118083wmo.145.1669216991388;
        Wed, 23 Nov 2022 07:23:11 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b002365730eae8sm16654203wrr.55.2022.11.23.07.23.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:23:10 -0800 (PST)
Message-ID: <5b253182-c15e-7fdd-48e2-37fd64838644@gmail.com>
Date:   Wed, 23 Nov 2022 16:23:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/5] arm64: dts: mt8186: Add power domains controller
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
References: <20221123135531.23221-1-allen-kh.cheng@mediatek.com>
 <20221123135531.23221-3-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221123135531.23221-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/11/2022 14:55, Allen-KH Cheng wrote:
> Add power domains controller for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied for the next merge window. (v6.2-tmp/dts64 which will transform into 
v6.2-next/dts64 once v6.2-rc1 is released)

Thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 188 +++++++++++++++++++++++
>   1 file changed, 188 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index c326aeb33a10..2b03a342b8db 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -332,6 +332,194 @@
>   			#interrupt-cells = <2>;
>   		};
>   
> +		scpsys: syscon@10006000 {
> +			compatible = "mediatek,mt8186-scpsys", "syscon", "simple-mfd";
> +			reg = <0 0x10006000 0 0x1000>;
> +
> +			/* System Power Manager */
> +			spm: power-controller {
> +				compatible = "mediatek,mt8186-power-controller";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				#power-domain-cells = <1>;
> +
> +				/* power domain of the SoC */
> +				mfg0: power-domain@MT8186_POWER_DOMAIN_MFG0 {
> +					reg = <MT8186_POWER_DOMAIN_MFG0>;
> +					clocks = <&topckgen CLK_TOP_MFG>;
> +					clock-names = "mfg00";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAIN_MFG1 {
> +						reg = <MT8186_POWER_DOMAIN_MFG1>;
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8186_POWER_DOMAIN_MFG2 {
> +							reg = <MT8186_POWER_DOMAIN_MFG2>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8186_POWER_DOMAIN_MFG3 {
> +							reg = <MT8186_POWER_DOMAIN_MFG3>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_CSIRX_TOP {
> +					reg = <MT8186_POWER_DOMAIN_CSIRX_TOP>;
> +					clocks = <&topckgen CLK_TOP_SENINF>,
> +						 <&topckgen CLK_TOP_SENINF1>;
> +					clock-names = "csirx_top0", "csirx_top1";
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB {
> +					reg = <MT8186_POWER_DOMAIN_SSUSB>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_SSUSB_P1 {
> +					reg = <MT8186_POWER_DOMAIN_SSUSB_P1>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_ADSP_AO {
> +					reg = <MT8186_POWER_DOMAIN_ADSP_AO>;
> +					clocks = <&topckgen CLK_TOP_AUDIODSP>,
> +						 <&topckgen CLK_TOP_ADSP_BUS>;
> +					clock-names = "audioadsp", "adsp_bus";
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAIN_ADSP_INFRA {
> +						reg = <MT8186_POWER_DOMAIN_ADSP_INFRA>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8186_POWER_DOMAIN_ADSP_TOP {
> +							reg = <MT8186_POWER_DOMAIN_ADSP_TOP>;
> +							mediatek,infracfg = <&infracfg_ao>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_CONN_ON {
> +					reg = <MT8186_POWER_DOMAIN_CONN_ON>;
> +					mediatek,infracfg = <&infracfg_ao>;
> +					#power-domain-cells = <0>;
> +				};
> +
> +				power-domain@MT8186_POWER_DOMAIN_DIS {
> +					reg = <MT8186_POWER_DOMAIN_DIS>;
> +					clocks = <&topckgen CLK_TOP_DISP>,
> +						 <&topckgen CLK_TOP_MDP>,
> +						 <&mmsys CLK_MM_SMI_INFRA>,
> +						 <&mmsys CLK_MM_SMI_COMMON>,
> +						 <&mmsys CLK_MM_SMI_GALS>,
> +						 <&mmsys CLK_MM_SMI_IOMMU>;
> +					clock-names = "disp", "mdp", "smi_infra", "smi_common",
> +						     "smi_gals", "smi_iommu";
> +					mediatek,infracfg = <&infracfg_ao>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					#power-domain-cells = <1>;
> +
> +					power-domain@MT8186_POWER_DOMAIN_VDEC {
> +						reg = <MT8186_POWER_DOMAIN_VDEC>;
> +						clocks = <&topckgen CLK_TOP_VDEC>,
> +							 <&vdecsys CLK_VDEC_LARB1_CKEN>;
> +						clock-names = "vdec0", "larb";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAIN_CAM {
> +						reg = <MT8186_POWER_DOMAIN_CAM>;
> +						clocks = <&topckgen CLK_TOP_CAM>,
> +							 <&topckgen CLK_TOP_SENINF>,
> +							 <&topckgen CLK_TOP_SENINF1>,
> +							 <&topckgen CLK_TOP_SENINF2>,
> +							 <&topckgen CLK_TOP_SENINF3>,
> +							 <&topckgen CLK_TOP_CAMTM>,
> +							 <&camsys CLK_CAM2MM_GALS>;
> +						clock-names = "cam-top", "cam0", "cam1", "cam2",
> +							     "cam3", "cam-tm", "gals";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8186_POWER_DOMAIN_CAM_RAWB {
> +							reg = <MT8186_POWER_DOMAIN_CAM_RAWB>;
> +							#power-domain-cells = <0>;
> +						};
> +
> +						power-domain@MT8186_POWER_DOMAIN_CAM_RAWA {
> +							reg = <MT8186_POWER_DOMAIN_CAM_RAWA>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAIN_IMG {
> +						reg = <MT8186_POWER_DOMAIN_IMG>;
> +						clocks = <&topckgen CLK_TOP_IMG1>,
> +							 <&imgsys1 CLK_IMG1_GALS_IMG1>;
> +						clock-names = "img-top", "gals";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#address-cells = <1>;
> +						#size-cells = <0>;
> +						#power-domain-cells = <1>;
> +
> +						power-domain@MT8186_POWER_DOMAIN_IMG2 {
> +							reg = <MT8186_POWER_DOMAIN_IMG2>;
> +							#power-domain-cells = <0>;
> +						};
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAIN_IPE {
> +						reg = <MT8186_POWER_DOMAIN_IPE>;
> +						clocks = <&topckgen CLK_TOP_IPE>,
> +							 <&ipesys CLK_IPE_LARB19>,
> +							 <&ipesys CLK_IPE_LARB20>,
> +							 <&ipesys CLK_IPE_SMI_SUBCOM>,
> +							 <&ipesys CLK_IPE_GALS_IPE>;
> +						clock-names = "ipe-top", "ipe-larb0", "ipe-larb1",
> +							      "ipe-smi", "ipe-gals";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAIN_VENC {
> +						reg = <MT8186_POWER_DOMAIN_VENC>;
> +						clocks = <&topckgen CLK_TOP_VENC>,
> +							 <&vencsys CLK_VENC_CKE1_VENC>;
> +						clock-names = "venc0", "larb";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#power-domain-cells = <0>;
> +					};
> +
> +					power-domain@MT8186_POWER_DOMAIN_WPE {
> +						reg = <MT8186_POWER_DOMAIN_WPE>;
> +						clocks = <&topckgen CLK_TOP_WPE>,
> +							 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
> +							 <&wpesys CLK_WPE_SMI_LARB8_PCLK_EN>;
> +						clock-names = "wpe0", "larb-ck", "larb-pclk";
> +						mediatek,infracfg = <&infracfg_ao>;
> +						#power-domain-cells = <0>;
> +					};
> +				};
> +			};
> +		};
> +
>   		watchdog: watchdog@10007000 {
>   			compatible = "mediatek,mt8186-wdt",
>   				     "mediatek,mt6589-wdt";
