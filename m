Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5925569C4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBTEhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 23:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTEhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:37:04 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08223E3A8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:37:03 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id p33so100500uae.7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vW3SjDhHqWHMVSsNmZhVWE2xaUo+F2XQu/b/bwpzrYM=;
        b=oGlsgZzS/dLKb8pyM6kFC4HSH7T/ttdwR9fMSx4Ge17fKrWCJ4+0aARjWSylD1IFbH
         r2pznwSEZPiUAECAH7vXXj096XKUX/wC/VXlrHBiSsM7jyckRHP5PUm8b8UCOGCj+Yp6
         w5p+8+xMMu+91rezsUcD0rjXj4HwT54k+G+tiSFJB0+GajBkeEzG/kKbXtitqE6+rIW1
         I78pC8n/qM8hdYCb+kBfKYwb4eNrB/ATVeXEsT4spVkBNwXgUdkcOM3YiK45WRINoWa1
         L01Qkmj5SvhlKCXOCxawmBV22igO+c6us2zUffsw/oAxfN9mjc/fHwEHrkugpp4taB32
         J+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vW3SjDhHqWHMVSsNmZhVWE2xaUo+F2XQu/b/bwpzrYM=;
        b=rQjjSxp07FH8Gj8AlIWDx8xS0f5R+vlcRzrRxqiUhwvwonJv6mxP7rOMaSeRJvbHBc
         1zFS/ZQDR9EmXGChEz6Y5WE5tdreyS52gDzKmMy9e5d1cvUJyGsBUOl6pe69dtVX7ifN
         vS5Ri9seTG1QLDhMtgLBZlrin9CG6km9H31ngtcfeiZnOp1K8vxDmCQUKK3R2yhpTsut
         rmU5tteBfJzQDgcBocZdmNGnqk9yf0rylWKyr8ezQ8m3Y0/KgRxqAmF7nCdPjhsKn/s+
         BrZTL2tuRRE7DVJ9RpOXq7FpSD2tV4vVrXfm06g4GkhVZQwi2VLUAM3NVKPciVhKw16l
         QIVQ==
X-Gm-Message-State: AO0yUKVfxgpg+/aavIQ805KDP2E4u99KwRgEpIIH6iFD/7v7RAD7QllJ
        8oeXSdVivQfhkoU5e8WUfW81wb0MIYrZeqlNgZngXw==
X-Google-Smtp-Source: AK7set8lJ71u8xZ5NZye9XUtlI1bfHkPZlqL8px++W8ibh9g6TXKjzSz1dZiZ/5nJC+gXKlPBPdVx+EeJ52SMY5butg=
X-Received: by 2002:ab0:5b54:0:b0:68a:8f33:9567 with SMTP id
 v20-20020ab05b54000000b0068a8f339567mr432419uae.2.1676867821482; Sun, 19 Feb
 2023 20:37:01 -0800 (PST)
MIME-Version: 1.0
References: <20230103141409.772298-1-apatel@ventanamicro.com>
 <20230103141409.772298-7-apatel@ventanamicro.com> <Y7X62v5Zp6+thx5A@spud>
In-Reply-To: <Y7X62v5Zp6+thx5A@spud>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 20 Feb 2023 10:06:49 +0530
Message-ID: <CAK9=C2UPa5SATTG1pJdckqaoJxh-8EBz8xsENirZQ-vbaHTgjg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] dt-bindings: interrupt-controller: Add RISC-V
 advanced PLIC
To:     Conor Dooley <conor@kernel.org>
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

On Thu, Jan 5, 2023 at 3:47 AM Conor Dooley <conor@kernel.org> wrote:
>
> Hey Anup,
>
> On Tue, Jan 03, 2023 at 07:44:06PM +0530, Anup Patel wrote:
> > We add DT bindings document for RISC-V advanced platform level
> > interrupt controller (APLIC) defined by the RISC-V advanced
> > interrupt architecture (AIA) specification.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> >  .../interrupt-controller/riscv,aplic.yaml     | 159 ++++++++++++++++++
> >  1 file changed, 159 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,aplic.yaml
>
> > +  interrupts-extended:
> > +    minItems: 1
> > +    maxItems: 16384
> > +    description:
> > +      Given APLIC domain directly injects external interrupts to a set of
> > +      RISC-V HARTS (or CPUs). Each node pointed to should be a riscv,cpu-intc
> > +      node, which has a riscv node (i.e. RISC-V HART) as parent.
> > +
> > +  msi-parent:
> > +    description:
> > +      Given APLIC domain forwards wired interrupts as MSIs to a AIA incoming
> > +      message signaled interrupt controller (IMSIC). This property should be
> > +      considered only when the interrupts-extended property is absent.
>
> Considered by what?
> On v1 you said:
> <quote>
> If both "interrupts-extended" and "msi-parent" are present then it means
> the APLIC domain supports both MSI mode and Direct mode in HW. In this
> case, the APLIC driver has to choose between MSI mode or Direct mode.
> <\quote>
>
> The description is still pretty ambiguous IMO. Perhaps incorporate
> some of that expanded comment into the property description?
> Say, "If both foo and bar are present, the APLIC domain has hardware
> support for both MSI and direct mode. Software may then chose either
> mode".
> Have I misunderstood your comment on v1? It read as if having both
> present indicated that both were possible & that "should be considered
> only..." was more of a suggestion and a comment about the Linux driver's
> behaviour.
> Apologies if I have misunderstood, but I suppose if I have then the
> binding's description could be improved!!

