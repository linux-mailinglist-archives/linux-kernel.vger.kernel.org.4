Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A69685F10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 06:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjBAFiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 00:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBAFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 00:38:16 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C752F7B6;
        Tue, 31 Jan 2023 21:38:14 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3114hBtr026763;
        Wed, 1 Feb 2023 05:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PyOBXszOi5f70yjy1+vveBqK67JgpijjFqZ06K00oFU=;
 b=aEwcwVYQYO/oppWM6VzcbWO4EEm2qrdPwYBcAgehdY7R4o3FR8s6GNeBBhRSnHewfnuC
 Wc9zt69vt9mPPF+G5MixIDbY+gB0lq6BXrbbGdggX38bKkt3qlRU/deeg47bsFwuC9vY
 ZY+Rs9hT7ErqtPVq+JYeJ6hNOtJ3pviZsyWu4nNhkmIHxZXEFRkukPCaPCT94zRN5itW
 ZGHCUS8LF10Dgx+OS0JsMyJAhB58oRD28m4hkDOAeY8QmSyVqg5123Fz0+O1Zi40VfBB
 sA7ATXjaLFZ5RgSfWAzQptzb9bjEvVuCiqG6dhkDvvKLgA+HTyzhVZrZRnIif++uOz0W qg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nfbyq0s5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Feb 2023 05:37:54 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3115brFW008466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Feb 2023 05:37:53 GMT
Received: from [10.50.28.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 31 Jan
 2023 21:37:46 -0800
Message-ID: <038b0f5a-5be1-bb90-80f0-29203ad7c0f0@quicinc.com>
Date:   Wed, 1 Feb 2023 11:07:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH V2 8/9] arm64: dts: qcom: add IPQ5332 SoC and MI01.2 board
 support
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <dmitry.baryshkov@linaro.org>, <marcel.ziswiler@toradex.com>,
        <nfraprado@collabora.com>, <robimarko@gmail.com>,
        <quic_gurus@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230130114702.20606-1-quic_kathirav@quicinc.com>
 <20230130114702.20606-9-quic_kathirav@quicinc.com>
 <1d8777f7-ec11-b68c-629e-b17d5772396b@linaro.org>
