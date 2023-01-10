Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232086640E7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbjAJMu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbjAJMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:50:18 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD64FD54
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:50:17 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id m6so18217671lfj.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 04:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NREKwsbkkrocJg3Oe5+JFiLqkx/+hSVffR+c8QWPu6A=;
        b=ZyVqcVHbZ8im3KUjIm9OBFVWO3Jw4RbJlsz/B/3chyFa2G7G0EwaBpdvMuNPft5vlc
         E8QQFMg5uDICB/wL1t+2dfn2/DqS7fXlyTIjEYcg+UpODSRqAdoajQV/6Jl8zaSTNr5t
         a2iY6zSmMC80SoWZvIhaDPnlOZV4/W/46AxwU6+R9geuYZs7xk6a1zmrHfeZNJAPQcbB
         Dr3loRAIEji4A4lIQ67Ooamt7s8oRIExePg8C/HBPsz7psUW6kf3+62rJ6L1Q870L5OM
         wzbMX+VK79IijVofY2l9bNbOaqI/vKLtUG+SUeyPMbAa5F1X5Ui1bBXnDXHRmi3Q0rYg
         0z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NREKwsbkkrocJg3Oe5+JFiLqkx/+hSVffR+c8QWPu6A=;
        b=r5CnyFn8tB6bbUcJmcuVgscdLsahn/wqYYQmqWkAPpmfGB22/rom//G1C2YbERtT4G
         j2gDgR5cCoA5/DgbfxikOKS2UrN6PZafnJeXqjHyUg3A+KkyJuzaL5EnhKbTt5jwRNmM
         jofbHkLRCnsBdXDa43m2urMul3mxJoAYhfFJ2J9ZFBedQ6CMkkGiLFJToLD2OSn5hq3u
         yVlDIy+EpFzTweGn88rScFBbEYCnSZVmPRMp8BE5xRv/I0oXJYFco3faeIbdKZyWh/la
         BeHPVdK1iGBNdJ2OClDZpjpNYDYybn39rHmRWfGTN/YoGK3eogAoP2cTi1DOdsXmMzdy
         cLtQ==
X-Gm-Message-State: AFqh2kpTfXcmu+Ii2v8Ei31d9Qqfx/ONBGxyYu4G1pwLnPIke/klDMIf
        LajVs7RbaY5WrpkbiZY+pWRsAg==
X-Google-Smtp-Source: AMrXdXsQLcRXcSacdP3cu8Yvq8BTfttp5aRsrb4P74uj8O36h061jyy6ECiUSQR1M/3G7SwoX1NmlA==
X-Received: by 2002:a05:6512:3410:b0:4a4:68b8:f4db with SMTP id i16-20020a056512341000b004a468b8f4dbmr18220243lfr.33.1673355015622;
        Tue, 10 Jan 2023 04:50:15 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512348f00b004abc977ad7fsm2163377lfr.294.2023.01.10.04.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:50:15 -0800 (PST)
Message-ID: <9a584aa9-52f1-2c1b-db93-45f0302641dc@linaro.org>
Date:   Tue, 10 Jan 2023 13:50:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, p.zabel@pengutronix.de,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, tdas@codeaurora.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230110121316.24892-7-quic_devipriy@quicinc.com>
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



On 10.01.2023 13:13, devi priya wrote:
> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
> 
> Add initial device tree support for Qualcomm IPQ9574 SoC
> and AL02 board
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile            |   1 +
>  arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  69 ++++
>  arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 318 +++++++++++++++++++
>  3 files changed, 388 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..872c62028a0b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-al02-c7.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> new file mode 100644
> index 000000000000..ae3c32f3e16a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
BSD3?

