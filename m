Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1B60F935
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiJ0NhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiJ0NhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:37:02 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70D180AFB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id ml12so1306233qvb.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2GnhnNDCyIBLFVOQg7DgSoVuXf9UreqHVmB6/UwdfA=;
        b=OLoIsgmBdxgAiGARPBR+7qMxJ/o9iFqUadWyIIMd8AaDPnFWat4uJE7ZV4wVBkbnJP
         cmyJzj1afELExUEs8YuT82EqLa7hZnP3BWgizDYsr0eFDOkteukVMrUg4oKEp3kiOc7A
         4+PvlfsKo5B9LmZiKkO12SSh6Y1MgV1mid+fWvIcDszdV/vsORMEmJPH3oX5CXNh+nNv
         zxlAFm3zJgYJ2P8+9G3LUGoUCeAxSCKLxyWomZvmCy3hZY4iJfxZ+VdtovLsb4zPGrC4
         e1aj8klmDJ5lcfZxYfbymLh4tXfEb6p1bVcu9nS/gwnG83p4IXnJtKFjEDjVR/O3JrFf
         IBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2GnhnNDCyIBLFVOQg7DgSoVuXf9UreqHVmB6/UwdfA=;
        b=TfIX9ZFbgbywyiQ/QiQPJ1ETWLz282Gx5VRaLQBynd5lbBFbkvf87JRnslqHhaRw++
         5FWPxjbOwouQ3PDd+g6LRu1WJaOVIjOlhI/7VzsUzSVWMRzBtjooLOUuDIOtS2dW9464
         mL44pcM8Z+dTLVj3G0g8Db4BLLg3YRpCJjjpSJz370XL8hKty67BLrik5hSaWKhran7b
         x0FLcRkKOvVMvCzYljzGsMtcbd7WEsEYn6glbfN6eIDxt+p2lTU0xiRcJX2kmA24G0SQ
         58HMXREioW1zMnNtMaWWLDpom9uVjBS3Q1u3foNpx827CzVXg5QmfhEy1on4I/uqxqfq
         599w==
X-Gm-Message-State: ACrzQf3JW0XAiyy0sNXaTwSu966wTd/mGDPKlPKIHs+FqzMZ7ZyMsYG+
        yGTeFZG60sKkjf65Vgs41RWBJg==
X-Google-Smtp-Source: AMsMyM6eM3CbvgHfXpxbKm4Dxk1AfkCFjTjNBUWsKVT3knCJXw4HktFheUouQKDo95dPiPVkMQXqqQ==
X-Received: by 2002:a0c:e651:0:b0:4bb:a726:3392 with SMTP id c17-20020a0ce651000000b004bba7263392mr1214478qvn.0.1666877819292;
        Thu, 27 Oct 2022 06:36:59 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id x3-20020a05620a448300b006bbc09af9f5sm954213qkp.101.2022.10.27.06.36.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:36:58 -0700 (PDT)
Message-ID: <a05535bc-ba18-0296-b387-d2c9c759d6f2@linaro.org>
Date:   Thu, 27 Oct 2022 09:36:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 4/4] arm64: dts: uniphier: Add NX1 SoC and boards support
Content-Language: en-US
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221027045157.23325-1-hayashi.kunihiko@socionext.com>
 <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027045157.23325-5-hayashi.kunihiko@socionext.com>
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

On 27/10/2022 00:51, Kunihiko Hayashi wrote:
> Initial version of devicetree sources for NX1 SoC and boards.
> 

Thank you for your patch. There is something to discuss/improve.

