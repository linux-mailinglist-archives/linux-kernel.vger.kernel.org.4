Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5BD6020BA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbiJRCBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiJRCBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:01:41 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED9617AA9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:01:40 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id df9so8504547qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhd/ZUoCMuwUhpjleHprYk4PDVfQssfuw60p/YwvSaQ=;
        b=jNaPVof0L0MmviTeoZV5EZJKtT33wAw+QpArqZCK6HQpL238vQw4N9i2cO6lbsYE9u
         ENwS2Qee5VTIW8OUIqkDb1dudArA/lyynHOGkqu1WNkl0b9bX50Vt2UYqn+8Nm6Mc35y
         EHBvdhX0Q8X5AzWWA2nXRS0VT4p2NmSYqaWA6zgSHGBN6C+Uppm1VwHWsUZjqD0ayp0m
         nPAqQBRRyx0oWM7k2kc1BkNzykME+r4hDTPgQ3u3/Qavcc2O+tK7Wn41wt8RAVOMtKe3
         8hutEbNMFXpRh6C5gwciChhrDuCPMMe3IXQ1cSihSud1HzHNBN7fcGW4KSmHeaJ3corw
         3iJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhd/ZUoCMuwUhpjleHprYk4PDVfQssfuw60p/YwvSaQ=;
        b=ceSaY5mg4WeakCrEGs9OA37ZUlhngHjG8Z8nViSPokNFrtFrt+a5JV45jjriIrWE1i
         OoctfofISrNQszfZJCmS7nkzWe0xlXOisSZj/Ie6PqCXapdhZ9EFKm41EHNIBMijVMsv
         6s3S6tcKOo83pprlfY0XggGVbEu9ZHBxkuLP3cf/aKLEpQQWv1hujCydOKaj+0n47Oqb
         51M1WbhLxK5jF9Ao7YJrx7FZRuck+KD5uJtMlYKhhJK95PTbTWSjFfxGssTtAL9OfkdI
         FBt5KBrBsxc53bFrjdSjmQS2gwTX2j2EVqbdgCNZKLudpsRGPAXURT2NwugSJrayD8Va
         YcRA==
X-Gm-Message-State: ACrzQf1PRGq361MkX10DCMb+QVpjTP8nj2GSf2GOXiXHKrIk0YjCk/wg
        NWYAUQwthgpA5wI43zSkvU32eg==
X-Google-Smtp-Source: AMsMyM6Y1eek9DkmLLKa1ivGYgW3X5larIJ9MQZNCr5jutpXmxlW/v23OPmjIS4nXOeidTQiMBvmxg==
X-Received: by 2002:a05:6214:c2a:b0:474:2411:b482 with SMTP id a10-20020a0562140c2a00b004742411b482mr365531qvd.128.1666058499306;
        Mon, 17 Oct 2022 19:01:39 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id hh6-20020a05622a618600b00343057845f7sm983408qtb.20.2022.10.17.19.01.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 19:01:38 -0700 (PDT)