> +/*
> + * IPQ9574 AL02-C7 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
Happy new year!

> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
> +	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
> +	interrupt-parent = <&intc>;
> +
> +	aliases {
> +		serial0 = &blsp1_uart2;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +};
> +
> +&blsp1_uart2 {
> +	pinctrl-0 = <&uart2_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sdhc_1 {
> +	pinctrl-0 = <&emmc_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&tlmm {
> +	emmc_pins: emmc-state {
sdc_default? I suppose you'll introduce a corresponding sleep state
later on, so that'll be easier to distinguish.

> +		emmc-clk-pins {
> +			pins = "gpio5";
> +			function = "sdc_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
Please add a newline between subsequent nodes.
> +		emmc-cmd-pins {
> +			pins = "gpio4";
> +			function = "sdc_cmd";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +		emmc-data-pins {
> +			pins = "gpio0", "gpio1", "gpio2",
> +			     "gpio3", "gpio6", "gpio7",
> +			     "gpio8", "gpio9";
The indentation here is wrong.

> +			function = "sdc_data";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +		emmc-rclk-pins {
> +			pins = "gpio10";
> +			function = "sdc_rclk";
> +			drive-strength = <8>;
> +			bias-pull-down;
> +		};
> +	};
> +
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> new file mode 100644
> index 000000000000..188d18688a77
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -0,0 +1,318 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * IPQ9574 SoC device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,gcc-ipq9574.h>
> +#include <dt-bindings/reset/qcom,gcc-ipq9574.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		bias_pll_ubi_nc_clk: bias_pll_ubi_nc_clk {
Could you tell us something about the purpose of this clock? First
time seeing it, your gcc driver reveals it's connected to at least
PCIe.

> +			compatible = "fixed-clock";
> +			clock-frequency = <353000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <250000000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <125000000>;
> +			#clock-cells = <0>;
> +		};
Do not define these pipe clocks. You can leave the GCC entries as <0>
until you introduce the QMPPHY support, which then you can feed as it
provides these clocks.

> +
> +		sleep_clk: sleep-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <32000>;
> +			#clock-cells = <0>;
> +		};
> +
> +		xo_board_clk: xo-board-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <24000000>;
The clock frequency should be moved to the device DT, because the
clock is on the board and not on the SoC.

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
> +			compatible = "arm,cortex-a73";
> +			reg = <0x0>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x1>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a73";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <2>;
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
> +		compatible = "arm,cortex-a73-pmu";
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
> +		tz_region: memory@4a600000 {
> +			reg = <0x0 0x4a600000 0x0 0x400000>;
> +			no-map;
> +		};
That's.. surprisingly little reserved memory.. No hyp? No PIL regions
that make the board explode when something touches them?

> +	};
> +
> +	soc: soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
Is 32 bits enough for this SoC's bus? Newer ones use 36 or more..

> +		compatible = "simple-bus";
> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq9574-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 65>;
> +			gpio-reserved-ranges = <59 1>;
I see it's assigned to [rx0, pwm23, qdss_tracedata_a].. Is this
board-specific or is this pin supposed to be forbidden on all IPQ9574
boards?

> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			uart2_pins: uart2-state {
> +				pins = "gpio34", "gpio35";
> +				function = "blsp2_uart";
> +				drive-strength = <8>;
> +				bias-disable;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,gcc-ipq9574";
> +			reg = <0x1800000 0x80000>;
> +			clocks = <&xo_board_clk>,
> +				<&sleep_clk>,
> +				<&bias_pll_ubi_nc_clk>,
> +				<&pcie30_phy0_pipe_clk>,
> +				<&pcie30_phy1_pipe_clk>,
> +				<&pcie30_phy2_pipe_clk>,
> +				<&pcie30_phy3_pipe_clk>,
> +				<&usb3phy_0_cc_pipe_clk>;
> +			clock-names = "xo",
> +				"sleep_clk",
> +				"bias_pll_ubi_nc_clk",
> +				"pcie30_phy0_pipe_clk",
> +				"pcie30_phy1_pipe_clk",
> +				"pcie30_phy2_pipe_clk",
> +				"pcie30_phy3_pipe_clk",
> +				"usb3phy_0_cc_pipe_clk";
Please touch up the indentation.

> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
> +		sdhc_1: sdhci@7804000 {
> +			compatible = "qcom,sdhci-msm-v5";
> +			reg = <0x7804000 0x1000>, <0x7805000 0x1000>;
> +			reg-names = "hc_mem", "cmdq_mem";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
> +				   <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
Please touch up the indentation.

> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&xo_board_clk>,
> +			       <&gcc GCC_SDCC1_AHB_CLK>,
> +			       <&gcc GCC_SDCC1_APPS_CLK>;
Please touch up the indentation.

> +			clock-names = "xo", "iface", "core";
The order should be "iface", "core", "xo" as per Documentation/devicetree/bindings/mmc/sdhci-msm.yaml

> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;
Are these the limitations of the controller? Otherwise they should
probably be moved to the device-specific DT.

> +			max-frequency = <384000000>;
> +			bus-width = <8>;

> +			non-removable;
And this property too.
> +			status = "disabled";
> +		};
> +
> +		blsp1_uart2: serial@78b1000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078b1000 0x200>;
> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			reg = <0x0b000000 0x1000>,  /* GICD */
> +			      <0x0b002000 0x1000>,  /* GICC */
> +			      <0x0b001000 0x1000>,  /* GICH */
> +			      <0x0b004000 0x1000>;  /* GICV */
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			interrupt-controller;
> +			#interrupt-cells = <3>;
> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			ranges = <0 0x0b00c000 0x3000>;
> +
> +			v2m0: v2m@0 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x0 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x1000 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m2: v2m@2 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x2000 0xffd>;
> +				msi-controller;
> +			};
> +		};
> +
> +		timer@b120000 {
> +			compatible = "arm,armv7-timer-mem";
> +			reg = <0xb120000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			clock-frequency = <24000000>;
Drop, something earlier in the boot chain already writes to CNTFRQ_ELn.

> +
> +			frame@b120000 {
> +				reg = <0xb121000 0x1000>,
> +				      <0xb122000 0x1000>;
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0xb123000 0x1000>;
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				reg = <0xb124000 0x1000>;
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0xb125000 0x1000>;
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0xb126000 0x1000>;
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0xb127000 0x1000>;
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0xb128000 0x1000>;
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
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
> +		clock-frequency = <24000000>;
Drop, something earlier in the boot chain already writes to CNTFRQ_ELn.

Konrad
> +	};
> +};
