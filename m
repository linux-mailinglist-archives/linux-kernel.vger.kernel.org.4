Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A7604F91
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 20:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiJSSW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 14:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJSSW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 14:22:56 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A17D1BBEF0;
        Wed, 19 Oct 2022 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666203774; x=1697739774;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TMpxtyP3Z/4Q9i7TSn8VljPk4WqZmZ356B09v3/00MU=;
  b=pL6wpvZQZCiTNw+Y3/1/XQtP9YmT16wIBnqe8HCNty2K7PtivX0nu+we
   PUYCVQI3aaxN/sGYMCWVZMeoxnIouEc5xZd9r5WxIxIYRRXN63lvphYtC
   MEsO7mzL08z1fFN17M6r6h18ij8eF2XVZWNw8Pf9aEdnilT3GGVE86z91
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Oct 2022 11:22:54 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 11:22:53 -0700
Received: from [10.134.66.255] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 11:22:53 -0700
Message-ID: <32c48147-be2f-9e32-b6df-29fef1e33fbc@quicinc.com>
Date:   Wed, 19 Oct 2022 11:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
 <20221014221025.7372-2-quic_molvera@quicinc.com>
 <199530e8-2e84-3b82-3d9a-265d38fd6fab@linaro.org>
From:   Melody Olvera <quic_molvera@quicinc.com>
In-Reply-To: <199530e8-2e84-3b82-3d9a-265d38fd6fab@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/15/2022 6:38 AM, Krzysztof Kozlowski wrote:
> On 14/10/2022 18:10, Melody Olvera wrote:
>> Add documentation details for device tree bindings for QDU1000 and QRU1000
>> TLMM devices.
>>
>> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
>> ---
>>  .../pinctrl/qcom,qdu1000-pinctrl.yaml         | 159 ++++++++++++++++++
>>  1 file changed, 159 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..2ec661e5e1e0
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
> Filename matching compatible, so qcom,qdu1000-tlmm.yaml
Got it.
>> @@ -0,0 +1,159 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
>> +
>> +maintainers:
>> +  - Melody Olvera <quic_molvera@quicinc.com>
>> +
>> +description: |
>> +  This binding describes the Top Level Mode Multiplexer block (TLMM) found
>> +  in the QDU1000 and QRU1000 platforms.
>> +
>> +allOf:
>> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    items:
>> +      - const: qcom,qdu1000-tlmm
>> +      - const: qcom,qru1000-tlmm
>> +
>> +  reg:
>> +    maxItems: 1
> Blank line
Sure.
>
>> +  interrupts: true
>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 75
>> +
>> +  gpio-line-names:
>> +    maxItems: 150
>> +
>> +  "#gpio-cells": true
>> +  gpio-ranges: true
>> +  wakeup-parent: true
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-qdu1000-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-qdu1000-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-qdu1000-tlmm-state:
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
>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
>> +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
>> +        minItems: 1
>> +        maxItems: 36
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2,
>> +                atest_usb1, atest_usb10, atest_usb11, atest_usb12, atest_usb13,
>> +                atest_usb2, atest_usb20, atest_usb21, atest_usb22, atest_usb23,
>> +                audio_ref, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
>> +                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
>> +                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
>> +                ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1,
>> +                gcc_gp2, gcc_gp3, gpio, jitter_bist, ldo_en, ldo_update,
>> +                lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
>> +                mdp_vsync3, mss_lte, m_voc, nav_pps, pa_indicator, pci_e0,
>> +                pci_e1, phase_flag, pll_bist, pll_bypassnl, pll_reset,
>> +                pri_mi2s, pri_mi2s_ws, prng_rosc, qdss, qdss_cti, qlink_enable,
>> +                qlink_request, qspi_clk, qspi_cs, qspi_data, qua_mi2s, qup0,
>> +                qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2, qup3,
>> +                qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6,
>> +                sdc4_clk, sdc4_cmd, sdc4_data, sd_write, sec_mi2s, sp_cmu,
>> +                spkr_i2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
>> +                tsense_pwm1, tsense_pwm2, tsif1_clk, tsif1_data, tsif1_en,
>> +                tsif1_error, tsif1_sync, tsif2_clk, tsif2_data, tsif2_en,
>> +                tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
>> +                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset,
>> +                uim_batt, usb_phy, vfr_1, vsense_trigger, wlan1_adc0,
>> +                wlan1_adc1, wlan2_adc0, wlan2_adc1]
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
>> +    pinctrl@03000000 {
>> +        compatible = "qcom,qdu1000-pinctrl";
>> +        reg = <0x03000000 0xdc2000>;
>> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        interrupt-controller;
>> +        #interrupt-cells = <2>;
>> +        gpio-ranges = <&tlmm 0 0 151>;
>> +        wakeup-parent = <&pdc_intc>;
>> +
>> +        cci0-default-state {
> You have now bindings for your new SoC and you still did not run them
> against your own DTS... The purpose of DT schema is not only to have
> them, but actually to use them.
>
> There is no point for us to do manual review if automated tools can do
> the work, right?
>
> So please test your DTS.
Yes this is very fair. Apologies; I'm new to this process so I'm still learning about the
tools at my disposal. I believe I've figured out running dt_bindings_check and dtbs_check;
future patchsets will have these run prior to submitting.

Thanks,
Melody

