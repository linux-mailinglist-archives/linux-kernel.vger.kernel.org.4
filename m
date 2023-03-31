Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57AD6D2037
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjCaM0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbjCaM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:26:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD226BE;
        Fri, 31 Mar 2023 05:26:33 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32V7DMgV006937;
        Fri, 31 Mar 2023 12:26:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KecvlXR5Xf+6vpH/FS8Z60UCAHN1qIrGzVAd51rNoOQ=;
 b=KK+G+XysT+0jpo8exI2ZxVrGf38rjxJ6mBGNx9HXwrnXFhh/HIvUErt5570N7UrZPsOP
 TleraHmFlWZ3uvt8RCW53WofOLG7D7n/Gf1nD5vgJipY1zMUBq63zJVbuES1qjpzYmiI
 BQCEC/MiEA3J1wDzNE77hJ7Zz+bIwpUFyZ1V6Vvywb41crpjktcmLcgWG4b20RX7BB/F
 QBDVRRnw2gdgXQ23hKr6sKRKTxPOHRAzu1hKqLiwdoGfqsWJ9Xitn3CTpk+3cFJSW0kT
 bEhRs6afnQRruZXKX+fYYEqGTwW2ABzvQpNwO0jg1cwFvlvdxn+Pi4J54QGwfst0tD6n 2g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pntxf8uaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 12:26:00 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32VCPxcf018378
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Mar 2023 12:25:59 GMT
Received: from [10.50.5.218] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 31 Mar
 2023 05:25:50 -0700
Message-ID: <0316b1fb-0581-e3e6-b5ba-64c2a6ef2ec4@quicinc.com>
Date:   Fri, 31 Mar 2023 17:52:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
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
 <a6225636-7abb-3c5c-c78f-8d40c25167b9@quicinc.com>
 <CAA8EJprgcMOX-WRXP2i9k850La1A1UKaKuODd-fVi27nOxMbyA@mail.gmail.com>
