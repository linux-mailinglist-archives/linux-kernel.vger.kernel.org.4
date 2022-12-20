Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60C665247A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 17:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiLTQPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 11:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiLTQO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 11:14:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BCB1ADB7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:14:54 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id n1so12909298ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 08:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABsPQHwzy/hpR6LdUf60UqznMqNqLFDZcSfy42srSno=;
        b=yAdMc2mD7/UlXp7JB/FWn7ALs+xR3pyneL8BQrEfiFgGxPvsoHJRkgTHJMYuxh/eVQ
         dRPEgoN9KGdPcrvDOczbIPKKQj9AdjJvCOO//sIWuFeN5/hiWzp0ACs0GmxD29EaTR5c
         11liI/BiCW/rw4zEjnz5esFLZGxpyuRZMUQ9Egbb2rV/Pl8QMLK1jbOkmc0YMlf3GAv7
         LDY2Peh9Q0EW5kowlfvHCf1wek9ReneHplBH3ictgR87FTGsT0sBGxrKQPyKaXeiPtSW
         hpOeNH2QiEa6dt0BXJ2Z+El6A5iBk6UvkYXugbXhz7WlQuBmzneFGY4sEq0KE30L/jo/
         g6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABsPQHwzy/hpR6LdUf60UqznMqNqLFDZcSfy42srSno=;
        b=6kG4enwYVcg1+8O8+v2W17248j7LYp1+JZkVfAZ2THXcrS/rndFF5TQ/vakqer6ZBo
         DOWCYtwXryJgYumy4Cwp43oYUMLzFCpQq7W21bANNxwhBNE4ZTjK9vvPdpYlWXq65lbg
         T7zrMSAGZTVWN87mJAB34q45PN7Pkkua625jL2r3zq2eFUQeV/aBkdApBZPUbzwNL54D
         Yk/YgWk+I7dG2/rMABsKC3Sbut8KvyGRpx4yk43BFLu7n13JbR9hZa8+fGedr+1D7oL6
         y88HLZrenkueJiD4+6kCJzyGMboiXRtgUxCn5CwdPza6h6qNST++2KkLvezFWTr8NtVO
         zGWQ==
X-Gm-Message-State: ANoB5pnlj2MgIw1Z1RLTKvoMAHjP/lXwG3z7XVTVpJgx1GeP5Pu+ZdAP
        wywLGEfB9fliFH8Mf8ar+sIwKw==
X-Google-Smtp-Source: AA0mqf4nQQQHWEhnvXe9zTEZ5mFeKxXJ2c+Ec+h4+aO8Xy3oTCguiLzatqqDmiWd1OioCXTQ48jpow==
X-Received: by 2002:a05:651c:3c1:b0:27a:3eeb:66c4 with SMTP id f1-20020a05651c03c100b0027a3eeb66c4mr10331739ljp.26.1671552892549;
        Tue, 20 Dec 2022 08:14:52 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f5-20020a05651c03c500b0027b477e5bdesm1062163ljp.19.2022.12.20.08.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 08:14:52 -0800 (PST)
Message-ID: <a113d20c-dc6c-2e44-009f-d4b17beb8820@linaro.org>
Date:   Tue, 20 Dec 2022 17:14:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] arm64: dts: rockchip: Add RK3566 LubanCat 1
Content-Language: en-US
To:     Yuteng Zhong <zonyitoo@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Peter Geis <pgwipeout@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, DHDAXCW <lasstp5011@gmail.com>
References: <Y6GMnq3AC7Kbnag8@VM-66-53-centos>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6GMnq3AC7Kbnag8@VM-66-53-centos>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2022 11:21, Yuteng Zhong wrote:
> LubanCat 1 is a Rockchip RK3566 SBC based
> is developed by EmbedFire Electronics Co., Ltd.
> Mini Linux Card Type Cheap Computer Development Board

Please wrap commit message according to Linux coding style / submission
process:
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586

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
>  .../devicetree/bindings/arm/rockchip.yaml     |   5 +
>  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
>  .../boot/dts/rockchip/rk3566-lubancat-1.dts   | 600 ++++++++++++++++++
>  3 files changed, 606 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
> index 88ff4422a8c1..84d39a3a8843 100644
> --- a/Documentation/devicetree/bindings/arm/rockchip.yaml
> +++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
> @@ -781,6 +781,11 @@ properties:
>            - const: rockchip,rk3568-bpi-r2pro
>            - const: rockchip,rk3568
>  
> +      - description: EmbedFire LubanCat 1
> +        items:
> +          - const: embedfire,lubancat-1
> +          - const: rockchip,rk3566
> +

