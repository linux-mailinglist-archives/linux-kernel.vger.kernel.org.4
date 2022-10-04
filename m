Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7325F47C8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbiJDQlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiJDQlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:41:20 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 893465E679;
        Tue,  4 Oct 2022 09:41:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294GKuYp016029;
        Tue, 4 Oct 2022 16:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=gUkqzjnsvNMB0cdzmm2BoYGO4IpLodoDO9uPFRmB4VY=;
 b=oGCZagDuEupkgG0hjwFkX7Vnx0Zi1bBXg2GBbpUqZa5znB1x0nWlxME6Ry04sXcXi9Aa
 RpUMuUCLenmjh8ohjLSkJZlKRBxW6sdm9gGx2D/hVPcL19bKkCLi3koRgdYAxWVjkyf+
 hVUSl2KXGVbrry0fXZLaoL90FRkCnUbpCx/0Lr49kagrZM4K+CfNaXUaef5YA7zxOSBI
 fMrWmeEpUkMbAZgnGLtAlVxItmqSK9kSP7cAqdNTwqDSyl5EuYWxd/R7jNUxKRiXGIgU
 oUM6HFmhb0AzBCV6+gV3r8m37EGFSZDxmfo6Uw66vNq91U6tb/ME9awAPbTZEB4bUpj6 Yw== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxdn1xc9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 16:41:14 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294GfDt9014045
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 16:41:13 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 09:41:11 -0700
Message-ID: <1831973e-909d-4943-be6d-b44ba3868085@quicinc.com>
Date:   Tue, 4 Oct 2022 11:41:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000
 pinctrl bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-2-quic_molvera@quicinc.com>
 <b12393d9-6b1a-a9cb-a964-cb2936da12cf@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <b12393d9-6b1a-a9cb-a964-cb2936da12cf@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ULnrfGmvMBMa6B_cXvXcek2FelW_GBYv
X-Proofpoint-GUID: ULnrfGmvMBMa6B_cXvXcek2FelW_GBYv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_07,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040107
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 4:20 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:05, Melody Olvera wrote:
>> Add documentation details for device tree bindings for QDU1000 and QRU1000
>> TLMM devices.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        | 133 ++++++++++++++++++
>>  1 file changed, 133 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..e8d938303231
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> @@ -0,0 +1,133 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description: |
>> +  This binding describes the Top Level Mode Multiplexer block.
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,qdu1000-tlmm
>> +      - const: qcom,qru1000-tlmm
>> +
>> +  reg:
>> +    items:
>> +      - description: Base address of TLMM register space
>> +      - description: Size of TLMM register space
>> +
>> +  interrupts:
>> +    minItems: 0
> Cannot be 0 of interrupts.
>
>> +    maxItems: 1
>> +    items:
>> +      - const: TLMM summary IRQ
>> +
>> +  interrupt-controller: true
>> +
>> +  '#interrupt-cells':
>> +    const: 2
>> +
>> +  gpio-controller: true
>> +
>> +  '#gpio-cells':
>> +    const: 2
>> +
>> +  wakeup-parent:
>> +    maxItems: 1
>> +    description:
>> +      Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
>> +      a general description of GPIO and interrupt bindings.
>> +
>> +      Please refer to pinctrl-bindings.txt in this directory for details of the
>> +      common pinctrl bindings used by client devices, including the meaning of the
>> +      phrase "pin configuration node".
>> +
>> +      The pin configuration nodes act as a container for an arbitrary number of
>> +      subnodes. Each of these subnodes represents some desired configuration for a
>> +      pin, a group, or a list of pins or groups. This configuration can include the
>> +      mux function to select on those pin(s)/group(s), and various pin configuration
>> +      parameters, such as pull-up, drive strength, etc.
>> +
>> +
>> +# PIN CONFIGURATION NODES
>> +patternPropetries:
>> +  '^.*$':
>> +    if:
>> +      type: object
>> +    then:
> Nope, that's not correct binding. It does not work. It never worked.
>
> Please do it exactly like:
> https://lore.kernel.org/linux-devicetree/20220930200529.331223-1-krzysztof.kozlowski@linaro.org/T/#m08b62ef5d873a52a5cbf3c53b25eff03726e7a16
> https://lore.kernel.org/linux-devicetree/20220927173702.5200-1-krzysztof.kozlowski@linaro.org/T/#t
Understood; will correct the binding.
>
>> +      properties:
>> +        pins:
>> +          description:
>> +            List of gpio pins affected by the properties specified in
>> +            this subnode.
>> +          items:
>> +            oneOf:
>> +              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
>> +              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
>> +            minItems: 1
>> +            maxItems: 36
>> +        function:
>> +          description:
>> +            Specify the alternative function to be configured for the
>> +            specified pins. Functions are only valid for gpio pins.
>> +          enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
>> +            atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
>> +            cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
>> +            cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
>> +            cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
>> +            gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
>> +            mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
>> +            mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
>> +            mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
>> +            nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
>> +            phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
>> +            phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
>> +            phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
>> +            phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
>> +            phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
>> +            pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
>> +            qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
>> +            qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
>> +            qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
>> +            qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
>> +            qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
>> +            qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
>> +            qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
>> +            sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
>> +            tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
>> +            uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
>> +            vfr_1, vsense_trigger]
>> +        drive-strength:
>> +          enum: [2, 4, 6, 8, 10, 12, 14, 16]
>> +          default: 2
>> +          description:
>> +            Selects the drive strength for the specified pins, in mA.
>> +        bias-pull-down: true
>> +        bias-pull-up: true
>> +        bias-disable: true
>> +        output-high: true
>> +        output-low: true
> You miss blank lines in several places. Please do it exactly like I
> shown for sdm845.
Ditto for above.
>
>> +      required:
>> +        - pins
>> +        - function
>> +      additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    tlmm: pinctrl@03000000 {
>> +      compatible = "qcom,qdu10000-tlmm";
>> +      reg = <0x03000000 0xdc2000>;
>> +      interrupts = <0 208 0>;
> Use defines.
Understood.
>
>> +      gpio-controller;
>> +      #gpio-cells = <2>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <2>;
>> +      wakeup-parent = <&pdc>;
> Missing children.
Will add.
>
>> +    };
> Best regards,
> Krzysztof
Thanks,
Melody
