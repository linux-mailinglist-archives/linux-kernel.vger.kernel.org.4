Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CEE25ED7A4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233274AbiI1IZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 04:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233181AbiI1IZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 04:25:24 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E838B50718
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:25:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id u18so19228581lfo.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 01:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=44BDHNSti79tl8v1Eaa7d6KYOVFkLP1VzWu1QAI0Esc=;
        b=RRP7gVQNWd4jOJ3YkjEKGjRwsb/inj6ShkxUxpCzFUXnrrLQAvUEXls71fGmU57mg9
         LIXaW33WyWLiPEqPFCufgX99n/i1w+ksxWFx/3TCuyAK0TZ9Untje5vKu+Z9YBXl0Ft+
         bdRQzvgON66SjoXR9sVSQHP5r0F4SA/hY4Q8+3pcno+C5/p0F/0H32fBKmSwFJ/q+nQC
         hWoBPILfKg9g/OJvDcfb4J9lGLKh+mUImjWDOibS8joTGtZT/vooOkn603u9pOcULjKL
         wSkSm1JjugUmiQ910+kGAJ0kYD2KWdI8raE4jFySNrNDlTWqHHBP5YQHB2amClo5DhVH
         AIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=44BDHNSti79tl8v1Eaa7d6KYOVFkLP1VzWu1QAI0Esc=;
        b=Lp1eXo1uiLk2lbLmNTxSy3uZcwt4wjyEaYUHtAT0Zht7+gspQnPhosG/8qvE8+QkY+
         HtPPGhWdvnwIjw0QuI9SZMNBg7qm5MSLfMjxpDDYU0TUf4xHBMgimvBrMsWhXkiZ254u
         gTIDfOGGM3Z9b+5aLK9LbEYGnA1Tq+lyMntbDz9A+jrxiV1dJsbrQg6rn4jdevQ09lxX
         dYQ4wp9DPM5OD2V9Km+0vXkRxc4lJ44m4grEf408ORQZTMoFoHon1FV8xzQYKoNstMbx
         qgRM7WIXS3nbqEkT9oGcJgQv+nswiMGrH+EkBlFJqlqtgJc9adjqANfaoyZu1WxBUlV7
         MUQg==
X-Gm-Message-State: ACrzQf1uDcIAixWsSh2ateJ8Ljg4xf61ZZ40xxMwFzOkJj3qPvqbNROg
        bgnnbJJcJ7GSpacwNOaK06IP3Q==
X-Google-Smtp-Source: AMsMyM7mHw+7O59tuyhPhnTMDLtidSY7Y9Ozeqjd0eFgcm1SvbjWGeI0J7uO+JL8WwD3O6Ty62EexQ==
X-Received: by 2002:a05:6512:159e:b0:498:f1eb:f7a with SMTP id bp30-20020a056512159e00b00498f1eb0f7amr12170717lfb.425.1664353517084;
        Wed, 28 Sep 2022 01:25:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n13-20020a05651203ed00b004978e51b691sm408596lfq.266.2022.09.28.01.25.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 01:25:16 -0700 (PDT)
Message-ID: <7757c8bd-67cc-17cf-657d-da83fb3994b7@linaro.org>
Date:   Wed, 28 Sep 2022 10:25:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 1/3] dt-bindings: pinctrl: qcom: add sdm670 pinctrl
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220927230833.125749-1-mailingradian@gmail.com>
 <20220927230833.125749-2-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220927230833.125749-2-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 01:08, Richard Acayan wrote:
> There is a new driver for the Snapdragon 670 TLMM (Top-Level Mode
> Multiplexer). Document it.
> 
> Adapted from qcom,sm6350-pinctrl.yaml.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 138 ++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> new file mode 100644
> index 000000000000..1d8e76db57c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sdm670-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SDM670 TLMM block
> +
> +maintainers:
> +  - Richard Acayan <mailingradian@gmail.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer (TLMM) block found
> +  in the SDM670 platform.
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sdm670-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  '#interrupt-cells': true
> +  gpio-controller: true
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 75
> +
> +  '#gpio-cells': true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +patternProperties:
> +  '-state$':

Use " quotes here.

> +    oneOf:
> +      - $ref: "#/$defs/qcom-sdm670-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sdm670-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sdm670-tlmm-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          oneOf:
> +            - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
> +            - enum: [ ufs_reset, sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data,
> +                      sdc2_clk, sdc2_cmd, sdc2_data ]
> +        minItems: 1
> +        maxItems: 36
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ adsp_ext, agera_pll, atest_char, atest_tsens, atest_tsens2, atest_usb1, atest_usb10,
> +                atest_usb11, atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21,
> +                atest_usb22, atest_usb23, cam_mclk, cci_async, cci_i2c, cci_timer0, cci_timer1,
> +                cci_timer2, cci_timer3, cci_timer4, copy_gp, copy_phase, dbg_out, ddr_bist,
> +                ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, edp_hot, edp_lcd, gcc_gp1, gcc_gp2, gcc_gp3,
> +                gp_pdm0, gp_pdm1, gp_pdm2, gpio, gps_tx, jitter_bist, ldo_en, ldo_update,
> +                lpass_slimbus, m_voc, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3,
> +                mss_lte, nav_pps, pa_indicator, pci_e0, pci_e1, phase_flag, pll_bist, pll_bypassnl,
> +                pll_reset, pri_mi2s, pri_mi2s_ws, prng_rosc, qdss_cti, qdss, qlink_enable,
> +                qlink_request, qua_mi2s, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15, qup2,
> +                qup3, qup4, qup5, qup6, qup7, qup8, qup9, qup_l4, qup_l5, qup_l6, sdc4_clk,
> +                sdc4_cmd, sdc4_data, sd_write, sec_mi2s, ter_mi2s, tgu_ch0, tgu_ch1, tgu_ch2,
> +                tgu_ch3, tsif1_clk, tsif1_data, tsif1_en, tsif1_error, tsif1_sync, tsif2_clk,
> +                tsif2_data, tsif2_en, tsif2_error, tsif2_sync, uim1_clk, uim1_data, uim1_present,
> +                uim1_reset, uim2_clk, uim2_data, uim2_present, uim2_reset, uim_batt, usb_phy, vfr_1,
> +                vsense_trigger, wlan1_adc0, wlan1_adc1, wlan2_adc0, wlan2_adc1, wsa_clk, wsa_data, ]
> +
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
> +    allOf:
> +      - $ref: "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state"

Drop quotes.

> +      - if:
> +          properties:
> +            pins:
> +              pattern: "^gpio([0-9]|[1-9][0-9]|1[0-4][0-9])$"
> +        then:
> +          required:
> +            - function
> +

You can drop it (and move the ref just after description). This will be
handled with common schema:
https://lore.kernel.org/linux-devicetree/20220927173702.5200-1-krzysztof.kozlowski@linaro.org/T/#m48dedb167f16315dbacd5c56c57f9033fe28a5d9

This however is not a dependency - if you remove these lines, your patch
can still be applied independently of mine.

Best regards,
Krzysztof

