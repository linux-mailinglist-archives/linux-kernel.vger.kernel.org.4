Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1B8E5F1B2B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiJAJUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 05:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJAJUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 05:20:44 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319E1CB476
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 02:20:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id j16so10209547lfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 02:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=+wucZNX0Wwe0qQzZ7D8P59CVWmW7nCgHShbe6I3lY48=;
        b=SySlrt0VioI2J+vd5flh5fGNH5ZlxTsrRzpzbFJSBrbvZMtbDh86z64V6C0YW+NM12
         dnvf8FfBbKEXZlpywlvX9CmO1fnniKCPkdnnswze49wGJQfuvkA7u3OjwRQPB7SGEi52
         0UKpEcLuMLuQSrVwaK77NwCRnjKXZ/3FSxLpBoy6Ai+S9YH1tHvPmhDF31e1vtmgzD4Q
         fcxGU0Lxp+1rZmbvwEL1MxtM7JQVkMo/n1dwNtlVXJcYrHNEu4+eFb9FwScSUna/nb5M
         +LF/CF6KvHAEEc0B1VeU3MERZHHUnU+4+F5LNtODue5Uhzt2eKz4OmvDZn4UJsz9cwyX
         bLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=+wucZNX0Wwe0qQzZ7D8P59CVWmW7nCgHShbe6I3lY48=;
        b=nlJF8Dn0K8JgwIDB/pKIPtJ9iFUstINX6am+klKgaFsS0PI6B85JdLDPpTqnpz3idn
         eKr2UyWYChAO48sfHueFatJa47xUKYkc0PTb8dM8qLzzya+509UqOCGDLQGbFBT0EjOy
         FlOcy3GFb2rOCfPTq2KwuwJBfOpTH6ZTzZ7wFzgWoP7N4EiV/doAAyfqAwh7RokrVoWF
         CXflypIfa4NvHEssdB9Fo06WukyuQ1WVp5RZs1Ad+HHFU6JY6THWGqHWy24y1oZRUEyE
         HWSkrzHMIx2XcYmLpul2DeSsknBEFHzNe/2zB1EItEIG4JB8QeqEMnYIppbGnwjlqneT
         cjXQ==
X-Gm-Message-State: ACrzQf1o1r1y1a3xtBZpydKfGkj+0gav8P4j9Oq+wkUL/yHL3HNetFy/
        X43h0Hdzqizh1qQbOfFrdBXgXg==
X-Google-Smtp-Source: AMsMyM6Svfw02+ySiCJFl9MbBdIlPwjHKROPv/yWMiiGL74FoEWPw4z4aIZyr+GFy+jeTGblmX3UHg==
X-Received: by 2002:a05:6512:3c8c:b0:498:f7ba:9a69 with SMTP id h12-20020a0565123c8c00b00498f7ba9a69mr4675399lfv.8.1664616040517;
        Sat, 01 Oct 2022 02:20:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b0026bf43a4d72sm372746ljn.115.2022.10.01.02.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 02:20:39 -0700 (PDT)
Message-ID: <b12393d9-6b1a-a9cb-a964-cb2936da12cf@linaro.org>
Date:   Sat, 1 Oct 2022 11:20:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and QRU1000
 pinctrl bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221001030546.28220-1-quic_molvera@quicinc.com>
 <20221001030546.28220-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001030546.28220-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/2022 05:05, Melody Olvera wrote:
> Add documentation details for device tree bindings for QDU1000 and QRU1000
> TLMM devices.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../pinctrl/qcom,qdru1000-pinctrl.yaml        | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> new file mode 100644
> index 000000000000..e8d938303231
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/pinctrl/qcom,qdru1000-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  This binding describes the Top Level Mode Multiplexer block.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,qdu1000-tlmm
> +      - const: qcom,qru1000-tlmm
> +
> +  reg:
> +    items:
> +      - description: Base address of TLMM register space
> +      - description: Size of TLMM register space
> +
> +  interrupts:
> +    minItems: 0

Cannot be 0 of interrupts.

> +    maxItems: 1
> +    items:
> +      - const: TLMM summary IRQ
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    const: 2
> +
> +  wakeup-parent:
> +    maxItems: 1
> +    description:
> +      Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> +      a general description of GPIO and interrupt bindings.
> +
> +      Please refer to pinctrl-bindings.txt in this directory for details of the
> +      common pinctrl bindings used by client devices, including the meaning of the
> +      phrase "pin configuration node".
> +
> +      The pin configuration nodes act as a container for an arbitrary number of
> +      subnodes. Each of these subnodes represents some desired configuration for a
> +      pin, a group, or a list of pins or groups. This configuration can include the
> +      mux function to select on those pin(s)/group(s), and various pin configuration
> +      parameters, such as pull-up, drive strength, etc.
> +
> +
> +# PIN CONFIGURATION NODES
> +patternPropetries:
> +  '^.*$':
> +    if:
> +      type: object
> +    then:

Nope, that's not correct binding. It does not work. It never worked.

Please do it exactly like:
https://lore.kernel.org/linux-devicetree/20220930200529.331223-1-krzysztof.kozlowski@linaro.org/T/#m08b62ef5d873a52a5cbf3c53b25eff03726e7a16
https://lore.kernel.org/linux-devicetree/20220927173702.5200-1-krzysztof.kozlowski@linaro.org/T/#t


