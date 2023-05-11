Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808006FEFDB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237799AbjEKKYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjEKKYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:24:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B8510C0;
        Thu, 11 May 2023 03:24:43 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-965e4be7541so1371784766b.1;
        Thu, 11 May 2023 03:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683800682; x=1686392682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKIHjNuVfN/SnXKi7SQ+s4TzIAii7gZTENdU4EJ5tHs=;
        b=mexFiMyBRQsUwrAeCVoow3PR+OT1wBvx2ohKzbIFrYHafFVQXG6RWNB2ZxjXx7mbZQ
         UoBe9R9lSdnc6/8ScwV87y/FyQBOAySFwsV6Ope6ZCuzlTFyVnPLbsGjjewssBI4uefC
         m15ipXGJLqrSWxbtoDra18FPh3SDA5abUiPr/LQ2Zstny+fqgXCeMA/hZh3crSKG67zJ
         FwN1WGUgtRKjs3PSNegAcr4O7BcHcBt8gujnPov+HsG+QsTf3Eui5cs+2u5zGYx5f33w
         92v8c0nJmZMvu+LQBTHEQIxI7wqdOjM5hoCpGNvPoJV8/+kJ/w7Er6VL/EJFL6Opjqh1
         teAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683800682; x=1686392682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sKIHjNuVfN/SnXKi7SQ+s4TzIAii7gZTENdU4EJ5tHs=;
        b=GKvvrUf+RHonWrH7cpYRxjB38ewUZPMpl9MJm7FWAw47cBpZhgCEFqr9KD+1iknEbR
         m/OBnRHhwAEfV/y2pY8Oe4y0JhOkFv3Dmgm/RnjmSn0N6Z2Al+jTFaXt8KBOsY9g5IcG
         0xC9yywY92cNMBoV4ZbN1GVjPGlq5dR3DdUA9J9a+37vttn5BWJaoY5oXa4hksoPXk9f
         lsmi8wjoCYgmzL2ZOhpmw6TTYANdKix4PZCe7PnASMRbDKsWmDuE+qtRat6cB4Xt41UB
         EN9C6+GwBCiUU0oO4kCUn9XGopgcIembC1As1NbSL1D9jOpfN4gAfrsFgGVZyS455P4B
         ffGA==
X-Gm-Message-State: AC+VfDyAG9b96NxNP77QH6pR3FroB31Euq+nrzS3X40A46eoMxvQupZZ
        kdJKvWIqdEzsflNesQCd8Sw1TO4kF0uUow==
X-Google-Smtp-Source: ACHHUZ7AtBECbxq/85eefVZO/jLIJmxb9cWBn2j2/WyDorPqakyk7Ddaz0d9bu5+oLlU2a2wnT9YPw==
X-Received: by 2002:a17:907:2d0c:b0:966:5c04:2c5a with SMTP id gs12-20020a1709072d0c00b009665c042c5amr13576063ejc.69.1683800682065;
        Thu, 11 May 2023 03:24:42 -0700 (PDT)
Received: from [192.168.3.32] (dh207-99-190.xnet.hr. [88.207.99.190])
        by smtp.gmail.com with ESMTPSA id j11-20020a1709062a0b00b0094e62aa8bcesm3840175eje.29.2023.05.11.03.24.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 03:24:41 -0700 (PDT)
Message-ID: <8f5040e0-169b-554b-c9e6-479b8f098bc6@gmail.com>
Date:   Thu, 11 May 2023 12:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 7/8] arm64: dts: Add ipq5018 SoC and rdp432-c2 board
 support
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-8-quic_srichara@quicinc.com>
Content-Language: en-US
From:   Robert Marko <robimarko@gmail.com>
In-Reply-To: <20230510134121.1232286-8-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10. 05. 2023. 15:41, Sricharan Ramabadhran wrote:
> Add initial device tree support for the Qualcomm IPQ5018 SoC and
> rdp432-c2 board.

Hi, does reboot work for you with this patchset?
I have tested on 2 different IPQ5018 boards and they wont reboot,
I get the:
Requesting system reboot
[  321.005977] qcom_scm firmware:scm: No available mechanism for setting 
download mode
[  321.006128] reboot: Restarting system

