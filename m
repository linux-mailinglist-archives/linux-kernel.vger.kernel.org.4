Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F937600155
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 18:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJPQaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 12:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJPQaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 12:30:13 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8704D21808
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:30:09 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id i9so6256776qvo.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RLCLC6l28ICU61ZnkvKWzFsSdviEqb8/d437SYfHEsU=;
        b=vXo9/lRaSIWx/kxotVGOjg4r7JjB2OFbP2QRA6HDJIPG/sOxBY1wGyAc6lABBOpNxn
         xngWfaVyc5NAZ569gS40OX7ZHOgmvvbOV4s9BaR5gtySUasE0MshJ7HhqeXIPWO2JzH0
         WatHzyQtFddsySVB9cVchCX0frIrRqrAvGHa6pRP0g++BV0D73BoYCPP3z1pJVtRSZx0
         SJsOjZxJeV48sFvRzkYeSsIxxeMdOIAxvMPtPqXhPYla5NeWhOgNwLgkN8m9AuYOkfA3
         JG0dqDIrnHlfg5l0AHRM6ToIJ2KLhDbY+gASCv6xGdHQmF8H7tGFvpLCj+GuSYrzPxkq
         jk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RLCLC6l28ICU61ZnkvKWzFsSdviEqb8/d437SYfHEsU=;
        b=ADwUjcWdUqzO9D1C6Yv9ECq+1+roDVQICDXwF/LgAar9LV0coHoEEj2NQLA0oKgBqj
         S857eQxvh3bmHq56iTUAnm+SuwFu8dhLlELS8lla+lnStYqkf2WBgGDsrnbLGYr3Ohgz
         wKQ5c7kWdH/mZQ6C+mf7yBk16a+X2ReuZQJRNT5zEZjFpqGDhq9fum3mQWQ4jNC1vDs8
         AUEEmAAoU2TZdLHG6sRT26OfTTgxXnUdDCN9lDlrwyt1EcH46wlkLG8c3DaJb5WIdX5D
         bX/aOTHLOuSBP9vSgnHlkz6WGcINSHsBvItX5eCRFfnGkFoF2butAewqY1x+YdzjJNdC
         2jJg==
X-Gm-Message-State: ACrzQf00ttCKGfqjOzTED1gdEi27tmCuh4JlGE8GETvwtsZdJPiiHyBe
        3k1KyS8G8HXTmy1di5j1kAwpOQ==
X-Google-Smtp-Source: AMsMyM5F3K5BfFAzBBmvcY1mpeisDu1Tejr9nvTu8Q6o7f7Gi9HiOPuItDv1dTpBKnyfUvDK/3kKNA==
X-Received: by 2002:ad4:5f4f:0:b0:4b1:db1e:6c01 with SMTP id p15-20020ad45f4f000000b004b1db1e6c01mr5707261qvg.100.1665937808692;
        Sun, 16 Oct 2022 09:30:08 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9b13:d679:7b5b:6921? ([2601:42:0:3450:9b13:d679:7b5b:6921])
        by smtp.gmail.com with ESMTPSA id 74-20020a37084d000000b006ee7923c187sm7099928qki.42.2022.10.16.09.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Oct 2022 09:30:07 -0700 (PDT)
Message-ID: <01bc7712-30c8-ab6d-c795-abd0f941cea0@linaro.org>
Date:   Sun, 16 Oct 2022 12:30:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 3/3] dt-bindings: pinctrl: qcom,sc7180: convert to
 dtschema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
References: <20221013184700.87260-1-krzysztof.kozlowski@linaro.org>
 <20221013184700.87260-3-krzysztof.kozlowski@linaro.org>
 <CAD=FV=UvuiU2GhjTwSxu-SK8C6ovLTwyakf55GRs_g-8b+caUQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=UvuiU2GhjTwSxu-SK8C6ovLTwyakf55GRs_g-8b+caUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 14:02, Doug Anderson wrote:
> Hi,
> 
> On Thu, Oct 13, 2022 at 11:49 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
>> new file mode 100644
>> index 000000000000..464f1031d15d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> 
> [ ... cut ... ]
> 
>> @@ -0,0 +1,162 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pinctrl/qcom,sc7180-pinctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm SC7180 TLMM pin controller
>> +
>> +maintainers:
>> +  - Bjorn Andersson <andersson@kernel.org>
>> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> +
>> +description:
>> +  Top Level Mode Multiplexer pin controller in Qualcomm SC7180 SoC.
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sc7180-pinctrl
>> +
>> +  reg:
>> +    maxItems: 3
>> +
>> +  reg-names:
>> +    items:
>> +      - const: west
>> +      - const: north
>> +      - const: south
>> +
>> +  interrupts: true
>> +  interrupt-controller: true
>> +  "#interrupt-cells": true
>> +  gpio-controller: true
>> +  "#gpio-cells": true
>> +  gpio-ranges: true
>> +  wakeup-parent: true
> 
> Do you need interrupts/interrupt-controller/.../... ? Below you
> include allOf "/schemas/pinctrl/qcom,tlmm-common.yaml". Won't you
> magically get those from there? Why do you need to duplicate this?

