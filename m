Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28656A9706
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjCCMKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjCCMKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:10:41 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB2715565;
        Fri,  3 Mar 2023 04:10:39 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3236PJk8006523;
        Fri, 3 Mar 2023 12:10:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=W27oQmmqd80ebHmdHi5E+YAa2BMVJDVjNpmnAIgPR3c=;
 b=QIWBRS/4h+6eNeIS9LDXI61p/OJaKLw9pnZGlDQx4CYp0TGPhHKWxwnHOd3vHbrIGo/P
 2ZvegiZwsl2wB1autPhHYjNj8pFjBlxWr03zdf+mTdyWzhC9YyT/4oIBXS06hwzS/2X4
 je3wlrJ3aMvdA//caDLQw6Q/J6OGc9N/ef8xLrOv9yBvvn5saHD4JkJDXQL0VgQFJLhp
 Z/LxrJLh+0he5PTxA2inbvntWuf5gb/i3a7vLbs4D56K7LQDtuAnF+JBKDP/aPyi1HsE
 EcWSPuaWVZpnMU2RoX4jFRZlcfKpiPOw3u4u7nsTZoBI7sfEL5mOo7BSfvpyUPzIDbsc bg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2veeubmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 12:10:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 323CAFrh006760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 12:10:15 GMT
Received: from [10.216.12.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 3 Mar 2023
 04:10:05 -0800
Message-ID: <7c12c509-dde5-413d-0ff6-6520029d5c59@quicinc.com>
Date:   Fri, 3 Mar 2023 17:39:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 7/7] arm64: dts: qcom: ipq9574: Add PCIe PHYs and
 controller nodes
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <mani@kernel.org>, <p.zabel@pengutronix.de>,
        <svarbanov@mm-sol.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-clk@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230214164135.17039-1-quic_devipriy@quicinc.com>
 <20230214164135.17039-8-quic_devipriy@quicinc.com>
 <d3403424-4adc-26d6-3a98-1807361fe0fc@quicinc.com>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <d3403424-4adc-26d6-3a98-1807361fe0fc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WHzwb6d0XtHZfE2SEet-ozEqsYIT9GfL
