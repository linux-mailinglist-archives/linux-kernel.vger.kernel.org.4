Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58AE6790BE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 07:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjAXGR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 01:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjAXGR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 01:17:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888C2DE6F;
        Mon, 23 Jan 2023 22:17:25 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30O5PcU7028447;
        Tue, 24 Jan 2023 06:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=k5XtAdI6pDnsLjE1zyevTiL0NTDbva/Iw9xlkmbclIc=;
 b=heXBzO/5x8c19zN7aec5f0aPjJcEonXN8k9JErC3PKR4etvlaMc1OYq41cTDjg4YIF/v
 RWL+Se4FdS1Wvw1vSE8VQ9byrXKOELrSZeUZsbOa9IcIu/LxkXuCF+rVd+pGtmLJ85We
 ShRUHy654m63sYqsTc9d9QKvtG4VMJXrSm1MxBnEgFZKJPGkEeV1HV6lYeloCSJVQJsA
 io6RuwEIGEgd9+unmi4+4rQC67Cq3ka6x0lp2+BFQ2e7JUnZMrKVsQGrrVf8cTAAWSOr
 m0rV9+Abgpdm6NEDg2FfziBC6lyopvQLQDDngh1+/9q6Bar3rfvj8k2jmz9A6OBWmYkQ zQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n89pwcghd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 06:16:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30O6GXAw013727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 06:16:33 GMT
Received: from [10.216.24.6] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 23 Jan
 2023 22:16:24 -0800
Message-ID: <8325038d-e6cd-3116-647e-6baeba09634f@quicinc.com>
Date:   Tue, 24 Jan 2023 11:46:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6/7] arm64: dts: Add ipq9574 SoC and AL02 board support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <tdas@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230110121316.24892-1-quic_devipriy@quicinc.com>
 <20230110121316.24892-7-quic_devipriy@quicinc.com>
 <9a584aa9-52f1-2c1b-db93-45f0302641dc@linaro.org>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <9a584aa9-52f1-2c1b-db93-45f0302641dc@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJHDJP1MIn6yPur2eR8lmba4SwHGbbrc
