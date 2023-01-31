Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3088682ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjAaKmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:42:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjAaKmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:42:06 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578AC34038;
        Tue, 31 Jan 2023 02:42:04 -0800 (PST)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30V5UTIm000912;
        Tue, 31 Jan 2023 10:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iKkNf0L9heYRi4sfoswTm/mTkhsfIhxq0Gt1gSuru3E=;
 b=YydTrergHA5KPR8ZL65UiZy9tcgMmHt7k2OaiTSLINi4b9fSyVQ4phoVKYe02bXQlk2y
 XxXWUCKvVmAy8o+QBiMJO+YvZAU9xBPEIFjZjYVoHGjqRrWNjUr9dwi11Ms7H7wSQI/U
 wnecH/6SxmqSi2Vp/mJOv4KVx1Bx2Q653XacYBp9E6zZAL8vkhd8IgukY8Sa180gP0zZ
 y8hfapoXcX2anL2boTn/Q+MhpmmYYaHbzJZXhAHntYGNQ5KnKmhqJrysi6yO8sAIzcGl
 tW4tLu2KSzEeATNcEThY/3ZV1XpywmpGp3P2z/Q2e7l2cmEXluUG+zgaKHc0G6SELyqF Bg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3neuwc8xv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 10:41:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30VAfC2I007494
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 10:41:12 GMT
Received: from [10.50.40.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 02:41:04 -0800
Message-ID: <9d06de84-78cc-0d8b-87bf-004d4cedd598@quicinc.com>
Date:   Tue, 31 Jan 2023 16:11:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 6/7] arm64: dts: qcom: Add ipq9574 SoC and AL02 board
 support
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230130125528.11509-1-quic_devipriy@quicinc.com>
 <20230130125528.11509-7-quic_devipriy@quicinc.com>
 <a1171edc-f1f2-da95-b0b4-81e3f5f7935d@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <a1171edc-f1f2-da95-b0b4-81e3f5f7935d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s2ppZM4fyezpoQlZEJM01tyft4FYLbaI
X-Proofpoint-ORIG-GUID: s2ppZM4fyezpoQlZEJM01tyft4FYLbaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310092
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 5:25 AM, Konrad Dybcio wrote:
> 
> 
> On 30.01.2023 13:55, devi priya wrote:
>> Add initial device tree support for Qualcomm IPQ9574 SoC
>> and AL02 board
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V3:
>>          - Updated the order of signed-offs
>>
>>   Changes in V2:
>>          - Updated the node name - emmc_pins to sdc_default_state
>>          - Moved the xo and sleep clock frequency to board DT
>>          - Removed the pipe clock definitions
>>          - Dropped clock frequency property for timer nodes
>>          - Added qcom,ipq9574-sdhci compatible string
>>          - Updated the copyright year to 2023
>>          - Corrected the indentations
>>
>>   arch/arm64/boot/dts/qcom/Makefile            |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  78 +++++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 285 +++++++++++++++++++
>>   3 files changed, 364 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index b0423ca3e79f..ff40e86181d4 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -7,6 +7,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= ipq6018-cp01-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk01.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= ipq8074-hk10-c2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM) += ipq9574-al02-c7.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-acer-a1-724.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)	+= msm8916-asus-z00l.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> new file mode 100644
>> index 000000000000..4aa06e4f63c7
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 AL02-C7 board device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "ipq9574.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>> +	compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
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
>> +	pinctrl-0 = <&sdc_default_state>;
>> +	pinctrl-names = "default";
>> +	status = "okay";
>> +};
>> +
>> +&sleep_clk {
>> +	clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +	sdc_default_state: sdc-default-state {
>> +		clk-pins {
>> +			pins = "gpio5";
>> +			function = "sdc_clk";
>> +			drive-strength = <8>;
>> +			bias-disable;
>> +		};
>> +
>> +		cmd-pins {
>> +			pins = "gpio4";
>> +			function = "sdc_cmd";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		data-pins {
>> +			pins = "gpio0", "gpio1", "gpio2",
>> +				"gpio3", "gpio6", "gpio7",
>> +				"gpio8", "gpio9";
> The second and third rows are still incorrectly indented.
okay. will correct it.
> 
>> +			function = "sdc_data";
>> +			drive-strength = <8>;
>> +			bias-pull-up;
>> +		};
>> +
>> +		rclk-pins {
>> +			pins = "gpio10";
>> +			function = "sdc_rclk";
>> +			drive-strength = <8>;
>> +			bias-pull-down;
>> +		};
>> +	};
> 
> [...]
> 
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		tz_region: memory@4a600000 {
> tz@
> 
Sure
>> +			reg = <0x0 0x4a600000 0x0 0x400000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>> +	soc: soc@0 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +		compatible = "simple-bus";
> compatible first, please
> 
Sure, okay
>> +
>> +		tlmm: pinctrl@1000000 {
>> +			compatible = "qcom,ipq9574-tlmm";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 65>;
>> +			gpio-reserved-ranges = <59 1>;
> It's reserved in the pinctrl driver, no need to do it again here.
> 
Okay, got it.
> 
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +
>> +			uart2_pins: uart2-state {
>> +				pins = "gpio34", "gpio35";
> 
> [...]
> 
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
>> +				reg = <0x00001000 0xffd>;
> Unit address must match the address part of the reg property.
> 
Okay
>> +				msi-controller;
>> +			};
>> +
>> +			v2m2: v2m@2 {
> And here.
> 
Okay
> Konrad
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x00002000 0xffd>;
>> +				msi-controller;
>> +			};
>> +		};
>> +
>> +		timer@b120000 {
>> +			compatible = "arm,armv7-timer-mem";
>> +			reg = <0x0b120000 0x1000>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges;
>> +
>> +			frame@b120000 {
>> +				reg = <0x0b121000 0x1000>,
>> +				      <0x0b122000 0x1000>;
>> +				frame-number = <0>;
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +			};
>> +
>> +			frame@b123000 {
>> +				reg = <0x0b123000 0x1000>;
>> +				frame-number = <1>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b124000 {
>> +				reg = <0x0b124000 0x1000>;
>> +				frame-number = <2>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b125000 {
>> +				reg = <0x0b125000 0x1000>;
>> +				frame-number = <3>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b126000 {
>> +				reg = <0x0b126000 0x1000>;
>> +				frame-number = <4>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b127000 {
>> +				reg = <0x0b127000 0x1000>;
>> +				frame-number = <5>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b128000 {
>> +				reg = <0x0b128000 0x1000>;
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
>> +	};
>> +};
Best Regards,
Devi Priya
