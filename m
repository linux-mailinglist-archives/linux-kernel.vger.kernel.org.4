Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CC85F4A00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 22:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJDUBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 16:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiJDUBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 16:01:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F875F12C;
        Tue,  4 Oct 2022 13:00:58 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294JC4c4020353;
        Tue, 4 Oct 2022 20:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=oINbwL87HRR+JM7c8BkziS6L29JQpdRxKzbEBinyrbg=;
 b=X4UtPsFWsmCnrDAoX9jwBy/UDdRjYw/AeiFYn5UerSurBv+5c4cZPuR9I1pmlYpXRcUt
 0VEhPfJmFagyA245VVg5db2jbtIHKIKXeif461S3QsZU4rUkBxQZysNc61Q70B7lFIYy
 uKYYXdHkPhsDOSuuNwfOFUhXyXCfvjkE7iAUWzLDVrB0UceomDMXPM48NPZb31tZDhVC
 w2KADK+sAqYsQ4ZEFRRHJcH5tsdNe0qvJO4nTteKw8yrVlN+D4nhJUyyIq8BIbD+UqBp
 4LFuJmdqTsdJcbcdZpGfsm0evcHgwW7OzzmVvAbiFy1cdVhBP7fdjPIJ+T9h87PYZ2WQ kw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jxdn1xq2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 20:00:52 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 294K0p6c009686
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 Oct 2022 20:00:51 GMT
Received: from [10.110.73.50] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 4 Oct 2022
 13:00:50 -0700
Message-ID: <deba878b-9960-96b6-7afe-f1abf447bf22@quicinc.com>
Date:   Tue, 4 Oct 2022 15:00:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] pinctrl: qcom: Add QDU1000/QRU1000 pinctrl driver
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
 <20221001030546.28220-3-quic_molvera@quicinc.com>
 <b0061b6d-56de-2003-ab25-da6cf1c78084@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <b0061b6d-56de-2003-ab25-da6cf1c78084@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ny4l-w-0WN---8sFCvoU8TwlnFzDRDlj