X-Proofpoint-GUID: WHzwb6d0XtHZfE2SEet-ozEqsYIT9GfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 bulkscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030105
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2023 12:27 PM, Kathiravan T wrote:
> 
> On 2/14/2023 10:11 PM, Devi Priya wrote:
>> Add PCIe0, PCIe1, PCIe2, PCIe3 (and corresponding PHY) devices
>> found on IPQ9574 platform. The PCIe0 & PCIe1 are 1-lane Gen3
>> host whereas PCIe2 & PCIe3 are 2-lane Gen3 host.
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts |  28 ++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi        | 477 ++++++++++++++++++-
>>   2 files changed, 499 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts 
>> b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> index 2c8430197ec0..21b53f34ce84 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-al02-c7.dts
>> @@ -8,6 +8,7 @@
>>   /dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>>   #include "ipq9574.dtsi"
>>   / {
>> @@ -29,6 +30,33 @@
>>       status = "okay";
>>   };
>> +&pcie1_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie1_x1 {
>> +    perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>> +&pcie2_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie2_x2 {
>> +    perst-gpios = <&tlmm 29 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>> +&pcie3_phy {
>> +    status = "okay";
>> +};
>> +
>> +&pcie3_x2 {
>> +    perst-gpios = <&tlmm 32 GPIO_ACTIVE_LOW>;
>> +    status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>       pinctrl-0 = <&sdc_default_state>;
>>       pinctrl-names = "default";
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi 
>> b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> index 062f80798ebb..a32dbdeb5bed 100644
>> --- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -6,8 +6,8 @@
>>    * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights 
>> reserved.
>>    */
>> -#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>   / {
>> @@ -22,11 +22,41 @@
>>               #clock-cells = <0>;
>>           };
>> +        pcie30_phy0_pipe_clk: pcie30_phy0_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy1_pipe_clk: pcie30_phy1_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy2_pipe_clk: pcie30_phy2_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>> +        pcie30_phy3_pipe_clk: pcie30_phy3_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <250000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>>           sleep_clk: sleep-clk {
>>               compatible = "fixed-clock";
>>               #clock-cells = <0>;
>>           };
>> +        usb3phy_0_cc_pipe_clk: usb3phy_0_cc_pipe_clk {
>> +            compatible = "fixed-clock";
>> +            clock-frequency = <125000000>;
>> +            #clock-cells = <0>;
>> +        };
>> +
>>           xo_board_clk: xo-board-clk {
>>               compatible = "fixed-clock";
>>               #clock-cells = <0>;
>> @@ -121,6 +151,155 @@
>>           #size-cells = <1>;
>>           ranges = <0 0 0 0xffffffff>;
>> +        pcie0_phy: phy@84000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +            reg = <0x00084000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +            clocks = <&gcc GCC_PCIE0_AUX_CLK>,
>> +                 <&gcc GCC_PCIE0_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE0_1LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE0_1LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE0_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE0_PHY_BCR>,
>> +                 <&gcc GCC_PCIE0PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie0_lane: phy@84200 {
>> +                reg = <0x00084200 0x16c>, /* Serdes Tx */
>> +                      <0x00084400 0x200>, /* Serdes Rx */
>> +                      <0x00084800 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x00084c00 0xf4>;  /* pcs_misc */
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE0_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie0_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie2_phy: phy@8c000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +            reg = <0x0008c000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE2_AUX_CLK>,
>> +                 <&gcc GCC_PCIE2_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE2_2LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE2_2LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE2_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE2_PHY_BCR>,
>> +                 <&gcc GCC_PCIE2PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie2_lanes: phy@8c200 {
>> +                reg = <0x0008c200 0x16c>, /* Serdes Tx0 */
>> +                      <0x0008c400 0x200>, /* Serdes Rx0 */
>> +                      <0x0008d000 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x0008c600 0x16c>, /* Serdes Tx1 */
>> +                      <0x0008c800 0x200>, /* Serdes Rx1 */
>> +                      <0x0008d400 0x0f8>; /* pcs_misc */
>> +
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE2_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie2_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie3_phy: phy@f4000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x2-pcie-phy";
>> +            reg = <0x000f4000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE3_AUX_CLK>,
>> +                 <&gcc GCC_PCIE3_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE3_2LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE3_2LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE3_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE3_PHY_BCR>,
>> +                 <&gcc GCC_PCIE3PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie3_lanes: phy@f4200 {
>> +                reg = <0x000f4200 0x16c>, /* Serdes Tx0 */
>> +                      <0x000f4400 0x200>, /* Serdes Rx0 */
>> +                      <0x000f5000 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x000f4600 0x16c>, /* Serdes Tx1 */
>> +                      <0x000f4800 0x200>, /* Serdes Rx1 */
>> +                      <0x000f5400 0x0f8>; /* pcs_misc */
>> +
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE3_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie3_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>> +        pcie1_phy: phy@fc000 {
>> +            compatible = "qcom,ipq9574-qmp-gen3x1-pcie-phy";
>> +            reg = <0x000fc000 0x1bc>; /* Serdes PLL */
>> +            #address-cells = <1>;
>> +            #size-cells = <1>;
>> +            ranges;
>> +
>> +            clocks = <&gcc GCC_PCIE1_AUX_CLK>,
>> +                 <&gcc GCC_PCIE1_AHB_CLK>,
>> +                 <&gcc GCC_ANOC_PCIE1_1LANE_M_CLK>,
>> +                 <&gcc GCC_SNOC_PCIE1_1LANE_S_CLK>;
>> +            clock-names = "aux", "cfg_ahb", "anoc_lane", "snoc_lane";
>> +
>> +            assigned-clocks = <&gcc GCC_PCIE1_AUX_CLK>;
>> +            assigned-clock-rates = <20000000>;
>> +
>> +            resets = <&gcc GCC_PCIE1_PHY_BCR>,
>> +                 <&gcc GCC_PCIE1PHY_PHY_BCR>;
>> +            reset-names = "phy", "common";
>> +
>> +            status = "disabled";
>> +
>> +            pcie1_lane: phy@fc200 {
>> +                reg = <0x000fc200 0x16c>, /* Serdes Tx */
>> +                      <0x000fc400 0x200>, /* Serdes Rx */
>> +                      <0x000fc800 0x1f0>, /* PCS: Lane0, COM, PCIE */
>> +                      <0x000fcc00 0xf4>;  /* pcs_misc */
>> +                #phy-cells = <0>;
>> +
>> +                clocks = <&gcc GCC_PCIE1_PIPE_CLK>;
>> +                clock-names = "pipe0";
>> +                clock-output-names = "gcc_pcie1_pipe_clk_src";
>> +                #clock-cells = <0>;
>> +            };
>> +        };
>> +
>>           tlmm: pinctrl@1000000 {
>>               compatible = "qcom,ipq9574-tlmm";
>>               reg = <0x01000000 0x300000>;
>> @@ -145,11 +324,11 @@
>>               clocks = <&xo_board_clk>,
>>                    <&sleep_clk>,
>>                    <&bias_pll_ubi_nc_clk>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>,
>> -                 <0>;
>> +                 <&pcie30_phy0_pipe_clk>,
>> +                 <&pcie30_phy1_pipe_clk>,
>> +                 <&pcie30_phy2_pipe_clk>,
>> +                 <&pcie30_phy3_pipe_clk>,
>> +                 <&usb3phy_0_cc_pipe_clk>;
> 
> 
> pipe clock source is PHY. So should we add the pcie_phy phandle here and 
> use it like how it is done in other targets, ex: sm8550.dtsi?
Yes sure kathir. Will update this in the next series
> 
> 
>>               #clock-cells = <1>;
>>               #reset-cells = <1>;
>>               #power-domain-cells = <1>;
>> @@ -282,6 +461,292 @@
>>                   status = "disabled";
>>               };
>>           };
>> +
>> +        pcie1_x1: pci@10000000 {
>> +            compatible = "qcom,pcie-ipq9574";
>> +            reg =  <0x10000000 0xf1d>,
>> +                   <0x10000F20 0xa8>,
>> +                   <0x10001000 0x1000>,
>> +                   <0x000F8000 0x4000>,
>> +                   <0x10100000 0x1000>,
>> +                   <0x00618108 0x4>;
>> +            reg-names = "dbi", "elbi", "atu", "parf", "config", 
>> "aggr_noc";
>> +            device_type = "pci";
>> +            linux,pci-domain = <2>;
>> +            bus-range = <0x00 0xff>;
>> +            num-lanes = <1>;
>> +            #address-cells = <3>;
>> +            #size-cells = <2>;
>> +
>> +            ranges = <0x81000000 0 0x10200000 0x10200000
>> +                  0 0x00100000   /* downstream I/O */
>> +                  0x82000000 0 0x10300000 0x10300000
>> +                  0 0x07d00000>; /* non-prefetchable memory */
>> +
>> +            #interrupt-cells = <1>;
>> +            interrupt-map-mask = <0 0 0 0x7>;
>> +            interrupt-map = <0 0 0 1 &intc 0 35
>> +                    IRQ_TYPE_LEVEL_HIGH>, /* int_a */
>> +                    <0 0 0 2 &intc 0 49
>> +                    IRQ_TYPE_LEVEL_HIGH>, /* int_b */
>> +                    <0 0 0 3 &intc 0 84
>> +                    IRQ_TYPE_LEVEL_HIGH>, /* int_c */
>> +                    <0 0 0 4 &intc 0 85
>> +                    IRQ_TYPE_LEVEL_HIGH>; /* int_d */
>> +
>> +            interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
>> +            interrupt-names = "global_irq";
> 
> 
> Controller driver doesn't support the "global_irq" yet. Please correct 
> me If I am wrong.
> 
> 
> Thanks, Kathiravan T.
> 
Regards,
Devi Priya
