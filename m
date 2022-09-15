Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7AB55B9603
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIOIOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiIOIOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:14:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C9B979F1;
        Thu, 15 Sep 2022 01:13:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C652E6601F69;
        Thu, 15 Sep 2022 09:13:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663229637;
        bh=I2xs6D1zEs3I3lvxfGXdbPUnS9e6puW/jlv8hQFnZrc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m6ZneEwjAzPFamedYARR4FTTD7womy74xDRCDKKKrFVrX3HseABHMCDEO2KK5qZK7
         l4KsmoQds+/Di91g1qWa2yY2EgkBHfYpZFEqeM9jtvX0jsT0E9Zadsyxpo4ctUrB9j
         EMCZ89PuRJPhE7q6zXVtuFtO5ksPIn8gHjC4mGCnYjz0vUxLB3pjbGRur0+uD69d12
         vxhB3in6wB1lXQnfhuz4hZF6GpFwU4XEREwKvq1XlQO6mAgmT/f4u3JrhMYyaO9weH
         KbGBum4oPvClVyVNv7dRz/WFF5DWk9Zcy9Q02N0NBlpsUC2tj0XGMOZhAqniSR04kz
         kpACVNR4x7ATw==
Message-ID: <f882ab40-b9bf-3f38-d62e-c175135383c3@collabora.com>
Date:   Thu, 15 Sep 2022 10:13:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/4] arm64: dts: mt8195: Add dp-intf nodes
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
 <20220915075849.1920-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915075849.1920-2-rex-bc.chen@mediatek.com>
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
> Add dp-intf0 and dp-intf1 nodes for MT8195.
> 
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..93e6a106a9b8 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2155,5 +2155,28 @@
>   			clock-names = "apb", "smi", "gals";
>   			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
>   		};
> +
> +		dp_intf0: dp-intf@1c015000 {

Please keep the devicetree nodes ordered by mmio.
dp_intf0 goes between mutex@1c016000 and larb@1c018000.


> +			status = "disabled";

status = "disabled" across the entire mt8195.dtsi nodes is always at the end.
Please keep consistency.

> +			compatible = "mediatek,mt8195-dp-intf";
> +			reg = <0 0x1c015000 0 0x1000>;
> +			interrupts = <GIC_SPI 657 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&vdosys0  CLK_VDO0_DP_INTF0>,
> +				 <&vdosys0 CLK_VDO0_DP_INTF0_DP_INTF>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL1>;
> +			clock-names = "engine", "pixel", "pll";
> +		};
> +
> +		dp_intf1: dp-intf@1c113000 {
> +			compatible = "mediatek,mt8195-dp-intf";
> +			reg = <0 0x1c113000 0 0x1000>;
> +			interrupts = <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>;
> +			power-domains = <&spm MT8195_POWER_DOMAIN_VDOSYS1>;
> +			clocks = <&vdosys1 CLK_VDO1_DP_INTF0_MM>,
> +				 <&vdosys1 CLK_VDO1_DPINTF>,
> +				 <&apmixedsys CLK_APMIXED_TVDPLL2>;
> +			clock-names = "engine", "pixel", "pll";
> +			status = "disabled";
> +		};
>   	};
>   };


