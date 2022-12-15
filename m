Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F764D944
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiLOKIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiLOKIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:08:49 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306C0186F1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:08:47 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id l8so9388998ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 02:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=48ouQIpnbSuWbwn4iletul7ZbmMkhr3Ykr/KxHK23u4=;
        b=aAq6NZXVGPXPiZFlEEopg5LXEZkHPvE2GrFZKeBQMkFMOyD3OriN/Q41jXRZyYCrLm
         CfWelh+vc225vPDWXZYVuNfK80wsKXn9+7f0b/mpGrduzNMh2T5wDLCfcuqZvACRQnhn
         3GRWSdw2Ynsx0dnJvdTskqNwp8navKpwy1M03muTq1JDdGUpfxAaFhW7NDwxhniGxuqv
         gf3AAMXp1i1d3EW5LBecXO+EMeu8bpsr+xcJ2f0sDQyTGHqt2/4g+IzXxEUeioj1o6dw
         0gkB4nMybHQ8z/SmG89oXmKFzpJ467lo7Lof2MUErcKaRAyKRe5mtATt0zKlbxjRjeD/
         e/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=48ouQIpnbSuWbwn4iletul7ZbmMkhr3Ykr/KxHK23u4=;
        b=gZvFYLeISFqpyo5Nc5624vKDSfRQidAd2439dz9+vq/xOA9Od/jWFWMehsl7w7xxzW
         47NS6V5bl26STGwXB2G3HXrfzOhG5smbocPhY1na0XXuep8tQmAogBe4IUJBmO3e9xE0
         R/6EirRui531LzWFwvFmXsSzT+k1DZC2e2Z2A6v7exzpL6BKeesrGd37iTe7PH6Z8GVI
         4FBgZP4lhZy7+R0dVvhtNz9G/ROeihjtTzYoRUaAT5W6ner/QXzvaEExvJSOwSG5tiBa
         SIoMJUtohWVdRPhdhlvo5ByZxLvjjwwkJxmqVGxf8DoioQsvO1iedbwdYJqeIQEIUUpN
         ip5w==
X-Gm-Message-State: ANoB5pmrj7h/TAc/HsvmlGhmvTDWSzMRQvOaGbvdVh9WoOyubJESpPVI
        B73sySx8V6PNz4l8F/R6ZkSkwg==
X-Google-Smtp-Source: AA0mqf40keFcvNhtVbwUHzDRJG6utW15O2IlS3q+4f1RXpXNgpUT6UbZsQIQ1K8/2ZwH5jSyMAShkQ==
X-Received: by 2002:a05:651c:1204:b0:27a:976:749e with SMTP id i4-20020a05651c120400b0027a0976749emr11536270lja.29.1671098925966;
        Thu, 15 Dec 2022 02:08:45 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf28-20020a2eaa1c000000b0027997d00fc2sm812121ljb.21.2022.12.15.02.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 02:08:45 -0800 (PST)
Message-ID: <85d8ca20-69d2-de77-8aa0-e5f2f77b07dc@linaro.org>
Date:   Thu, 15 Dec 2022 11:08:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-5-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221213234346.2868828-5-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/2022 00:43, Bernhard Rosenkränzer wrote:
> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
> 

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

This applies to all patches as others are also not properly sent.

> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>  .../pinctrl/mediatek,mt8365-pinctrl.yaml      | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> new file mode 100644
> index 0000000000000..3c0248b48caff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
> @@ -0,0 +1,197 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8365-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8365 Pin Controller
> +
> +maintainers:
> +  - Zhiyong Tao <zhiyong.tao@mediatek.com>
> +  - Bernhard Rosenkränzer <bero@baylibre.com>
> +
> +description: |
> +  The MediaTek's MT8365 Pin controller is used to control SoC pins.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8365-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  mediatek,pctl-regmap:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      maxItems: 1
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Should be phandles of the syscfg node.
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +    description: |
> +      Number of cells in GPIO specifier. Since the generic GPIO
> +      binding is used, the amount of cells must be specified as 2. See the below
> +      mentioned gpio binding representation for description of particular cells.
> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +patternProperties:
> +  "-pins$":
> +    type: object
> +    additionalProperties: false
> +    patternProperties:
> +      "pins$":
> +        type: object
> +        additionalProperties: false
> +        description: |
> +          A pinctrl node should contain at least one subnode representing the
> +          pinctrl groups available on the machine. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to muxer
> +          configuration, pullups, drive strength, input enable/disable and input
> +          schmitt.
> +        $ref: /schemas/pinctrl/pincfg-node.yaml
> +
> +        properties:
> +          pinmux:
> +            description:
> +              integer array, represents gpio pin number and mux setting.
> +              Supported pin number and mux varies for different SoCs, and are
> +              defined as macros in <soc>-pinfunc.h directly.
> +
> +          bias-disable: true
> +
> +          bias-pull-up:
> +            description: |
> +              Besides generic pinconfig options, it can be used as the pull up
> +              settings for 2 pull resistors, R0 and R1. User can configure those
> +              special pins.
> +
> +          bias-pull-down: true
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          output-low: true
> +
> +          output-high: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          mediatek,drive-strength-adv:
> +            description: |
> +              Describe the specific driving setup property.
> +              For I2C pins, the existing generic driving setup can only support
> +              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
> +              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
> +              driving setup, the existing generic setup will be disabled.
> +              The specific driving setup is controlled by E1E0EN.
> +              When E1=0/E0=0, the strength is 0.125mA.
> +              When E1=0/E0=1, the strength is 0.25mA.
> +              When E1=1/E0=0, the strength is 0.5mA.
> +              When E1=1/E0=1, the strength is 1mA.
> +              EN is used to enable or disable the specific driving setup.
> +              Valid arguments are described as below:
> +              0: (E1, E0, EN) = (0, 0, 0)
> +              1: (E1, E0, EN) = (0, 0, 1)
> +              2: (E1, E0, EN) = (0, 1, 0)
> +              3: (E1, E0, EN) = (0, 1, 1)
> +              4: (E1, E0, EN) = (1, 0, 0)
> +              5: (E1, E0, EN) = (1, 0, 1)
> +              6: (E1, E0, EN) = (1, 1, 0)
> +              7: (E1, E0, EN) = (1, 1, 1)
> +              So the valid arguments are from 0 to 7.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +
> +          mediatek,pull-up-adv:
> +            description: |
> +              Pull up setings for 2 pull resistors, R0 and R1. User can
> +              configure those special pins. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +
> +          mediatek,pull-down-adv:
> +            description: |
> +              Pull down settings for 2 pull resistors, R0 and R1. User can
> +              configure those special pins. Valid arguments are described as below:
> +              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
> +              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
> +              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
> +              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            enum: [0, 1, 2, 3]
> +
> +          mediatek,tdsel:
> +            description: |
> +              An integer describing the steps for output level shifter duty
> +              cycle when asserted (high pulse width adjustment). Valid arguments
> +              are from 0 to 15.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +          mediatek,rdsel:
> +            description: |
> +              An integer describing the steps for input level shifter duty cycle
> +              when asserted (high pulse width adjustment). Valid arguments are
> +              from 0 to 63.
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +
> +        required:
> +          - pinmux
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/pinctrl/mt8365-pinfunc.h>
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        pio: pinctrl@1000b000 {
> +          compatible = "mediatek,mt8365-pinctrl";

You use inconsistent indentation in example. Stick to one - either 2 or
4 spaces.


Best regards,
Krzysztof

