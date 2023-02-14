Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34444695FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBNJxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjBNJxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:53:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF59CBDF3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:53:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bu23so14979592wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5h6snxNwqi3yc/6b2X5fU8N8RXpsnnQV8JgbEOCMqVA=;
        b=Zg+0MnvymGjqP4gxpMQwD9Q3XTn8SalhzG734eNYM7yp3GKshukmBnNbEp7k+/i2kN
         XKOUlwohSxAf71gjs85dRbNziqx6ara61Gwr9DIb6Saw4j7Ael0VGx8urVl0KRrT3QW1
         t1TPtdjZ7FIxJw/4t5+T01YofORhJSkOBF+N5mv0XWS2A6C8b+abhByZC6LSYPeVWRbx
         PSGfsrmsjBgYpv8FRHa03vvPirJQy8ro7ZN/I/gVJPUtJHor5vyFSSuCQRXfur7j3IlV
         OUp3j9p9HUuiDohBkjQgXXswEeBZcIQppcr7h9Ix0Z4rC9kaSguxckzyoQdf6J6T20pn
         e7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5h6snxNwqi3yc/6b2X5fU8N8RXpsnnQV8JgbEOCMqVA=;
        b=W5ZUgLgIXluGRVLuKMBs+NcAldT+2LUmSEGMC8u/zgUpsSLboF6rnvGMjLOO6bLADQ
         /0Q7t+fuhVDlJ0TzpxRzaLeHG9mVue5Nto+yN7nHg9lkPfiEogHtm1s10M+pZ+au9EST
         guimpqpITHznZeLYGcxmW4rT9lJWv5ty8VWBGznTZ2aKXKnIMhNOwWW5wyc1sLWVR8Lv
         mH50J/FoJ9zXyrMTzKLfyCXvr+5vl5epb6cjWlMXNWeh4cLDuPq4vwE4u2FN/E2zXjhz
         c5viwRPt4o2pjSzsYLUsMaO4o/xP0JySHfyE2+Ka3vx2R3mPcs4XB34SRlK9JQSaPCHX
         lGvA==
X-Gm-Message-State: AO0yUKVF0CnUblFDkrSNTncqfOC1FCzWkBGt7nFEs1Scp3vn0LtLNcIk
        k/50sHbhRGRbB+a6zVD7Uo7uhA==
X-Google-Smtp-Source: AK7set8EIkVs9H4ls60SXwzuLE+qdjwduzm8OuB7RL+BMEcLayw78GCkgI0ZA1TUtTydLwSVuXpI9Q==
X-Received: by 2002:a5d:6b8e:0:b0:2c4:873:16b4 with SMTP id n14-20020a5d6b8e000000b002c4087316b4mr1511933wrx.16.1676368380676;
        Tue, 14 Feb 2023 01:53:00 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id w11-20020adff9cb000000b002c54e9f6bc2sm8137222wrr.77.2023.02.14.01.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:53:00 -0800 (PST)
Message-ID: <df464409-9a93-c057-5f66-923a9e24696a@linaro.org>
Date:   Tue, 14 Feb 2023 10:52:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson
 EIOINTC
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <cover.1676289084.git.zhoubinbin@loongson.cn>
 <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 13:15, Binbin Zhou wrote:
> Add Loongson Extended I/O Interrupt controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> new file mode 100644
> index 000000000000..88580297f955
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from bopth.

> +
> +title: Loongson Extended I/O Interrupt Controller
> +
> +maintainers:
> +  - Binbin Zhou <zhoubinbin@loongson.cn>
> +
> +description: |
> +  This interrupt controller is found on the Loongson-3 family chips and
> +  Loongson-2K0500 chip and is used to distribute interrupts directly to
> +  individual cores without forwarding them through the HT's interrupt line.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - loongson,eiointc-1.0

Why not using SoC based compatible? It is preferred.

> +
> +  reg:
> +    minItems: 1
> +    maxItems: 3

You need to describe the items.

> +
> +  interrupt-controller: true
> +
> +  interrupts:
> +    description:
> +      Interrupt source of the CPU interrupts.

You need to describe the items.

> +
> +  interrupt-names:
> +    description:
> +      List of names for the parent interrupts.

Drop description.

> +    items:
> +      - const: int0
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  'loongson,eio-num-vecs':

Drop quotes.

> +    description:
> +      The number of devices supported by the extended I/O interrupt vector.

Why this cannot be inferred from the compatible? Different boards with
the same SoC support different devices?

> +    $ref: "/schemas/types.yaml#/definitions/uint32"

Drop quotes.

> +    minimum: 1
> +    maximum: 256
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupt-controller
> +  - '#interrupt-cells'
> +  - 'loongson,eio-num-vecs'
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    eiointc: interrupt-controller@1fe11600 {
> +      compatible = "loongson,eiointc-1.0";
> +      reg = <0x1fe11600 0x8
> +             0x1fe11700 0x8
> +             0x1fe11800 0x8>;

That's not correct syntax. <>, <>, <>

> +
> +      interrupt-controller;
> +      #interrupt-cells = <1>;
> +
> +      interrupt-parent = <&cpuintc>;
> +      interrupts = <3>;
> +      interrupt-names = "int0";
> +
> +      loongson,eio-num-vecs = <128>;
> +

Drop stray blank line.

> +    };
> +
> +...

Best regards,
Krzysztof