And then it just hangs there.

Regards,
Robert

>
> Co-developed-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Co-developed-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>   [v4] Fixed the address range for intc v2m nodes
>        Fixed all schema check warnings
>        Added cache-unified and cache-size property for l2 cache node
>
>   arch/arm64/boot/dts/qcom/Makefile             |   1 +
>   .../arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts |  72 +++++
>   arch/arm64/boot/dts/qcom/ipq5018.dtsi         | 250 ++++++++++++++++++
>   3 files changed, 323 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq5018.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index d42c59572ace..57858e7f2095 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5018-rdp432-c2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-rdp468.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> new file mode 100644
> index 000000000000..e636a1cb9b77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 MP03.1-C2 board device tree source
> + *
> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5018.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5018/AP-RDP432.1-C2";
> +	compatible = "qcom,ipq5018-rdp432-c2", "qcom,ipq5018";
> +
> +	aliases {
> +		serial0 = &blsp1_uart1;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart1 {
> +	pinctrl-0 = <&uart1_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	max-frequency = <192000000>;
> +	bus-width = <4>;
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&tlmm {
> +	sdc_default_state: sdc-default-state {
> +		clk-pins {
> +			pins = "gpio9";
> +			function = "sdc1_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "gpio8";
> +			function = "sdc1_cmd";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "gpio4", "gpio5", "gpio6", "gpio7";
> +			function = "sdc1_data";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <24000000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> new file mode 100644
> index 000000000000..fc31043b59fe
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
> @@ -0,0 +1,250 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
> +/*
> + * IPQ5018 SoC device tree source
> + *
> + * Copyright (c) 2023 The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-ipq5018.h>
> +#include <dt-bindings/reset/qcom,gcc-ipq5018.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +
> +		xo_board_clk: xo-board-clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +		};
> +	};
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		CPU0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
> +			cache-size = <0x80000>;
> +			cache-unified;
> +		};
> +	};
> +
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-ipq5018", "qcom,scm";
> +		};
> +	};
> +
> +	memory@40000000 {
> +		device_type = "memory";
> +		/* We expect the bootloader to fill in the size */
> +		reg = <0x0 0x40000000 0x0 0x0>;
> +	};
> +
> +	pmu {
> +		compatible = "arm,cortex-a53-pmu";
> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +	};
> +
> +	psci {
> +		compatible = "arm,psci-1.0";
> +		method = "smc";
> +	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		tz_region: tz@4ac00000 {
> +			reg = <0x0 0x4ac00000 0x0 0x400000>;
> +			no-map;
> +		};
> +	};
> +
> +	soc: soc@0 {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq5018-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 47>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			uart1_pins: uart1-state {
> +				pins = "gpio31", "gpio32", "gpio33", "gpio34";
> +				function = "blsp1_uart1";
> +				drive-strength = <8>;
> +				bias-pull-down;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-ipq5018";
> +			reg = <0x01800000 0x80000>;
> +			clocks = <&xo_board_clk>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		sdhc_1: mmc@7804000 {
> +			compatible = "qcom,ipq5018-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x7804000 0x1000>;
> +			reg-names = "hc";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo_board_clk>;
> +			clock-names = "iface", "core", "xo";
> +			non-removable;
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart1: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>,  /* GICD */
> +			      <0x0b002000 0x2000>,  /* GICC */
> +			      <0x0b001000 0x1000>,  /* GICH */
> +			      <0x0b004000 0x2000>;  /* GICV */
> +			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0 0x0b00a000 0x1ffa>;
> +
> +			v2m0: v2m@0 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00000000 0xff8>;
> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1000 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xff8>;
> +				msi-controller;
> +			};
> +		};
> +
> +		timer@b120000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0x0b120000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			frame@b120000 {
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <0>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0xb123000 0x1000>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <1>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b124000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0x0b125000 0x1000>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <3>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0x0b126000 0x1000>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <4>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0x0b127000 0x1000>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <5>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0x0b128000 0x1000>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				frame-number = <6>;
> +				status = "disabled";
> +			};
> +		};
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> +	};
> +};
