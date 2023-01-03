Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455165BA2A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 06:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjACFK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 00:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjACFKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 00:10:50 -0500
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B35243
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 21:10:49 -0800 (PST)
Received: by mail-vk1-xa2d.google.com with SMTP id t2so4964548vkk.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 21:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1lF+uQj+FQsqhODd3DjLZyHBCSILu/V4r6YB+47iCA=;
        b=R4naHoGAnjr4w90CecJAm62X3fhC3J8oS6g5fRqtT1ap4xcepx+v9BGDMaDsVmDhnd
         f8W68HvcCLB/Vp8eyQgnfImvPKFqYlk2bBC8fUb09rqHRbt1U4nMEYhLBhrx+2gGQxWg
         CcDFDyLGVSLsMxP4Ad9Q9/e7MWD5LMYYtDRe81pBL0eC8ywRV5Y7m/G2x9+UKNNYrhuP
         3zAbZtisGYN4olRPjtBtEifauiPo1D1PD7EyI1zbJrI3elFDblsyP45oXXD6c5Z/CY2Y
         f0C+6adIEZfc8qfFOIEhm9OoyiWKdM1/HNQSOm3387gm9czDviOvHcT7EVCV39Vm70nh
         DPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1lF+uQj+FQsqhODd3DjLZyHBCSILu/V4r6YB+47iCA=;
        b=WdV86evHuXWmzCffoR9buaj215NEDi3u7ssOynfInw9tyVOfG/DMIf/7mI13SmCZcP
         xGYv4HyipjIaNpUyLjWmDRZm/V8DaBYpRAwiIgfvD0ZMcX7nOumYYfLBN6BkNTXJIvCG
         Fm0r4sgJdu2m78BTL7WKcuVO14CYm5iJFWB3dU85lLONzNlhiwW1P/Mfie3Kg/HuBl15
         X6Yk+dY25zwjJn/edlR8J0bMBhjy9XcGYlpXt8MjDvmAGQm5nTQq5jLHXPWh0AHkUNGv
         jOOwgKVHdzyrKEzyJCMVA3qM4RB7uwwzo5JAxwkORKDgyh4X2G6aeW5lAqWUnlt2PzWv
         I1jQ==
X-Gm-Message-State: AFqh2kouXdj/cpKZ26gU5AlyRdYW6534/pgmGFzdv8vZznJ5Q3pBhwhv
        VdXkgc8A3s6UVFcKAz1AdBF6esIXM2bJmA+z7cMDdQ==
X-Google-Smtp-Source: AMrXdXslkxL7UBNfkOhYC3B8zZdJn9HFotr+MwajcwvZmQTG61DbbRtZtGg7pjiZG0uYr4oy2I+EySvFDHjgctf1gGI=
X-Received: by 2002:a1f:c345:0:b0:3b8:2d76:434d with SMTP id
 t66-20020a1fc345000000b003b82d76434dmr4520082vkf.31.1672722648007; Mon, 02
 Jan 2023 21:10:48 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-7-apatel@ventanamicro.com> <Y3EQ4JU7uGbIMGiW@spud>
 <CAAhSdy2UAMmX+W5Cm3DuTJzZ0jJ3=CW4PhjctQNdfeS+4hqWqg@mail.gmail.com> <Y7MfyZBAErYGMZBK@spud>
