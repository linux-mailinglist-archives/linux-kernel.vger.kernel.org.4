Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E1763BB09
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 08:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiK2HyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 02:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiK2Hxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 02:53:53 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45922A956
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:53:51 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so21265461lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 23:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQybg/xOF6FhEZDOaOULtUoNETXBOqOsgADe67aMXLE=;
        b=UpbOptFUEiLzsBoX8bI44BnQ76xUx3UuYWpuBhe2dKYIm8oMJrJ/xo8z6OMkxu7HiD
         OvzjZz2VrPxTDDDoyXxH5Yl8g6ipP6FDTuMvUUHcw3kNZw/PXMkfkDHSoo9mHUZXHoFP
         OylNm8ch6ZPui25H3KaxDEbXIUB24DvWKgRfUErBMelTv7k9FW04Y94QUc5mnA7ZUqF1
         gT0fdh+4Y7hpPPuFcr7yMwL/xt/8DRCZSeCBAxS4VQHMFisHMlhpqe4FF21uFnLtOtkL
         nfVfeqCHBzarhnbV7gzabyklUaYZk+XkEIYLgiyQQCwZTUUthwmcSImZ7tVZvU0Jg2kv
         IoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQybg/xOF6FhEZDOaOULtUoNETXBOqOsgADe67aMXLE=;
        b=xACvJdeMl97MxpnzPMr0KBbYZEp444Ogc8uSiFeEbCIyBC4isHfrTTGFYbo0VgZMXK
         ZYNbZ9im3a9eYNRdKt17GraEQK/TRzAkwhswH5BxDupmxZ67uGj/j4C0YVv5UHpj4aOK
         fXRXXCNsT7aZ+omn/6jtKky9N5tv3mwoMdnl1I9xdE5PUVI9BOd3u5lkbXdxZu6MFW+Q
         oSEdlDhv4Ps5RGjQi27DHWAcsmziVZ49u/Wn77IJEBqQYmrN3RpZV8cgzR9mGbNuXzIl
         vZhI2msRmV+NOv8JPQE1I9WScpqW1uzpsVcyeo0POVerPX/voZwrXi382TW2JZD5DfR4
         +4lw==
X-Gm-Message-State: ANoB5pnOhvQQWRtgPeD7MgmKvyD6q57P++WdfHoZuh2QPYf7YYsEpEog
        2mn3wa4747bcAo7VT8mACNJA5g==
X-Google-Smtp-Source: AA0mqf5dJhrQO41ryq6m1BJXGW5hy/Q5lxwkYtSEPrZdima5tVcNCUG7xlI2pcPStT+BfOlClvCVYA==
X-Received: by 2002:ac2:5dd9:0:b0:4b4:e433:477b with SMTP id x25-20020ac25dd9000000b004b4e433477bmr11060037lfq.541.1669708430322;
        Mon, 28 Nov 2022 23:53:50 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o25-20020ac25e39000000b004979ec19380sm2097789lfg.285.2022.11.28.23.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 23:53:49 -0800 (PST)
Message-ID: <893717a9-14f0-1aa4-bf33-e5630cb0e769@linaro.org>
Date:   Tue, 29 Nov 2022 08:53:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: rk3328: Add Orange Pi R1 Plus
Content-Language: en-US
To:     Chukun Pan <amadeus@jmu.edu.cn>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20221129064042.17806-1-amadeus@jmu.edu.cn>
 <20221129064042.17806-2-amadeus@jmu.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129064042.17806-2-amadeus@jmu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 07:40, Chukun Pan wrote:
> Orange Pi R1 Plus is a Rockchip RK3328 based SBC by Xunlong.
> 
> This device is similar to the NanoPi R2S, and has a 16MB
> SPI NOR (mx25l12805d). The reset button is changed to
> directly reset the power supply, another detail is that
> both network ports have independent MAC addresses.
> 
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../dts/rockchip/rk3328-orangepi-r1-plus.dts  | 373 ++++++++++++++++++
>  2 files changed, 374 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 0a76a2ebb5f6..27e00f4f3c86 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -15,6 +15,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-orangepi-r1-plus.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock64.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-rock-pi-e.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-roc-cc.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> new file mode 100644
> index 000000000000..daa4da0bd5e4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3328-orangepi-r1-plus.dts
> @@ -0,0 +1,373 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Based on rk3328-nanopi-r2s.dts, which is:
> + *   Copyright (c) 2020 David Bauer <mail@david-bauer.net>
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include "rk3328.dtsi"
> +
> +/ {
> +	model = "Xunlong Orange Pi R1 Plus";
> +	compatible = "xunlong,orangepi-r1-plus", "rockchip,rk3328";
> +
> +	aliases {
> +		ethernet1 = &rtl8153;
> +		mmc0 = &sdmmc;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	gmac_clk: gmac-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "gmac_clkin";
> +		#clock-cells = <0>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&lan_led_pin>, <&sys_led_pin>, <&wan_led_pin>;
> +		pinctrl-names = "default";
> +
> +		led-0 {
> +			function = LED_FUNCTION_LAN;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio2 RK_PB7 GPIO_ACTIVE_HIGH>;
> +		};
> +
> +		led-1 {
> +			function = LED_FUNCTION_STATUS;
> +			color = <LED_COLOR_ID_RED>;
> +			gpios = <&gpio3 RK_PC5 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		led-2 {
> +			function = LED_FUNCTION_WAN;
> +			color = <LED_COLOR_ID_GREEN>;
> +			gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	vcc_sd: sdmmc-regulator {
> +		compatible = "regulator-fixed";
> +		gpio = <&gpio0 RK_PD6 GPIO_ACTIVE_LOW>;
> +		pinctrl-0 = <&sdmmc0m1_pin>;
> +		pinctrl-names = "default";
> +		regulator-name = "vcc_sd";
> +		regulator-boot-on;
> +		vin-supply = <&vcc_io>;
> +	};
> +
> +	vcc_sys: vcc-sys {

Use consistent prefix/suffix, so -regulator.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vdd_5v_lan: vdd-5v-lan {

Dutto

> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-0 = <&lan_vdd_pin>;
> +		pinctrl-names = "default";
> +		regulator-name = "vdd_5v_lan";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		vin-supply = <&vcc_sys>;
> +	};
> +};
> +


Best regards,
Krzysztof

