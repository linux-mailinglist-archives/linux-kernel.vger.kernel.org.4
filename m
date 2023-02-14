Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43196963AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjBNMlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjBNMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:40:58 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D59B75F;
        Tue, 14 Feb 2023 04:40:57 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w3so10132311edc.2;
        Tue, 14 Feb 2023 04:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H1RFf0S+LauH4t97A9Q1FiAiUoFreqXYpUT2qQSR1TQ=;
        b=n1BIx/4gI7lkixI4VskXa1oopYMTh2x6QS7kFJOUtozj9Xvk8B349TzwI/KuP9QX9h
         hiKwY/isB42BK/Q1vvzUpbDTOMd4d5sjSTystzFoxW2eHREBLzxl5e+NJO0cE3WKovdO
         gQviSHGBCCBkjIB70DnrvttO7IGzYXoZWZhSXnxE/1U4xp0n1mN+MXHpZoP8XnCPJXrs
         czo3OuC78GzYyjWLPDdvEiGd+45SH9ZM91ZABuhfmzq4P8X/GytXoje4e6j1QOQWD9LL
         jeAndMIrc1Kb9a0tMEQEwHzw/3PCtracCitfnXx8N/zrHkFrHf0sQcSTOIEkOipA0hQH
         N8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1RFf0S+LauH4t97A9Q1FiAiUoFreqXYpUT2qQSR1TQ=;
        b=hyEVhyjd8cbPvNVwCZRY7pQEgp8ev/omiRrmls8STeRExUvHg4JSvnTWJarVONCOka
         nZ0QDQNj+F55i7gQNLbgWktvHDvBQFTTClcPNFRge3c2JukdG++mTCmYdwW7WGPWd5fD
         1Am5o88Z9Kdwejn5bJwEYXO5zLhdpgpmrYTSUyuf6fGNZMXRrM0uC2Pg/GslLZMYJvX5
         zwM6RiVbo8AVQyOvwaElk4EUNf+y1j4W5hv2wPDaqC9yIqnEru8TK/Gy+rnO3NIkfec/
         trOr3+WCWpQzCqSUqY8Ll+I3LPpl9VfQH8BWvaHFC+5xpV8tiB5UipHo67ON9kQ75QtT
         43Dw==
X-Gm-Message-State: AO0yUKVcmOtW7LPuo8pogNUDWFbO6sI9e74c+Fb5hYSezXcDy0YBrwyG
        5D1YeHrJ8EP2xKIc0tylMToZLmVpgrlwGf9l6jhtVVcoEmpNDw==
X-Google-Smtp-Source: AK7set9gX/9JsXGwOTkQzAzjsrZy1joEqYecrfvxpR02xTTpOOOTxTzp1GEPx+h57s11892naFOB3oqMvks+U2HUUCI=
X-Received: by 2002:a50:a456:0:b0:4ac:b618:968e with SMTP id
 v22-20020a50a456000000b004acb618968emr1057978edb.1.1676378456247; Tue, 14 Feb
 2023 04:40:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676289084.git.zhoubinbin@loongson.cn> <a9f697906df6599e6b001981e668479da71aa7a0.1676289084.git.zhoubinbin@loongson.cn>
 <df464409-9a93-c057-5f66-923a9e24696a@linaro.org>
In-Reply-To: <df464409-9a93-c057-5f66-923a9e24696a@linaro.org>
From:   Binbin Zhou <zhoubb.aaron@gmail.com>
Date:   Tue, 14 Feb 2023 20:40:43 +0800
Message-ID: <CAMpQs4JX0Vgf5tvv5Yw5eLGANFfn1p=iQ_kMS0yQPV6kE2tN1g@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] dt-bindings: interrupt-controller: Add Loongson EIOINTC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, devicetree@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 5:53 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/02/2023 13:15, Binbin Zhou wrote:
> > Add Loongson Extended I/O Interrupt controller binding with DT schema
> > format using json-schema.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../loongson,eiointc.yaml                     | 80 +++++++++++++++++++
> >  1 file changed, 80 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> > new file mode 100644
> > index 000000000000..88580297f955
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,eiointc.yaml
> > @@ -0,0 +1,80 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/interrupt-controller/loongson,eiointc.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>
> Drop quotes from bopth.
>
> > +
> > +title: Loongson Extended I/O Interrupt Controller
> > +
> > +maintainers:
> > +  - Binbin Zhou <zhoubinbin@loongson.cn>
> > +
> > +description: |
> > +  This interrupt controller is found on the Loongson-3 family chips and
> > +  Loongson-2K0500 chip and is used to distribute interrupts directly to
> > +  individual cores without forwarding them through the HT's interrupt line.
> > +
> > +allOf:
> > +  - $ref: /schemas/interrupt-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - loongson,eiointc-1.0
>
> Why not using SoC based compatible? It is preferred.

Hi Krzysztof:

So far, from the datasheet, I know that only the EXIOINTC of the
Loongson-2K0500 is different from the other chips, and that is the
"loongson,eio-num-vecs" below, which is 128, while all the others are
256.
My original idea was to add this property to make compatible
consistent, and also to make it easier to add new chips if they have
different eio-num-vecs.

>
> > +
> > +  reg:
> > +    minItems: 1
> > +    maxItems: 3
>
> You need to describe the items.
>
> > +
> > +  interrupt-controller: true
> > +
> > +  interrupts:
> > +    description:
> > +      Interrupt source of the CPU interrupts.
>
> You need to describe the items.

Do you mean a more detailed description?

>
> > +
> > +  interrupt-names:
> > +    description:
> > +      List of names for the parent interrupts.
>
> Drop description.
>
> > +    items:
> > +      - const: int0
> > +
> > +  '#interrupt-cells':
> > +    const: 1
> > +
> > +  'loongson,eio-num-vecs':
>
> Drop quotes.
>
> > +    description:
> > +      The number of devices supported by the extended I/O interrupt vector.
>
> Why this cannot be inferred from the compatible? Different boards with
> the same SoC support different devices?

See above.

Thanks.
Binbin

>
> > +    $ref: "/schemas/types.yaml#/definitions/uint32"
>
> Drop quotes.
>
> > +    minimum: 1
> > +    maximum: 256
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - interrupt-controller
> > +  - '#interrupt-cells'
> > +  - 'loongson,eio-num-vecs'
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    eiointc: interrupt-controller@1fe11600 {
> > +      compatible = "loongson,eiointc-1.0";
> > +      reg = <0x1fe11600 0x8
> > +             0x1fe11700 0x8
> > +             0x1fe11800 0x8>;
>
> That's not correct syntax. <>, <>, <>
>
> > +
> > +      interrupt-controller;
> > +      #interrupt-cells = <1>;
> > +
> > +      interrupt-parent = <&cpuintc>;
> > +      interrupts = <3>;
> > +      interrupt-names = "int0";
> > +
> > +      loongson,eio-num-vecs = <128>;
> > +
>
> Drop stray blank line.
>
> > +    };
> > +
> > +...
>
> Best regards,
> Krzysztof
>
>
