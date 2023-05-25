Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD47107E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbjEYItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjEYItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:49:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8713198;
        Thu, 25 May 2023 01:49:30 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7313C6601F25;
        Thu, 25 May 2023 09:49:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685004569;
        bh=EtbcIEsusRHFZTgu8Dex+fRPFWvkGsCdZCUXAljl5dA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R3Kqq201hrVo9BPurnMzA4ezjYaxoOObvi2g1URGN83ygYowisAzheTdUdqoN8r5n
         TSPVNXvf2IqTDg6Ua32jPMj5mo3fBXv6Jzp00dpCYtRkUZIBFKRI6Z95fFDvcq9zyB
         Qmf4i6a4nRyF4Lo8EjOvSFAi7xS9fItyrAASqEHumC9d+L+2iMqekjSs9WuiEvzVgr
         kqPO/q7IWRwlb7SHqcUp/Q775FHR3XSGYEdGLrJGcoMiI0kG0mYN6GtVrQxhaJszeY
         PEVm7f/e/4fGzFf7IIwz7zGZD1F44ZMszNcIUEl1DVmOHxBiPP4hdPjndP8BOQ7DIl
         oElYLmw5vShYA==
Message-ID: <b80ceed1-0c5a-0875-dab0-309e2318d88e@collabora.com>
Date:   Thu, 25 May 2023 10:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v8 07/10] arm64: dts: mediatek: add ethernet support for
 mt8365-evk
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
References: <20230203-evk-board-support-v8-0-7019f3fd0adf@baylibre.com>
 <20230203-evk-board-support-v8-7-7019f3fd0adf@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230203-evk-board-support-v8-7-7019f3fd0adf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/05/23 10:33, Alexandre Mergnat ha scritto:
> - Enable "vibr" and "vsim2" regulators to power the ethernet chip.
> 
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 48 +++++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index 1a5769c397c2..86524cbf4354 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -88,6 +88,29 @@ optee_reserved: optee@43200000 {
>   	};
>   };
>   
> +&ethernet {
> +	pinctrl-0 = <&ethernet_pins>;
> +	pinctrl-names = "default";
> +	phy-handle = <&eth_phy>;
> +	phy-mode = "rmii";
> +	/*
> +	 * Ethernet and HDMI (DSI0) are sharing pins.
> +	 * Only one can be enabled at a time and require the physical switch
> +	 * SW2101 to be set on LAN position
> +	 * mt6357_vibr_reg and mt6357_vsim2_reg are needed to supply ethernet
> +	 */
> +	status = "disabled";

Ouh, that's sad :-(

...but you're left with no other choice, so I agree with providing at least
the full node in case anyone wants to actually enable it by flipping the
switch on the board, so you get my

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

> +
> +	mdio {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy: ethernet-phy@0 {
> +			reg = <0>;
> +		};
> +	};
> +};
> +
>   &i2c0 {
>   	clock-frequency = <100000>;
>   	pinctrl-0 = <&i2c0_pins>;
> @@ -138,6 +161,31 @@ &mt6357_pmic {
>   };
>   
>   &pio {
> +	ethernet_pins: ethernet-pins {
> +		phy_reset_pins {
> +			pinmux = <MT8365_PIN_133_TDM_TX_DATA1__FUNC_GPIO133>;
> +		};
> +
> +		rmii_pins {
> +			pinmux = <MT8365_PIN_0_GPIO0__FUNC_EXT_TXD0>,
> +				 <MT8365_PIN_1_GPIO1__FUNC_EXT_TXD1>,
> +				 <MT8365_PIN_2_GPIO2__FUNC_EXT_TXD2>,
> +				 <MT8365_PIN_3_GPIO3__FUNC_EXT_TXD3>,
> +				 <MT8365_PIN_4_GPIO4__FUNC_EXT_TXC>,
> +				 <MT8365_PIN_5_GPIO5__FUNC_EXT_RXER>,
> +				 <MT8365_PIN_6_GPIO6__FUNC_EXT_RXC>,
> +				 <MT8365_PIN_7_GPIO7__FUNC_EXT_RXDV>,
> +				 <MT8365_PIN_8_GPIO8__FUNC_EXT_RXD0>,
> +				 <MT8365_PIN_9_GPIO9__FUNC_EXT_RXD1>,
> +				 <MT8365_PIN_10_GPIO10__FUNC_EXT_RXD2>,
> +				 <MT8365_PIN_11_GPIO11__FUNC_EXT_RXD3>,
> +				 <MT8365_PIN_12_GPIO12__FUNC_EXT_TXEN>,
> +				 <MT8365_PIN_13_GPIO13__FUNC_EXT_COL>,
> +				 <MT8365_PIN_14_GPIO14__FUNC_EXT_MDIO>,
> +				 <MT8365_PIN_15_GPIO15__FUNC_EXT_MDC>;
> +		};
> +	};
> +
>   	gpio_keys: gpio-keys-pins {
>   		pins {
>   			pinmux = <MT8365_PIN_24_KPCOL0__FUNC_KPCOL0>;
> 