This is separate patch. Does not look like properly ordered. Don't add
stuff at the end of files/lists.

>  additionalProperties: true
>  
>  ...
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
> index 000000000000..af1abb38d45c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts
> @@ -0,0 +1,600 @@
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
> +	dc_5v: dc-5v {

Node names should be generic, so at least with regulator prefix or suffix.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +		compatible = "regulator-fixed";
> +		regulator-name = "dc_5v";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +	};
> +
> +	vcc3v3_sys: vcc3v3-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc3v3_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_sys: vcc5v0-sys {
> +		compatible = "regulator-fixed";
> +		regulator-name = "vcc5v0_sys";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		vin-supply = <&dc_5v>;
> +	};
> +
> +	pcie_3v3: pcie2-3v3-regulator {

And here you have it? Keep your code consistent.

> +		compatible = "regulator-fixed";
> +		regulator-name = "pcie_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		enable-active-high;
> +		gpio = <&gpio0 RK_PD3 GPIO_ACTIVE_HIGH>;
> +		startup-delay-us = <5000>;
> +		vin-supply = <&vcc5v0_sys>;
> +	};
> +
> +	vcc5v0_usb20_host: vcc5v0-usb20-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PB6 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb20_host_en>;
> +		regulator-name = "vcc5v0_usb20_host";
> +		regulator-always-on;
> +	};
> +
> +	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
> +		compatible = "regulator-fixed";
> +		enable-active-high;
> +		gpio = <&gpio2 RK_PB5 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&vcc5v0_usb30_host_en>;
> +		regulator-name = "vcc5v0_usb30_host";
> +		regulator-always-on;
> +	};
> +};
> +
> +&uart2 {
> +	status = "okay";
> +};
> +
> +&combphy1 {
> +	status = "okay";
> +};
> +
> +&combphy2 {
> +	status = "okay";
> +};
> +
> +&cpu0 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu1 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu2 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&cpu3 {
> +	cpu-supply = <&vdd_cpu>;
> +};
> +
> +&gpu {
> +	mali-supply = <&vdd_gpu>;
> +	status = "okay";
> +};
> +
> +&hdmi {
> +	avdd-0v9-supply = <&vdda0v9_image>;
> +	avdd-1v8-supply = <&vcca1v8_image>;
> +	status = "okay";
> +};
> +
> +&hdmi_in {
> +	hdmi_in_vp0: endpoint {
> +		remote-endpoint = <&vp0_out_hdmi>;
> +	};
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
> +&hdmi_sound {
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	vdd_cpu: regulator@1c {
> +		compatible = "tcs,tcs4525";
> +		reg = <0x1c>;
> +		fcs,suspend-voltage-selector = <1>;
> +		regulator-name = "vdd_cpu";
> +		regulator-always-on;
> +		regulator-boot-on;
> +		regulator-min-microvolt = <800000>;
> +		regulator-max-microvolt = <1150000>;
> +		regulator-ramp-delay = <2300>;
> +		vin-supply = <&vcc5v0_sys>;
> +
> +		regulator-state-mem {
> +			regulator-off-in-suspend;
> +		};
> +	};
> +
> +	rk809: pmic@20 {
> +		compatible = "rockchip,rk809";
> +		reg = <0x20>;
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
> +		assigned-clocks = <&cru I2S1_MCLKOUT_TX>;
> +		assigned-clock-parents = <&cru CLK_I2S1_8CH_TX>;
> +		#clock-cells = <1>;
> +		clock-names = "mclk";
> +		clocks = <&cru I2S1_MCLKOUT_TX>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pmic_int>;
> +		rockchip,system-power-controller;
> +		#sound-dai-cells = <0>;
> +		vcc1-supply = <&vcc3v3_sys>;
> +		vcc2-supply = <&vcc3v3_sys>;
> +		vcc3-supply = <&vcc3v3_sys>;
> +		vcc4-supply = <&vcc3v3_sys>;
> +		vcc5-supply = <&vcc3v3_sys>;
> +		vcc6-supply = <&vcc3v3_sys>;
> +		vcc7-supply = <&vcc3v3_sys>;
> +		vcc8-supply = <&vcc3v3_sys>;
> +		vcc9-supply = <&vcc3v3_sys>;
> +		wakeup-source;
> +
> +		regulators {
> +			vdd_logic: DCDC_REG1 {

No underscores in node names. Anything requires it?


Best regards,
Krzysztof

