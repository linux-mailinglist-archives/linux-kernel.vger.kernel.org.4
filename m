Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EDA6EDF24
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 11:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjDYJZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 05:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233403AbjDYJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 05:25:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0991210C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:25:01 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5058181d58dso9782162a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 02:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682414700; x=1685006700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VTQTqCCZGjzymhITgf5Q3xyA6Zyj8CaqqpMT/1f1B9g=;
        b=SmJPczl8Q0RYOsntc+RNSKFGyEo+Heq/ZsmdSxJBkd4YCfKNjqEiH316/WyW+C+oin
         mPfkKJLhatE/Rl7lzp50ePPrkUgKMpX6gGXkkVTvQntTVV5zYLzO9VJHsIQIlvDYRx4S
         vPsFNo88Cz59/BwOd6v8x2774kBHQUU28R+dXosx3kMVbDqLgqUOJFC8ko41KvAY4ia/
         64yT6zv+lb7N894bikzuZO6w80Npm4BbXL0kRbHuIf2Q1fQSjqPw2mSHLk3SHBfMH2an
         BCJQR9ck1sxwO5kOmzRvrPBaRotswsrJkxQPcTBiAIQGaA1dpyPBZZD95/AlTiuH16Z0
         /Tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682414700; x=1685006700;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VTQTqCCZGjzymhITgf5Q3xyA6Zyj8CaqqpMT/1f1B9g=;
        b=Z0u/jZI6YRZPY/4XLUWsR5pDaNpu3KPoBlyXhrJGU0lF8+M3R5xercTYVp6O+Idb8U
         3nolcI8hTgNo1mkVDNrBo4wmaNXj7gTBim4A15kOAIIT2dIbIZ/B9+PJjo/4MMMRrurQ
         wfZtmwy8tYR8HtDVIJ+LQ63GEh2fY3l6LZoT4YZ0V7bqMCBVyCCTd27by8sR0UY3evWv
         m+wciAbNhP3pveoa33LIkI4oVGiijMO0ZPxfXSmduwlC62oSG2OOtFRStvR7sS9lDXXp
         LEH23RzpYlwrw0qTMdMevvzJqouOJRqYeWBhLGTAkSocf+Mrf4/rY+CKHsdNV1/XBf8H
         0Ovg==
X-Gm-Message-State: AAQBX9f52i3VUpxMV5e1lXRkMSDkUD7xqTY1JBibx7kKQ13DvWNG6CmC
        47yo2qTYK5jxITEc58Z0bgeHBQ==
X-Google-Smtp-Source: AKy350Y5De3LWSBpvFr02fmhJNDamlcWRUqdhqX87K+rkiKyp9OMtaykxqYMUKNdaWX+LbW2kkhlZQ==
X-Received: by 2002:aa7:d5d4:0:b0:504:ba4f:3450 with SMTP id d20-20020aa7d5d4000000b00504ba4f3450mr12126271eds.30.1682414700295;
        Tue, 25 Apr 2023 02:25:00 -0700 (PDT)
Received: from [192.168.9.102] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7d0cb000000b0050687dbb5dasm5498604edo.31.2023.04.25.02.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 02:24:59 -0700 (PDT)
Message-ID: <466afe93-f9c2-6a73-ffdb-c30778b273af@linaro.org>
Date:   Tue, 25 Apr 2023 11:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 03/43] dt-bindings: pinctrl: Add DT bindings ep93xx
 pinctrl
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linusw@kernel.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230424123522.18302-4-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230424123522.18302-4-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 14:34, Nikita Shubin wrote:
> Add YAML bindings ep93xx SoC.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> 
> Notes:
>     rfc->v0:
>     - dropped separate bindings description, left only one with all groups,
>       functions and etc...
>     - added Alexander Sverdlin to maintainers
>     - added Linus Reviwed-by tags, through i shoudn't =) too many changes
>     - fixed warning and added seq_file header
> 
>  .../pinctrl/cirrus,ep93xx-pinctrl.yaml        | 66 +++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
> new file mode 100644
> index 000000000000..cba4be7c5994
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/cirrus,ep93xx-pinctrl.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/cirrus,ep93xx-pinctrl.yaml#
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
> +    enum:
> +      - cirrus,ep9301-pinctrl
> +      - cirrus,ep9307-pinctrl
> +      - cirrus,ep9312-pinctrl

Blank line

> +  regmap:
> +    description: phandle to syscon

This should be specific - vendor prefix, property name, explanation what
do you need here in description. "phandle to syscon" is redundant.

You also miss type.

Anyway, your example contradicts this. You do not have regmap.

> +
> +patternProperties:
> +  '^pinctrl-':

'^pins-' instead, because pinctrl is the entire device.

> +    type: object
> +    description: pin node
> +    $ref: pinmux-node.yaml#
> +
> +    properties:
> +      function:
> +        enum: [ spi, ac97, i2s, pwm, keypad, pata, lcd, gpio1, gpio2, gpio3,
> +                gpio4, gpio6, gpio7 ]

Why gpio has different versions? gpio should be one function.

> +      groups:
> +        minItems: 1
> +        maxItems: 2
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
> +  - regmap
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon: syscon@80930000 {
> +        compatible = "cirrus,ep9301-syscon",
> +                     "syscon", "simple-mfd";

You created now dependency on this binding. Drop the parent node. If
this is supposed to be always part of syscon, then example could be in
parent's node... but I have doubts that is a part of syscon in the first
place.

> +        reg = <0x80930000 0x1000>;
> +        #clock-cells = <1>;
> +        #reset-cells = <1>;
> +        pinctrl: pinctrl {
> +                compatible = "cirrus,ep9312-pinctrl";

Mixed indentation. Actually before also looks odd...
Use 4 spaces for example indentation.

> +                regmap = <&syscon>;
> +                spi_default_pins: pinctrl-spi {
> +                        function = "spi";
> +                        groups = "ssp";
> +                };
> +        };
> +    };

Best regards,
Krzysztof