X-Proofpoint-GUID: ny4l-w-0WN---8sFCvoU8TwlnFzDRDlj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040130
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/1/2022 4:22 AM, Krzysztof Kozlowski wrote:
> On 01/10/2022 05:05, Melody Olvera wrote:
>> Add pin control driver for the TLMM block found in the QDU1000
>> and QRU1000 SoC.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        |  177 +-
>>  drivers/pinctrl/qcom/Kconfig                  |   10 +
>>  drivers/pinctrl/qcom/Makefile                 |    1 +
>>  drivers/pinctrl/qcom/pinctrl-qdru1000.c       |   59 +
>>  drivers/pinctrl/qcom/pinctrl-qdru1000.h       | 1896 +++++++++++++++++
>>  5 files changed, 2050 insertions(+), 93 deletions(-)
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.c
>>  create mode 100644 drivers/pinctrl/qcom/pinctrl-qdru1000.h
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> index e8d938303231..42176247862c 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> Nope, drivers cannot be mixed with bindings in one patch.
Ack.
>
>> @@ -10,7 +10,11 @@ maintainers:
>>    - Melody Olvera <quic_molvera@quicinc.com>
>>  
>>  description: |
>> -  This binding describes the Top Level Mode Multiplexer block.
>> +  This binding describes the Top Level Mode Multiplexer block (TLMM) found
>> +  in the QDU1000 and QRU1000 platforms.
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>>  
>>  properties:
>>    compatible:
>> @@ -19,105 +23,92 @@ properties:
>>        - const: qcom,qru1000-tlmm
>>  
>>    reg:
>> -    items:
>> -      - description: Base address of TLMM register space
>> -      - description: Size of TLMM register space
>> -
>> -  interrupts:
>> -    minItems: 0
>>      maxItems: 1
>> -    items:
>> -      - const: TLMM summary IRQ
>> -
>> +  interrupts: true
>>    interrupt-controller: true
>> -
>> -  '#interrupt-cells':
>> -    const: 2
>> -
>> +  '#interrupt-cells': true
>>    gpio-controller: true
>> +  '#gpio-cells': true
>> +  wakeup-parent: true
>>  
>> -  '#gpio-cells':
>> -    const: 2
>> -
>> -  wakeup-parent:
>> -    maxItems: 1
>> -    description:
>> -      Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
>> -      a general description of GPIO and interrupt bindings.
>> -
>> -      Please refer to pinctrl-bindings.txt in this directory for details of the
>> -      common pinctrl bindings used by client devices, including the meaning of the
>> -      phrase "pin configuration node".
>> -
>> -      The pin configuration nodes act as a container for an arbitrary number of
>> -      subnodes. Each of these subnodes represents some desired configuration for a
>> -      pin, a group, or a list of pins or groups. This configuration can include the
>> -      mux function to select on those pin(s)/group(s), and various pin configuration
>> -      parameters, such as pull-up, drive strength, etc.
>> +required:
>> +  - compatible
>> +  - reg
>>  
>> +additionalProperties: false
>>  
>>  # PIN CONFIGURATION NODES
>> -patternPropetries:
>> -  '^.*$':
>> -    if:
>> -      type: object
>> -    then:
>> -      properties:
>> -        pins:
>> -          description:
>> -            List of gpio pins affected by the properties specified in
>> -            this subnode.
>> -          items:
>> -            oneOf:
>> -              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
>> -              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
>> -            minItems: 1
>> -            maxItems: 36
>> -        function:
>> -          description:
>> -            Specify the alternative function to be configured for the
>> -            specified pins. Functions are only valid for gpio pins.
>> -          enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
>> -            atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
>> -            cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
>> -            cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
>> -            cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
>> -            gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
>> -            mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
>> -            mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
>> -            mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
>> -            nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
>> -            phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
>> -            phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
>> -            phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
>> -            phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
>> -            phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
>> -            pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
>> -            qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
>> -            qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
>> -            qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
>> -            qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
>> -            qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
>> -            qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
>> -            qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
>> -            sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
>> -            tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
>> -            uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
>> -            vfr_1, vsense_trigger]
>> -        drive-strength:
>> -          enum: [2, 4, 6, 8, 10, 12, 14, 16]
>> -          default: 2
>> -          description:
>> -            Selects the drive strength for the specified pins, in mA.
>> -        bias-pull-down: true
>> -        bias-pull-up: true
>> -        bias-disable: true
>> -        output-high: true
>> -        output-low: true
>> -      required:
>> -        - pins
>> -        - function
>> -      additionalProperties: false
>> +patternProperties:
>> +  '-state$':
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-qdru1000-tlmm-state"
>> +      - patternProperties:
>> +          ".*":
>> +            $ref: "#/$defs/qcom-qdru1000-tlmm-state"
> Review your patches before sending...
>
>> +
>> +$defs:
>> +  qcom-qdru1000-tlmm-state:
>> +    type: object
>> +    description:
>> +      Pinctrl nodes' client devices use subnodes for desired pin configuration.
>> +      Client device subnodes use below standard properties.
>> +    $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"
>> +    properties:
>> +      pins:
>> +        description:
>> +          List of gpio pins affected by the properties specified in
>> +          this subnode.
>> +        items:
>> +          oneOf:
>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
>> +            - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
>> +        minItems: 1
>> +        maxItems: 36
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the
>> +          specified pins. Functions are only valid for gpio pins.
>> +        enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
>> +          atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
>> +          cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
>> +          cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
>> +          cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
>> +          gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
>> +          mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
>> +          mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
>> +          mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
>> +          nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
>> +          phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
>> +          phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
>> +          phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
>> +          phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
>> +          phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
>> +          pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
>> +          qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
>> +          qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
>> +          qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
>> +          qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
>> +          qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
>> +          qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
>> +          qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
>> +          sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
>> +          tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
>> +          uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
>> +          vfr_1, vsense_trigger]
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
>> +      - function
>> +
>> +    additionalProperties: false
>>  
>>  examples:
>>    - |
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index f415c13caae0..c8a7d6e44a81 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -390,6 +390,16 @@ config PINCTRL_SM8450
>>  	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
>>  	  Technologies Inc SM8450 platform.
>>  
>> +config PINCTRL_QDRU1000
> Order alphabetically.
>
>> +	tristate "Qualcomm Tehcnologies Inc QDU1000/QRU1000 pin controller driver"
>> +	depends on GPIOLIB && OF
>> +	depends on PINCTRL_MSM
>> +	help
>> +	  This is the pinctrl, pinmux, pinconf, and gpiolib driver for the
>> +	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
>> +	  Technologies Inc QDU1000 and QRU1000 platforms.
>> +
>> +
> No need for multiple line breaks.
>
>>  config PINCTRL_LPASS_LPI
>>  	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
>>  	select PINMUX
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index fbd64853a24d..431a845b4e2d 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -45,4 +45,5 @@ obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>>  obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>>  obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>>  obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
>> +obj-$(CONFIG_PINCTRL_QDRU1000) += pinctrl-qdru1000.o
> Wrong order.
Will fix.
>
>>  obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.c b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> new file mode 100644
>> index 000000000000..8b931ff80bb4
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.c
>> @@ -0,0 +1,59 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pinctrl/pinctrl.h>
>> +
>> +#include "pinctrl-msm.h"
>> +#include "pinctrl-qdru1000.h"
>> +
>> +static const struct msm_pinctrl_soc_data qdru1000_tlmm = {
>> +	.pins = qdru1000_pins,
>> +	.npins = ARRAY_SIZE(qdru1000_pins),
>> +	.functions = qdru1000_functions,
>> +	.nfunctions = ARRAY_SIZE(qdru1000_functions),
>> +	.groups = qdru1000_groups,
>> +	.ngroups = ARRAY_SIZE(qdru1000_groups),
>> +	.ngpios = 151,
>> +};
>> +
>> +static int qdru1000_tlmm_probe(struct platform_device *pdev)
>> +{
>> +	return msm_pinctrl_probe(pdev, &qdru1000_tlmm);
>> +}
>> +
>> +static const struct of_device_id qdru1000_tlmm_of_match[] = {
>> +	{ .compatible = "qcom,qdu1000-tlmm", },
>> +	{ .compatible = "qcom,qru1000-tlmm", },
>> +	{ },
>> +};
>> +
>> +static struct platform_driver qdru1000_tlmm_driver = {
>> +	.driver = {
>> +		.name = "qdru1000-tlmm",
>> +		.of_match_table = qdru1000_tlmm_of_match,
>> +	},
>> +	.probe = qdru1000_tlmm_probe,
>> +	.remove = msm_pinctrl_remove,
>> +};
>> +
>> +static int __init qdru1000_tlmm_init(void)
>> +{
>> +	return platform_driver_register(&qdru1000_tlmm_driver);
>> +}
>> +arch_initcall(qdru1000_tlmm_init);
>> +
>> +static void __exit qdru1000_tlmm_exit(void)
>> +{
>> +	platform_driver_unregister(&qdru1000_tlmm_driver);
>> +}
>> +module_exit(qdru1000_tlmm_exit);
>> +
>> +MODULE_DESCRIPTION("QTI QDRU1000 TLMM driver");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DEVICE_TABLE(of, qdru1000_tlmm_of_match);
>> diff --git a/drivers/pinctrl/qcom/pinctrl-qdru1000.h b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
>> new file mode 100644
>> index 000000000000..3c1f703ae53b
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-qdru1000.h
>> @@ -0,0 +1,1896 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#define FUNCTION(fname)			                \
>> +	[msm_mux_##fname] = {		                \
>> +		.name = #fname,				\
>> +		.groups = fname##_groups,               \
>> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
>> +	}
>> +
>> +#define REG_BASE 0x100000
>> +#define REG_SIZE 0x1000
>> +#define PINGROUP(id, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
>> +	{					        \
>> +		.name = "gpio" #id,			\
>> +		.pins = gpio##id##_pins,		\
>> +		.npins = (unsigned int)ARRAY_SIZE(gpio##id##_pins),	\
>> +		.funcs = (int[]){			\
>> +			msm_mux_gpio, /* gpio mode */	\
>> +			msm_mux_##f1,			\
>> +			msm_mux_##f2,			\
>> +			msm_mux_##f3,			\
>> +			msm_mux_##f4,			\
>> +			msm_mux_##f5,			\
>> +			msm_mux_##f6,			\
>> +			msm_mux_##f7,			\
>> +			msm_mux_##f8,			\
>> +			msm_mux_##f9			\
>> +		},				        \
>> +		.nfuncs = 10,				\
>> +		.ctl_reg = REG_BASE + REG_SIZE * id,			\
>> +		.io_reg = REG_BASE + 0x4 + REG_SIZE * id,		\
>> +		.intr_cfg_reg = REG_BASE + 0x8 + REG_SIZE * id,		\
>> +		.intr_status_reg = REG_BASE + 0xc + REG_SIZE * id,	\
>> +		.intr_target_reg = REG_BASE + 0x8 + REG_SIZE * id,	\
>> +		.mux_bit = 2,			\
>> +		.pull_bit = 0,			\
>> +		.drv_bit = 6,			\
>> +		.oe_bit = 9,			\
>> +		.in_bit = 0,			\
>> +		.out_bit = 1,			\
>> +		.intr_enable_bit = 0,		\
>> +		.intr_status_bit = 0,		\
>> +		.intr_target_bit = 5,		\
>> +		.intr_target_kpss_val = 3,	\
>> +		.intr_raw_status_bit = 4,	\
>> +		.intr_polarity_bit = 1,		\
>> +		.intr_detection_bit = 2,	\
>> +		.intr_detection_width = 2,	\
>> +	}
>> +
>> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
>> +	{					        \
>> +		.name = #pg_name,			\
>> +		.pins = pg_name##_pins,			\
>> +		.npins = (unsigned int)ARRAY_SIZE(pg_name##_pins),	\
>> +		.ctl_reg = REG_BASE + ctl,				\
>> +		.io_reg = 0,				\
>> +		.intr_cfg_reg = 0,			\
>> +		.intr_status_reg = 0,			\
>> +		.intr_target_reg = 0,			\
>> +		.mux_bit = -1,				\
>> +		.pull_bit = pull,			\
>> +		.drv_bit = drv,				\
>> +		.oe_bit = -1,				\
>> +		.in_bit = -1,				\
>> +		.out_bit = -1,				\
>> +		.intr_enable_bit = -1,			\
>> +		.intr_status_bit = -1,			\
>> +		.intr_target_bit = -1,			\
>> +		.intr_raw_status_bit = -1,		\
>> +		.intr_polarity_bit = -1,		\
>> +		.intr_detection_bit = -1,		\
>> +		.intr_detection_width = -1,		\
>> +	}
>> +
>> +#define UFS_RESET(pg_name, offset)				\
>> +	{					        \
>> +		.name = #pg_name,			\
>> +		.pins = pg_name##_pins,			\
>> +		.npins = (unsigned int)ARRAY_SIZE(pg_name##_pins),	\
>> +		.ctl_reg = offset,			\
>> +		.io_reg = offset + 0x4,			\
>> +		.intr_cfg_reg = 0,			\
>> +		.intr_status_reg = 0,			\
>> +		.intr_target_reg = 0,			\
>> +		.mux_bit = -1,				\
>> +		.pull_bit = 3,				\
>> +		.drv_bit = 0,				\
>> +		.oe_bit = -1,				\
>> +		.in_bit = -1,				\
>> +		.out_bit = 0,				\
>> +		.intr_enable_bit = -1,			\
>> +		.intr_status_bit = -1,			\
>> +		.intr_target_bit = -1,			\
>> +		.intr_raw_status_bit = -1,		\
>> +		.intr_polarity_bit = -1,		\
>> +		.intr_detection_bit = -1,		\
>> +		.intr_detection_width = -1,		\
>> +	}
>> +
>> +#define QUP_I3C(qup_mode, qup_offset)			\
>> +	{						\
>> +		.mode = qup_mode,			\
>> +		.offset = qup_offset,			\
>> +	}
>> +
>> +static const struct pinctrl_pin_desc qdru1000_pins[] = {
>> +	PINCTRL_PIN(0, "GPIO_0"),
>> +	PINCTRL_PIN(1, "GPIO_1"),
>> +	PINCTRL_PIN(2, "GPIO_2"),
>> +	PINCTRL_PIN(3, "GPIO_3"),
> Nope. Header is not a place for this stuff.
Will merge into driver file.
>
> Best regards,
> Krzysztof
>
Thanks,
Melody
