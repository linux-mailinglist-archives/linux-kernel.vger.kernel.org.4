Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D46169C881
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 11:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjBTK0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 05:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBTKZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 05:25:59 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A199744;
        Mon, 20 Feb 2023 02:25:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b12so2630982edd.4;
        Mon, 20 Feb 2023 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jVbuCrX77hdcUV9tPIvY6a+uVgr1ZlLsaq//Js9D80=;
        b=SnvzODHVOSzgyTT2U8CMusNHt8vDdhzOInAlPKyKaxh1Xb/jGd3PsiCDQZ9H31vD2c
         h5sb9Ks4PKYP5xbqKyC6FxcBA1WnqvYiBVv08lyDCWN+S6AgU/hdmJaFdJpF+Zs/CcKi
         VgJldHFKUhZWhrCbF4VjC85RvVypEMMLQAUQ/sjYDTeobRkTnt1E4I+hD+HFWK17xPtX
         zHB+MGko+KQ5woQ4OHlruo+mhHlbPiPSybBYe3OPe3p0RmwXEDqp4KYguHjbSeGN7a8Z
         twsbISbsNMwZmv9wMnbJXNoXKzImb5ssVic5RO70/zIs4FuKPKDctaenMYBldmPTEmTd
         M2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jVbuCrX77hdcUV9tPIvY6a+uVgr1ZlLsaq//Js9D80=;
        b=w9OuFGaNyd/JN1G9Xm33RqY1lYnqHCzKBi0qdXrx1HwcdnMgWD0uHSMQwZYrIKvq5X
         bA1vVnww1o4udiKr1ajScIFLy0Q6SaB2rKv7EeFK6I07b9n8R+BplcKAsv4/OKSFJLi1
         nEFjlW/tWRU8gWCRAZbWQUL+628US1kUKn8qjmkmSs65iDi6vr1pRV06gBiIY9sLgidw
         +bAP8DETe9hujj19eJx2b6v2mZlWfQ1FHXnDWDCUsCclIri049ZU7idj2l+1tlV000j/
         4KRXUPx5qU5VQwpIMHOc3o45tnCtjMEJRFOg+oO1o179KsFbVspwszdX2IdgC+Tb5l27
         R7NQ==
X-Gm-Message-State: AO0yUKVC+F9BkBt+V4la6LVQv+WcFZrAC8oihH+G3zYai8yadYd8ihcm
        DWPM3JzxPfc2tgBvd5DBS0c/9N83hjjyFyN08p2L4TSIdxY=
X-Google-Smtp-Source: AK7set9xOfHDq388f6yFanZDaSGy8xeYo4JmNargpSm83IFmw8/BrCTkKywyqtEeCMPFuWw6vVKjGzy5tce7U3UhwAE=
X-Received: by 2002:a17:907:988c:b0:877:747e:f076 with SMTP id
 ja12-20020a170907988c00b00877747ef076mr3902882ejc.0.1676888755902; Mon, 20
 Feb 2023 02:25:55 -0800 (PST)
MIME-Version: 1.0
References: <20230218122236.1919465-1-keguang.zhang@gmail.com> <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org>
In-Reply-To: <646cc26f-ed98-10fc-217b-5dc4416670a6@linaro.org>
From:   Kelvin Cheung <keguang.zhang@gmail.com>
Date:   Mon, 20 Feb 2023 18:25:39 +0800
Message-ID: <CAJhJPsU7KmR1Z1uGsKUDW_=wUwr_Bg_7DwqsMD7tKWrZYQMPhw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: interrupt-controller: convert
 loongson,ls1x-intc.txt to json-schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
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

On Mon, Feb 20, 2023 at 4:04 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 18/02/2023 13:22, Keguang Zhang wrote:
> > Convert the Loongson1 interrupt controller dt-bindings to json-schema.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  .../loongson,ls1x-intc.txt                    | 24 ---------
> >  .../loongson,ls1x-intc.yaml                   | 51 +++++++++++++++++++
> >  2 files changed, 51 insertions(+), 24 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> > deleted file mode 100644
> > index a63ed9fcb535..000000000000
> > --- a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
> > +++ /dev/null
> > @@ -1,24 +0,0 @@
> > -Loongson ls1x Interrupt Controller
> > -
> > -Required properties:
> > -
> > -- compatible : should be "loongson,ls1x-intc". Valid strings are:
> > -
> > -- reg : Specifies base physical address and size of the registers.
> > -- interrupt-controller : Identifies the node as an interrupt controller
> > -- #interrupt-cells : Specifies the number of cells needed to encode an
> > -  interrupt source. The value shall be 2.
> > -- interrupts : Specifies the CPU interrupt the controller is connected to.
> > -
> > -Example:
> > -
> > -intc: interrupt-controller@1fd01040 {
> > -     compatible = "loongson,ls1x-intc";
> > -     reg = <0x1fd01040 0x18>;
> > -
> > -     interrupt-controller;
> > -     #interrupt-cells = <2>;
> > -
> > -     interrupt-parent = <&cpu_intc>;
> > -     interrupts = <2>;
> > -};
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> > new file mode 100644
> > index 000000000000..4cea3ee9fbb1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/loongson,ls1x-intc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Loongson-1 Interrupt Controller
>
> You changed the title, so this binding now will cover all Loonson-1
> interrupt controllers?
>
Yes.

> > +
> > +maintainers:
> > +  - Keguang Zhang <keguang.zhang@gmail.com>
> > +
> > +description: |
>
> Drop |
>
Will do.


> > +  Loongson-1 interrupt controller is connected to the MIPS core interrupt
> > +  controller, which controls several groups of interrupts.
> > +
>
>
> Best regards,
> Krzysztof
>


--
Best regards,

Kelvin Cheung
