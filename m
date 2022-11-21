Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C72631BBE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiKUIoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKUIoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:44:06 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C9420BC8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:44:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u2so13726096ljl.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wxftyZ2bP2CUFfh3czroSbXEkpE9WW3TKCsWldwqoD4=;
        b=T8wpmAD/YM1OJp1WdAfGtQLu6JITwzgbjDuaLUfULtYgmsJgkWd6hytkFrZ6K/pCBv
         JSIiX0YkoOWL9rPoru+GVuOALP0CcuQnTomgEPLSp3YOQaDkeHkw20kT9L95/hY/Opxg
         vT6kEQ7zHHUFsQCGobjeV1YdppkOeoJgOXPlV4ooWJS5fL2GQnialdIeYix6loFbPFfv
         ziQ0QZL4G3ZzG9NtyuX7+puK4Q2QDlC72BRweGfmh1zn5ZCDkdKTwaB9wqviYiujzu7P
         UFQ3KhwLYxRt7xdTHBM1V4yHWHUPgKNXKevH/BjCqTtV8jqquhyfAoC5WVnGZwtjP5vX
         XisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxftyZ2bP2CUFfh3czroSbXEkpE9WW3TKCsWldwqoD4=;
        b=OXw1yiaBTJ0wEr41ko/B0clZy0krac56elNNRYxmcPsHxgWf4RdsopGaBfzbLrKvWd
         taSaqTvN/zC4Q03x+YCNFKxP0el9/zmTw9XIFMJluzPIKIxPxajw0vB7qFG6BI0VWoh+
         ITncfD47EagXT4KKDFICx+kfdBkv/B4AnQ64i7PdWiAMLsvw1ePYPbPY/d95PiccZPC4
         3KjIeGF4adB7FjH1fGywJcX/L4i34ngfnuZCBSrxSWWWFKl4PncpQ6/v6P+yd9oWa7G1
         SDJndgJZb3pbChuKsE8yh/1TttGGJom3CeW3N8PDwNUynzCb43iJ8POl77TswHmEtcVj
         YeJQ==
X-Gm-Message-State: ANoB5pnkhaqvV/4AyM4W4b2snTkJr7HC1dhj8MCUNaqlhKoO/y1/1j1/
        4jZmr0UYFSRIXo6WycMcUssAWAEpNJS6GkKK
X-Google-Smtp-Source: AA0mqf5KdnXjPudf2OofYgn1svqdExEvDe0y/8NY1QQoQd7ipIpcNdio9ewCPYaGdWlJpX9MbV2odw==
X-Received: by 2002:a05:651c:118e:b0:277:af8:a360 with SMTP id w14-20020a05651c118e00b002770af8a360mr2266183ljo.318.1669020241916;
        Mon, 21 Nov 2022 00:44:01 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a4-20020a056512200400b004a01105eea2sm1919084lfb.150.2022.11.21.00.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 00:44:01 -0800 (PST)
Message-ID: <7f78e57a-d9be-b1e9-d161-40b1f66e3804@linaro.org>
Date:   Mon, 21 Nov 2022 09:44:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/5] dt-bindings: pinctrl: Add StarFive JH7110 aon
 pinctrl
Content-Language: en-US
To:     Hal Feng <hal.feng@starfivetech.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
References: <20221118011108.70715-1-hal.feng@starfivetech.com>
 <20221118011108.70715-4-hal.feng@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118011108.70715-4-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2022 02:11, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> new file mode 100644
> index 000000000000..1dd000e1f614
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/starfive,jh7110-aon-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 Aon Pin Controller
> +
> +description: |
> +  Bindings for the JH7110 RISC-V SoC from StarFive Technology Ltd.
> +
> +  Out of the SoC's many pins only the ones named PAD_GPIO0 to PAD_GPIO4
> +  can be multiplexed and have configurable bias, drive strength,
> +  schmitt trigger etc.
> +  Some peripherals have their I/O go through the 4 "GPIOs". This also
> +  includes PWM.
> +
> +maintainers:
> +  - Jianlong Huang <jianlong.huang@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh7110-aon-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: control
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupts:
> +    maxItems: 1
> +    description: The GPIO parent interrupt.

Same comments apply plus one more.

> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - interrupts
> +  - interrupt-controller
> +  - "#interrupt-cells"

"required:" goes after patternProperties.

> +
> +patternProperties:
> +  '-[0-9]+$':

Same comment.

> +    type: object
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        description: |
> +          A pinctrl node should contain at least one subnode representing the
> +          pinctrl groups available on the machine. Each subnode will list the
> +          pins it needs, and how they should be configured, with regard to
> +          muxer configuration, system signal configuration, pin groups for
> +          vin/vout module, pin voltage, mux functions for output, mux functions
> +          for output enable, mux functions for input.
> +
> +        properties:
> +          pinmux:
> +            description: |
> +              The list of GPIOs and their mux settings that properties in the
> +              node apply to. This should be set using the GPIOMUX macro.
> +            $ref: "/schemas/pinctrl/pinmux-node.yaml#/properties/pinmux"
> +
> +          bias-disable: true
> +
> +          bias-pull-up:
> +            type: boolean
> +
> +          bias-pull-down:
> +            type: boolean
> +
> +          drive-strength:
> +            enum: [ 2, 4, 8, 12 ]
> +
> +          input-enable: true
> +
> +          input-disable: true
> +
> +          input-schmitt-enable: true
> +
> +          input-schmitt-disable: true
> +
> +          slew-rate:
> +            maximum: 1
> +
> +        additionalProperties: false
> +
> +    additionalProperties: false
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +    #include <dt-bindings/pinctrl/pinctrl-starfive-jh7110.h>
> +
> +        soc {
> +                #address-cells = <2>;
> +                #size-cells = <2>;

Same comment.

> +
> +                gpioa: gpio@17020000 {
> +                        compatible = "starfive,jh7110-aon-pinctrl";
> +                        reg = <0x0 0x17020000 0x0 0x10000>;
> +                        reg-names = "control";
> +                        resets = <&aoncrg_rst JH7110_AONRST_AON_IOMUX>;
> +                        interrupts = <85>;
> +                        interrupt-controller;
> +                        #interrupt-cells = <2>;
> +                        #gpio-cells = <2>;
> +                        gpio-controller;
> +                };
> +        };
> +
> +...

Best regards,
Krzysztof