Message-ID: <d6bda69e-d331-3e64-2100-d41e84c3fab7@linaro.org>
Date:   Mon, 17 Oct 2022 22:01:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] arm64: dts: mt8195: Add Ethernet controller
Content-Language: en-US
To:     Biao Huang <biao.huang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        macpaul.lin@mediatek.com
References: <20221017095834.7675-1-biao.huang@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221017095834.7675-1-biao.huang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/10/2022 05:58, Biao Huang wrote:
> Add Ethernet controller node for mt8195.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 88 ++++++++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 87 +++++++++++++++++++
>  2 files changed, 175 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> index 4fbd99eb496a..02e04f82a4ae 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -258,6 +258,72 @@ &mt6359_vsram_others_ldo_reg {
>  };
>  
>  &pio {
> +	eth_default: eth_default {

No underscores in node names. Please also be sure your patch does not
bring new warnings with `dtbs_check` (lack of suffix above could mean it
brings...)

> +		txd_pins {

No underscores

> +			pinmux = <PINMUX_GPIO77__FUNC_GBE_TXD3>,
> +				 <PINMUX_GPIO78__FUNC_GBE_TXD2>,
> +				 <PINMUX_GPIO79__FUNC_GBE_TXD1>,
> +				 <PINMUX_GPIO80__FUNC_GBE_TXD0>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +		cc_pins {

Ditto... and so on.

> +			pinmux = <PINMUX_GPIO85__FUNC_GBE_TXC>,
> +				 <PINMUX_GPIO88__FUNC_GBE_TXEN>,
> +				 <PINMUX_GPIO87__FUNC_GBE_RXDV>,
> +				 <PINMUX_GPIO86__FUNC_GBE_RXC>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +		rxd_pins {
> +			pinmux = <PINMUX_GPIO81__FUNC_GBE_RXD3>,
> +				 <PINMUX_GPIO82__FUNC_GBE_RXD2>,
> +				 <PINMUX_GPIO83__FUNC_GBE_RXD1>,
> +				 <PINMUX_GPIO84__FUNC_GBE_RXD0>;
> +		};
> +		mdio_pins {
> +			pinmux = <PINMUX_GPIO89__FUNC_GBE_MDC>,
> +				 <PINMUX_GPIO90__FUNC_GBE_MDIO>;
> +			input-enable;
> +		};
> +		power_pins {
> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> +			output-high;
> +		};
> +	};
> +
> +	eth_sleep: eth_sleep {
> +		txd_pins {
> +			pinmux = <PINMUX_GPIO77__FUNC_GPIO77>,
> +				 <PINMUX_GPIO78__FUNC_GPIO78>,
> +				 <PINMUX_GPIO79__FUNC_GPIO79>,
> +				 <PINMUX_GPIO80__FUNC_GPIO80>;
> +		};
> +		cc_pins {
> +			pinmux = <PINMUX_GPIO85__FUNC_GPIO85>,
> +				 <PINMUX_GPIO88__FUNC_GPIO88>,
> +				 <PINMUX_GPIO87__FUNC_GPIO87>,
> +				 <PINMUX_GPIO86__FUNC_GPIO86>;
> +		};
> +		rxd_pins {
> +			pinmux = <PINMUX_GPIO81__FUNC_GPIO81>,
> +				 <PINMUX_GPIO82__FUNC_GPIO82>,
> +				 <PINMUX_GPIO83__FUNC_GPIO83>,
> +				 <PINMUX_GPIO84__FUNC_GPIO84>;
> +		};
> +		mdio_pins {
> +			pinmux = <PINMUX_GPIO89__FUNC_GPIO89>,
> +				 <PINMUX_GPIO90__FUNC_GPIO90>;
> +			input-disable;
> +			bias-disable;
> +		};
> +		power_pins {
> +			pinmux = <PINMUX_GPIO91__FUNC_GPIO91>,
> +				 <PINMUX_GPIO92__FUNC_GPIO92>;
> +			input-disable;
> +			bias-disable;
> +		};
> +	};
> +
>  	gpio_keys_pins: gpio-keys-pins {
>  		pins {
>  			pinmux = <PINMUX_GPIO106__FUNC_GPIO106>;
> @@ -434,6 +500,28 @@ &xhci0 {
>  	status = "okay";
>  };
>  
> +&eth {
> +	phy-mode ="rgmii-rxid";
> +	phy-handle = <&eth_phy0>;
> +	snps,reset-gpio = <&pio 93 GPIO_ACTIVE_HIGH>;
> +	snps,reset-delays-us = <0 10000 10000>;
> +	mediatek,tx-delay-ps = <2030>;
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&eth_default>;
> +	pinctrl-1 = <&eth_sleep>;
> +	status = "okay";
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		eth_phy0: eth_phy0@1 {

ethernet-phy@1

> +			compatible = "ethernet-phy-id001c.c916";
> +			reg = <0x1>;
> +		};
> +	};
> +};
> +
>  &xhci1 {
>  	vusb33-supply = <&mt6359_vusb_ldo_reg>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 905d1a90b406..aa1fcc3b9cb6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1042,6 +1042,93 @@ spis1: spi@1101e000 {
>  			status = "disabled";
>  		};
>  
> +		stmmac_axi_setup: stmmac-axi-config {
> +			snps,wr_osr_lmt = <0x7>;
> +			snps,rd_osr_lmt = <0x7>;
> +			snps,blen = <0 0 0 0 16 8 4>;
> +		};
> +
> +		mtl_rx_setup: rx-queues-config {
> +			snps,rx-queues-to-use = <4>;
> +			snps,rx-sched-sp;
> +			queue0 {
> +				snps,dcb-algorithm;
> +				snps,map-to-dma-channel = <0x0>;
> +			};
> +			queue1 {
> +				snps,dcb-algorithm;
> +				snps,map-to-dma-channel = <0x0>;
> +			};
> +			queue2 {
> +				snps,dcb-algorithm;
> +				snps,map-to-dma-channel = <0x0>;
> +			};
> +			queue3 {
> +				snps,dcb-algorithm;
> +				snps,map-to-dma-channel = <0x0>;
> +			};
> +		};
> +
> +		mtl_tx_setup: tx-queues-config {
> +			snps,tx-queues-to-use = <4>;
> +			snps,tx-sched-wrr;
> +			queue0 {
> +				snps,weight = <0x10>;
> +				snps,dcb-algorithm;
> +				snps,priority = <0x0>;
> +			};
> +			queue1 {
> +				snps,weight = <0x11>;
> +				snps,dcb-algorithm;
> +				snps,priority = <0x1>;
> +			};
> +			queue2 {
> +				snps,weight = <0x12>;
> +				snps,dcb-algorithm;
> +				snps,priority = <0x2>;
> +			};
> +			queue3 {
> +				snps,weight = <0x13>;
> +				snps,dcb-algorithm;
> +				snps,priority = <0x3>;
> +			};
> +		};
> +
> +		eth: ethernet@11021000 {
> +			compatible = "mediatek,mt8195-gmac", "snps,dwmac-5.10a";
> +			reg = <0 0x11021000 0 0x4000>;
> +			interrupts = <GIC_SPI 716 IRQ_TYPE_LEVEL_HIGH 0>;
> +			interrupt-names = "macirq";
> +			mac-address = [00 55 7b b5 7d f7];

How is this property of a SoC? Are you saying now that all MT8195 SoCs
have the same MAC address?

Best regards,
Krzysztof

