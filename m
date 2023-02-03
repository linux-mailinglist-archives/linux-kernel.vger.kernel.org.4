Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70727688F25
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 06:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjBCFyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 00:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbjBCFyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 00:54:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E1465F2D;
        Thu,  2 Feb 2023 21:54:09 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3135IBQL002696;
        Fri, 3 Feb 2023 05:53:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MxrjjqCFQUgMQ+IgGFb6GZaIrDagvP4hFrw4yyeAE74=;
 b=iJe2dYZrwa8FC9O6+ab6AxVnZtdlLCx7eANjKbLyo/800nPu7LUL4VWPia+WKyom4v42
 UjaTA0AftnNdqB9cPZo0cgVggFUNtSabYjBjtg0uMiM64qM86Ky/JOqCwd4POgHfwmpm
 NYDmrIJ5KvIFQO+u86xJLLzMPIva2Bze5LXxcS6OY6jGXOcdo8PMgiZ5e1NvYVNVdV8d
 u2yt+l2XQnWQfbV+YgeOiqkHpcVKLELh/YxQ7ojBHbfFwHI4k6d44PV5jXJxHRzYE06I
 +4qxmt3XO+Zlm+o7mH/oNQ9/z1BkoG5xJWudDQJVUdEbgnqohAt/byC/ZwLJm6Ov8qcC 3w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfnyhmus7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 05:53:50 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3135rn7V026177
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 05:53:49 GMT
Received: from [10.50.53.202] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 2 Feb 2023
 21:53:41 -0800
Message-ID: <a8ff78da-61af-75e9-b4f5-e812a965f9c1@quicinc.com>
Date:   Fri, 3 Feb 2023 11:23:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V6 6/7] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     Devi Priya <quic_devipriy@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <shawnguo@kernel.org>,
        <arnd@arndb.de>, <marcel.ziswiler@toradex.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_poovendh@quicinc.com>
References: <20230202150619.22425-1-quic_devipriy@quicinc.com>
 <20230202150619.22425-7-quic_devipriy@quicinc.com>
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <20230202150619.22425-7-quic_devipriy@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0VZ0OStjosrofgi--DT3xdRSXdOY0yda
X-Proofpoint-ORIG-GUID: 0VZ0OStjosrofgi--DT3xdRSXdOY0yda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_02,2023-02-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030053
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/2/2023 8:36 PM, Devi Priya wrote:
> Add initial device tree support for Qualcomm IPQ9574 SoC and AL02 board
>
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/Makefile            |   1 +
>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  84 ++++++
>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 278 +++++++++++++++++++
>   3 files changed, 363 insertions(+)
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 557d77d48dc8..562952c76f7a 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
> +dtb-$(CONFIG_ARCH_QCOM) += ipq9574-al02-c7.dtb


Please use tab.


>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> new file mode 100644
> index 000000000000..2c8430197ec0
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 AL02-C7 board device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +/dts-v1/;
> +
> +#include "ipq9574.dtsi"
> +
> +/ {
> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
> +	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
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
> +	pinctrl-0 = <&sdc_default_state>;
> +	pinctrl-names = "default";
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	mmc-hs400-enhanced-strobe;
> +	max-frequency = <384000000>;
> +	bus-width = <8>;
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
> +			pins = "gpio5";
> +			function = "sdc_clk";
> +			drive-strength = <8>;
> +			bias-disable;
> +		};
> +
> +		cmd-pins {
> +			pins = "gpio4";
> +			function = "sdc_cmd";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		data-pins {
> +			pins = "gpio0", "gpio1", "gpio2",
> +			       "gpio3", "gpio6", "gpio7",
> +			       "gpio8", "gpio9";
> +			function = "sdc_data";
> +			drive-strength = <8>;
> +			bias-pull-up;
> +		};
> +
> +		rclk-pins {
> +			pins = "gpio10";
> +			function = "sdc_rclk";
> +			drive-strength = <8>;
> +			bias-pull-down;
> +		};
> +	};
> +};
> +
> +&xo_board_clk {
> +	clock-frequency = <24000000>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> new file mode 100644
> index 000000000000..2b86ba17bb32
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
> @@ -0,0 +1,278 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> +/*
> + * IPQ9574 SoC device tree source
> + *
> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> +
> +/ {
> +	interrupt-parent = <&intc>;
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	clocks {
> +		bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
> +			compatible = "fixed-clock";
> +			clock-frequency = <353000000>;
> +			#clock-cells = <0>;
> +		};
> +
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
> +		tz_region: tz@4a600000 {
> +			reg = <0x0 0x4a600000 0x0 0x400000>;
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
> +			compatible = "qcom,ipq9574-tlmm";
> +			reg = <0x01000000 0x300000>;
> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +			gpio-controller;
> +			#gpio-cells = <2>;
> +			gpio-ranges = <&tlmm 0 0 65>;
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
> +			compatible = "qcom,ipq9574-gcc";
> +			reg = <0x01800000 0x80000>;
> +			clocks = <&xo_board_clk>,
> +				 <&sleep_clk>,
> +				 <&bias_pll_ubi_nc_clk>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>,
> +				 <0>;
> +			clock-names = "xo",
> +				      "sleep_clk",
> +				      "bias_pll_ubi_nc_clk",
> +				      "pcie30_phy0_pipe_clk",
> +				      "pcie30_phy1_pipe_clk",
> +				      "pcie30_phy2_pipe_clk",
> +				      "pcie30_phy3_pipe_clk",
> +				      "usb3phy_0_cc_pipe_clk";
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +			#power-domain-cells = <1>;
> +		};
> +
> +		sdhc_1: mmc@7804000 {
> +			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
> +			reg-names = "hc", "cqhci";
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
> +				reg = <0x00000000 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m1: v2m@1000 {
> +				compatible = "arm,gic-v2m-frame";
> +				reg = <0x00001000 0xffd>;
> +				msi-controller;
> +			};
> +
> +			v2m2: v2m@2000 {
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
> +				reg = <0x0b121000 0x1000>,
> +				      <0x0b122000 0x1000>;
> +				frame-number = <0>;
> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +
> +			frame@b123000 {
> +				reg = <0x0b123000 0x1000>;
> +				frame-number = <1>;
> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b124000 {
> +				reg = <0x0b124000 0x1000>;
> +				frame-number = <2>;
> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b125000 {
> +				reg = <0x0b125000 0x1000>;
> +				frame-number = <3>;
> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b126000 {
> +				reg = <0x0b126000 0x1000>;
> +				frame-number = <4>;
> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b127000 {
> +				reg = <0x0b127000 0x1000>;
> +				frame-number = <5>;
> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
> +				status = "disabled";
> +			};
> +
> +			frame@b128000 {
> +				reg = <0x0b128000 0x1000>;
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
> +	};
> +};
