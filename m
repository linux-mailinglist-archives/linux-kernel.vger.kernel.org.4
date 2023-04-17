Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD346E3F75
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjDQGNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjDQGNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:13:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9FD3A80;
        Sun, 16 Apr 2023 23:13:38 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33H5KUTi008801;
        Mon, 17 Apr 2023 06:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dmpQU757SZHn9CQWgTbDdOh1c+pt7TrP5B0NfC7omrg=;
 b=ej00GKT2Vt0+hCuWBdx0voD4LrTGmU0u8mDubLB3pNkLw6cfYRrjJKcKVtWOatObs8j2
 xVQBDhpHDnD6s6HKcqPfN5cVynOv8nsRGXoks+TLshyuQu1TI6DoydHhGaFh236FOo7r
 nRA5wPJ3kYnZGHciKezow5F4uL2AtSu40cJkrCh+MgSfvlsXBQYjPWCtHzTvwPvnLCcG
 Z/SwMfqqKUBUTKm1vwWfochXlspGbehRO70GM1Wc2VCUxk9iJ3rGzTubkhbF+bVRover
 LnQueopdJpd+Za8NHM8ofIHbO3T7ZinAdAzu0OATQG56lrdYqTuFaFHaSegNldJX51Re 4w== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pyn3tjme5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:13:26 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33H6DOJr019119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Apr 2023 06:13:24 GMT
Received: from [10.216.30.175] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Sun, 16 Apr
 2023 23:13:18 -0700
Message-ID: <9e977da8-902a-74d2-7cce-74669b127c30@quicinc.com>
Date:   Mon, 17 Apr 2023 11:43:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V3 3/9] dt-bindings: pinctrl: qcom: Add support for
 ipq5018
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <ulf.hansson@linaro.org>,
        <linus.walleij@linaro.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
 <536ed00f-e252-c8d3-e3ae-9bb9bb79babe@linaro.org>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <536ed00f-e252-c8d3-e3ae-9bb9bb79babe@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hVJ-iBFPYOko0ili8Gjym0T_bBJrxKw8
X-Proofpoint-ORIG-GUID: hVJ-iBFPYOko0ili8Gjym0T_bBJrxKw8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-17_02,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304170056
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/2023 2:35 PM, Krzysztof Kozlowski wrote:
> On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
>> Add device tree binding Documentation details for ipq5018
>> pinctrl driver.
>>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> +
>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +  "#gpio-cells": true
>> +  gpio-ranges: true
>> +  wakeup-parent: true
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 33
> 
> 24
> (you cannot have more than 24...)
> 
  ok, will change this.

>> +
>> +  gpio-line-names:
>> +    maxItems: 47
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-ipq5018-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-ipq5018-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-ipq5018-tlmm-state:
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
>> +          pattern: "^gpio([0-9]|[1-3][0-9]|4[0-6])$"
>> +        minItems: 1
>> +        maxItems: 8
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +        enum: [ atest_char, audio_pdm0, audio_pdm1, audio_rxbclk, audio_rxd,
>> +                audio_rxfsync, audio_rxmclk, audio_txbclk, audio_txd,
>> +                audio_txfsync, audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart0,
>> +                blsp0_uart1, blsp1_i2c0, blsp1_i2c1, blsp1_spi0, blsp1_spi1,
>> +                blsp1_uart0, blsp1_uart1, blsp1_uart2, blsp2_i2c0, blsp2_i2c1,
>> +                blsp2_spi, blsp2_spi0, blsp2_spi1, btss, burn0, burn1, cri_trng,
>> +                cri_trng0, cri_trng1, cxc_clk, cxc_data, dbg_out, eud_gpio,
>> +                gcc_plltest, gcc_tlmm, gpio, led0, led2, mac0, mac1, mdc, mdio,
>> +                pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake, pll_test,
>> +                prng_rosc, pwm0, pwm1, pwm2, pwm3, qdss_cti_trig_in_a0,
>> +                qdss_cti_trig_in_a1, qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
>> +                qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
>> +                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
>> +                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
>> +                qdss_tracedata_a, qdss_tracedata_b, qspi_clk, qspi_cs,
>> +                qspi_data, reset_out, sdc1_clk, sdc1_cmd, sdc1_data, wci_txd,
>> +                wci_rxd, wsa_swrm, wsi_clk3, wsi_data3, wsis_reset, xfem ]
>> +
>> +      bias-pull-down: true
>> +      bias-pull-up: true
>> +      bias-disable: true
>> +      drive-strength: true
>> +      input-enable: true
>> +      output-high: true
>> +      output-low: true
> 
> Drop all these 7, especially that input-enable is not allowed explicitly.
> 
   ok.

>> +
>> +    required:
>> +      - pins
>> +
>> +    additionalProperties: false
> 
> Instead:
> unevaluatedProperties: false
> and put it after the $ref above. Just like recent changes in the next.
> 
   ok, will check and fix it.

>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
>> +    tlmm: pinctrl@1000000 {
>> +        compatible = "qcom,ipq5018-tlmm";
>> +        reg = <0x01000000 0x300000>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        gpio-ranges = <&tlmm 0 0 47>;
>> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +
>> +        uart2-state {
>> +            pins = "gpio34", "gpio35";
>> +            function = "blsp2_uart";
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

   I ran it against the TOT, will run it this time on nxt and post V4.


Regards,
  Sricharan
