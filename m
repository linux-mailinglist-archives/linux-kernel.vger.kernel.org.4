Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B21E67B650
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjAYPxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbjAYPxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:53:04 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899E9212F;
        Wed, 25 Jan 2023 07:53:03 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PErW9V014743;
        Wed, 25 Jan 2023 15:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6eEpNVI0rNe3xJIlW8P6xrZ8Jv6Y1y+7RCqksyUlwbQ=;
 b=eD+CKS3pgqypHvg52j739dRv+nbE/8JCU93kbN6v0EZ4WrOsFaSXUU45k/Z+wsKayq7a
 zPd2+ByxhZG7A8vin3ahTXR8fqSbOCbdivpC+3+s1Oy8kjmMnjAkRi4LnRk/pZEAoUMw
 3heWIiImLUrkACp5KUTPtoXD8mHdhyfhdix7xBftWTLc70g/FRSRU7DIRE7pmkWdSwOn
 5n0KIwU2fm2FzJSvTkrkHWKAyom+lSldfy6RjCp5WdBvtjs7luwZnx3WUBeOpnkfPl/w
 QWeRa+rmQUXN0Zv78KgMbF9xRYjWdylQoOLBZc4KXLYn2F0t71R9MDRZCSsQeB58TgQ4 xg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nb6jc83um-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:52:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30PFnjHj004361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 15:49:45 GMT
Received: from [10.50.43.172] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Wed, 25 Jan
 2023 07:49:36 -0800
Message-ID: <0b28f4a3-c445-7473-501b-39cbcfdb9889@quicinc.com>
Date:   Wed, 25 Jan 2023 21:19:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 01/10] dt-bindings: pinctrl: qcom: add IPQ5332 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <dmitry.baryshkov@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <bhupesh.sharma@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230125104520.89684-1-quic_kathirav@quicinc.com>
 <20230125104520.89684-2-quic_kathirav@quicinc.com>
 <50ec54ba-3468-3448-3fab-f28e97549ad2@linaro.org>
Content-Language: en-US
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <50ec54ba-3468-3448-3fab-f28e97549ad2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yhun6mfdqR7DHk1Zl3e9Yppvn_YUKEsV
X-Proofpoint-GUID: yhun6mfdqR7DHk1Zl3e9Yppvn_YUKEsV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_09,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301250141
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2023 4:40 PM, Krzysztof Kozlowski wrote:
> On 25/01/2023 11:45, Kathiravan Thirumoorthy wrote:
>> From: Kathiravan T <quic_kathirav@quicinc.com>
>>
>> Add device tree bindings for IPQ5332 TLMM block.
>>
>> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
>> ---
>>   .../pinctrl/qcom,ipq5332-pinctrl.yaml         | 134 ++++++++++++++++++
>>   1 file changed, 134 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..d101ee04b8b7
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-pinctrl.yaml
> Name matching compatible, please.


Sure, will rename it accordingly.


>
>> @@ -0,0 +1,134 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq5332-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm IPQ5332 TLMM pin controller
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description: |
>> +  Top Level Mode Multiplexer pin controller in Qualcomm IPQ5332 SoC.
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,ipq5332-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts: true
> missing maxItems
>
> Rebase your patches on latest next and use the latest bindings and
> drivers as starting point.


Changes are based on v6.2-rc1.  I see the maxItems changes in 
linux-next. Will update this in V2.


>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +  "#gpio-cells": true
>> +  gpio-ranges: true
>> +  wakeup-parent: true
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 27
>> +
>> +  gpio-line-names:
>> +    maxItems: 53
> You have 54 GPIOs.


Sorry, GPIO ranges are from 0-52, will update it in all places in V2.


>
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-ipq5332-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-ipq5332-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-ipq5332-tlmm-state:
>> +    type: object
>> +    description:
>> +      Pinctrl node's client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
>> +
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in this
>> +          subnode.
>> +        items:
>> +          pattern: "^gpio([0-9]|[1-4][0-9]|5[0-3])$"
>> +        minItems: 1
>> +        maxItems: 36
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +        enum: [ PTA_0, PTA_2, PTA_1, atest_char, atest_char0, atest_char1,
> 1. lowercase only
>
> 2. order all these by name


Ack.


>
>
>> +                atest_char2, atest_char3, atest_tic, audio_pri, audio_pri0,
>> +                audio_pri1, audio_sec, audio_sec0, audio_sec1, blsp0_i2c,
>> +                blsp0_spi, blsp0_uart0, blsp0_uart1, blsp1_i2c0, blsp1_i2c1,
>> +                blsp1_spi0, blsp1_spi1, blsp1_uart0, blsp1_uart1, blsp1_uart2,
>> +                blsp2_i2c0, blsp2_i2c1, blsp2_spi, blsp2_spi0, blsp2_spi1,
>> +                core_voltage, cri_trng0, cri_trng1, cri_trng2, cri_trng3,
>> +                cxc_clk, cxc_data, dbg_out, gcc_plltest, gcc_tlmm, gpio,
>> +                lock_det, mac0, mac1, mdc0, mdc1, mdio0, mdio1, pc, pcie0_clk,
> Best regards,
> Krzysztof


Thanks,

Kathiravan T.

