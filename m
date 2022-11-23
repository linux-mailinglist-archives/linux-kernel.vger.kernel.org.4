Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6555D6363AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbiKWPaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 10:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238711AbiKWP3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 10:29:53 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBEED2E1;
        Wed, 23 Nov 2022 07:28:48 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r9-20020a1c4409000000b003d02dd48c45so1380661wma.0;
        Wed, 23 Nov 2022 07:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftqEzEHnnMvonMmmJPLx6q5CLZsq2t+9P9lW6KSyUwA=;
        b=akBjQxkV1kzp7iW2Bc6yWhwVg7siLcSntAvammjB8aPCVEUX0FEVKdffeYYcV682IQ
         M3MrwaQ7SdFzlqx7PjEtQrdwyft/XmWExSmSpzirEAG7iswC/E60w+B1pjYdhDq4Vpyq
         cQvXg+ChFKI8uUjT4atzfzK5IiZZGsF8hxkhrxouXgepRbPVQ3FyC5i2Ps1tayi6diyL
         Ce8X1CW02MLnZzUM5eUaj3xKv9LHKnm5DCGelrA+VLJw915ZJ77/4zoNJPWcaYBzMur0
         PTJsMyy8YyGN4zpoTtaSPYBgQukqQVnNd3xBWL8zmzFfotVS2B8yncFtDgS2Iw6P9W1T
         INYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ftqEzEHnnMvonMmmJPLx6q5CLZsq2t+9P9lW6KSyUwA=;
        b=HKyfagY2VyeSrbenm/dNg4bbEx/2mZW5PGMoKoUyjw1hgU1PKOz53kBJr0qb4HrHJr
         cxUfSN8IbzvkPa/crkcgN+c+lUAfr8nMYKkGnuOTRRa+dvaenjH1RjkqVgTEltF6j823
         kLJ/q3JaVN7qQf9a+NqeEd3sbEhnyc5nOFQq4K29jVvuyg/Hr1bgrLKJClKc66PMEOyh
         PCS7txyqyea2dw8ahCg1Soo2sX/26/QV5J93h6N5MwmMeX5rQBs3jBGNKHIQGBssljlF
         6lrbV9/z10X8sTrZ2NcShNJkM3uuyAbylmaQLE6y98SJR1Or65riP0DsqYo8F3xwN01D
         z/iQ==
X-Gm-Message-State: ANoB5pmK8M00GcYFfRVSPNzeGzrRGk2/fQTbM4A46aX9R14zvfY0Laff
        TCW0hY4awQO0MKJQShejIxY=
X-Google-Smtp-Source: AA0mqf5f1bJQd/kk45F2Ul+AxbhB4M3fRPov9KTjDa55p+XRKykCJ9GiF6HDxcwFeaMn0RXT5OVtMg==
X-Received: by 2002:a05:600c:1e12:b0:3cf:9ad3:a20e with SMTP id ay18-20020a05600c1e1200b003cf9ad3a20emr9388507wmb.151.1669217327267;
        Wed, 23 Nov 2022 07:28:47 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g26-20020adfa49a000000b002366e3f1497sm17316267wrb.6.2022.11.23.07.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:28:46 -0800 (PST)