Yes, when both DT properties are present then it's up to Linux
APLIC driver to choose the appropriate APLIC mode.

I forgot to update the text here in v2 but I will update it in v3.
Thanks for pointing.

>
> > +  riscv,children:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
> > +    items:
> > +      maxItems: 1
> > +    description:
> > +      A list of child APLIC domains for the given APLIC domain. Each child
> > +      APLIC domain is assigned child index in increasing order with the
>
> btw, missing article before child (& a comma after order I think).

Okay, I will update.

>
> > +      first child APLIC domain assigned child index 0. The APLIC domain
> > +      child index is used by firmware to delegate interrupts from the
> > +      given APLIC domain to a particular child APLIC domain.
> > +
> > +  riscv,delegate:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> > +    maxItems: 1024
>
> Is it valid to have a delegate property without children? If not, the
> binding should reflect that dependency IMO.

Okay, I will update.

>
> > +    items:
> > +      items:
> > +        - description: child APLIC domain phandle
> > +        - description: first interrupt number (inclusive)
> > +        - description: last interrupt number (inclusive)
> > +    description:
> > +      A interrupt delegation list where each entry is a triple consisting
> > +      of child APLIC domain phandle, first interrupt number, and last
> > +      interrupt number. The firmware will configure interrupt delegation
>
> btw, drop the article before firmware here.
> Also, "firmware will" or "firmware must"? Semantics perhaps, but they
> are different!

I think "firmware must" is better because APLIC M-mode domains are
not accessible to S-mode so firmware must configure delegation for
at least all APLIC M-mode domains.

>
> Kinda for my own curiosity here, but do you expect these properties to
> generally be dynamically filled in by the bootloader or read by the
> bootloader to set up the configuration?

Firmware (or bootloader) will look at this property and setup delegation
before booting the OS kernel.

>
> > +      registers based on interrupt delegation list.
>
> I'm sorry Anup, but this child versus delegate thing is still not clear
> to me binding wise. See below.

There are two different information in-context of APLIC domain:

1) HW child domain numbering: If an APLIC domain has N children
    then HW will have a fixed child index for each of the N children
    in the range 0 to N-1. This HW child index is required at the time
    of setting up interrupt delegation in sourcecfgX registers. The
    "riscv,children" DT property helps firmware (or bootloader) find
    the total number of child APLIC domains and corresponding
    HW child index number.

2) IRQ delegation to child domains: An APLIC domain can delegate
   any IRQ range(s) to a particular APLIC child domain. The
   "riscv,delegate" DT property is simply a table where we have
   one row for each IRQ range which is delegated to some child
   APLIC domain. This property is more of a system setting fixed
   by the RISC-V platform vendor.

>
> > +    aplic0: interrupt-controller@c000000 {
> > +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> > +      interrupts-extended = <&cpu1_intc 11>,
> > +                            <&cpu2_intc 11>,
> > +                            <&cpu3_intc 11>,
> > +                            <&cpu4_intc 11>;
> > +      reg = <0xc000000 0x4080>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +      riscv,children = <&aplic1>, <&aplic2>;
> > +      riscv,delegate = <&aplic1 1 63>;
>
> Is aplic2 here for demonstrative purposes only, since it has not been
> delegated any interrupts?

Yes, it's for demonstrative purposes only.

> I suppose it is hardware present on the SoC that is not being used by
> the current configuration?

Yes, in this example aplic2 is unused because it has no interrupts
delegated to it.

>
> Thanks,
> Conor.
>
> > +    };
> > +
> > +    aplic1: interrupt-controller@d000000 {
> > +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> > +      interrupts-extended = <&cpu1_intc 9>,
> > +                            <&cpu2_intc 9>;
> > +      reg = <0xd000000 0x4080>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +    };
> > +
> > +    aplic2: interrupt-controller@e000000 {
> > +      compatible = "riscv,qemu-aplic", "riscv,aplic";
> > +      interrupts-extended = <&cpu3_intc 9>,
> > +                            <&cpu4_intc 9>;
> > +      reg = <0xe000000 0x4080>;
> > +      interrupt-controller;
> > +      #interrupt-cells = <2>;
> > +      riscv,num-sources = <63>;
> > +    };
>

Regards,
Anup
