Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F25B9605
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiIOIOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIOIOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:14:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6997B0F;
        Thu, 15 Sep 2022 01:14:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE9486601F69;
        Thu, 15 Sep 2022 09:14:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663229645;
        bh=TxnD5zdRaSawjyj06ttIobSn1RRh53WxSYuyvrmydSU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ADVfk27Obu/lWkuopA9jemmYwEPHRiqP2dtPjEFDvDtkB6GLzNZLXq+yTaeWhuhne
         CuWTQDIf0Hdrwdc5J+VB+G61cuqJ0BPhE4qjRV3slXiTh7a2c5Wi+K6F6gXMEVaUFt
         /EngCP/1QRTKerg360I9Vu8ZdEsBJIX7yGb+LZnujcrsVSZJ3ChnF5ErdoZkMCjyqZ
         Te4UYVz6GCHi2NR1CdvVSqjofzwL1IjTJNAOZsIuiTJXrv6HbuhsHJHhtAfapJM1Xy
         zPbZPeQcK9cy/ogGZggH9+i1uKx6HGrbuytvoWpuRJatkqCrx8x8gBGH9XyMfPGGX7
         IuAL4bmIaGrHw==
Message-ID: <81d9d1fd-2ac6-7500-111d-b073f19c1d8b@collabora.com>
Date:   Thu, 15 Sep 2022 10:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/4] arm64: dts: mt8195: Add dptx nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
 <20220915075849.1920-3-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915075849.1920-3-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 09:58, Bo-Chen Chen ha scritto:
> Add edptx and dptx nodes for MT8195.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 93e6a106a9b8..6f3f9bf3dc54 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1241,6 +1241,9 @@
>   				reg = <0x189 0x2>;
>   				bits = <7 5>;
>   			};
> +			dp_calibration: dp-data@1ac {
> +				reg = <0x1ac 0x10>;
> +			};
>   		};
>   
>   		u3phy2: t-phy@11c40000 {
> @@ -2178,5 +2181,27 @@
>   			clock-names = "engine", "pixel", "pll";
>   			status = "disabled";
>   		};
> +
> +		edp_tx: edp-tx@1c500000 {
> +			status = "disabled";
> +			compatible = "mediatek,mt8195-edp-tx";
> +			reg = <0 0x1c500000 0 0x8000>;
> +			nvmem-cells = <&dp_calibration>;
> +			nvmem-cell-names = "dp_calibration_data";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_EPD_TX>;
> +			interrupts = <GIC_SPI 676 IRQ_TYPE_LEVEL_HIGH 0>;
> +			max-linkrate-mhz = <8100>;
> +		};
> +
> +		dp_tx: dp-tx@1c600000 {
> +			compatible = "mediatek,mt8195-dp-tx";
> +			reg = <0 0x1c600000 0 0x8000>;
> +			nvmem-cells = <&dp_calibration>;
> +			nvmem-cell-names = "dp_calibration_data";
> +			power-domains = <&spm MT8195_POWER_DOMAIN_DP_TX>;
> +			interrupts = <GIC_SPI 458 IRQ_TYPE_LEVEL_HIGH 0>;
> +			status = "disabled";
> +			max-linkrate-mhz = <8100>;

max-linkrate-mhz should go before status.

> +		};
>   	};
>   };

