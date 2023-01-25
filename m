Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC3867BF73
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjAYV7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjAYV7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:59:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C271115C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:59:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id v6so262610ejg.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 13:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lX+y5Lyf2JUzoB4lGwRgfeGfOebGswBkxxo9RBt49bk=;
        b=Ef00RJtr2R+jYmtvrUQYJBLnsvollU9Qa1nT4g93570szJn2axTRQ63x4P+befLZTo
         IszCGPD531xk9xDjdLrbW9H2EfFBTRLcQPeTyzD4cFEMzLjqMP2JJwceH/U5J3ZMTeY/
         V/2wXnMPjOvpgwsou3DS0tBovGFQY7uSsLo+pH4Muaak8p6FyYqag+z3qvqVQAKe+73s
         dGGI1vUEAfNyHRgzMdgk8VDQqIANUyV2jnoHe+Kk/LFIzlpF1oswqB9uIA+htH6Liiti
         QRK5C8x2JeAj0GNRCOlI1JcD4TgNAWWi3pYPozRmqtYLA7kDnN1s0lNIsKCsw41ffVCN
         tnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lX+y5Lyf2JUzoB4lGwRgfeGfOebGswBkxxo9RBt49bk=;
        b=7qAhu2x8zUZFentc1JIpW9kJGUQrDC5tmlr+t/ubkbE72LY7opgZ3uqsrWFzFCMBJ7
         GGuauK9+qiv256YGgCly7fTQnwDeufgvUpc7WkTV2Yv5J8V3rApkt/aGoIxox1IHONL5
         rcpUoSfNRuJJZsxPVI2BMSOcPdlDvTruIPXTXa702wuKjCl63M87mt+R5IWEmafbAwhc
         4OACYADpemK0A2cQ9feppLja9MhRxvM6oZNhCnnD3aanJLBscWg4gMN57ixK6FhVfDgY
         fqv0xye9nUewDuGOAcjzJ0TBUuWimfoFdS1BoXvKOQRt3DZ1wrVtfCKOHSPeMbqK22JE
         tCbg==
X-Gm-Message-State: AFqh2krdSOhNSlStin8XE8pMxKk+N3WmKAPQCMcGBMaJDiTeOj7N9HkK
        2lzK4wQT/iMMWu93KYwTf8MVPC0ZhpLclmbk
X-Google-Smtp-Source: AMrXdXtr88D3wQCnZsRcn6mDIPFvkGt5bRFcuBUgXntecSY5vyksSr6/7/hT38BC7BZr5dZTVUaSUA==
X-Received: by 2002:a17:906:1798:b0:84d:43e4:3633 with SMTP id t24-20020a170906179800b0084d43e43633mr32539874eje.36.1674683974279;
        Wed, 25 Jan 2023 13:59:34 -0800 (PST)
Received: from [192.168.1.101] (abyk108.neoplus.adsl.tpnet.pl. [83.9.30.108])
        by smtp.gmail.com with ESMTPSA id sg16-20020a170907a41000b00870d3fdceb9sm2937003ejc.89.2023.01.25.13.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 13:59:33 -0800 (PST)
Message-ID: <f0312e77-0835-7f79-acf0-3d91d6548f07@linaro.org>
Date:   Wed, 25 Jan 2023 22:59:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 09/10] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board
 support
Content-Language: en-US
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, marcel.ziswiler@toradex.com,
        dmitry.baryshkov@linaro.org, nfraprado@collabora.com,
        broonie@kernel.org, robimarko@gmail.com, quic_gurus@quicinc.com,
        bhupesh.sharma@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-10-quic_kathirav@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230125104520.89684-10-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25.01.2023 11:45, Kathiravan Thirumoorthy wrote:
