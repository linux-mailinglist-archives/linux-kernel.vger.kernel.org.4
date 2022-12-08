Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0036469F1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiLHHwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLHHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:52:47 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB710B5A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:52:45 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q7so684037ljp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 23:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WeLvogb5JcadAWbdKBuMs8s2ANbAcK0xMjx9ddwhq14=;
        b=ZHANhG9Di5kOOXFJDYWU/H7bgD39QQKX/0QHbql541UnEppPeUB17FwVY4f+KQDowh
         gCQYMEdcbAuhhh6zy3f5wB0otFHnd5cOee/YdrN1dk71ntSyXv5Vy796a9Ue6Rl2aJS+
         M3LKUrkbQe6Xl2liTjjM1puFs/8QD49O+4YFKnGiyxOQLGP+RUv3SbTrpgsyxorbIMnM
         M8nDtE6yH9oebfJ1AF2KXh/NaDB92Io4bxk7PYS2Q4QPVhNPD102260eQSMmu5I3+eIJ
         RW7mS0L02YnQhu+VVQCS8s9sLU/qQiAjDXrwJhgLocr5iBWHPNDFasV1MYkv4MMwSpxG
         iz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WeLvogb5JcadAWbdKBuMs8s2ANbAcK0xMjx9ddwhq14=;
        b=4BqaNVK2pt1M8Lhds7FIcvUcX2PIyKKijFN+gk4HIyHTlWn8gPdDj5mynWF7E5OTAu
         Q+2PJvOx3Utaz7jxWZ5qs4BuxQ+XCpG1Ub9Kr84QMk1uAbuN5BqdZoJiReWYkTTb8CCn
         +jxx32wsnj+5u9mc7q8L/Uwau47XJwZde4fvzFAPAkM7yDbPjGrVJfR74ANUmvXIiQyH
         ndkyd1TfxpmLcBpzxHak+FXu+abH0B/QoV7n58w0dqBq/ix3o7bqH9DnfBb300fdW2hV
         gRQzREOMkgcJdMk8CW4og7zcS0yuoT3mrlMsp2CALHaHFldXIU9OnAiY8QvyrOIHx00q
         xa/A==
X-Gm-Message-State: ANoB5pkZh6iGW4A2G4UZ7XaLHSSTxdms5br9fkEpzwNsiQgjvbSxUMxE
        1slNslOhI30kAxU6DqfNhKHe4w==
X-Google-Smtp-Source: AA0mqf7NUrHXH8IdAre6WwZa9HcPzETJhRbH+/idQa0BUPVdPF8aRm+V8yQNfDi69QgGf02lR11a0Q==
X-Received: by 2002:a05:651c:10b5:b0:27a:727:cb92 with SMTP id k21-20020a05651c10b500b0027a0727cb92mr4328153ljn.84.1670485963624;
        Wed, 07 Dec 2022 23:52:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f3-20020ac25083000000b0049c29389b98sm3217960lfm.151.2022.12.07.23.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 23:52:42 -0800 (PST)
Message-ID: <dc0254dc-ef1b-d5fb-163e-281c725a3dcd@linaro.org>
Date:   Thu, 8 Dec 2022 08:52:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 2/3] dt-bindings: leds: add dt schema for
 worldsemi,ws2812b
To:     Chuanhong Guo <gch981213@gmail.com>, linux-leds@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221207040904.582585-1-gch981213@gmail.com>
 <20221207040904.582585-3-gch981213@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221207040904.582585-3-gch981213@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2022 05:09, Chuanhong Guo wrote:
> Add dt binding schema for WorldSemi WS2812B driven using SPI
> bus.
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> Changes since v1:
> remove linux driver reference from description
> remove some obvious descriptions
> fix unit address regex in multi-led property
> drop various minItems
> add maxItems = 1 to reg
> fix node names and property orders in binding example
> drop -spi from compatible string
> add default-brightness
> 
> Change since v2:
> drop "this patch" from commit message
> rename leds to led-controller
> drop default-brightness and default-intensity
> 
>  .../bindings/leds/worldsemi,ws2812b.yaml      | 116 ++++++++++++++++++
>  1 file changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> new file mode 100644
> index 000000000000..548c05ac3d31
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/worldsemi,ws2812b.yaml
> @@ -0,0 +1,116 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/worldsemi,ws2812b.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: WS2812B LEDs driven using SPI
> +
> +maintainers:
> +  - Chuanhong Guo <gch981213@gmail.com>
> +
> +description: |
> +  WorldSemi WS2812B is a individually addressable LED chip that can be chained
> +  together and controlled individually using a single wire.
> +  This binding describes a chain of WS2812B LEDs connected to the SPI MOSI pin.
> +  Typical setups includes connecting the data pin of the LED chain to MOSI as
> +  the only device or using CS and MOSI with a tri-state voltage-level shifter
> +  for the data pin.
> +  The SPI frequency needs to be 2.105MHz~2.85MHz for the timing to be correct
> +  and the controller needs to send all the bytes continuously.
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +properties:
> +  compatible:
> +    const: worldsemi,ws2812b
> +
> +  reg:
> +    maxItems: 1
> +
> +  spi-max-frequency:
> +    minimum: 2105000
> +    maximum: 2850000
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^multi-led@[0-9a-f]+$":
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      color-index:
> +        description: |
> +          A 3-item array specifying color of each components in this LED. It
> +          should be one of the LED_COLOR_ID_* prefixed definitions from the
> +          header include/dt-bindings/leds/common.h. Defaults to
> +          <LED_COLOR_ID_GREEN LED_COLOR_ID_RED LED_COLOR_ID_BLUE>
> +          if unspecified.
> +        $ref: /schemas/types.yaml#/definitions/uint32-array

Hmm, maybe we should add more colors the "color" property, like
LED_COLOR_ID_GRB, LED_COLOR_ID_BRG, LED_COLOR_ID_BGR?

Rest look ok for me. If there is going to be resend, drop redundant "dt
schema for" from the subject.

Best regards,
Krzysztof

