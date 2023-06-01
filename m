Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6CC71955B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjFAIVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjFAIUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:20:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3869E12F
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:20:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5151934a4e3so997760a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685607648; x=1688199648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Md0U6+/SKVeb+yyoE/2w2q9WIxgDj78VnRr+rNxliiE=;
        b=f7IpXtUty+F4U9DsC24oWpabK26KruKEF2LZF++dtr/9oUkQaeeL7FNozNtiW+HK57
         j6ON6YhJiu4022YuwcWq52MkR8mpC2C0qXQiugdFsYt0xDw0wXPJAOfdoyWsNJOvGijb
         KPI6ZrMuAzijTrNmliitzJrR3NUGC22qUjaf9dEplBlcxaYRuyvqaNU/+BruvhVgoLH5
         MXU6K+VfizixMgLhi8j9fWEwl7fCzjpBMqnI39/WbdvREcu4YkosRNVytz5luabmyVOd
         hnQ70ahEy8s4ITQ1NIoFj8aBEgvLrmI8rwkykQ0hz0xdig8ADqJ5OYbSQWcetLfPs8dZ
         IdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685607648; x=1688199648;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Md0U6+/SKVeb+yyoE/2w2q9WIxgDj78VnRr+rNxliiE=;
        b=TTo0961aHcw1XMTZjGZvLF+g2S52pqXTBIizG9VK318LWXRuCxNwf+PmFKjkLO5Hwl
         mYBK9L66XTw8KTOgoKd+c9/hQkj0KlVCTl+YoURk/wwUB/8/LLMu1rIrivfuO7ghfEFC
         WoF+C5I3nobF8Y1B0l9k5NpqsTVkfvfjzEZLUQ5FW1vMEcGgZkZME0O8bS30hX15JkQR
         rBfozurWOmOiLfhsORBEaSveOY0Sfe00f9iH00jTwtOuE3rwv1VlQHE6MS+w144ddu6X
         8NBvjjNMjWe9sSEIYx0ALj8Pne9H9W+OalxIiUOkNLHpb3QAb1t7PpPIlouxJWo+2jgd
         VS8w==
X-Gm-Message-State: AC+VfDxcq1VsdufwLJLVPnCe5JlQJI6a7Dx5gPiv+Wh4plKVgFhVGJ3v
        lqAEPo5kLMvgBA0RErtfFwPnTg==
X-Google-Smtp-Source: ACHHUZ6Ce2afAmgynQKHdIneIQvfpfY4VrIPBqFOlOLDUEmj1RGEbDL7DFER6Cc3PVrpE8b/1VW62A==
X-Received: by 2002:a05:6402:322:b0:514:8e6f:66fe with SMTP id q2-20020a056402032200b005148e6f66femr6016179edw.33.1685607648607;
        Thu, 01 Jun 2023 01:20:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id c9-20020aa7df09000000b00515e951cad2sm954076edy.53.2023.06.01.01.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:20:48 -0700 (PDT)
Message-ID: <cacd8ea8-f834-4983-20ff-a875fee8011a@linaro.org>
Date:   Thu, 1 Jun 2023 10:20:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 33/43] dt-bindings: gpio: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601054549.10843-15-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601054549.10843-15-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:45, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC gpio controller.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/gpio/gpio-ep9301.yaml | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml b/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml
> new file mode 100644
> index 000000000000..daadfb4926c3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/gpio-ep9301.yaml

Filename...

> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/gpio-ep9301.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EP93xx GPIO controller
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +  - Bartosz Golaszewski <brgl@bgdev.pl>

Did you choose correct maintainers? Bartosz, Linus, do you take care
about EP93xx platform?


> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-gpio
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-gpio
> +              - cirrus,ep9307-gpio
> +              - cirrus,ep9312-gpio
> +              - cirrus,ep9315-gpio
> +          - const: cirrus,ep9301-gpio
> +
> +  reg:
> +    minItems: 2
> +    items:
> +      - description: data register
> +      - description: direction register
> +      - description: interrupt registers base
> +
> +  reg-names:
> +    minItems: 2
> +    items:
> +      - const: data
> +      - const: dir
> +      - const: intr
> +
> +  gpio-controller: true
> +
> +  gpio-ranges: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 2
> +
> +  interrupts:
> +    oneOf:
> +      - maxItems: 1
> +      - description: port F has dedicated irq line for each gpio line
> +        maxItems: 8
> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpio@80840000 {
> +      compatible = "cirrus,ep9301-gpio";
> +      reg = <0x80840000 0x04>,
> +            <0x80840010 0x04>,
> +            <0x80840090 0x1c>;
> +      reg-names = "data", "dir", "intr";
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +        interrupt-controller;
> +        interrupt-parent = <&vic1>;
> +        interrupts = <27>;
> +    };
> +
> +    gpio@80840004 {
> +      compatible = "cirrus,ep9301-gpio";
> +      reg = <0x80840004 0x04>,
> +            <0x80840014 0x04>,
> +            <0x808400ac 0x1c>;
> +      reg-names = "data", "dir", "intr";
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +      interrupt-controller;
> +      interrupt-parent = <&vic1>;
> +      interrupts = <27>;
> +    };

Same example as before, drop.

> +
> +    gpio@80840008 {
> +      compatible = "cirrus,ep9301-gpio";
> +      reg = <0x80840008 0x04>,
> +            <0x80840018 0x04>;
> +      reg-names = "data", "dir";
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +    };
> +
> +    gpio@8084000c {
> +      compatible = "cirrus,ep9301-gpio";
> +      reg = <0x8084000c 0x04>,
> +            <0x8084001c 0x04>;
> +      reg-names = "data", "dir";
> +      gpio-controller;
> +      #gpio-cells = <2>;
> +    };

Same as before... Just keep one example for interrupt controller and one
for non-interrupt-controller.


Best regards,
Krzysztof