X-Proofpoint-GUID: TJHDJP1MIn6yPur2eR8lmba4SwHGbbrc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240056
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/10/2023 6:20 PM, Konrad Dybcio wrote:
> 
> 
> On 10.01.2023 13:13, devi priya wrote:
>> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
>>
>> Add initial device tree support for Qualcomm IPQ9574 SoC
>> and AL02 board
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> Signed-off-by: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/Makefile            |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  69 ++++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 318 +++++++++++++++++++
>>   3 files changed, 388 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 3e79496292e7..872c62028a0b 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)	+= ipq9574-al02-c7.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-huawei-g7.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> new file mode 100644
>> index 000000000000..ae3c32f3e16a
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
> BSD3?
> 
Sure, will add dual license
>> +/*
>> + * IPQ9574 AL02-C7 board device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
> Happy new year!
> 
Sure, will update!
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq9574.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>> +	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>> +	interrupt-parent = <&intc>;
>> +
>> +	aliases {
>> +		serial0 = &blsp1_uart2;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +};
>> +
>> +&blsp1_uart2 {
>> +	pinctrl-0 = <&uart2_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +	pinctrl-0 = <&emmc_pins>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&tlmm {
>> +	emmc_pins: emmc-state {
> sdc_default? I suppose you'll introduce a corresponding sleep state
> later on, so that'll be easier to distinguish.
Sure, will update the node name. But, we don't have power management 
states. It would always be in the running state.
> 
>> +		emmc-clk-pins {
>> +			pins = "gpio5";
>> +			function = "sdc_clk";
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
> Please add a newline between subsequent nodes.
Sure, okay
>> +		emmc-cmd-pins {
>> +			pins = "gpio4";
>> +			function = "sdc_cmd";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +		emmc-data-pins {
>> +			pins = "gpio0", "gpio1", "gpio2",
>> +			     "gpio3", "gpio6", "gpio7",
>> +			     "gpio8", "gpio9";
> The indentation here is wrong.
Sure, will update
> 
>> +			function = "sdc_data";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +		emmc-rclk-pins {
>> +			pins = "gpio10";
>> +			function = "sdc_rclk";
>> +			drive-strength = <8>;
>> +			bias-pull-down;
>> +		};
>> +	};
>> +
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> new file mode 100644
>> index 000000000000..188d18688a77
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -0,0 +1,318 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * IPQ9574 SoC device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,gcc-ipq9574.h>
>> +#include <dt-bindings/reset/qcom,gcc-ipq9574.h>
>> +
>> +/ {
>> +	interrupt-parent = <&intc>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	clocks {
>> +		bias_pll_ubi_nc_clk: bias_pll_ubi_nc_clk {
> Could you tell us something about the purpose of this clock? First
> time seeing it, your gcc driver reveals it's connected to at least
> PCIe.
Bias_pll_ubi_nc_clk (353MHz) is a backup source for 
Q6_AXIM2_CLK/PCIE2_AXIM_CLK/PCIE3_AXIM_CLK/SNOC-CLK.
> 
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <353000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <250000000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <125000000>;
>> +			#clock-cells = <0>;
>> +		};
> Do not define these pipe clocks. You can leave the GCC entries as <0>
> until you introduce the QMPPHY support, which then you can feed as it
> provides these clocks.
Sure, okay
> 
>> +
>> +		sleep_clk: sleep-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <32000>;
>> +			#clock-cells = <0>;
>> +		};
>> +
>> +		xo_board_clk: xo-board-clk {
>> +			compatible = "fixed-clock";
>> +			clock-frequency = <24000000>;
> The clock frequency should be moved to the device DT, because the
> clock is on the board and not on the SoC.
Okay, will move to device DT
> 
>> +			#clock-cells = <0>;
>> +		};
>> +	};
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CPU0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a73";
>> +			reg = <0x0>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a73";
>> +			reg = <0x1>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a73";
>> +			reg = <0x2>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		CPU3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a73";
>> +			reg = <0x3>;
>> +			enable-method = "psci";
>> +			next-level-cache = <&L2_0>;
>> +		};
>> +
>> +		L2_0: l2-cache {
>> +			compatible = "cache";
>> +			cache-level = <2>;
>> +		};
>> +	};
>> +
>> +	memory@40000000 {
>> +		device_type = "memory";
>> +		/* We expect the bootloader to fill in the size */
>> +		reg = <0x0 0x40000000 0x0 0x0>;
>> +	};
>> +
>> +	pmu {
>> +		compatible = "arm,cortex-a73-pmu";
>> +		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-1.0";
>> +		method = "smc";
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		tz_region: memory@4a600000 {
>> +			reg = <0x0 0x4a600000 0x0 0x400000>;
>> +			no-map;
>> +		};
> That's.. surprisingly little reserved memory.. No hyp? No PIL regions
> that make the board explode when something touches them?
> 
The reserved memory for TZ region is 4Mb. yes,we have hypervisor and PIL 
regions.
The memory for PIL region will be separately reserved by the remoteproc
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
> Is 32 bits enough for this SoC's bus? Newer ones use 36 or more..
Yes, as the maximum range supported by ipq9574 is 4GB, 32 bits would be 
sufficient
> 
>> +		compatible = "simple-bus";
>> +
>> +		tlmm: pinctrl@1000000 {
>> +			compatible = "qcom,ipq9574-tlmm";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 65>;
>> +			gpio-reserved-ranges = <59 1>;
> I see it's assigned to [rx0, pwm23, qdss_tracedata_a].. Is this
> board-specific or is this pin supposed to be forbidden on all IPQ9574
> boards?
This pin is reserved by TZ and is forbidden on all IPQ9574 boards.
> 
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +
>> +			uart2_pins: uart2-state {
>> +				pins = "gpio34", "gpio35";
>> +				function = "blsp2_uart";
>> +				drive-strength = <8>;
>> +				bias-disable;
>> +			};
>> +		};
>> +
>> +		gcc: clock-controller@1800000 {
>> +			compatible = "qcom,gcc-ipq9574";
>> +			reg = <0x1800000 0x80000>;
>> +			clocks = <&xo_board_clk>,
>> +				<&sleep_clk>,
>> +				<&bias_pll_ubi_nc_clk>,
>> +				<&pcie30_phy0_pipe_clk>,
>> +				<&pcie30_phy1_pipe_clk>,
>> +				<&pcie30_phy2_pipe_clk>,
>> +				<&pcie30_phy3_pipe_clk>,
>> +				<&usb3phy_0_cc_pipe_clk>;
>> +			clock-names = "xo",
>> +				"sleep_clk",
>> +				"bias_pll_ubi_nc_clk",
>> +				"pcie30_phy0_pipe_clk",
>> +				"pcie30_phy1_pipe_clk",
>> +				"pcie30_phy2_pipe_clk",
>> +				"pcie30_phy3_pipe_clk",
>> +				"usb3phy_0_cc_pipe_clk";
> Please touch up the indentation.
> 
Sure okay
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +		};
>> +
>> +		sdhc_1: sdhci@7804000 {
>> +			compatible = "qcom,sdhci-msm-v5";
>> +			reg = <0x7804000 0x1000>, <0x7805000 0x1000>;
>> +			reg-names = "hc_mem", "cmdq_mem";
>> +
>> +			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>> +				   <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> Please touch up the indentation.
Okay
> 
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&xo_board_clk>,
>> +			       <&gcc GCC_SDCC1_AHB_CLK>,
>> +			       <&gcc GCC_SDCC1_APPS_CLK>;
> Please touch up the indentation.
> 
Sure, will do
>> +			clock-names = "xo", "iface", "core";
> The order should be "iface", "core", "xo" as per Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
Got it, will update
> 
>> +			mmc-ddr-1_8v;
>> +			mmc-hs200-1_8v;
>> +			mmc-hs400-1_8v;
>> +			mmc-hs400-enhanced-strobe;
> Are these the limitations of the controller? Otherwise they should
> probably be moved to the device-specific DT.
Yes, these are specific to the controller, hence added them in SoC
> 
>> +			max-frequency = <384000000>;
>> +			bus-width = <8>;
> 
>> +			non-removable;
> And this property too.
Yes, it is specific to the controller
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp1_uart2: serial@78b1000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078b1000 0x200>;
>> +			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART3_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>> +
>> +		intc: interrupt-controller@b000000 {
>> +			compatible = "qcom,msm-qgic2";
>> +			reg = <0x0b000000 0x1000>,  /* GICD */
>> +			      <0x0b002000 0x1000>,  /* GICC */
>> +			      <0x0b001000 0x1000>,  /* GICH */
>> +			      <0x0b004000 0x1000>;  /* GICV */
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			ranges = <0 0x0b00c000 0x3000>;
>> +
>> +			v2m0: v2m@0 {
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x0 0xffd>;
>> +				msi-controller;
>> +			};
>> +
>> +			v2m1: v2m@1 {
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x1000 0xffd>;
>> +				msi-controller;
>> +			};
>> +
>> +			v2m2: v2m@2 {
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x2000 0xffd>;
>> +				msi-controller;
>> +			};
>> +		};
>> +
>> +		timer@b120000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0xb120000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +			clock-frequency = <24000000>;
> Drop, something earlier in the boot chain already writes to CNTFRQ_ELn.
> 
Sure, okay
>> +
>> +			frame@b120000 {
>> +				reg = <0xb121000 0x1000>,
>> +				      <0xb122000 0x1000>;
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			frame@b123000 {
>> +				reg = <0xb123000 0x1000>;
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b124000 {
>> +				reg = <0xb124000 0x1000>;
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b125000 {
>> +				reg = <0xb125000 0x1000>;
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b126000 {
>> +				reg = <0xb126000 0x1000>;
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b127000 {
>> +				reg = <0xb127000 0x1000>;
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b128000 {
>> +				reg = <0xb128000 0x1000>;
>> +				frame-number = <6>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts = <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			     <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		clock-frequency = <24000000>;
> Drop, something earlier in the boot chain already writes to CNTFRQ_ELn.
> 
Okay
> Konrad
>> +	};
>> +};
Best Regards,
Devi Priya
