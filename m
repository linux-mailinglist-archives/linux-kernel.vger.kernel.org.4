Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205A469C4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 06:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBTFKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 00:10:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTFKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 00:10:10 -0500
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9B8CC25
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:10:08 -0800 (PST)
Received: by mail-vk1-xa36.google.com with SMTP id o27so1132594vkn.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 21:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NgBPiBFudnfp+7ZvqZ/TkWNG31i8uXBHpDwh2oWMqzE=;
        b=BDBIi58gFTYL1Ye7j2+aVGb70PhaM+5gaPYE8OtvNOkBlo7FTuGosQ8ay6pWKO2h6m
         kS9KKzq5TEJ2hWGzG0sI5nB3LW/7nI6yrJHRnInnrC5vbkGG8YCJ4y3WW5Iooh4el4eQ
         bEb42TocXTFACSywTV1SjaK7X/96qaPoCdOj0LocD77SCoSrPuqSZQIxtISDdVA5ntJ0
         eQRzfTQGp3RxpUHAbgp5o5/hzCrVGvyD6CkgCOKTxcmg1xigEhpyDyncoAQPYYKrbG06
         f1LwWcRQ6m6PYNltlepXhqFYnOKoWugCGEtPDsq0bNCpYdQWLlqe2TvOEt6ST9ZD+uvG
         0/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgBPiBFudnfp+7ZvqZ/TkWNG31i8uXBHpDwh2oWMqzE=;
        b=YzI2u0ljIZq8JUtrn4C7Bu5IxmeBYwEUmIkDa/HgKhxzfbk76WEuaFhYQ0f+mNKxYO
         oZLfrK7Ppetf5oKDE/27kP0OpTTLWPiMM3c0vGNLLtpnvbWCqv+timhnCcNHXjo/aoqI
         dhfhwM54z02IkenQO2At7/RxGbKJtE9md1QyCUpVQ8Jgup2/Bvr3RO5HDrsQzLpFScNK
         3JZhL0qg4DJ2eVquC2gW0d/YbgcVKdoWH46JqHERPE/INm0WvyNVaJLIDKGIZTu3gTun
         UV+Qkos59tBhhKeSh3MxyIzBOxry1lFdafqTWZgK303oOPJCOM5uGQqn7ncU1nfxTAJi
         1akQ==
X-Gm-Message-State: AO0yUKUu+xVnlWOBYdziEmWe3Q0nzHXbMsDJ2cVprtiE5jqmecRaUlC+
        g7tDN1EE01yDEfJ2QY3xZbzizN37nX5l7tyvkSPdhg==
X-Google-Smtp-Source: AK7set8FC6hXeAgP2mDNjCcg4nLEnoSw3NsjrH4zo8zCcxifANoD+MXxgaK8eYhqFpLzsjpz6TDINMrGKctI5n+y9eY=
X-Received: by 2002:a1f:a682:0:b0:3d5:9b32:7ba4 with SMTP id
 p124-20020a1fa682000000b003d59b327ba4mr119794vke.15.1676869807876; Sun, 19
 Feb 2023 21:10:07 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com> <4bd8c6da-6ad4-5e1a-169c-48f48560b36b@dram.page>
In-Reply-To: <4bd8c6da-6ad4-5e1a-169c-48f48560b36b@dram.page>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 10:39:56 +0530
Message-ID: <CAK9=C2XpGRH98MvrnwiuS7zhT8woKnnihGSinkNP1vcKz3WtRQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To:     Vivian Wang <uwu@dram.page>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
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

