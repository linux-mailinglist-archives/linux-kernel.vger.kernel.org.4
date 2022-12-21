Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E157652DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiLUIQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234516AbiLUIPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:15:44 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AB3F7D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:15:43 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b3so22401127lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tKVTpYZFPEDtKyLcWavwNidP1gFKsOiP+G6edw3PI9g=;
        b=vahFHpUDyrqgLEJM7LTlfQSXUee1o2TfjthdfLdgytrvn/mWRZMStW/eUl9K3VhG/2
         rW3a3BSINNKDlG/kDJ8ERk/Wwdz9KyGmrY9X6HSmHYegm248/3wlGApZXmAvfc8YIZG9
         UfqpRQNEJQfmABHy1YGf03fdsExb1o6N9UkKHLEsaEiZekXs28Pp500Rg94id2g/3Eed
         sbWPy7FZRXBMEaVGXZm9n48vANpoT0GV+Gz24KYiw/igkpF3IyVK4SlSzZy07NKKVDWG
         6pGB3/BFGoBm4h80lujRgi8J3yVVmqVojDmQwW68IKfqhbF3o8fpM12d1bdNyqO9c6pT
         zRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tKVTpYZFPEDtKyLcWavwNidP1gFKsOiP+G6edw3PI9g=;
        b=FBHispVVEX86cNPXnUop1NVB/dDmfRUv1wYD3cMm6A2wWDdvJGgl9gVjHD5SWpP/uI
         cOeAx1TIG3S8GM2RUq/1Tzol7Vlj/zA1od+La1CRA1L8rmDUJdoGKXh/1/vg48pLHEA8
         wUKpi5rjkrYGthitawVhrR9JvjyLttGWDkFn2rgbIkfN36Lx6YiFaDF3sa2Q4TeG6/YF
         DdKpEOUwb+Mm925tW5RwuAh2lNLJQEtGJpXEwv5nbrWsIjhwE0aD8efgD7hkt3zBfvKj
         y4FThWj9rB0WF6gL+urLRTN/zSpn2/TC6g69oOBFu+toIGCxUBo6CsGbejwcgAJ6UInu
         mqZg==
X-Gm-Message-State: AFqh2kq0Sae9XLM+kXC58BZYBd8I2ttanQMS2e3aKHJyXR4XHecygq80
        Qk6aGh7pnoy94QvQcgDybjMoAQ==
X-Google-Smtp-Source: AMrXdXtXrEk0IuAOycHdERvZxfkVj6P/rVqGYvaomI4T69wVYQdjoSNcMjMry1fmRVNsDStpQx2K9g==
X-Received: by 2002:a19:c20d:0:b0:4b5:b18b:8966 with SMTP id l13-20020a19c20d000000b004b5b18b8966mr185160lfc.49.1671610541679;
        Wed, 21 Dec 2022 00:15:41 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b00497aa190523sm1767100lfo.248.2022.12.21.00.15.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:15:41 -0800 (PST)
Message-ID: <88357291-3cdd-8d5a-fdec-38bd081a4235@linaro.org>
Date:   Wed, 21 Dec 2022 09:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/2] arm64: dts: rockchip: Add EmbedFire LubanCat 1
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6KdvAlWLMG4whJh@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6KdvAlWLMG4whJh@VM-66-53-centos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 06:46, Yuteng Zhong wrote:
> from: DHDAXCW <lasstp5011@gmail.com>
> 
> LubanCat 1 is a Rockchip RK3566 SBC based
> is developed by EmbedFire Electronics Co., Ltd.
> Mini Linux Card Type Cheap Computer Development Board
> 
> It has the following characteristics:
> - MicroSD card slot, onboard eMMC flash memory
> - 1GbE Realtek RTL8211F Ethernet Transceiver
> - 1 USB Type-C port (power and USB2.0 OTG)
> - 1 USB 3.0 Host port
> - 3 USB 2.0 Host ports
> - 1 HDMI
> - 1 infrared receiver
> - 1 MIPI DSI
> - 1 MIPI CSI
> - 1 x 4-section headphone jack
> - Mini PCIe socket (USB or PCIe)
> - 1 SIM Card slot
> - 1 SYS LED and 1 PWR LED
> - 40-pin GPIO expansion header
> 
> Signed-off-by: Yuteng Zhong <zonyitoo@gmail.com>
> Signed-off-by: DHDAXCW <lasstp5011@gmail.com>
> ---
> 
> Changed in V2:
>   - Remove RNG node
> Changed in V3:
>   - Sent E-mail with a wrong attachment
> Changed in V4:
>   - Modify all node names
> 
> ---
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 598 ++++++++++++++++++
>  2 files changed, 599 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> 
> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> index 0a76a2ebb5f6..e52bda04d45a 100644
> --- a/arch/arm64/boot/dts/rockchip/Makefile
> +++ b/arch/arm64/boot/dts/rockchip/Makefile
> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-blade.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-cm4.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-soquartz-model-a.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-box-demo.dtb
> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3566-lubancat-1.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-bpi-r2-pro.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-evb1-v10.dtb
>  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> new file mode 100644
> index 000000000000..443fcfabbd16
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> @@ -0,0 +1,598 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> +* Copyright (c) 2021 Rockchip Electronics Co., Ltd.
> +*/
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/leds/common.h>
> +#include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip,vop2.h>
> +#include "rk3566.dtsi"
> +
> +/ {
> +	model = "EmbedFire LubanCat 1";
> +	compatible = "embedfire,lubancat-1", "rockchip,rk3566";
> +
> +	aliases {
> +		ethernet0 = &gmac1;
> +		mmc0 = &sdmmc0;
> +		mmc1 = &sdhci;
> +	};
> +
> +	chosen: chosen {
> +		stdout-path = "serial2:1500000n8";
> +	};
> +
> +	gmac1_clkin: external-gmac1-clock {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "gmac1_clkin";
> +		#clock-cells = <0>;
> +	};
> +	
> +	hdmi-con {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		sys_led: sys-led {
> +			label = "sys_led";
> +			linux,default-trigger = "heartbeat";
> +			default-state = "on";
> +			gpios = <&gpio0 RK_PC5 GPIO_ACTIVE_LOW>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&sys_led_pin>;
> +		};
> +	};
> +
> +	usb_5v: usb-5v-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys-regulator {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&usb_5v>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc3v3_pcie: vcc3v3-pcie-regulator {


Best regards,
Krzysztof