Content-Language: en-US
From:   Kathiravan T <quic_kathirav@quicinc.com>
In-Reply-To: <1d8777f7-ec11-b68c-629e-b17d5772396b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bLZYQBKJ1E3-qY6vaLMMen9jAyYbuSyk
X-Proofpoint-GUID: bLZYQBKJ1E3-qY6vaLMMen9jAyYbuSyk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_02,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302010047
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/30/2023 5:55 PM, Konrad Dybcio wrote:
>
> On 30.01.2023 12:47, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Add initial device tree support for the Qualcomm IPQ5332 SoC and
>> MI01.2 board.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
> [...]
>
>> +
>> +	reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		tz_mem: tz@4a600000 {
>> +			no-map;
>> +			reg = <0x0 0x4a600000 0x0 0x200000>;
> reg should come before no-map


Ack. Will fix it in V3.


>
>
>> +		};
>> +	};
>> +
>> +	soc@0 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0 0xffffffff>;
>> +
>> +		tlmm: pinctrl@1000000 {
>> +			compatible = "qcom,ipq5332-tlmm";
>> +			reg = <0x01000000 0x300000>;
>> +			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>;
>> +			gpio-controller;
>> +			#gpio-cells = <2>;
>> +			gpio-ranges = <&tlmm 0 0 53>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <2>;
>> +
>> +			serial_0_pins: serial0-state {
>> +				pins = "gpio18", "gpio19";
>> +				function = "blsp0_uart0";
>> +				drive-strength = <8>;
>> +				bias-pull-up;
>> +			};
>> +		};
>> +
>> +		gcc: clock-controller@1800000 {
>> +			compatible = "qcom,ipq5332-gcc";
>> +			reg = <0x01800000 0x80000>;
>> +			#clock-cells = <1>;
>> +			#reset-cells = <1>;
>> +			#power-domain-cells = <1>;
>> +			clock-names = "xo",
>> +				      "sleep_clk",
>> +				      "pcie_2lane_phy_pipe_clk",
>> +				      "pcie_2lane_phy_pipe_clk_x1",
>> +				      "usb_pcie_wrapper_pipe_clk";
>> +			clocks = <&xo_board>,
>> +				 <&sleep_clk>,
>> +				 <0>,
>> +				 <0>,
>> +				 <0>;
>> +		};
>> +
>> +		sdhc: mmc@7804000 {
>> +			compatible = "qcom,ipq5332-sdhci", "qcom,sdhci-msm-v5";
>> +			reg = <0x07804000 0x1000>, <0x07805000 0x1000>;
>> +
>> +			interrupts = <GIC_SPI 313 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 316 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-names = "hc_irq", "pwr_irq";
>> +
>> +			clocks = <&gcc GCC_SDCC1_AHB_CLK>,
>> +				 <&gcc GCC_SDCC1_APPS_CLK>,
>> +				 <&xo_board>;
>> +			clock-names = "iface", "core", "xo";
>> +			mmc-ddr-1_8v;
>> +			mmc-hs200-1_8v;
>> +			max-frequency = <192000000>;
>> +			bus-width = <4>;
>> +			status = "disabled";
>> +		};
>> +
>> +		blsp1_uart0: serial@78af000 {
>> +			compatible = "qcom,msm-uartdm-v1.4", "qcom,msm-uartdm";
>> +			reg = <0x078af000 0x200>;
>> +			interrupts = <GIC_SPI 290 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&gcc GCC_BLSP1_UART1_APPS_CLK>,
>> +				 <&gcc GCC_BLSP1_AHB_CLK>;
>> +			clock-names = "core", "iface";
>> +			status = "disabled";
>> +		};
>> +
>> +		intc: interrupt-controller@b000000 {
>> +			compatible = "qcom,msm-qgic2";
>> +			reg = <0x0b000000 0x1000>,	/* GICD */
>> +			      <0x0b002000 0x1000>,	/* GICC */
>> +			      <0x0b001000 0x1000>,	/* GICH */
>> +			      <0x0b004000 0x1000>;	/* GICV */
>> +			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +			interrupt-controller;
>> +			#interrupt-cells = <3>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			ranges = <0 0x0b00c000 0x3000>;
>> +
>> +			v2m0: v2m@0 {
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x00000000 0xffd>;
>> +				msi-controller;
>> +			};
>> +
>> +			v2m1: v2m@1 {
>> +				compatible = "arm,gic-v2m-frame";
>> +				reg = <0x00001000 0xffd>;
> The unit address does not match the address part of the reg
> property, dtbs_check will not succeed..


Thanks, will update the node name accordingly in V3. AFAIR, I didn't see 
any dtbs_check warning. Let me cross check it again.


>
> The rest lgtm


Thanks a lot for the review!


>
> Konrad
>> +				msi-controller;
>> +			};
>> +
>> +			v2m2: v2m@2 {
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
>> +				interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +					     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <0>;
>> +			};
>> +
>> +			frame@b123000 {
>> +				reg = <0x0b123000 0x1000>;
>> +				interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <1>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b124000 {
>> +				reg = <0x0b124000 0x1000>;
>> +				interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <2>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b125000 {
>> +				reg = <0x0b125000 0x1000>;
>> +				interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <3>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b126000 {
>> +				reg = <0x0b126000 0x1000>;
>> +				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <4>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b127000 {
>> +				reg = <0x0b127000 0x1000>;
>> +				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <5>;
>> +				status = "disabled";
>> +			};
>> +
>> +			frame@b128000 {
>> +				reg = <0x0b128000 0x1000>;
>> +				interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
>> +				frame-number = <6>;
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