On Sun, Feb 19, 2023 at 5:18 PM Vivian Wang <uwu@dram.page> wrote:
>
> On 1/3/23 22:14, Anup Patel wrote:
> > We add DT bindings document for RISC-V advanced platform level
> > interrupt controller (APLIC) defined by the RISC-V advanced
> > interrupt architecture (AIA) specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> > new file mode 100644
> > index 000000000000..b7f20aad72c2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
> > @@ -0,0 +1,159 @@
> >
> > <snip>
> >
> > +  riscv,children:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      maxItems: 1
> > +    description:
> > +      A list of child APLIC domains for the given APLIC domain. Each child
> > +      APLIC domain is assigned child index in increasing order with the
> > +      first child APLIC domain assigned child index 0. The APLIC domain
> > +      child index is used by firmware to delegate interrupts from the
> > +      given APLIC domain to a particular child APLIC domain.
> > +
> > +  riscv,delegate:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      items:
> > +        - description: child APLIC domain phandle
> > +        - description: first interrupt number (inclusive)
> > +        - description: last interrupt number (inclusive)
> > +    description:
> > +      A interrupt delegation list where each entry is a triple consisting
> > +      of child APLIC domain phandle, first interrupt number, and last
> > +      interrupt number. The firmware will configure interrupt delegation
> > +      registers based on interrupt delegation list.
> > +
>
> I'm not sure if this is the right place to ask, since it could be more
> of a OpenSBI/QEMU problem, but I think a more detailed description about
> what 'the firmware' does is appropriate here.
>
> My main confusion is how to describe wired interrupts connected to
> APLICs. Say we have two APLIC nodes with labels aplic_m and aplic_s that
> are the APLIC domains for M-mode and S-mode respectively. IIUC, wired
> interrupts are connected directly to aplic_m. So how do I refer to it in
> the device nodes?

Please see my previous reply to Conor about these DT properties.
The riscv,children DT property describes HW child numbering whereas
the riscv,delegate DT propert is a table of IRQ delegation.

In your example, let's assume we have N wired interrupts. This
means we will have devices connected to the root APLIC domain
(aplic_m). Now since aplic_s is a child of aplic_m, we will have
N wired interrupts going from from aplic_m to aplic_s where
aplic_m will route a wired/device interrupt x to aplic_s if
sourcecfg[x].D = 1 and sourcecfg[x].child = 0.

>
>  1. <&aplic_s num IRQ_TYPE_foo>, but it would be a lie to M-mode
>     software, which could be a problem. QEMU 7.2.0 seems to take this
>     approach. (I could also be misunderstanding QEMU and it actually
>     does connect wired interrupts to the S-mode APLIC, but then
>     riscv,children and riscv,delegate would be lies.)

No, it's not a lie. The <&aplic_s num IRQ_TYPE_foo> in a device DT
node is based on the IRQ delegation fixed by the RISC-V platform.
QEMU has its own strategy of delegating IRQs to APLIC S-mode
while other platforms can use a different strategy.

>  2. <&aplic_m ...>, and when M-mode software gives S-mode software
>     access to devices, it delegates relevant interrupts and patches it
>     into <&aplic_s num IRQ_TYPE_foo>. Seems to be the 'correct'
>     approach, but pretty complicated.

The APLIC M-mode domain is not accessible to S-mode software so
Linux cannot create an irqdomain using APLIC M-mode DT node. This
means device DT nodes must have <&aplic_s num IRQ_TYPE_foo>
which points to APLIC S-mode domain.

It is totally up to RISC-V firmware and platform if it wants to dynamically
add/patch <&aplic_s num IRQ_TYPE_foo> in device DT nodes. Currently,
we do not patch device DT nodes in OpenSBI and instead have the
device DT nodes point to correct APLIC domain based on the IRQ
delegation.

>  3. <&aplic_m ...>, S-mode software sees this, and sees that aplic_m has
>     num in riscv,delegate, so goes to find the child it's been delegated
>     to, which is (should be) aplic_s. A bit annoyingly abstraction
>     breaking, since S-mode shouldn't even need to know about aplic_m.

Yes, S-mode should know about aplic_m and if it tries to access aplic_m
then it will get an access fault.

This is exactly why device DT node should have "interrupts" DT property
pointing to the actual APLIC domain which is delivering interrupt to S-mode.

>
> I see that others are also confused by riscv,delegate and riscv,children
> properties. It would be great if we could clarify the expected behavior
> here rather than just saying 'the firmware will do the thing'.

Regards,
Anup
