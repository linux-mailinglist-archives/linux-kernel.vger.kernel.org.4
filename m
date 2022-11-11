Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449996255C9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbiKKIyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:54:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbiKKIyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:54:36 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD305748C9;
        Fri, 11 Nov 2022 00:54:35 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z14so5570358wrn.7;
        Fri, 11 Nov 2022 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6hA0mNJH5dp5zCfbNj8pPfn0E69pce6sOPzSeIcns=;
        b=f5bQZL4/zURSHQu0IeAH/yYin10bNCfSTROwNzvCLAnewE9QVKytfxJa7U/vT53KW/
         RStVrEfQYiizzAsrsd8LhDUWhKhpdS/QAxpdkD2fhyDxU5J9DvJL2wFl87H/e0B3Hyf0
         og60S9w87y8qwkYw7zZQ9DOScK2NXc8PrW6C8GvPM0H4FIKv5TLYB5rEm/Hve/SJBcgQ
         hbjiRAX/bSyS2Eiu6TDZZiSUoFAo9+vY77337/YzFrSoykG4kqO7tgRE3GPlzBj7E9DA
         pTomiEc2ErcW64g3AFBipKY5O2XT6lS9EzrKhUQV8+imMhA8oVxa8kp9uTJs7NLW2Gs1
         H2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ne6hA0mNJH5dp5zCfbNj8pPfn0E69pce6sOPzSeIcns=;
        b=OjuYalsL/3jxHNX3xqJN3lPv589AabtpX4glUgOWu4DmsS/nrX/YP6nQ5Jcn3WCkOo
         GOfCFyAmefRxjZW2nxVYrk4IfcNYAuAvgKM0W3NbPouGwFSLNBaGWQjYt9PqItzypNyU
         c5yr7aw95rgAc3mvx5Y4EvJuzsIaucqRrKoSu1JJkq7WvFrxshtenTYU0DxcdESvOaOt
         jAJQh+7ct1UM1s6t+V1nhfNpmb0euLjQzXZdwLca1PoIy9z6/oGnvey/dpL/DXTh4G4A
         ZzZgxei87XsSvDwc1MidNEgL5oraUVDlD+amzXwApKriDmqkU2hXUtsVRwvl8ckbk2mF
         cPqw==
X-Gm-Message-State: ANoB5pnek2FY7N4NlvaVak8sQ5czhe0kqszbpQ6EjZw4WfgAsRXClf/j
        J8jts7IZk8AMFmz7GrOVpWjTS+zj6EgFsA==
X-Google-Smtp-Source: AA0mqf6vReapZolaQq5WFMxn3HAc5gQBF5r+IMMtA/9Uc54iWN5ZN1QIz7bvKvB9aRyjkfMF9FTyWA==
X-Received: by 2002:a5d:5684:0:b0:22e:53c0:ead8 with SMTP id f4-20020a5d5684000000b0022e53c0ead8mr624736wrv.210.1668156874241;
        Fri, 11 Nov 2022 00:54:34 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t7-20020a1c7707000000b003cfa80443a0sm2188640wmi.35.2022.11.11.00.54.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:54:32 -0800 (PST)
Message-ID: <1eb8cbba-5e8a-df34-9c0c-4d5d24de4e18@gmail.com>
Date:   Fri, 11 Nov 2022 09:54:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 02/11] arm64: dts: mt7986: add spi related device nodes
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-3-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221106085034.12582-3-linux@fw-web.de>
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



On 06/11/2022 09:50, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This patch adds spi support for MT7986.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 35 ++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 28 ++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 35 ++++++++++++++++++++
>   3 files changed, 98 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 6189436fe31d..58f7e6b169bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -55,6 +55,20 @@ switch: switch@0 {
>   };
>   
>   &pio {
> +	spi_flash_pins: spi-flash-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi0", "spi0_wp_hold";
> +		};
> +	};
> +
> +	spic_pins: spic-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi1_2";
> +		};
> +	};
> +
>   	uart1_pins: uart1-pins {
>   		mux {
>   			function = "uart";
> @@ -101,6 +115,27 @@ conf {
>   	};
>   };
>   
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_flash_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +	spi_nand: spi_nand@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +		spi-tx-buswidth = <4>;
> +		spi-rx-buswidth = <4>;
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spic_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +};
> +
>   &switch {
>   	ports {
>   		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 226648f48df2..6d881095d933 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -112,6 +112,34 @@ infracfg: infracfg@10001000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		spi0: spi@1100a000 {
> +			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100a000 0 0x100>;
> +			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MPLL_D2>,
> +				 <&topckgen CLK_TOP_SPI_SEL>,
> +				 <&infracfg CLK_INFRA_SPI0_CK>,
> +				 <&infracfg CLK_INFRA_SPI0_HCK_CK>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
> +			status = "disabled";
> +		};
> +
> +		spi1: spi@1100b000 {
> +			compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0 0x1100b000 0 0x100>;
> +			interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_MPLL_D2>,
> +				 <&topckgen CLK_TOP_SPIM_MST_SEL>,
> +				 <&infracfg CLK_INFRA_SPI1_CK>,
> +				 <&infracfg CLK_INFRA_SPI1_HCK_CK>;
> +			clock-names = "parent-clk", "sel-clk", "spi-clk", "hclk";
> +			status = "disabled";
> +		};
> +
>   		topckgen: topckgen@1001b000 {
>   			compatible = "mediatek,mt7986-topckgen", "syscon";
>   			reg = <0 0x1001B000 0 0x1000>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 7459ddb6b6f0..7673aa3fa6ae 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -96,6 +96,20 @@ fixed-link {
>   };
>   
>   &pio {
> +	spi_flash_pins: spi-flash-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi0", "spi0_wp_hold";

Waiting on pinctrl binding:
https://patchwork.kernel.org/project/linux-mediatek/patch/20221106080114.7426-2-linux@fw-web.de/

Please resend once merged.

Regards,
Matthias

> +		};
> +	};
> +
> +	spic_pins: spic-pins {
> +		mux {
> +			function = "spi";
> +			groups = "spi1_2";
> +		};
> +	};
> +
>   	wf_2g_5g_pins: wf-2g-5g-pins {
>   		mux {
>   			function = "wifi";
> @@ -128,6 +142,27 @@ conf {
>   	};
>   };
>   
> +&spi0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spi_flash_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +	spi_nand: spi_nand@0 {
> +		compatible = "spi-nand";
> +		reg = <0>;
> +		spi-max-frequency = <10000000>;
> +		spi-tx-buswidth = <4>;
> +		spi-rx-buswidth = <4>;
> +	};
> +};
> +
> +&spi1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&spic_pins>;
> +	cs-gpios = <0>, <0>;
> +	status = "okay";
> +};
> +
>   &uart0 {
>   	status = "okay";
>   };