Content-Language: en-US
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <CAA8EJprgcMOX-WRXP2i9k850La1A1UKaKuODd-fVi27nOxMbyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vW7OdrM7OPZuEvEvwN9zF4gpPlQa2XXp
X-Proofpoint-ORIG-GUID: vW7OdrM7OPZuEvEvwN9zF4gpPlQa2XXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_06,2023-03-30_04,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303310099
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/28/2023 4:09 PM, Dmitry Baryshkov wrote:
> On Tue, 28 Mar 2023 at 10:31, Devi Priya <quic_devipriy@quicinc.com> wrote:
>> On 3/27/2023 8:15 PM, Dmitry Baryshkov wrote:
>>> On Mon, 27 Mar 2023 at 16:28, Devi Priya <quic_devipriy@quicinc.com> wrote:
>>>>
>>>> Add initial device tree support for Qualcomm IPQ9574 SoC and
>>>> Reference Design Platform(RDP) 433 which is based on IPQ9574
>>>> family of SoCs
>>>>
>>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>>> Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>>>> ---
>>>>    Changes in V10:
>>>>           - Renamed the Board Device Tree Source to use the RDP numbers
>>>>           - Updated the Makefile, subject and commit message accordingly
>>>>
>>>>    arch/arm64/boot/dts/qcom/Makefile           |   1 +
>>>>    arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts |  84 ++++++
>>>>    arch/arm64/boot/dts/qcom/ipq9574.dtsi       | 270 ++++++++++++++++++++
>>>>    3 files changed, 355 insertions(+)
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>>    create mode 100644 arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
>>>> index 1a29403400b7..52f1f92c5195 100644
>>>> --- a/arch/arm64/boot/dts/qcom/Makefile
>>>> +++ b/arch/arm64/boot/dts/qcom/Makefile
>>>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_QCOM) += ipq6018-cp01-c1.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk01.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c1.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += ipq8074-hk10-c2.dtb
>>>> +dtb-$(CONFIG_ARCH_QCOM)        += ipq9574-rdp433.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += msm8916-acer-a1-724.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += msm8916-alcatel-idol347.dtb
>>>>    dtb-$(CONFIG_ARCH_QCOM)        += msm8916-asus-z00l.dtb
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>> new file mode 100644
>>>> index 000000000000..2ce8e09e7565
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts
>>>> @@ -0,0 +1,84 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>>> +/*
>>>> + * IPQ9574 RDP433 board device tree source
>>>> + *
>>>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +/dts-v1/;
>>>> +
>>>> +#include "ipq9574.dtsi"
>>>> +
>>>> +/ {
>>>> +       model = "Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C7";
>>>> +       compatible = "qcom,ipq9574-ap-al02-c7", "qcom,ipq9574";
>>>> +
>>>> +       aliases {
>>>> +               serial0 = &blsp1_uart2;
>>>> +       };
>>>> +
>>>> +       chosen {
>>>> +               stdout-path = "serial0:115200n8";
>>>> +       };
>>>> +};
>>>> +
>>>> +&blsp1_uart2 {
>>>> +       pinctrl-0 = <&uart2_pins>;
>>>> +       pinctrl-names = "default";
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&sdhc_1 {
>>>> +       pinctrl-0 = <&sdc_default_state>;
>>>> +       pinctrl-names = "default";
>>>> +       mmc-ddr-1_8v;
>>>> +       mmc-hs200-1_8v;
>>>> +       mmc-hs400-1_8v;
>>>> +       mmc-hs400-enhanced-strobe;
>>>> +       max-frequency = <384000000>;
>>>> +       bus-width = <8>;
>>>> +       status = "okay";
>>>> +};
>>>> +
>>>> +&sleep_clk {
>>>> +       clock-frequency = <32000>;
>>>> +};
>>>> +
>>>> +&tlmm {
>>>> +       sdc_default_state: sdc-default-state {
>>>> +               clk-pins {
>>>> +                       pins = "gpio5";
>>>> +                       function = "sdc_clk";
>>>> +                       drive-strength = <8>;
>>>> +                       bias-disable;
>>>> +               };
>>>> +
>>>> +               cmd-pins {
>>>> +                       pins = "gpio4";
>>>> +                       function = "sdc_cmd";
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-up;
>>>> +               };
>>>> +
>>>> +               data-pins {
>>>> +                       pins = "gpio0", "gpio1", "gpio2",
>>>> +                              "gpio3", "gpio6", "gpio7",
>>>> +                              "gpio8", "gpio9";
>>>> +                       function = "sdc_data";
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-up;
>>>> +               };
>>>> +
>>>> +               rclk-pins {
>>>> +                       pins = "gpio10";
>>>> +                       function = "sdc_rclk";
>>>> +                       drive-strength = <8>;
>>>> +                       bias-pull-down;
>>>> +               };
>>>> +       };
>>>> +};
>>>> +
>>>> +&xo_board_clk {
>>>> +       clock-frequency = <24000000>;
>>>> +};
>>>> diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> new file mode 100644
>>>> index 000000000000..3bb7435f5e7f
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
>>>> @@ -0,0 +1,270 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
>>>> +/*
>>>> + * IPQ9574 SoC device tree source
>>>> + *
>>>> + * Copyright (c) 2020-2021 The Linux Foundation. All rights reserved.
>>>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +#include <dt-bindings/clock/qcom,ipq9574-gcc.h>
>>>> +#include <dt-bindings/reset/qcom,ipq9574-gcc.h>
>>>> +
>>>> +/ {
>>>> +       interrupt-parent = <&intc>;
>>>> +       #address-cells = <2>;
>>>> +       #size-cells = <2>;
>>>> +
>>>> +       clocks {
>>>> +               bias_pll_ubi_nc_clk: bias-pll-ubi-nc-clk {
>>>> +                       compatible = "fixed-clock";
>>>> +                       clock-frequency = <353000000>;
>>>> +                       #clock-cells = <0>;
>>>> +               };
>>>
>>> What is the source for this clock? With it clocking at 353 MHz, I
>>> doubt that it is an external clock.
>> bias_pll_ubi_nc_clk (353MHz)is a backup source
>> for Q6_AXIM2_CLK/PCIE2_AXIM_CLK/PCIE3_AXIM_CLK/SNOC-CLK
>> It is from the CMN_PLL, and is the same as that of PPE core clock.
>> Do you suggest to move its clock-frequency to Board DT similar to
>> xo/sleep clock?
> 
> No, I suggest moving it to the device where it originates. If it comes
> from GCC, it should be provided by the GCC, not by the top-level fixed
> clock.Bias PLL is a fixed PLL on the SoC which provides 352MHz.
As it is just a backup source for PCIE2_AXIM_CLK, we would remove the
clock node as it is not being used.

> 
>>>
>>>> +
>>>> +               sleep_clk: sleep-clk {
>>>> +                       compatible = "fixed-clock";
>>>> +                       #clock-cells = <0>;
>>>> +               };
>>>> +
>>>> +               xo_board_clk: xo-board-clk {
>>>> +                       compatible = "fixed-clock";
>>>> +                       #clock-cells = <0>;
>>>> +               };
>>>> +       };
>>>
>>> [skipped the rest]
>>>
>> Regards,
>> Devi Priya
> 
> 
>
Regards,
Devi Priya
