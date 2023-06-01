Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 855CA719372
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjFAGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjFAGmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:42:21 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11408180
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:42:16 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-96fb45a5258so54630966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601734; x=1688193734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ANMyuQNsEPiF3QmDOiOhBLvKIIT27fWFnUKpORZrZFw=;
        b=ggtn9YySWdXvGrl85dcClMiC4+V1v1mqF11/6CQ+6dJ1lklKIHR73dJ7mVcp/QxxIQ
         /xdx8h+2OS6ricRnu8tSxMMLAzo7rd3Z4G7TB7wyvIlghny2osCznIfUsRl3cFzZpycg
         8QWJHmeA+RHG3daSf3sppVfBVYNdBAPwyas61MqbUfXvqT84ZmCZEC4127Sc1BCWemD+
         r/nQr6IsDNQafD79CUDqH4BLGjHQFBmHH/W77T40PrORsTSiBathnYRDYzP7RK2ukaTU
         +P+HYPylSQf/yfYwwiJVn0BcHvvuxOaoBlXb6pHy+4C9zWR7DsZjk4coKv5AOZ6D7HH0
         nYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601734; x=1688193734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANMyuQNsEPiF3QmDOiOhBLvKIIT27fWFnUKpORZrZFw=;
        b=YBIsGoUnKnmUgdLPZaiAcBdencFC20o91n5LJMRvLxsvrHTAXYxUkWt74NOTAEmHuZ
         DIvEQczCTEVIyaxJ0jgG990TMBydfK7IEwRAGticjxhnGfH4MS2A1OyCfZeVNsNFQQuG
         wCmHnsrMyvTkcmLAiv6ZRNHlalw5Z31tzxP3ff1n2PBoimji9ERzUFYRCpTXmmnnRpM1
         EVymTHvDeU8ELC964abKDcsNod39hjuYNmqjwsaSpCQ9IN/jDiS+FTrTJqs6Nq6r+KML
         7GEQVlOKe0jaolKpp+YHf46BSJUxHvqXsyZ2UUoklwzDi3Efe0kJ7+oPnS4/CYhsqQKH
         kSNw==
X-Gm-Message-State: AC+VfDxGGW4Knde/0L3QMHOEfu9kk+GPuLpZgQs4QDtuliDATSzVtqmv
        4fz7Pr8vl78C0s2frxO5Aebfzg==
X-Google-Smtp-Source: ACHHUZ66nv9NTyqbJPI7nFOnwMxBePXKep1wFvXa6V6HAWyh9Su1v4eq7DXY5+5fNbc53Pd+4P/dGw==
X-Received: by 2002:a17:907:3f1c:b0:970:d85:59e9 with SMTP id hq28-20020a1709073f1c00b009700d8559e9mr6969993ejc.5.1685601734515;
        Wed, 31 May 2023 23:42:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906139300b0095fd0462695sm9994101ejc.5.2023.05.31.23.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:42:14 -0700 (PDT)
Message-ID: <14df9815-3c3a-5adf-b8ca-01ea5cf89bfd@linaro.org>
Date:   Thu, 1 Jun 2023 08:42:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 06/43] dt-bindings: pinctrl: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-7-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-7-nikita.shubin@maquefel.me>
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

On 01/06/2023 07:33, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC pinctrl.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Notes:
>     v0 -> v1:
>     
>     Krzysztof Kozlowski:
>     - removed wildcards
>     - use fallback compatible and list all possible compatibles
>     - fix ident
>     - dropped bindings in title
> 
>  .../pinctrl/cirrus,ep9301-pinctrl.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> new file mode 100644
> index 000000000000..ff7b30a11bab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep9301-pinctrl.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,ep9301-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Cirrus ep93xx pins mux controller
> +
> +maintainers:
> +  - Nikita Shubin <nikita.shubin@maquefel.me>
> +  - Alexander Sverdlin <alexander.sverdlin@gmail.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cirrus,ep9301-pinctrl
> +      - items:
> +          - enum:
> +              - cirrus,ep9302-pinctrl
> +              - cirrus,ep9307-pinctrl
> +              - cirrus,ep9312-pinctrl
> +              - cirrus,ep9315-pinctrl
> +          - const: cirrus,ep9301-pinctrl
> +
> +patternProperties:
> +  '^pins-':
> +    type: object
> +    description: pin node
> +    $ref: pinmux-node.yaml#
> +
> +    properties:
> +      function:
> +        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio ]

Blank line.

> +      groups:
> +        minItems: 1
> +        maxItems: 2

How one pin can belong to two groups? What does it mean?

> +        items:
> +          enum: [ ssp, ac97, i2s_on_ssp, i2s_on_ac97, pwm1, gpio1agrp,
> +                  gpio2agrp, gpio3agrp, gpio4agrp, gpio6agrp, gpio7agrp,
> +                  rasteronsdram0grp, rasteronsdram3grp, keypadgrp, idegrp]
> +
> +    required:
> +      - function
> +      - groups
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@80930000 {
> +      compatible = "cirrus,ep9301-syscon",
> +                  "syscon", "simple-mfd";

Weird wrapping.

> +      reg = <0x80930000 0x1000>;
> +      #clock-cells = <1>;
> +      #reset-cells = <1>;
> +      pinctrl {
> +        compatible = "cirrus,ep9312-pinctrl", "cirrus,ep9301-pinctrl";
> +        spi_default_pins: pins-spi {
> +          function = "spi";
> +          groups = "ssp";
> +        };
> +      };
> +    };

Best regards,
Krzysztof

