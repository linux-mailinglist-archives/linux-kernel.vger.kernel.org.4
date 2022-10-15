Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BC15FFA51
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJONik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 09:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJONif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 09:38:35 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9B450BAB
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:38:33 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y10so4923073qvo.11
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 06:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b4mFuuQ02+k8VW/5xjkVPK8npqQHe0XxF+FCDJo3Hcg=;
        b=DoOYXpdPLNWOMXDRp0prW3SvEcK/aB/3+tcdxwCILldlDfJgxCaozEVW/9DGsa5Dwq
         oecx+8HokOuRfboz2j2dC4gJ+2k6KZjmWXMbcgXchm9Tjk/EnDpa6hsJGm8X+Lx7jl0r
         x5pUPsOHjOLG6Dmi7rfXx/iafVm8+GEe4QJOSmEk2Cl5X0nlH07ULKVViJM7kqTEdTuZ
         YwY411h2mrGstwfFTDD45XaAEKGts+eKLqUo23m5RaZ2zOF3uL3G/u4ki/H7AqxHzyxF
         dv6GPI+Ja+eejpfBZwlPCnDHDZ5B3nlOfe26zx3bvGBdPecGnwejLWtHmBBKsDyTa9K5
         Perg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b4mFuuQ02+k8VW/5xjkVPK8npqQHe0XxF+FCDJo3Hcg=;
        b=7fTs87FjqqRnVP4/vfPatmvN7PRPONl8WexlT31MkyjvhMoUxKPpN4or4YHhvgPMdr
         eB3nqPnidsRUAWsC+cwgTecOTAGL+evCmBCFQ9a/FjL+qwCB7Q39D5Ii3QjSIoY6TUOv
         wxK/fW+Fvyb5/0HmUmBbfcPhHJgzhxG1nDkBHuHnalVXF+V1QDNyguiAX8KmAsdy9qtT
         o4wOgDwJOtB9Xgnf9D0GJGBkImyffDeYNT0bYO58WPPgv4UY+2l6cvDfaczqMNH9O+1a
         f0T/E9IsVVHd9YRPZPbvkWJAR6snkDYBMM3tzHMH2LVYlqIzCYhIsgsSsMYvTUGwLfvJ
         XO4w==
X-Gm-Message-State: ACrzQf2WBO2YPzR/mkdNJs9HrTT6O/z/5/OGEVgwhG0+Ie7N42eAP0dP
        igZ5v/j45SJrOkvxX1KPScc0Mg==
X-Google-Smtp-Source: AMsMyM6ZcNE+k+H3T3uhOv353caTXc7OucwsHBiUGFwt9cwNSA1Gu2njofua+LBP5Yms3gJuPwvsjw==
X-Received: by 2002:a05:6214:c42:b0:4b4:2d1:c752 with SMTP id r2-20020a0562140c4200b004b402d1c752mr1796962qvj.28.1665841112867;
        Sat, 15 Oct 2022 06:38:32 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:161:5720:79e9:9739? ([2601:42:0:3450:161:5720:79e9:9739])
        by smtp.gmail.com with ESMTPSA id s10-20020a05622a1a8a00b0039492d503cdsm4229446qtc.51.2022.10.15.06.38.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 06:38:31 -0700 (PDT)
Message-ID: <199530e8-2e84-3b82-3d9a-265d38fd6fab@linaro.org>
Date:   Sat, 15 Oct 2022 09:38:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221025.7372-1-quic_molvera@quicinc.com>
 <20221014221025.7372-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221025.7372-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:10, Melody Olvera wrote:
> Add documentation details for device tree bindings for QDU1000 and QRU1000
> TLMM devices.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../pinctrl/qcom,qdu1000-pinctrl.yaml         | 159 ++++++++++++++++++
>  1 file changed, 159 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml
> new file mode 100644
> index 000000000000..2ec661e5e1e0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-pinctrl.yaml

Filename matching compatible, so qcom,qdu1000-tlmm.yaml

> @@ -0,0 +1,159 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block (TLMM) found
> +  in the QDU1000 and QRU1000 platforms.
> +
> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,qdu1000-tlmm
> +      - const: qcom,qru1000-tlmm
> +
> +  reg:
> +    maxItems: 1

Blank line

> +  interrupts: true
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 75
> +
> +  gpio-line-names:
> +    maxItems: 150
> +
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-qdu1000-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-qdu1000-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-qdu1000-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
> +            - enum: [ ufs_reset, sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2,
> +                atest_usb1, atest_usb10, atest_usb11, atest_usb12, atest_usb13,
> +                atest_usb2, atest_usb20, atest_usb21, atest_usb22, atest_usb23,
> +                audio_ref, btfm_slimbus, cam_mclk, cci_async, cci_i2c,
> +                cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> +                cri_trng, cri_trng0, cri_trng1, dbg_out, ddr_bist, ddr_pxi0,
> +                ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1,
> +                gcc_gp2, gcc_gp3, gpio, jitter_bist, ldo_en, ldo_update,
> +                lpass_slimbus, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> +                mdp_vsync3, mss_lte, m_voc, nav_pps, pa_indicator, pci_e0,
> +                pci_e1, phase_flag, pll_bist, pll_bypassnl, pll_reset,
> +                pri_mi2s, pri_mi2s_ws, prng_rosc, qdss, qdss_cti, qlink_enable,
> +                qlink_request, qspi_clk, qspi_cs, qspi_data, qua_mi2s, qup0,
> +                qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2, qup3,
> +                qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6,
> +                sdc4_clk, sdc4_cmd, sdc4_data, sd_write, sec_mi2s, sp_cmu,
> +                spkr_i2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
> +                tsense_pwm1, tsense_pwm2, tsif1_clk, tsif1_data, tsif1_en,
> +                tsif1_error, tsif1_sync, tsif2_clk, tsif2_data, tsif2_en,
> +                tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
> +                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset,
> +                uim_batt, usb_phy, vfr_1, vsense_trigger, wlan1_adc0,
> +                wlan1_adc1, wlan2_adc0, wlan2_adc1]
> +
> +      bias-disable: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pinctrl@03000000 {
> +        compatible = "qcom,qdu1000-pinctrl";
> +        reg = <0x03000000 0xdc2000>;
> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 151>;
> +        wakeup-parent = <&pdc_intc>;
> +
> +        cci0-default-state {

You have now bindings for your new SoC and you still did not run them
against your own DTS... The purpose of DT schema is not only to have
them, but actually to use them.

There is no point for us to do manual review if automated tools can do
the work, right?

So please test your DTS.

Best regards,
Krzysztof

