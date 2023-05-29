Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF36714B43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjE2N6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbjE2N5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:57:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF54A7;
        Mon, 29 May 2023 06:57:09 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-30aef0499b6so436692f8f.1;
        Mon, 29 May 2023 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685368596; x=1687960596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9cbwoD1bDN3KeTSFxlU0dNxIG4pUsYvcyn2OEG5dA6Q=;
        b=P9z5GBmuumqpXC/Gaq66lcgqiAY/Pss4bmTLP+wq60i0MlcKwPs3S4uOVtCPyb28fH
         OoiHnTE1ViICbKKXgH37QBybD80O6JRJSRRZPjz2ysjynt4Tog74GNfvSrA3FfuvTlw8
         h/mrNsxY1Nax1/9BbwELXG1HshPnvUX2/j2+0ET2yrk1K+hbK4U1PchSSa/ah9kvaxUR
         sxujRG+zrr0f0NBHfQv0CDjysLAAp1uWo6yPkX9eZUMgjW25RLi2ODUlCG3UOMx6EQ1I
         NbLBtETwCRxTAo+zW2Adlyem4pYuG+HRUzLZs0P/x2ST380ED7ujhpvh8SmdMQuUnJGS
         XIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685368596; x=1687960596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cbwoD1bDN3KeTSFxlU0dNxIG4pUsYvcyn2OEG5dA6Q=;
        b=Px8NrokMEqUrc1ZdgLJfKQtWwpgCvva45NkoQ31IKVnAOi0uvCugiz7tchr6oSasX9
         bAGDVhHSjOwF/x6QVUEuYuO95i+xdlYFkVU0Kg2dNmXPv/qTSmVMOvcRguha9t2Jdllw
         mha9gER86nbRWmXI1DvuH+fwp39KCla9XIR/Xfc54UU+fttE88Ot/m66t03JY8xeLyyX
         VM4hZCFln26W0ySLVMRZLYRRjRV0ADpsKyobe4FGO2VD7bTKU9TnMlmrQT9n4aLYnTrK
         VFu9+tmItolYLFxwHWcHY7Bdlduhs31Kvl2g1OITtwmLRggzA5nhj89J7QeGzSSvXBej
         LKcA==
X-Gm-Message-State: AC+VfDwZwio/fddsuAWVX1iFhQMvgq9YQID7+wChoTqclAY3oUhHtb1R
        NJi61uZtaErhdmPy20J9+As=
X-Google-Smtp-Source: ACHHUZ4wVc5iPVCtxm5Cr6CfPsCUAV2JxQmkDbIFVJyxLuluN7/4L9PtEZwmPvo0Q4/mI85A2+kIFg==
X-Received: by 2002:a5d:694b:0:b0:309:4ee8:35ce with SMTP id r11-20020a5d694b000000b003094ee835cemr11215209wrw.21.1685368595936;
        Mon, 29 May 2023 06:56:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c16-20020a5d4f10000000b002fda1b12a0bsm80555wru.2.2023.05.29.06.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 06:56:34 -0700 (PDT)
Message-ID: <a24acb75-4503-d987-0ebb-cdbba564768f@gmail.com>
Date:   Mon, 29 May 2023 15:56:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 18/27] arm64: dts: mediatek: mt6795: Add support for IOMMU
 and LARBs
Content-Language: en-US, ca-ES, es-ES
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-19-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230412112739.160376-19-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add nodes for the multimedia IOMMU and its LARBs: this includes all but
> the MJC LARB, which cannot currently be used and will be added later.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks

> ---
>   arch/arm64/boot/dts/mediatek/mt6795.dtsi | 60 ++++++++++++++++++++++++
>   1 file changed, 60 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> index a8b2c4517e79..9cfa02085f61 100644
> --- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
> @@ -8,6 +8,7 @@
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/clock/mediatek,mt6795-clk.h>
>   #include <dt-bindings/gce/mediatek,mt6795-gce.h>
> +#include <dt-bindings/memory/mt6795-larb-port.h>
>   #include <dt-bindings/pinctrl/mt6795-pinfunc.h>
>   #include <dt-bindings/power/mt6795-power.h>
>   #include <dt-bindings/reset/mediatek,mt6795-resets.h>
> @@ -390,6 +391,17 @@ systimer: timer@10200670 {
>   			clock-names = "clk13m";
>   		};
>   
> +		iommu: iommu@10205000 {
> +			compatible = "mediatek,mt6795-m4u";
> +			reg = <0 0x10205000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_M4U>;
> +			clock-names = "bclk";
> +			interrupts = <GIC_SPI 146 IRQ_TYPE_LEVEL_LOW>;
> +			mediatek,larbs = <&larb0 &larb1 &larb2 &larb3>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
> +			#iommu-cells = <1>;
> +		};
> +
>   		apmixedsys: syscon@10209000 {
>   			compatible = "mediatek,mt6795-apmixedsys", "syscon";
>   			reg = <0 0x10209000 0 0x1000>;
> @@ -648,16 +660,64 @@ mmsys: syscon@14000000 {
>   			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX 0 0x1000>;
>   		};
>   
> +		larb0: larb@14021000 {
> +			compatible = "mediatek,mt6795-smi-larb";
> +			reg = <0 0x14021000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&mmsys CLK_MM_SMI_LARB0>;
> +			clock-names = "apb", "smi";
> +			mediatek,smi = <&smi_common>;
> +			mediatek,larb-id = <0>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
> +		};
> +
> +		smi_common: smi@14022000 {
> +			compatible = "mediatek,mt6795-smi-common";
> +			reg = <0 0x14022000 0 0x1000>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_MM>;
> +			clocks = <&infracfg CLK_INFRA_SMI>, <&mmsys CLK_MM_SMI_COMMON>;
> +			clock-names = "apb", "smi";
> +		};
> +
> +		larb2: larb@15001000 {
> +			compatible = "mediatek,mt6795-smi-larb";
> +			reg = <0 0x15001000 0 0x1000>;
> +			clocks = <&mmsys CLK_MM_SMI_COMMON>, <&infracfg CLK_INFRA_SMI>;
> +			clock-names = "apb", "smi";
> +			mediatek,smi = <&smi_common>;
> +			mediatek,larb-id = <2>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_ISP>;
> +		};
> +
>   		vdecsys: clock-controller@16000000 {
>   			compatible = "mediatek,mt6795-vdecsys";
>   			reg = <0 0x16000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
>   
> +		larb1: larb@16010000 {
> +			compatible = "mediatek,mt6795-smi-larb";
> +			reg = <0 0x16010000 0 0x1000>;
> +			mediatek,smi = <&smi_common>;
> +			mediatek,larb-id = <1>;
> +			clocks = <&vdecsys CLK_VDEC_CKEN>, <&vdecsys CLK_VDEC_LARB_CKEN>;
> +			clock-names = "apb", "smi";
> +			power-domains = <&spm MT6795_POWER_DOMAIN_VDEC>;
> +		};
> +
>   		vencsys: clock-controller@18000000 {
>   			compatible = "mediatek,mt6795-vencsys";
>   			reg = <0 0x18000000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
> +
> +		larb3: larb@18001000 {
> +			compatible = "mediatek,mt6795-smi-larb";
> +			reg = <0 0x18001000 0 0x1000>;
> +			clocks = <&vencsys CLK_VENC_VENC>, <&vencsys CLK_VENC_LARB>;
> +			clock-names = "apb", "smi";
> +			mediatek,smi = <&smi_common>;
> +			mediatek,larb-id = <3>;
> +			power-domains = <&spm MT6795_POWER_DOMAIN_VENC>;
> +		};
>   	};
>   };
