Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5D07372D9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 19:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjFTR2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjFTR2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 13:28:15 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CCC1BCD;
        Tue, 20 Jun 2023 10:27:57 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77e3f25446bso67844839f.1;
        Tue, 20 Jun 2023 10:27:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687282076; x=1689874076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DtmXvzTKV50ciUPxU/tBlIrW6Rdi+4ramlafrVnIKhs=;
        b=LV8KUNntAuKLZpgT4zJVBO24CJ1bZ4CC0LGfX4rxeVDj8F8H3MYQ10EMO4WoF6eUyd
         442xcDsFxZYc4VL2rfhmJFCKSpWOjqe6xAWzyHURNcEICv8E9PzG+AD4aUXq81usMPRX
         04YTjWUAsPCTvElA9Wz6xN/o4UZRF/4piya3Sc/1meuZDxCduaP1Tm1TPNrBoXyEA7Q5
         N3kSgiim2zJvFq9iNzQfn+m3gH54E3m0YPRK7++zPsw3pJMCfDsL4TF2hrghb1ccTHti
         8Aypn5PHPkJyy1jgumUNS/EFu3iFYXhfhHXhI4FHMgZXt/Q9dyCXCbmb6wf59kbH7JK3
         pgbg==
X-Gm-Message-State: AC+VfDwqiflhPRGpMClqNYKkOdD+ZmzU9weN4Mw9Zhl4mnKVIapgQhVe
        JSbwsE3lMRqBt9TI6zD/Wg==
X-Google-Smtp-Source: ACHHUZ4guYbQXENVIXMxtZn/ZzFiBW17twj3s5exPO+ukdj++CH8m91siOGF+oRbnDaeK4LTL8iS8w==
X-Received: by 2002:a6b:8d8f:0:b0:774:814a:1abe with SMTP id p137-20020a6b8d8f000000b00774814a1abemr7367864iod.1.1687282076223;
        Tue, 20 Jun 2023 10:27:56 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y8-20020a6bd808000000b0077ac2261248sm787628iob.5.2023.06.20.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:27:55 -0700 (PDT)
Received: (nullmailer pid 3860166 invoked by uid 1000);
        Tue, 20 Jun 2023 17:27:53 -0000
Date:   Tue, 20 Jun 2023 11:27:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: qcom,sm8350-lpass-lpi: add
 SM8350 LPASS TLMM
Message-ID: <20230620172753.GA3858158-robh@kernel.org>
References: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619092735.20323-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 11:27:33AM +0200, Krzysztof Kozlowski wrote:
> Add bidings for pin controller in SM8350 Low Power Audio SubSystem

bidings?

> (LPASS).
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. None
> ---
>  .../qcom,sm8350-lpass-lpi-pinctrl.yaml        | 144 ++++++++++++++++++
>  1 file changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
> new file mode 100644
> index 000000000000..0fb2002772b9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml
> @@ -0,0 +1,144 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8350 SoC LPASS LPI TLMM
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description:
> +  Top Level Mode Multiplexer pin controller in the Low Power Audio SubSystem
> +  (LPASS) Low Power Island (LPI) of Qualcomm SM8350 SoC.
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8350-lpass-lpi-pinctrl
> +
> +  reg:
> +    items:
> +      - description: LPASS LPI TLMM Control and Status registers
> +      - description: LPASS LPI MCC registers
> +
> +  clocks:
> +    items:
> +      - description: LPASS Core voting clock
> +      - description: LPASS Audio voting clock
> +
> +  clock-names:
> +    items:
> +      - const: core
> +      - const: audio
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    description: Specifying the pin number and flags, as defined in
> +      include/dt-bindings/gpio/gpio.h
> +    const: 2
> +
> +  gpio-ranges:
> +    maxItems: 1
> +
> +patternProperties:
> +  "-state$":
> +    oneOf:
> +      - $ref: "#/$defs/qcom-sm8350-lpass-state"
> +      - patternProperties:
> +          "-pins$":
> +            $ref: "#/$defs/qcom-sm8350-lpass-state"
> +        additionalProperties: false
> +
> +$defs:
> +  qcom-sm8350-lpass-state:
> +    type: object
> +    description:
> +      Pinctrl node's client devices use subnodes for desired pin configuration.
> +      Client device subnodes use below standard properties.
> +    $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +    properties:
> +      pins:
> +        description:
> +          List of gpio pins affected by the properties specified in this
> +          subnode.
> +        items:
> +          pattern: "^gpio([0-9]|1[0-9]|2[0-2])$"
> +
> +      function:
> +        enum: [ dmic1_clk, dmic1_data, dmic2_clk, dmic2_data, dmic3_clk,
> +                dmic3_data, dmic4_clk, dmic4_data, ext_mclk1_a, ext_mclk1_b,
> +                ext_mclk1_c, ext_mclk1_d, ext_mclk1_e, gpio, i2s0_clk,
> +                i2s0_data, i2s0_ws, i2s1_clk, i2s1_data, i2s1_ws, i2s2_clk,
> +                i2s2_data, i2s2_ws, i2s3_clk, i2s3_data, i2s3_ws, i2s4_clk,
> +                i2s4_data, i2s4_ws, slimbus_clk, slimbus_data, swr_rx_clk,
> +                swr_rx_data, swr_tx_clk, swr_tx_data, wsa_swr_clk,
> +                wsa_swr_data, wsa2_swr_clk, wsa2_swr_data ]
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +
> +      drive-strength:
> +        enum: [2, 4, 6, 8, 10, 12, 14, 16]
> +        default: 2
> +        description:
> +          Selects the drive strength for the specified pins, in mA.
> +
> +      slew-rate:
> +        enum: [0, 1, 2, 3]
> +        default: 0
> +        description: |
> +          0: No adjustments
> +          1: Higher Slew rate (faster edges)
> +          2: Lower Slew rate (slower edges)
> +          3: Reserved (No adjustments)
> +
> +      bias-bus-hold: true
> +      bias-pull-down: true
> +      bias-pull-up: true
> +      bias-disable: true
> +      input-enable: true
> +      output-high: true
> +      output-low: true
> +
> +    required:
> +      - pins
> +      - function
> +
> +    additionalProperties: false
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/sound/qcom,q6afe.h>
> +
> +    lpass_tlmm: pinctrl@33c0000 {

Drop unused label.

With those,

Reviewed-by: Rob Herring <robh@kernel.org>