Message-ID: <3e4bf9b4-ad17-6854-a3f7-92ba88d229ad@gmail.com>
Date:   Wed, 23 Nov 2022 16:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] arm64: dts: mt8186: Add IOMMU and SMI nodes
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
 <20221123135531.23221-4-allen-kh.cheng@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221123135531.23221-4-allen-kh.cheng@mediatek.com>
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
> Add iommu and smi nodes for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Applied thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8186.dtsi | 173 +++++++++++++++++++++++
>   1 file changed, 173 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8186.dtsi b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> index 2b03a342b8db..c0481f0dc527 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8186.dtsi
> @@ -7,6 +7,7 @@
>   #include <dt-bindings/clock/mt8186-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/memory/mt8186-memory-port.h>
>   #include <dt-bindings/pinctrl/mt8186-pinfunc.h>
>   #include <dt-bindings/power/mt8186-power.h>
>   #include <dt-bindings/phy/phy.h>
> @@ -947,24 +948,113 @@
>   			#reset-cells = <1>;
>   		};
>   
> +		smi_common: smi@14002000 {
> +			compatible = "mediatek,mt8186-smi-common";
> +			reg = <0 0x14002000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_GALS>, <&mmsys CLK_MM_SMI_GALS>;
> +			clock-names = "apb", "smi", "gals0", "gals1";
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		larb0: smi@14003000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14003000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <0>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		larb1: smi@14004000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14004000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>,
> +				 <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <1>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
> +		iommu_mm: iommu@14016000 {
> +			compatible = "mediatek,mt8186-iommu-mm";
> +			reg = <0 0x14016000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_IOMMU>;
> +			clock-names = "bclk";
> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH 0>;
> +			mediatek,larbs = <&larb0 &larb1 &larb2 &larb4
> +					  &larb7 &larb8 &larb9 &larb11
> +					  &larb13 &larb14 &larb16 &larb17
> +					  &larb19 &larb20>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +			#iommu-cells = <1>;
> +		};
> +
>   		wpesys: clock-controller@14020000 {
>   			compatible = "mediatek,mt8186-wpesys";
>   			reg = <0 0x14020000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb8: smi@14023000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x14023000 0 0x1000>;
> +			clocks = <&wpesys CLK_WPE_SMI_LARB8_CK_EN>,
> +				 <&wpesys CLK_WPE_SMI_LARB8_CK_EN>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <8>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_WPE>;
> +		};
> +
>   		imgsys1: clock-controller@15020000 {
>   			compatible = "mediatek,mt8186-imgsys1";
>   			reg = <0 0x15020000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb9: smi@1502e000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1502e000 0 0x1000>;
> +			clocks = <&imgsys1 CLK_IMG1_GALS_IMG1>,
> +				 <&imgsys1 CLK_IMG1_LARB9_IMG1>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <9>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_IMG>;
> +		};
> +
>   		imgsys2: clock-controller@15820000 {
>   			compatible = "mediatek,mt8186-imgsys2";
>   			reg = <0 0x15820000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb11: smi@1582e000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1582e000 0 0x1000>;
> +			clocks = <&imgsys1 CLK_IMG1_LARB9_IMG1>,
> +				 <&imgsys2 CLK_IMG2_LARB9_IMG2>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <11>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_IMG2>;
> +		};
> +
> +		larb4: smi@1602e000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1602e000 0 0x1000>;
> +			clocks = <&vdecsys CLK_VDEC_LARB1_CKEN>,
> +				 <&vdecsys CLK_VDEC_LARB1_CKEN>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <4>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_VDEC>;
> +		};
> +
>   		vdecsys: clock-controller@1602f000 {
>   			compatible = "mediatek,mt8186-vdecsys";
>   			reg = <0 0x1602f000 0 0x1000>;
> @@ -977,12 +1067,65 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		larb7: smi@17010000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x17010000 0 0x1000>;
> +			clocks = <&vencsys CLK_VENC_CKE1_VENC>,
> +				 <&vencsys CLK_VENC_CKE1_VENC>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <7>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_VENC>;
> +		};
> +
>   		camsys: clock-controller@1a000000 {
>   			compatible = "mediatek,mt8186-camsys";
>   			reg = <0 0x1a000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb13: smi@1a001000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1a001000 0 0x1000>;
> +			clocks = <&camsys CLK_CAM2MM_GALS>, <&camsys CLK_CAM_LARB13>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <13>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_CAM>;
> +		};
> +
> +		larb14: smi@1a002000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1a002000 0 0x1000>;
> +			clocks = <&camsys CLK_CAM2MM_GALS>, <&camsys CLK_CAM_LARB14>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <14>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_CAM>;
> +		};
> +
> +		larb16: smi@1a00f000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1a00f000 0 0x1000>;
> +			clocks = <&camsys CLK_CAM_LARB14>,
> +				 <&camsys_rawa CLK_CAM_RAWA_LARBX_RAWA>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <16>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_CAM_RAWA>;
> +		};
> +
> +		larb17: smi@1a010000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1a010000 0 0x1000>;
> +			clocks = <&camsys CLK_CAM_LARB13>,
> +				 <&camsys_rawb CLK_CAM_RAWB_LARBX_RAWB>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <17>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_CAM_RAWB>;
> +		};
> +
>   		camsys_rawa: clock-controller@1a04f000 {
>   			compatible = "mediatek,mt8186-camsys_rawa";
>   			reg = <0 0x1a04f000 0 0x1000>;
> @@ -1001,10 +1144,40 @@
>   			#clock-cells = <1>;
>   		};
>   
> +		larb2: smi@1b002000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1b002000 0 0x1000>;
> +			clocks = <&mdpsys CLK_MDP_SMI0>, <&mdpsys CLK_MDP_SMI0>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <2>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_DIS>;
> +		};
> +
>   		ipesys: clock-controller@1c000000 {
>   			compatible = "mediatek,mt8186-ipesys";
>   			reg = <0 0x1c000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
> +
> +		larb20: smi@1c00f000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1c00f000 0 0x1000>;
> +			clocks = <&ipesys CLK_IPE_LARB20>, <&ipesys CLK_IPE_LARB20>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <20>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
> +		};
> +
> +		larb19: smi@1c10f000 {
> +			compatible = "mediatek,mt8186-smi-larb";
> +			reg = <0 0x1c10f000 0 0x1000>;
> +			clocks = <&ipesys CLK_IPE_LARB19>, <&ipesys CLK_IPE_LARB19>;
> +			clock-names = "apb", "smi";
> +			mediatek,larb-id = <19>;
> +			mediatek,smi = <&smi_common>;
> +			power-domains = <&spm MT8186_POWER_DOMAIN_IPE>;
> +		};
>   	};
>   };
