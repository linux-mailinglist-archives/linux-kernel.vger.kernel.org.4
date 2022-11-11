Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA2B625612
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbiKKJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233567AbiKKJB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:01:28 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E048D7FC;
        Fri, 11 Nov 2022 00:58:53 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id j15so5614843wrq.3;
        Fri, 11 Nov 2022 00:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mhPdRtC5P9el746wpRaUn88cJ5QQDfecOo6k2qO/YRw=;
        b=ODGS5/N8z37QTHKd5wbq4rm9UfLrcVtAuaFYHP7eg1RmB60fM6AbAEWq7/1Gp0P4uw
         YXxXdjEgcOWEnJR16XgxwN3t+Hxp7N4ob7EgqVR2tGxOjP8bhvyO90i78jwlF1f7ZIBF
         CnhBcXg5/dag8qOYkgsMD5lm3xbkFYbApk+XFYTzVjSoF6w0LX9NPRMw4Phfbgk2rg1X
         3KM92AqpV5pzv2vAuaWVl621EA3vNJvQD1V8jfIu4Non1oiNsEP97cxAilSxgWTp9kDh
         KPjURzRoOe4nASGRYWUqrLCwAq+E6G7PWCTtMPiC0vVf5IYS53//UqhZKcvhiMIUsRyv
         W4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mhPdRtC5P9el746wpRaUn88cJ5QQDfecOo6k2qO/YRw=;
        b=vIdcwojdI+r6DwTTcQV+ff05m/Ib7bfDAR7/f++tnzvtDc4UXxPRIwFlg97CUzgDYG
         YHcfcnIboLRQjch9nBRAJeDb5JdT3K5jXjUIDmfiqk6wro1EU/u/DKJJ1wkwFU+irVzq
         sIKOEEb3sbCj8TF2wBOsD21WQ33ke2W+t6XotQ0xmhTQL0scoFUASLBmHDNaBBLqKyW0
         Ch5iiLmddam4s//2T6oEs2TpQFTXRQoekASVLNxqAbUyNV2uTJZ25wVVSzdcGfQwmXeF
         YcZf/cbQi+ak898rZamO6E7Es9ym3x76QvbsehAen32f3Ub8KPaz6osjB/qFo+PlrKVj
         CjgQ==
X-Gm-Message-State: ANoB5pltW954eF8KHT3HqPda3sEPH5am9u9vQMcABICKonnkXayUnYXP
        HZgJ5J8vv3s97OMiXTLWZkw=
X-Google-Smtp-Source: AA0mqf6gSWwlgp9C2vWz+Si18kl9g/4RJgfoUqSd0qYNeAadlvvMv6N2lPtTR6po77IdmggQlHlK1Q==
X-Received: by 2002:adf:ea0c:0:b0:236:60e8:3cca with SMTP id q12-20020adfea0c000000b0023660e83ccamr621581wrm.471.1668157131624;
        Fri, 11 Nov 2022 00:58:51 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j5-20020a5d5645000000b0022da3977ec5sm1283001wrw.113.2022.11.11.00.58.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 00:58:49 -0800 (PST)
Message-ID: <9955078b-72cd-4260-0cc2-ba1b9e0a0bdd@gmail.com>
Date:   Fri, 11 Nov 2022 09:58:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RFC v3 05/11] arm64: dts: mt7986: add mmc related device nodes
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>
References: <20221106085034.12582-1-linux@fw-web.de>
 <20221106085034.12582-6-linux@fw-web.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221106085034.12582-6-linux@fw-web.de>
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
> This patch adds mmc support for MT7986.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:
> - fix pullups/pulldowns for mt7986a-rfb to have generic bias-pull-*
> 
> v2:
> - update mmc-node because clocks changed
> ---
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 87 ++++++++++++++++++++
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 15 ++++
>   2 files changed, 102 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index 2b5d7ea31b4d..e1a0331aaa5f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -5,6 +5,8 @@
>    */
>   
>   /dts-v1/;
> +#include <dt-bindings/pinctrl/mt65xx.h>
> +
>   #include "mt7986a.dtsi"
>   
>   / {
> @@ -24,6 +26,15 @@ memory@40000000 {
>   		reg = <0 0x40000000 0 0x40000000>;
>   	};
>   
> +	reg_1p8v: regulator-1p8v {
> +		compatible = "regulator-fixed";
> +		regulator-name = "fixed-1.8V";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +
>   	reg_3p3v: regulator-3p3v {
>   		compatible = "regulator-fixed";
>   		regulator-name = "fixed-3.3V";
> @@ -76,7 +87,83 @@ switch: switch@0 {
>   	};
>   };
>   
> +&mmc0 {
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc0_pins_default>;
> +	pinctrl-1 = <&mmc0_pins_uhs>;
> +	bus-width = <8>;
> +	max-frequency = <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	hs400-ds-delay = <0x14014>;
> +	vmmc-supply = <&reg_3p3v>;
> +	vqmmc-supply = <&reg_1p8v>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	status = "okay";
> +};
> +
>   &pio {
> +	mmc0_pins_default: mmc0-pins {
> +		mux {
> +			function = "emmc";
> +			groups = "emmc_51";

Waiting on
https://patchwork.kernel.org/project/linux-mediatek/patch/20221106080114.7426-3-linux@fw-web.de/

Please correct me if I'm wrong.

Matthias

> +		};
> +		conf-cmd-dat {
> +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> +			input-enable;
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +		conf-clk {
> +			pins = "EMMC_CK";
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-ds {
> +			pins = "EMMC_DSL";
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-rst {
> +			pins = "EMMC_RSTB";
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0-uhs-pins {
> +		mux {
> +			function = "emmc";
> +			groups = "emmc_51";
> +		};
> +		conf-cmd-dat {
> +			pins = "EMMC_DATA_0", "EMMC_DATA_1", "EMMC_DATA_2",
> +			       "EMMC_DATA_3", "EMMC_DATA_4", "EMMC_DATA_5",
> +			       "EMMC_DATA_6", "EMMC_DATA_7", "EMMC_CMD";
> +			input-enable;
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +		conf-clk {
> +			pins = "EMMC_CK";
> +			drive-strength = <6>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-ds {
> +			pins = "EMMC_DSL";
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>; /* pull-down 50K */
> +		};
> +		conf-rst {
> +			pins = "EMMC_RSTB";
> +			drive-strength = <4>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_01>; /* pull-up 10K */
> +		};
> +	};
> +
>   	spi_flash_pins: spi-flash-pins {
>   		mux {
>   			function = "spi";
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 1c7a973c28ca..32c26b239ae6 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -284,6 +284,21 @@ ssusb: usb@11200000 {
>   			status = "disabled";
>   		};
>   
> +		mmc0: mmc@11230000 {
> +			compatible = "mediatek,mt7986-mmc";
> +			reg = <0 0x11230000 0 0x1000>,
> +			      <0 0x11c20000 0 0x1000>;
> +			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&topckgen CLK_TOP_EMMC_416M_SEL>,
> +				 <&infracfg CLK_INFRA_MSDC_HCK_CK>,
> +				 <&infracfg CLK_INFRA_MSDC_CK>,
> +				 <&infracfg CLK_INFRA_MSDC_133M_CK>,
> +				 <&infracfg CLK_INFRA_MSDC_66M_CK>;
> +			clock-names = "source", "hclk", "source_cg", "bus_clk",
> +				      "sys_cg";
> +			status = "disabled";
> +		};
> +
>   		usb_phy: t-phy@11e10000 {
>   			compatible = "mediatek,mt7986-tphy",
>   				     "mediatek,generic-tphy-v2";