> diff --git a/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi b/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi
> new file mode 100644
> index 000000000000..e401763de86e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/socionext/uniphier-nx1.dtsi
> @@ -0,0 +1,704 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
> +//
> +// Device Tree Source for UniPhier NX1 SoC
> +//
> +// Copyright (C) 2021 Socionext Inc.
> +//   Author: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/gpio/uniphier-gpio.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +	compatible = "socionext,uniphier-nx1";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	interrupt-parent = <&gic>;
> +
> +	cpus {
> +		#address-cells = <2>;
> +		#size-cells = <0>;
> +
> +		cpu-map {
> +			cluster0 {
> +				core0 {
> +					cpu = <&cpu0>;
> +				};
> +				core1 {
> +					cpu = <&cpu1>;
> +				};
> +				core2 {
> +					cpu = <&cpu2>;
> +				};
> +				core3 {
> +					cpu = <&cpu3>;
> +				};
> +			};
> +		};
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0 0x000>;
> +			clocks = <&sys_clk 33>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0 0x001>;
> +			clocks = <&sys_clk 33>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0 0x002>;
> +			clocks = <&sys_clk 33>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		cpu3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0 0x003>;
> +			clocks = <&sys_clk 33>;
> +			enable-method = "psci";
> +			next-level-cache = <&l2>;
> +			operating-points-v2 = <&cluster0_opp>;
> +			#cooling-cells = <2>;
> +		};
> +
> +		l2: l2-cache {
> +			compatible = "cache";
> +		};
> +	};
> +
> +	cluster0_opp: opp-table {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp-78125000 {
> +			opp-hz = /bits/ 64 <78125000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp-156250000 {
> +			opp-hz = /bits/ 64 <156250000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp-312500000 {
> +			opp-hz = /bits/ 64 <312500000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp-625000000 {
> +			opp-hz = /bits/ 64 <625000000>;
> +			clock-latency-ns = <300>;
> +		};
> +		opp-1250000000 {
> +			opp-hz = /bits/ 64 <1250000000>;
> +			clock-latency-ns = <300>;
> +		};
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	clocks {
> +		refclk: ref {

Generic node name, so at least "clock" prefix or suffix.

> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;

Are you sure the clock is a property of a SoC? IOW, it is physically on
the SoC? If not, define entire clock or its frequency by boards.

> +		};
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio UNIPHIER_GPIO_PORT(3, 0) GPIO_ACTIVE_LOW>;
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 11 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
> +	thermal-zones {
> +		cpu-thermal {
> +			polling-delay-passive = <250>;	/* 250ms */
> +			polling-delay = <1000>;		/* 1000ms */
> +			thermal-sensors = <&pvtctl>;
> +
> +			trips {
> +				cpu_crit: cpu-crit {
> +					temperature = <120000>;	/* 120C */
> +					hysteresis = <2000>;
> +					type = "critical";
> +				};
> +				cpu_alert: cpu-alert {
> +					temperature = <110000>;	/* 110C */
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip = <&cpu_alert>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure-memory@21000000 {
> +			reg = <0x0 0x21000000 0x0 0x01000000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		sysctrl: sysctrl@11840000 {

Node name: system-controller or syscon

> +			compatible = "socionext,uniphier-nx1-sysctrl",

This looks undocumented.

Did you run `make dtbs_check`?


> +				     "simple-mfd", "syscon";
> +			reg = <0x11840000 0x10000>;
> +
> +			sys_clk: clock {

Node name: clock-controller

> +				compatible = "socionext,uniphier-nx1-clock";
> +				#clock-cells = <1>;
> +			};
> +
> +			sys_rst: reset {

reset-controller

> +				compatible = "socionext,uniphier-nx1-reset";
> +				#reset-cells = <1>;
> +			};
> +
> +			watchdog {
> +				compatible = "socionext,uniphier-wdt";
> +			};
> +
> +			pvtctl: thermal-sensor {
> +				compatible = "socionext,uniphier-nx1-thermal";
> +				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>;
> +				#thermal-sensor-cells = <0>;
> +				socionext,tmod-calibration = <0x0f22 0x68ee>;
> +			};
> +		};
> +
> +		spi0: spi@14006000 {
> +			compatible = "socionext,uniphier-scssi";
> +			status = "disabled";
> +			reg = <0x14006000 0x100>;

Reg is second property. Status goes last. The same in other nodes.


> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi0>;
> +			clocks = <&peri_clk 11>;
> +			resets = <&peri_rst 11>;
> +		};
> +
> +		spi1: spi@14006100 {
> +			compatible = "socionext,uniphier-scssi";
> +			status = "disabled";
> +			reg = <0x14006100 0x100>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_spi1>;
> +			clocks = <&peri_clk 12>;
> +			resets = <&peri_rst 12>;
> +		};
> +
> +		serial0: serial@14006800 {
> +			compatible = "socionext,uniphier-uart";
> +			status = "disabled";
> +			reg = <0x14006800 0x40>;
> +			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_uart0>;
> +			clocks = <&peri_clk 0>;
> +			resets = <&peri_rst 0>;
> +		};
> +
> +		serial1: serial@14006900 {
> +			compatible = "socionext,uniphier-uart";
> +			status = "disabled";
> +			reg = <0x14006900 0x40>;
> +			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_uart1>;
> +			clocks = <&peri_clk 1>;
> +			resets = <&peri_rst 1>;
> +		};
> +
> +		serial2: serial@14006a00 {
> +			compatible = "socionext,uniphier-uart";
> +			status = "disabled";
> +			reg = <0x14006a00 0x40>;
> +			interrupts = <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_uart2>;
> +			clocks = <&peri_clk 2>;
> +			resets = <&peri_rst 2>;
> +		};
> +
> +		serial3: serial@14006b00 {
> +			compatible = "socionext,uniphier-uart";
> +			status = "disabled";
> +			reg = <0x14006b00 0x40>;
> +			interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_uart3>;
> +			clocks = <&peri_clk 3>;
> +			resets = <&peri_rst 3>;
> +		};
> +
> +		gpio: gpio@14007000 {
> +			compatible = "socionext,uniphier-gpio";
> +			reg = <0x14007000 0x200>;
> +			interrupt-parent = <&aidet>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&pinctrl 0 0 0>,
> +				      <&pinctrl 49 0 0>,
> +				      <&pinctrl 53 0 0>,
> +				      <&pinctrl 96 0 0>,
> +				      <&pinctrl 120 0 0>;
> +			gpio-ranges-group-names = "gpio_range0",
> +						  "gpio_range1",
> +						  "gpio_range2",
> +						  "gpio_range3",
> +						  "gpio_range4";
> +			ngpios = <126>;
> +			socionext,interrupt-ranges = <0 48 6>;
> +		};
> +
> +		eth: ethernet@15000000 {
> +			compatible = "socionext,uniphier-nx1-ave4";
> +			status = "disabled";
> +			reg = <0x15000000 0x8500>;
> +			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_ether_rgmii>;
> +			clock-names = "ether";
> +			clocks = <&sys_clk 6>;
> +			reset-names = "ether";
> +			resets = <&sys_rst 6>;
> +			phy-mode = "rgmii-id";
> +			local-mac-address = [00 00 00 00 00 00];
> +			socionext,syscon-phy-mode = <&soc_glue 0>;
> +
> +			mdio: mdio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +			};
> +		};
> +
> +		usb: usb@15a00000 {
> +			compatible = "socionext,uniphier-dwc3", "snps,dwc3";
> +			status = "disabled";
> +			reg = <0x15a00000 0xcd00>;
> +			interrupt-names = "host";
> +			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb0>, <&pinctrl_usb1>;
> +			clock-names = "ref", "bus_early", "suspend";
> +			clocks = <&sys_clk 12>, <&sys_clk 12>, <&sys_clk 12>;
> +			resets = <&usb_rst 15>;
> +			phys = <&usb_hsphy0>, <&usb_hsphy1>,
> +			       <&usb_ssphy0>, <&usb_ssphy1>;
> +			dr_mode = "host";
> +		};
> +
> +		usb-controller@15b00000 {
> +			compatible = "socionext,uniphier-nx1-dwc3-glue",

Undocumented compatible.

> +				     "simple-mfd";


Missing reg. Did you run `make dtbs_check`? Did you actually check it
with dtc?

> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x15b00000 0x400>;
> +
> +			usb_rst: reset@0 {

reset-controller

> +				compatible = "socionext,uniphier-nx1-usb3-reset";
> +				reg = <0x0 0x4>;
> +				#reset-cells = <1>;
> +				clock-names = "link";
> +				clocks = <&sys_clk 12>;
> +				reset-names = "link";
> +				resets = <&sys_rst 12>;
> +			};
> +
> +			usb_vbus0: regulator@100 {
> +				compatible = "socionext,uniphier-nx1-usb3-regulator";
> +				reg = <0x100 0x10>;
> +				clock-names = "link";
> +				clocks = <&sys_clk 12>;
> +				reset-names = "link";
> +				resets = <&sys_rst 12>;
> +			};
> +
> +			usb_vbus1: regulator@110 {
> +				compatible = "socionext,uniphier-nx1-usb3-regulator";
> +				reg = <0x110 0x10>;
> +				clock-names = "link";
> +				clocks = <&sys_clk 12>;
> +				reset-names = "link";
> +				resets = <&sys_rst 12>;
> +			};
> +
> +			usb_hsphy0: hs-phy@200 {

Node name: phy

The same in all other places. It can be also usb-phy and few others
mentioned iin DT spec:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +				compatible = "socionext,uniphier-nx1-usb3-hsphy";
> +				reg = <0x200 0x10>;
> +				#phy-cells = <0>;
> +				clock-names = "link", "phy", "phy-ext";
> +				clocks = <&sys_clk 12>, <&sys_clk 16>,
> +					 <&sys_clk 13>;
> +				reset-names = "link", "phy";
> +				resets = <&sys_rst 12>, <&sys_rst 16>;
> +				vbus-supply = <&usb_vbus0>;
> +			};
> +
> +			usb_hsphy1: hs-phy@210 {
> +				compatible = "socionext,uniphier-nx1-usb3-hsphy";
> +				reg = <0x210 0x10>;
> +				#phy-cells = <0>;
> +				clock-names = "link", "phy", "phy-ext";
> +				clocks = <&sys_clk 12>, <&sys_clk 16>,
> +					 <&sys_clk 13>;
> +				reset-names = "link", "phy";
> +				resets = <&sys_rst 12>, <&sys_rst 16>;
> +				vbus-supply = <&usb_vbus1>;
> +			};
> +
> +			usb_ssphy0: ss-phy@300 {
> +				compatible = "socionext,uniphier-nx1-usb3-ssphy";
> +				reg = <0x300 0x10>;
> +				#phy-cells = <0>;
> +				clock-names = "link", "phy", "phy-ext";
> +				clocks = <&sys_clk 12>, <&sys_clk 17>,
> +					 <&sys_clk 13>;
> +				reset-names = "link", "phy";
> +				resets = <&sys_rst 12>, <&sys_rst 17>;
> +				vbus-supply = <&usb_vbus0>;
> +			};
> +
> +			usb_ssphy1: ss-phy@310 {
> +				compatible = "socionext,uniphier-nx1-usb3-ssphy";
> +				reg = <0x310 0x10>;
> +				#phy-cells = <0>;
> +				clock-names = "link", "phy", "phy-ext";
> +				clocks = <&sys_clk 12>, <&sys_clk 18>,
> +					 <&sys_clk 13>;
> +				reset-names = "link", "phy";
> +				resets = <&sys_rst 12>, <&sys_rst 18>;
> +				vbus-supply = <&usb_vbus1>;
> +			};
> +		};
> +
> +		pcie: pcie@16000000 {
> +			compatible = "socionext,uniphier-pcie";
> +			status = "disabled";
> +			reg-names = "dbi", "link", "config", "atu";
> +			reg = <0x16000000 0x1000>, <0x179a0000 0x10000>,
> +			      <0x0fff0000 0x10000>, <0x16300000 0x1000>;
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			clocks = <&sys_clk 24>;
> +			resets = <&sys_rst 24>;
> +			num-lanes = <2>;
> +			num-viewport = <1>;
> +			bus-range = <0x0 0xff>;
> +			device_type = "pci";
> +			ranges =
> +			/* downstream I/O */
> +				<0x81000000 0 0x00000000 0x0ffe0000 0 0x00010000>,
> +			/* non-prefetchable memory */
> +				<0x82000000 0 0x20000000 0x04200000 0 0x0bde0000>;
> +			#interrupt-cells = <1>;
> +			interrupt-names = "dma", "msi";
> +			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-map-mask = <0 0 0 7>;
> +			interrupt-map = <0 0 0 1 &pcie_intc 0>,	/* INTA */
> +					<0 0 0 2 &pcie_intc 1>,	/* INTB */
> +					<0 0 0 3 &pcie_intc 2>,	/* INTC */
> +					<0 0 0 4 &pcie_intc 3>;	/* INTD */
> +			phy-names = "pcie-phy";
> +			phys = <&pcie_phy>;
> +
> +			pcie_intc: legacy-interrupt-controller {
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupt-parent = <&gic>;
> +				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		pcie_ep: pcie-ep@16000000 {
> +			compatible = "socionext,uniphier-nx1-pcie-ep";
> +			status = "disabled";
> +			reg-names = "dbi", "dbi2", "link", "addr_space", "atu";
> +			reg = <0x16000000 0x1000>, <0x16100000 0x1000>,
> +			      <0x179a0000 0x10000>, <0x04200000 0xbe00000>,
> +			      <0x16300000 0x1000>;
> +			clock-names = "link";
> +			clocks = <&sys_clk 24>;
> +			reset-names = "link";
> +			resets = <&sys_rst 24>;
> +			num-ib-windows = <16>;
> +			num-ob-windows = <16>;
> +			num-lanes = <2>;
> +			phy-names = "pcie-phy";
> +			phys = <&pcie_phy>;
> +		};
> +
> +		pcie_phy: phy@179b8000 {
> +			compatible = "socionext,uniphier-nx1-pcie-phy";
> +			reg = <0x179b8000 0x4000>;
> +			#phy-cells = <0>;
> +			clock-names = "link";
> +			clocks = <&sys_clk 24>;
> +			reset-names = "link";
> +			resets = <&sys_rst 24>;
> +			socionext,syscon = <&sysctrl>;
> +		};
> +
> +		i2c0: i2c@18780000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18780000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c0>;
> +			clocks = <&peri_clk 4>;
> +			resets = <&peri_rst 4>;
> +			clock-frequency = <400000>;
> +		};
> +
> +		i2c1: i2c@18781000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18781000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c1>;
> +			clocks = <&peri_clk 5>;
> +			resets = <&peri_rst 5>;
> +			clock-frequency = <400000>;
> +		};
> +
> +		i2c2: i2c@18782000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18782000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c2>;
> +			clocks = <&peri_clk 6>;
> +			resets = <&peri_rst 6>;
> +			clock-frequency = <400000>;
> +		};
> +
> +		i2c3: i2c@18783000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18783000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c3>;
> +			clocks = <&peri_clk 7>;
> +			resets = <&peri_rst 7>;
> +			clock-frequency = <400000>;
> +		};
> +
> +		i2c4: i2c@18784000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18784000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c4>;
> +			clocks = <&peri_clk 8>;
> +			resets = <&peri_rst 8>;
> +			clock-frequency = <100000>;
> +		};
> +
> +		i2c5: i2c@18785000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18785000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c5>;
> +			clocks = <&peri_clk 9>;
> +			resets = <&peri_rst 9>;
> +			clock-frequency = <100000>;
> +		};
> +
> +		i2c6: i2c@18786000 {
> +			compatible = "socionext,uniphier-fi2c";
> +			status = "disabled";
> +			reg = <0x18786000 0x80>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_i2c6>;
> +			clocks = <&peri_clk 10>;
> +			resets = <&peri_rst 10>;
> +			clock-frequency = <100000>;
> +		};
> +
> +		sdctrl@19810000 {

Same comment as before...

> +			compatible = "socionext,uniphier-nx1-sdctrl",

Same problem as before...

> +				     "simple-mfd", "syscon";
> +			reg = <0x19810000 0x400>;
> +
> +			sd_clk: clock {
> +				compatible = "socionext,uniphier-nx1-sd-clock";
> +				#clock-cells = <1>;
> +			};
> +
> +			sd_rst: reset {
> +				compatible = "socionext,uniphier-nx1-sd-reset";
> +				#reset-cells = <1>;
> +			};
> +		};
> +
> +		perictrl@19820000 {
> +			compatible = "socionext,uniphier-nx1-perictrl",

Also undocumented.

> +				     "simple-mfd", "syscon";
> +			reg = <0x19820000 0x200>;
> +
> +			peri_clk: clock {

clock-controller

> +				compatible = "socionext,uniphier-nx1-peri-clock";
> +				#clock-cells = <1>;
> +			};
> +
> +			peri_rst: reset {

reset-controller

> +				compatible = "socionext,uniphier-nx1-peri-reset";
> +				#reset-cells = <1>;
> +			};
> +		};
> +
> +		emmc: mmc@1a000000 {
> +			compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
> +			reg = <0x1a000000 0x400>;
> +			interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_emmc>;
> +			clocks = <&sys_clk 4>;
> +			resets = <&sys_rst 4>;
> +			bus-width = <8>;
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-pwrseq = <&emmc_pwrseq>;
> +			cdns,phy-input-delay-legacy = <9>;
> +			cdns,phy-input-delay-mmc-highspeed = <2>;
> +			cdns,phy-input-delay-mmc-ddr = <3>;
> +			cdns,phy-dll-delay-sdclk = <21>;
> +			cdns,phy-dll-delay-sdclk-hsmmc = <21>;
> +		};
> +
> +		sd: mmc@1a400000 {
> +			compatible = "socionext,uniphier-sd-v3.1.1";
> +			status = "disabled";
> +			reg = <0x1a400000 0x800>;
> +			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_sd>;
> +			clocks = <&sd_clk 0>;
> +			reset-names = "host";
> +			resets = <&sd_rst 0>;
> +			bus-width = <4>;
> +			cap-sd-highspeed;
> +		};
> +
> +		soc_glue: soc-glue@1f800000 {
> +			compatible = "socionext,uniphier-nx1-soc-glue",

I am not going to check...

> +				     "simple-mfd", "syscon";
> +			reg = <0x1f800000 0x2000>;
> +
> +			pinctrl: pinctrl {
> +				compatible = "socionext,uniphier-nx1-pinctrl";
> +			};
> +		};
> +
> +		soc-glue@1f900000 {
> +			compatible = "socionext,uniphier-nx1-soc-glue-debug",

Hm...

> +				     "simple-mfd";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x1f900000 0x2000>;
> +		};
> +
> +		xdmac: dma-controller@1fa10000 {
> +			compatible = "socionext,uniphier-xdmac";
> +			reg = <0x1fa10000 0x5300>;
> +			interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>;
> +			dma-channels = <16>;
> +			#dma-cells = <2>;
> +		};
> +
> +		aidet: aidet@1fb20000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +			compatible = "socionext,uniphier-nx1-aidet";
> +			reg = <0x1fb20000 0x200>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +		};


Best regards,
Krzysztof