There is additionalProperties:false, so every property from referenced
schema has to be included.

The true solution would be to switch to unevaluatedProperties:false but
then we accept all properties from:
1. qcom,tlmm-common.yaml - not a problem, we already mention all of them
here with :true
2. pinctrl.yaml - we would now allow to use pinctrl-use-default.
3. any other future common properties.

> 
> 
>> +  gpio-reserved-ranges:
>> +    minItems: 1
>> +    maxItems: 60
>> +
>> +  gpio-line-names:
>> +    maxItems: 119
>> +
>> +patternProperties:
>> +  "-state$":
>> +    oneOf:
>> +      - $ref: "#/$defs/qcom-sc7180-tlmm-state"
>> +      - patternProperties:
>> +          "-pins$":
>> +            $ref: "#/$defs/qcom-sc7180-tlmm-state"
>> +        additionalProperties: false
>> +
>> +$defs:
>> +  qcom-sc7180-tlmm-state:
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
>> +            - pattern: "^gpio([0-9]|[1-9][0-9]|10[0-9]|11[0-8])$"
>> +            - enum: [ sdc1_rclk, sdc1_clk, sdc1_cmd, sdc1_data, sdc2_clk,
>> +                      sdc2_cmd, sdc2_data, ufs_reset ]
>> +        minItems: 1
>> +        maxItems: 36
>> +
>> +      function:
>> +        description:
>> +          Specify the alternative function to be configured for the specified
>> +          pins.
>> +
>> +        enum: [ adsp_ext, agera_pll, aoss_cti, atest_char, atest_char0,
>> +                atest_char1, atest_char2, atest_char3, atest_tsens,
>> +                atest_tsens2, atest_usb1, atest_usb10, atest_usb11,
>> +                atest_usb12, atest_usb13, atest_usb2, atest_usb20, atest_usb21,
>> +                atest_usb22, atest_usb23, audio_ref, btfm_slimbus, cam_mclk,
>> +                cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2,
>> +                cci_timer3, cci_timer4, cri_trng, dbg_out, ddr_bist, ddr_pxi0,
>> +                ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, edp_lcd, gcc_gp1,
>> +                gcc_gp2, gcc_gp3, gpio, gp_pdm0, gp_pdm1, gp_pdm2, gps_tx,
>> +                jitter_bist, ldo_en, ldo_update, lpass_ext, mdp_vsync,
>> +                mdp_vsync0, mdp_vsync1, mdp_vsync2, mdp_vsync3, mi2s_0, mi2s_1,
>> +                mi2s_2, mss_lte, m_voc, pa_indicator, phase_flag, PLL_BIST,
>> +                pll_bypassnl, pll_reset, prng_rosc, qdss, qdss_cti,
>> +                qlink_enable, qlink_request, qspi_clk, qspi_cs, qspi_data,
>> +                qup00, qup01, qup02_i2c, qup02_uart, qup03, qup04_i2c,
>> +                qup04_uart, qup05, qup10, qup11_i2c, qup11_uart, qup12,
>> +                qup13_i2c, qup13_uart, qup14, qup15, sdc1_tb, sdc2_tb,
>> +                sd_write, sp_cmu, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3,
>> +                tsense_pwm1, tsense_pwm2, uim1, uim2, uim_batt, usb_phy, vfr_1,
>> +                _V_GPIO, _V_PPS_IN, _V_PPS_OUT, vsense_trigger, wlan1_adc0,
>> +                wlan1_adc1, wlan2_adc0, wlan2_adc1 ]
>> +
>> +      drive-strength:
>> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
>> +        description:
>> +          Selects the drive strength for the specified pins, in mA.
> 
> Again, why do you need to duplicate. The yaml is weak in me, but I
> think you're effectively subclassing
> "qcom,tlmm-common.yaml#/$defs/qcom-tlmm-state", right? It has the
> exact same definition of drive-strength. Why duplicate it?

Yes, this can be dropped.

> 
> 
>> +      bias-pull-down: true
>> +      bias-pull-up: true
>> +      bias-disable: true
>> +      input-enable: true
>> +      output-high: true
>> +      output-low: true
> 
> Again, maybe the above properties aren't needed? Don't you inherit
> them from tlmm-common?

From tlmm-common yes, however without this and
additionalProperties:false we would accept everything from pincfg-node
which too much. The binding/hardware does not support all of them, I think.

Best regards,
Krzysztof