> From: Kathiravan T <quic_kathirav@quicinc.com>
> 
> Add initial device tree support for the Qualcomm IPQ5332 SoC and
> MI01.2 board.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/Makefile           |   1 +
>  arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts |  71 +++++
>  arch/arm64/boot/dts/qcom/ipq5332.dtsi       | 273 ++++++++++++++++++++
>  3 files changed, 345 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq5332.dtsi
> 
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 3e79496292e7..fbd5bc583a9b 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -3,6 +3,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= apq8016-sbc.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8094-sony-xperia-kitakami-karin_windy.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-db820c.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= apq8096-ifc6640.dtb
> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq5332-mi01.2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>  dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> new file mode 100644
> index 000000000000..7984d8f824ce
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332-mi01.2.dts
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ5332 AP-MI01.2 board device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq5332.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ5332/AP-MI01.2";
> +	compatible = "qcom,ipq5332-ap-mi01.2", "qcom,ipq5332";
> +
> +	aliases {
> +		serial0 = &blsp1_uart0;
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0";
> +	};
> +};
> +
> +&blsp1_uart0 {
> +	pinctrl-0 = <&serial_0_pins>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +};
> +
> +&sdhc {
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&sleep_clk {
> +	clock-frequency = <32000>;
> +};
> +
> +&xo_board {
> +	clock-frequency = <24000000>;
> +};
> +
> +/* PINCTRL */
> +
> +&tlmm {
> +	sdc_default_state: sdc-default-state {
> +		clk-pins {
> +			pins = "gpio13";
> +			function = "sdc_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "gpio12";
> +			function = "sdc_cmd";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "gpio8", "gpio9", "gpio10", "gpio11";
> +			function = "sdc_data";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> new file mode 100644
> index 000000000000..d04244a3cd3a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
> @@ -0,0 +1,273 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * IPQ5332 device tree source
> + *
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/clock/qcom,gcc-ipq5332.h>
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
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
> +		xo_board: xo-board-clk {
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
> +		CPU2: cpu@2 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x2>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		CPU3: cpu@3 {
> +			device_type = "cpu";
> +			compatible = "arm,cortex-a53";
> +			reg = <0x3>;
> +			enable-method = "psci";
> +			next-level-cache = <&L2_0>;
> +		};
> +
> +		L2_0: l2-cache {
> +			compatible = "cache";
> +			cache-level = <0x2>;
> +		};
> +	};
> +
> +	firmware {
> +		scm {
> +			compatible = "qcom,scm-ipq5332", "qcom,scm";
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
> +		tz: memory@4a600000 {
memory@ is discouraged, the node name should be somewhat
descriptive of what lies in this reserved region. On the
other hand, tz: sounds like a label to a trust zone device
of some kind. I propose:

tz_mem: tz@4a600000 {

instead.

> +			no-map;
> +			reg = <0x0 0x4a600000 0x0 0x200000>;
> +		};
> +	};
> +
> +	soc@0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0 0xffffffff>;
> +		compatible = "simple-bus";
Move compatible first, please.

> +
> +		tlmm: pinctrl@1000000 {
> +			compatible = "qcom,ipq5332-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 53>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
> +
> +			serial_0_pins: serial0-state {
You may be interested in having a suspend state for this
one, so you may wish to rename this futureproofing-ly to
serial0-active-state.

> +				pins = "gpio18", "gpio19";
> +				function = "blsp0_uart0";
> +				drive-strength = <8>;
> +				bias-pull-up;
> +			};
> +		};
> +
> +		gcc: clock-controller@1800000 {
> +			compatible = "qcom,ipq5332-gcc";
> +			reg = <0x01800000 0x80000>;
> +			#clock-cells = <0x1>;
> +			#reset-cells = <0x1>;
Decimal values for -cells, please.

> +			#power-domain-cells = <1>;
> +			clock-names = "xo",
> +				      "sleep_clk",
> +				      "pcie_2lane_phy_pipe_clk",
> +				      "pcie_2lane_phy_pipe_clk_x1",
> +				      "usb_pcie_wrapper_pipe_clk";
> +			clocks = <&xo_board>,
> +				 <&sleep_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +		};
> +
> +		sdhc: mmc@7804000 {
> +			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
> +
> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
> +				 <&gcc GCC_SDCC1_APPS_CLK>,
> +				 <&xo_board>;
> +			clock-names = "iface", "core", "xo";
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			max-frequency = <192000000>;
As Krzysztof pointed out, this one should go.

> +			bus-width = <4>;
Oh that's interesting.. a 4-wide bus for eMMC?

> +			status = "disabled";
> +		};
> +
> +		blsp1_uart0: serial@78af000 {
> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
> +			reg = <0x078af000 0x200>;
> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
> +				 <&gcc GCC_BLSP1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +			status = "disabled";
> +		};
> +
> +		intc: interrupt-controller@b000000 {
> +			compatible = "qcom,msm-qgic2";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
Please move these two above ranges..

> +			interrupt-controller;
> +			#interrupt-cells = <0x3>;
Decimal value, please.

> +			reg = <0x0b000000 0x1000>,	/* GICD */
> +			      <0x0b002000 0x1000>,	/* GICC */
> +			      <0x0b001000 0x1000>,	/* GICH */
> +			      <0x0b004000 0x1000>;	/* GICV */
..and reg just below compatible...

> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;

..and interrupts just below reg, please.

> +			ranges = <0 0x0b00c000 0x3000>;
> +
> +			v2m0: v2m@0 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x0 0xffd>;
Please pad the reg for consistency.

> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m2: v2m@2 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00002000 0xffd>;
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
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
reg
interrupts
frame-number

would be more consistent with most other nodes.

> +			};
> +
> +			frame@b123000 {
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b123000 0x1000>;
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
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b125000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b126000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b127000 0x1000>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				frame-number = <6>;
> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
> +				reg = <0x0b128000 0x1000>;
> +				status = "disabled";
> +			};
> +		};
> +
> +	};
> +
> +	timer {
> +		compatible = "arm,armv8-timer";
> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
> +				<GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
The indentation seems off here.

Konrad
> +	};
> +};