In-Reply-To: <Y7MfyZBAErYGMZBK@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Tue, 3 Jan 2023 10:40:35 +0530
Message-ID: <CAK9=C2WoFZBmnqpNGUZWATMqd22TiHpQehAYbW+DNX8ejHU=RA@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: Add RISC-V advanced PLIC bindings
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 2, 2023 at 11:48 PM Conor Dooley <conor@kernel.org> wrote:
>
> On Mon, Jan 02, 2023 at 10:20:48PM +0530, Anup Patel wrote:
> > On Sun, Nov 13, 2022 at 9:14 PM Conor Dooley <conor@kernel.org> wrote:
>
> > > > +  domain.
> > > > +
> > > > +allOf:
> > > > +  - $ref: /schemas/interrupt-controller.yaml#
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    items:
> > > > +      - enum:
> > > > +          - vendor,chip-aplic
> > >
> > > Same comment here about the validity of this placeholder.
> >
> > Okay, I will add "riscv,qemu-aplic" as QEMU specific compatible string.
>
> Ah neat. I think that's a fair compromise.
>
> > > > +      - const: riscv,aplic
>
> > > > +  msi-parent:
> > > > +    description:
> > > > +      The presence of this property implies that given APLIC domain forwards
> > > > +      wired interrupts as MSIs to a AIA incoming message signaled interrupt
> > > > +      controller (IMSIC). This property should be considered only when the
> > > > +      interrupts-extended property is absent.
> > >
> > > This mutual exclusion can be represented, can't it?
> > > IIRC it is some sort of oneOf thing, somewhat like below:
> > > oneOf:
> > >   - required:
> > >       - msi-parent
> > >   - required:
> > >       - interrupts-extended
> > >
> > > AFAIR from doing the i2c ocores binding, this will force the addition of
> > > one, but not both, to a node.
> > >
> > > Or is this not actually mutually exclusive & the msi-parent property is
> > > permitted but just left unused if interrupts-extended is present?
> >
> > If both are present then interrupts-extended is preferred.
>
> Perhaps I am making a fool of myself here, but why would someone include
> both of them at once, if only one is going to be used?
> It would appear that making them explicitly mutually exclusive would
> make the binding easier to understand.
> What am I missing?

If both "interrupts-extended" and "msi-parent" are present then it means
the APLIC domain supports both MSI mode and Direct mode in HW. In this
case, the APLIC driver has to choose between MSI mode or Direct mode.

>
> > > > +  riscv,children:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > +    minItems: 1
> > > > +    maxItems: 1024
> > > > +    description:
> > > > +      This property represents a list of child APLIC domains for the given
> > > > +      APLIC domain. Each child APLIC domain is assigned child index in
> > > > +      increasing order with the first child APLIC domain assigned child
> > > > +      index 0. The APLIC domain child index is used by firmware to delegate
> > > > +      interrupts from the given APLIC domain to a particular child APLIC
> > > > +      domain.
> > > > +
> > > > +  riscv,delegate:
> > > > +    $ref: '/schemas/types.yaml#/definitions/phandle-array'
> > > > +    minItems: 1
> > > > +    maxItems: 1024
> > > > +    description:
> > > > +      This property represents a interrupt delegation list where each entry
> > > > +      is a triple consisting of child APLIC domain phandle, first interrupt
> > > > +      number, and last interrupt number. The firmware will configure interrupt
> > > > +      delegation registers based on interrupt delegation list.
> > >
> > > What is the inter dependence of the children and delegate?
> > > Is it valid to have a delegate property without children?
> > > Can the firmware delegate interrupts without the delegation list, based
> > > on the children property alone? Or is it effectively useless without a
> > > children property?
> >
> > Both properties convey different information. The "riscv,childen" describes
> > the association of child indexes with child APLIC domains whereas the
> > "riscv,delegate" describes the interrupt delegation to few of the child
> > APLIC domains.
> >
> >
> > >
> > > In your examples, the second has msi-parent but neither of these custom
> > > properties. Do the children/delegate properties have a meaning in the
> > > msi-parent case?
> >
> > The "riscv,childern" and "riscv,delegate" are only useful when we have
> > hierarchy of multiple APLIC domains. The second example only has
> > one APLIC domain hence these custom properties are absent.
>
> It'd be great if you could include an example that explains the
> difference as, IIRC, both Rob and I both were kinda confused as to how
> the properties differ.

Okay, I will try to improve the examples.

Regards,
Anup
