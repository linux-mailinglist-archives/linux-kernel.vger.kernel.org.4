Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0190D5B8832
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 14:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiINMZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 08:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiINMZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 08:25:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C3727FC6;
        Wed, 14 Sep 2022 05:25:37 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B9678660201C;
        Wed, 14 Sep 2022 13:25:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663158336;
        bh=chHX2jLIhcmbg+DDld/yuFaSQbRv4/mc7ZJbewN4Trc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K2dzTtfRPSBVPtyL0U9eeZa0r9AtGR11cm87zqE1lSzRrlhp0+UQ+BOLr65VugiFk
         HA8CmyhxcMnK6cRMkzSXtze/ytfjFwpVWmQSa0WXVmTxnnCj3lAJ846MRs2dXJAYqa
         +z9aJiqLPurmG/BB0qSu4KprXROi8tIOQbWIhmrQJpU0DrgSVBHAaOBxghbeKjpzAN
         7R+TsxiuWZoqEgwKt6E0KrNOJzOvGc+nKfvT7RpH+GKlwR+uQAEw8odZGdtseyz9oc
         RSqkb5r6jxXFjddrZbLYIZW/Go2UVgWRAxNkKt8rGKE/1Ka5ocpsl3hjYShaGxf/n8
         Fr2JRoKFkMqkQ==
Message-ID: <57039109-bf86-bd91-3b71-531e45fcb68f@collabora.com>
Date:   Wed, 14 Sep 2022 14:25:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v9,6/7] arm64: dts: mt8195: Add thermal zones and thermal
 nodes
Content-Language: en-US
To:     bchihi@baylibre.com, rafael@kernel.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amitk@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, mka@chromium.org, robh+dt@kernel.org,
        krzk+dt@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        fan.chen@mediatek.com, louis.yu@mediatek.com,
        rex-bc.chen@mediatek.com, abailon@baylibre.com
References: <20220817080757.352021-1-bchihi@baylibre.com>
 <20220817080757.352021-7-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220817080757.352021-7-bchihi@baylibre.com>
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

Il 17/08/22 10:07, bchihi@baylibre.com ha scritto:
> From: Tinghan Shen <tinghan.shen@mediatek.com>
> 
> Add thermal zones and thermal nodes for the mt8195.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Co-developed-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Co-developed-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Co-developed-by: Balsam CHIHI <bchihi@baylibre.com>
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 111 +++++++++++++++++++++++
>   1 file changed, 111 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 95967a0196d8..aafbbe83e6ba 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/phy/phy.h>
>   #include <dt-bindings/pinctrl/mt8195-pinfunc.h>
> +#include <dt-bindings/reset/mt8195-resets.h>
>   
>   / {
>   	compatible = "mediatek,mt8195";
> @@ -452,6 +453,28 @@ spi0: spi@1100a000 {
>   			status = "disabled";
>   		};
>   
> +		lvts_ap: thermal-sensor@1100b000 {
> +			compatible = "mediatek,mt8195-lvts-ap";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x1100b000 0 0x1000>;
> +			interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8195_INFRA_RST0_THERM_CTRL_SWRST>;
> +			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> +			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
> +		};
> +
> +		lvts_mcu: thermal-sensor@11278000 {

Please keep the devicetree nodes ordered by address.
This one must be moved between mmc@1125000 and usb@11290000.

Regards,
Angelo

> +			compatible = "mediatek,mt8195-lvts-mcu";
> +			#thermal-sensor-cells = <1>;
> +			reg = <0 0x11278000 0 0x1000>;
> +			interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>;
> +			clocks = <&infracfg_ao CLK_INFRA_AO_THERM>;
> +			resets = <&infracfg_ao MT8195_INFRA_RST4_THERM_CTRL_MCU_SWRST>;
> +			nvmem-cells = <&lvts_efuse_data1 &lvts_efuse_data2>;
> +			nvmem-cell-names = "lvts_calib_data1", "lvts_calib_data2";
> +		};
> +
>   		spi1: spi@11010000 {
>   			compatible = "mediatek,mt8195-spi",
>   				     "mediatek,mt6765-spi";

