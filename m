Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D306E3668
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 11:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjDPJFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 05:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDPJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 05:05:10 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10BD10D5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:05:08 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fw30so3790935ejc.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681635907; x=1684227907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ck4XYdD6YdZ8K9Gm8GO9YeJUD7xuHdlDYyGefMg4lk=;
        b=dCO6xdSmOV+3+ND61Z6QfE4A/f+qUhc3vXowb/fo4ukPDKFLgELwaPCVLyy/4hTBwl
         mtCEHVlQTGF2gTx7d4W+AY5GOHuMJrxcK9O+H8QJwI8Uu9jtO89c2nPE1x+Dr3B412XT
         RTiaU49QmhI7rcbBLmt1gT7V7+7hbJK8x/TLlos67UyyKJi7VLzfYJKnfEC6r9nNuz9U
         3jcz0eEorZViRRao+LdOPtQ87TcvGpv79GySuqUOgyeu4dapc/jAau0rIrDXdGmy6IB+
         aUzc+JWBZ6TRbKn2ESg2RWDIk5MmMA327xVyDV6Z9bX+O+Lz1BzAikavsrEeAC8I4oPC
         6ybQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681635907; x=1684227907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8ck4XYdD6YdZ8K9Gm8GO9YeJUD7xuHdlDYyGefMg4lk=;
        b=dAdsvpCa1r1SMrh2ma8ohNzr/iG5jokaJ/jk0MDPGgDPPc4kmesgukxmWiGVSSUcKH
         6eOdx5iv8of+dn3Ic0/Cf7sViq0Cy1NhmJpThZVGWUpZm98t85TZC53pjLJcuJAJa2TO
         5SZzmowWI5JAvMVNzQvPhIHBS2v41aC+6JY48hs6qO/Nmq9E1Y8gQNFZoviM+CQp8EN+
         MAAf36k3ppj09PtcN5rGMIt2s3tt5AsmhLynxtmTtvSkMpe7Cixfb5R8d4CK4X6PF3S4
         VcdVaLTs5r+BgpB8glfjy6zCkpuYwwU9iJyu6Pt25A8K++8bYs0H5+ScVMGd7/BMOBNM
         MH0Q==
X-Gm-Message-State: AAQBX9ei/5EDOngihTKK0bAyP+M6ioVNSBsaBo4qhJYBEfItXTP1QIJZ
        cYf4F9Xc59NNpwrwfiODwiIx3A==
X-Google-Smtp-Source: AKy350ZwKjKmAKbeHinOjCMQHeeTQx7fSWuMUdI9VaIwMvoujjiaVsAmXtfxKFN7MC9DMSO5OH/BTg==
X-Received: by 2002:a17:906:11d2:b0:932:e9c7:c32 with SMTP id o18-20020a17090611d200b00932e9c70c32mr4939847eja.59.1681635907347;
        Sun, 16 Apr 2023 02:05:07 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id z23-20020a1709063a1700b0094e7d196aa4sm4831007eje.160.2023.04.16.02.05.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 02:05:06 -0700 (PDT)
Message-ID: <536ed00f-e252-c8d3-e3ae-9bb9bb79babe@linaro.org>
Date:   Sun, 16 Apr 2023 11:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3 3/9] dt-bindings: pinctrl: qcom: Add support for
 ipq5018
Content-Language: en-US
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Nitheesh Sekar <quic_nsekar@quicinc.com>,
        Varadarajan Narayanan <quic_varada@quicinc.com>
References: <1681468167-11689-1-git-send-email-quic_srichara@quicinc.com>
 <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1681468167-11689-4-git-send-email-quic_srichara@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 12:29, Sricharan Ramabadhran wrote:
> Add device tree binding Documentation details for ipq5018
> pinctrl driver.
> 

Thank you for your patch. There is something to discuss/improve.

> +
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +  "#gpio-cells": true
> +  gpio-ranges: true
> +  wakeup-parent: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 33

24
(you cannot have more than 24...)

> +
> +  gpio-line-names:
> +    maxItems: 47
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-ipq5018-tlmm-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-ipq5018-tlmm-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-ipq5018-tlmm-state:
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
> +          pattern: "^gpio([0-9]|[1-3][0-9]|4[0-6])$"
> +        minItems: 1
> +        maxItems: 8
> +
> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +        enum: [ atest_char, audio_pdm0, audio_pdm1, audio_rxbclk, audio_rxd,
> +                audio_rxfsync, audio_rxmclk, audio_txbclk, audio_txd,
> +                audio_txfsync, audio_txmclk, blsp0_i2c, blsp0_spi, blsp0_uart0,
> +                blsp0_uart1, blsp1_i2c0, blsp1_i2c1, blsp1_spi0, blsp1_spi1,
> +                blsp1_uart0, blsp1_uart1, blsp1_uart2, blsp2_i2c0, blsp2_i2c1,
> +                blsp2_spi, blsp2_spi0, blsp2_spi1, btss, burn0, burn1, cri_trng,
> +                cri_trng0, cri_trng1, cxc_clk, cxc_data, dbg_out, eud_gpio,
> +                gcc_plltest, gcc_tlmm, gpio, led0, led2, mac0, mac1, mdc, mdio,
> +                pcie0_clk, pcie0_wake, pcie1_clk, pcie1_wake, pll_test,
> +                prng_rosc, pwm0, pwm1, pwm2, pwm3, qdss_cti_trig_in_a0,
> +                qdss_cti_trig_in_a1, qdss_cti_trig_in_b0, qdss_cti_trig_in_b1,
> +                qdss_cti_trig_out_a0, qdss_cti_trig_out_a1,
> +                qdss_cti_trig_out_b0, qdss_cti_trig_out_b1, qdss_traceclk_a,
> +                qdss_traceclk_b, qdss_tracectl_a, qdss_tracectl_b,
> +                qdss_tracedata_a, qdss_tracedata_b, qspi_clk, qspi_cs,
> +                qspi_data, reset_out, sdc1_clk, sdc1_cmd, sdc1_data, wci_txd,
> +                wci_rxd, wsa_swrm, wsi_clk3, wsi_data3, wsis_reset, xfem ]
> +
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      bias-disable: true
> +      drive-strength: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true

Drop all these 7, especially that input-enable is not allowed explicitly.

> +
> +    required:
> +      - pins
> +
> +    additionalProperties: false

Instead:
unevaluatedProperties: false
and put it after the $ref above. Just like recent changes in the next.

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
> +    tlmm: pinctrl@1000000 {
> +        compatible = "qcom,ipq5018-tlmm";
> +        reg = <0x01000000 0x300000>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 47>;
> +        interrupts = <GIC_SPI 208 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +
> +        uart2-state {
> +            pins = "gpio34", "gpio35";
> +            function = "blsp2_uart";

Does not look like you tested the bindings. Please run `make
dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).

Best regards,
Krzysztof

