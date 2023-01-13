Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B7E66989E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241478AbjAMNeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240874AbjAMNcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:32:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFDBDEDB;
        Fri, 13 Jan 2023 05:25:15 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DB6ORw025120;
        Fri, 13 Jan 2023 13:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EJGiPWxm+wlAx4xUAF5tWKNS4NE4L5iI0AcPw5kbXSA=;
 b=YVamdU3DTsLOJORbqbpjIDJsCe87NHTudbM8KKbfdoOgl33yUQZvugrNnrtzn9i5l9Ub
 XdPbLbEh8wu3A6EisATjmjcO9CSY3LaiRc1YZodcRTEf1ggAcI6b6rKzQrANtVfbO/Mp
 21cUacaVWh3XLx4mfw3mtXcEr1/qBuHaP//kzrt2zif3K2zyf3H3FvQMTgbwcwkI+pX0
 VfPth6fQNpCFB5srAGwCeso9uH7JKQ17dKx4JJ7prBxXwTcOsEBJt80u+d9S8JbTgM4C
 YswgtPqmrf7qSpe0VEIMTUMZIqOyQ0nC2JuA7YgaQpWRCW6o4IxOGVzqH+CymDRYGuew vg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n2s0csw39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:24:15 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30DDOEUk025661
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Jan 2023 13:24:14 GMT
Received: from [10.50.57.3] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 13 Jan
 2023 05:24:05 -0800
Message-ID: <a0db608a-2c65-e831-abc2-072609fd7a5a@quicinc.com>
Date:   Fri, 13 Jan 2023 18:54:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/7] dt-bindings: pinctrl: qcom: Add ipq9574 pinctrl
 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
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
 <20230110121316.24892-4-quic_devipriy@quicinc.com>
 <b63600f9-82ef-83dc-1680-1df125b5d971@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <b63600f9-82ef-83dc-1680-1df125b5d971@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PuBMXDN3wkcljeLCHoW766euYjspV1jp
X-Proofpoint-GUID: PuBMXDN3wkcljeLCHoW766euYjspV1jp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_06,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130088
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/11/2023 3:09 PM, Krzysztof Kozlowski wrote:
> On 10/01/2023 13:13, devi priya wrote:
>> Add device tree binding documentation details for ipq9574
>> pinctrl driver
>>
> 
> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> prefix is already stating that these are bindings.
Sure, okay
> 
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
>> ---
>>   .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   | 129 ++++++++++++++++++
>>   1 file changed, 129 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
>> new file mode 100644
>> index 000000000000..f9cb457bc18d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
>> @@ -0,0 +1,129 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,ipq9574-tlmm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. IPQ9574 TLMM block
>> +
>> +maintainers:
>> +  - Anusha <quic_anusha@quicinc.com>
>> +
>> +description: |
>> +  This binding describes the Top Level Mode Multiplexer block found in the
>> +  IPQ9574 platform.
> 
> No, please rebase on recent changes. You started your work on some old
> bindings so your binding likely includes all issues we fixed.
Sure, will do
> 
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,ipq9574-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts: true
>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +  gpio-reserved-ranges: true
>> +  "#gpio-cells": true
>> +  gpio-ranges: true
>> +  wakeup-parent: true
> 
> Missing gpio-line-names and constraints for ranges. Look at other bindings.
Okay
> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-ipq9574-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-ipq9574-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-ipq9574-tlmm-state:
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
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-5][0-9]|6[0-4])$"
>> +            - enum: [ sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk, sdc2_cmd,
>> +                      sdc2_data, qdsd_cmd, qdsd_data0, qdsd_data1, qdsd_data2,
>> +                      qdsd_data3 ]
> 
> These are ordered by name.
The enum values seem to be ordered alphabetically.
could you please help us understand the ordering?
> 
>> +        minItems: 1
>> +        maxItems: 8
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +        enum: [ atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
>> +                audio_pdm1, audio_pri, audio_sec, blsp0_spi, blsp0_uart,
>> +                blsp1_i2c, blsp1_spi, blsp1_uart, blsp2_i2c, blsp2_spi,
>> +                blsp2_uart, blsp3_i2c, blsp3_spi, blsp3_uart, blsp4_i2c,
>> +                blsp4_spi, blsp4_uart, blsp5_i2c, blsp5_uart, cri_trng0,
>> +                cri_trng1, cri_trng3, cxc0, cxc1, dbg_out, dwc_ddrphy,
>> +                gcc_plltest, gcc_tlmm, mac00, mac01, mac10, mac11, mdc,
>> +                mdio, pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake, pcie2_clk,
>> +                pcie2_wake, pcie3_clk, pcie3_wake, prng_rosc0, prng_rosc1,
>> +                prng_rosc2, prng_rosc3, pta1_0, pta1_1, pta1_2, pta20, pta21,
>> +                pwm00, pwm01, pwm02, pwm03, pwm04, pwm10, pwm11, pwm12, pwm13,
>> +                pwm14, pwm20, pwm21, pwm22, pwm23, pwm24, pwm30, pwm31, pwm32,
>> +                pwm33, qdss_cti_trig_in_a0, qdss_cti_trig_in_a1, qdss_cti_trig_in_b0,
>> +                qdss_cti_trig_in_b1, qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
>> +                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
>> +                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b, qdss_tracedata_a,
>> +                dss_tracedata_b, qdss_tracedata_b, qspi_clk, qspi_cs, qspi_data,
>> +                rx0, rx1, sdc_clk, sdc_cmd, sdc_data, sdc_rclk, tsens_max,
>> +                wci20, wci21, wsa_swrm, audio_pdm0 ]
> 
> These too
> 
>> +
>> +      bias-disable: true
>> +      bias-pull-down: true
>> +      bias-pull-up: true
>> +      drive-strength: true
>> +      input-enable: true
>> +      output-high: true
>> +      output-low: true
>> +
>> +    required:
>> +      - pins
>> +
>> +    additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    tlmm: pinctrl@1000000 {
>> +        compatible = "qcom,ipq9574-tlmm";
>> +        reg = <0x01000000 0x300000>;
>> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        gpio-ranges = <&tlmm 0 0 65>;
>> +
>> +        uart2-state {
>> +                pins = "gpio34", "gpio35";
> 
> Wrong indentation.
Okay
> 
>> +                function = "blsp2_uart";
>> +                drive-strength = <8>;
>> +                bias-pull-down;
>> +        };
>> +    };
> 
> Best regards,
> Krzysztof
> 

Best Regards,
Devi Priya