> +      properties:
> +        pins:
> +          description:
> +            List of gpio pins affected by the properties specified in
> +            this subnode.
> +          items:
> +            oneOf:
> +              - pattern: "^gpio([0-9]|[1-9][0-9]|1[0-9][0-9]|20[0-9])"
> +              - enum: [ sdc2_clk, sdc2_cmd, sdc2_data, ufs_reset ]
> +            minItems: 1
> +            maxItems: 36
> +        function:
> +          description:
> +            Specify the alternative function to be configured for the
> +            specified pins. Functions are only valid for gpio pins.
> +          enum: [gpio, aon_cam, atest_char, atest_char0, atest_char1, atest_char2, atest_char3,
> +            atest_usb0, atest_usb00, atest_usb01, atest_usb02, atest_usb03, audio_ref, cam_mclk,
> +            cci_async, cci_i2c, cci_timer0, cci_timer1, cci_timer2, cci_timer3, cci_timer4,
> +            cmu_rng0, cmu_rng1, cmu_rng2, cmu_rng3, coex_uart1, coex_uart2, cri_trng, cri_trng0,
> +            cri_trng1, dbg_out, ddr_bist, ddr_pxi0, ddr_pxi1, ddr_pxi2, ddr_pxi3, dp_hot, gcc_gp1,
> +            gcc_gp2, gcc_gp3, ibi_i3c, jitter_bist, mdp_vsync, mdp_vsync0, mdp_vsync1, mdp_vsync2,
> +            mdp_vsync3, mi2s0_data0, mi2s0_data1, mi2s0_sck, mi2s0_ws, mi2s2_data0, mi2s2_data1,
> +            mi2s2_sck, mi2s2_ws, mss_grfc0, mss_grfc1, mss_grfc10, mss_grfc11, mss_grfc12,
> +            mss_grfc2, mss_grfc3, mss_grfc4, mss_grfc5, mss_grfc6, mss_grfc7, mss_grfc8, mss_grfc9,
> +            nav_0, nav_1, nav_2, pcie0_clkreqn, pcie1_clkreqn, phase_flag0, phase_flag1,
> +            phase_flag10, phase_flag11, phase_flag12, phase_flag13, phase_flag14, phase_flag15,
> +            phase_flag16, phase_flag17, phase_flag18, phase_flag19, phase_flag2, phase_flag20,
> +            phase_flag21, phase_flag22, phase_flag23, phase_flag24, phase_flag25, phase_flag26,
> +            phase_flag27, phase_flag28, phase_flag29, phase_flag3, phase_flag30, phase_flag31,
> +            phase_flag4, phase_flag5, phase_flag6, phase_flag7, phase_flag8, phase_flag9, pll_bist,
> +            pll_clk, pri_mi2s, prng_rosc0, prng_rosc1, prng_rosc2, prng_rosc3, qdss_cti, qdss_gpio,
> +            qdss_gpio0, qdss_gpio1, qdss_gpio10, qdss_gpio11, qdss_gpio12, qdss_gpio13, qdss_gpio14,
> +            qdss_gpio15, qdss_gpio2, qdss_gpio3, qdss_gpio4, qdss_gpio5, qdss_gpio6, qdss_gpio7,
> +            qdss_gpio8, qdss_gpio9, qlink0_enable, qlink0_request, qlink0_wmss, qlink1_enable,
> +            qlink1_request, qlink1_wmss, qlink2_enable, qlink2_request, qlink2_wmss, qspi0, qspi1,
> +            qspi2, qspi3, qspi_clk, qspi_cs, qup0, qup1, qup10, qup11, qup12, qup13, qup14, qup15,
> +            qup16, qup17, qup18, qup19, qup2, qup20, qup21, qup3, qup4, qup5, qup6, qup7, qup8,
> +            qup9, qup_l4, qup_l5, qup_l6, sd_write, sdc40, sdc41, sdc42, sdc43, sdc4_clk, sdc4_cmd,
> +            sec_mi2s, tb_trig, tgu_ch0, tgu_ch1, tgu_ch2, tgu_ch3, tmess_prng0, tmess_prng1,
> +            tmess_prng2, tmess_prng3, tsense_pwm1, tsense_pwm2, uim0_clk, uim0_data, uim0_present,
> +            uim0_reset, uim1_clk, uim1_data, uim1_present, uim1_reset, usb2phy_ac, usb_phy, vfr_0,
> +            vfr_1, vsense_trigger]
> +        drive-strength:
> +          enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +          default: 2
> +          description:
> +            Selects the drive strength for the specified pins, in mA.
> +        bias-pull-down: true
> +        bias-pull-up: true
> +        bias-disable: true
> +        output-high: true
> +        output-low: true

You miss blank lines in several places. Please do it exactly like I
shown for sdm845.

> +      required:
> +        - pins
> +        - function
> +      additionalProperties: false
> +
> +examples:
> +  - |
> +    tlmm: pinctrl@03000000 {
> +      compatible = "qcom,qdu10000-tlmm";
> +      reg = <0x03000000 0xdc2000>;
> +      interrupts = <0 208 0>;

Use defines.

> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      #interrupt-cells = <2>;
> +      wakeup-parent = <&pdc>;

Missing children.

> +    };

Best regards,
Krzysztof

