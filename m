Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F26CB816
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjC1HcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 03:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjC1HcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 03:32:08 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF1198C;
        Tue, 28 Mar 2023 00:32:06 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32S6XJD1025942;
        Tue, 28 Mar 2023 07:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=uduZbWQtwpQmzQ42ckolDm8PL2riDI47dyZEnq16dbY=;
 b=QHPIl4pM5rq3yOvsUb9fu0UGIAAgdmuapKDS09VMwAUINF1O1nWm+QUNZWB29eqNMlOL
 eve+vEvtQmpQ8Z6SiZSySsFCtgoofNNWRlweR9o1wDpGWd0E8LZ6iPL1Y6kF/UbvMEur
 t5TQ+tqPwATH7ZjVHRUhkVqWOiRE4jV9/LcWi/CJc/+/NL1C+l+lEARoEF/oDWV122P1
 s5iNZymFl46JrASRsL5APEJlr/07C+gnbPR2EkPzW+g95RcHhclpsXWmKshw61V/NcRn
 gLKZBfkOmn1XPo5F3rfodoZ3XQPjQsJBYa3UTqw5ePj8Mn5huyVywwPJgLpvL6TitgXM 9A== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pkby4aakt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:31:48 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32S7VkLb028818
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 07:31:46 GMT
Received: from [10.216.32.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Mar
 2023 00:31:37 -0700
Message-ID: <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
Date:   Tue, 28 Mar 2023 13:01:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
From:   Devi Priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH V10 3/4] arm64: dts: qcom: Add support for ipq9574 SoC and
 RDP433 variant
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <linus.walleij@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_poovendh@quicinc.com>
References: <20230327132718.573-1-quic_devipriy@quicinc.com>
 <20230327132718.573-4-quic_devipriy@quicinc.com>
 <CAA8EJprTm1sZ8fnfNee+NJTiaFq17QwWaEnSoJWVYs_GY65xFg@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAA8EJprTm1sZ8fnfNee+NJTiaFq17QwWaEnSoJWVYs_GY65xFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6s3NXea5trpvIZrzSmJr5ZswA4K2sKQY
X-Proofpoint-GUID: 6s3NXea5trpvIZrzSmJr5ZswA4K2sKQY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-27_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280061
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/27/2023 8:15 PM, Dmitry Baryshkov wrote:
> On Mon, 27 Mar 2023 at 16:28, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>
>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>> family of SoCs
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   Changes in V10:
>>          - Renamed the Board Device Tree Source to use the RDP numbers
>>          - Updated the Makefile, subject and commit message accordingly
>>
>>   arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>   arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 ++++++
>>   arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 270 ++++++++++++++++++++
>>   3 files changed, 355 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>   create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>> index 1a29403400b7..52f1f92c5195 100644
>> --- a/arch/arm64/boot/dts/qcom/Makefile
>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_QCOM) += ipq6018-cp01-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk01.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c1.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c2.dtb
>> +dtb-$(CONFIG_ARCH_QCOM)        += ipq9574-rdp433.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-acer-a1-724.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-alcatel-idol347.dtb
>>   dtb-$(CONFIG_ARCH_QCOM)        += msm8916-asus-z00l.dtb
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> new file mode 100644
>> index 000000000000..2ce8e09e7565
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 RDP433 board device tree source
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
>> +       model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>> +       compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>> +
>> +       aliases {
>> +               serial0 = &blsp1_uart2;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
>> +};
>> +
>> +&blsp1_uart2 {
>> +       pinctrl-0 = <&uart2_pins>;
>> +       pinctrl-names = "default";
>> +       status = "okay";
>> +};
>> +
>> +&sdhc_1 {
>> +       pinctrl-0 = <&sdc_default_state>;
>> +       pinctrl-names = "default";
>> +       mmc-ddr-1_8v;
>> +       mmc-hs200-1_8v;
>> +       mmc-hs400-1_8v;
>> +       mmc-hs400-enhanced-strobe;
>> +       max-frequency = <384000000>;
>> +       bus-width = <8>;
>> +       status = "okay";
>> +};
>> +
>> +&sleep_clk {
>> +       clock-frequency = <32000>;
>> +};
>> +
>> +&tlmm {
>> +       sdc_default_state: sdc-default-state {
>> +               clk-pins {
>> +                       pins = "gpio5";
>> +                       function = "sdc_clk";
>> +                       drive-strength = <8>;
>> +                       bias-disable;
>> +               };
>> +
>> +               cmd-pins {
>> +                       pins = "gpio4";
>> +                       function = "sdc_cmd";
>> +                       drive-strength = <8>;
>> +                       bias-pull-up;
>> +               };
>> +
>> +               data-pins {
>> +                       pins = "gpio0", "gpio1", "gpio2",
>> +                              "gpio3", "gpio6", "gpio7",
>> +                              "gpio8", "gpio9";
>> +                       function = "sdc_data";
>> +                       drive-strength = <8>;
>> +                       bias-pull-up;
>> +               };
>> +
>> +               rclk-pins {
>> +                       pins = "gpio10";
>> +                       function = "sdc_rclk";
>> +                       drive-strength = <8>;
>> +                       bias-pull-down;
>> +               };
>> +       };
>> +};
>> +
>> +&xo_board_clk {
>> +       clock-frequency = <24000000>;
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> new file mode 100644
>> index 000000000000..3bb7435f5e7f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>> @@ -0,0 +1,270 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>> +/*
>> + * IPQ9574 SoC device tree source
>> + *
>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>> +
>> +/ {
>> +       interrupt-parent = <&intc>;
>> +       #address-cells = <2>;
>> +       #size-cells = <2>;
>> +
>> +       clocks {
>> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>> +                       compatible = "fixed-clock";
>> +                       clock-frequency = <353000000>;
>> +                       #clock-cells = <0>;
>> +               };
> 
> What is the source for this clock? With it clocking at 353 MHz, I
> doubt that it is an external clock.
bias_pll_ubi_nc_clk (353MHz)is a backup source
for Q6_AXIM2_CLK/PCIE2_AXIM_CLK/PCIE3_AXIM_CLK/SNOC-CLK
It is from the CMN_PLL, and is the same as that of PPE core clock.
Do you suggest to move its clock-frequency to Board DT similar to 
xo/sleep clock?
> 
>> +
>> +               sleep_clk: sleep-clk {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0>;
>> +               };
>> +
>> +               xo_board_clk: xo-board-clk {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0>;
>> +               };
>> +       };
> 
> [skipped the rest]
> 
Regards,
Devi Priya
