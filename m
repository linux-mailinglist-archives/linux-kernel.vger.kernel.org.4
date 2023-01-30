Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BBE680F21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236591AbjA3Ngu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235037AbjA3Ngs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:36:48 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB03126E0;
        Mon, 30 Jan 2023 05:36:47 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id b1so13951049ybn.11;
        Mon, 30 Jan 2023 05:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVXFMfiXW7j1hSxPDtInEvzJtkAmO/pwYdcItY2zsYc=;
        b=Yo1kEWfwEHOJ2WPhV9wNw4bitrVT4PA8LZfEfJWC9LuuLXlaBN6OhOlqJo9+HXDlL1
         woog57bYi+hNUnzSGwFeR9LI/8Fc5Y5xEtEHUZi9/tVAaBaq3mEtrsfkKC+oC1IdLhCE
         WVDvzIvYWc9KB1by7/LxKYjVZVbOWZcVc4F94gnOxH8diD3QihhkDAkdsFVSuhDNMtxQ
         6DEhB6FXPKpn0Xo9uiBbh6rCTrAIiYx7GLLt2HzFNuyM2VsB9SSloj946tmDmhVdG5C0
         uEjFkHhY4FrHNi9O1Qb6L22seNhsPxyi+Pec6U11pYJxOssa7gtSDV8KxW/pWrUIHb0N
         ZE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVXFMfiXW7j1hSxPDtInEvzJtkAmO/pwYdcItY2zsYc=;
        b=NOCv/BwVEeIkO/9KJdUiKS2KwW3R4EWpey0i12dPyrUkY4w0W2mXxNvYznqSGcuHN7
         vmtwfgGuH/P0Z5J3Qbfu9aLx1xY0Hbk/IyU71wME+R8SkAL+1hGMnlzT/J+9Q1TTrU7P
         RXuA7N8en3QYP2fWVjciVxBZxQ84UcBL3yTTnZovYWqnCWZf5D8rTKXHr8TmJ0oul+EL
         9n9Fza3XaRKJdDJ9h89ZLRK3ciYohVUJyZITr8xOmlXPtgLHgg/Pw2td2QYPSd5lsHFb
         b7R+HWzfAot5xgEldisgQqeOJyHXXL+4mmV6Do0+LDlCSlTBoBQtCIEAssLxOw3953Vs
         yajg==
X-Gm-Message-State: AO0yUKVj+rN9VjJnEd1+umfwAvlPcD/cVAkUHzaHzgVosogBFkkn1i6c
        +5QvA5oFDofxscdyCb0Cz36QhT5gTAlAOZG10pUBgyJfjRE=
X-Google-Smtp-Source: AK7set900xzmxxQiL/dVyqLp37FVN80GeSLvWgrXmbl0dW4zdIY99Hug+iq7ujv+gggOluRCuYf7OUltJeCT39T7u0E=
X-Received: by 2002:a25:b55:0:b0:816:c63:dc96 with SMTP id 82-20020a250b55000000b008160c63dc96mr398350ybl.119.1675085806597;
 Mon, 30 Jan 2023 05:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
 <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHE3wAYd7TSamN77Xy7CSxnEd8QHW8xm9ng4opsBEapg@mail.gmail.com>
 <CA+V-a8vBFSKbFJo1nEX7eN+S8eJazDDfCrzO7oFHsiF5yvpZ+g@mail.gmail.com> <874js8duh7.wl-maz@kernel.org>
In-Reply-To: <874js8duh7.wl-maz@kernel.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Jan 2023 13:36:20 +0000
Message-ID: <CA+V-a8tvc1K=eHxGNGPvGjp4Ddz6jKu2b3w4+KE-SfJu0Qquvw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Marc Zyngier <maz@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Marc,

On Mon, Jan 30, 2023 at 1:26 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 30 Jan 2023 13:13:26 +0000,
> "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >
> > Hi Geert,
> >
> > On Mon, Jan 30, 2023 at 10:05 AM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > >
> > > On Fri, Jan 27, 2023 at 10:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > > > > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > > > > > node
> > > > > > >
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > > > > > RZ/G2L
> > > > > > > (r9a07g044) SoC.
> > > > > > >
> > > > > > > Signed-off-by: Lad Prabhakar
> > > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > ---
> > > > > > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > > > > > >  1 file changed, 5 insertions(+)
> > > > > > >
> > > > > > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > > > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > > @@ -161,6 +161,11 @@ opp-50000000 {
> > > > > > >               };
> > > > > > >       };
> > > > > > >
> > > > > > > +     pmu_a55 {
> > > > > > > +             compatible = "arm,cortex-a55-pmu";
> > > > > > > +             interrupts-extended = <&gic GIC_PPI 7
> > > > > > > + IRQ_TYPE_LEVEL_HIGH>;
> > > > > >
> > > > > > Just a question, Is it tested?
> > > > > Yes this was tested with perf test
> > > > >
> > > > > > timer node[1] defines irq type as LOW, here it is high.
> > > > > You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this should
> > > > > be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
> > > > >
> > > > > > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as
> > > > > it has 2 cores??
> > > > > >
> > > > > No this is not required for example here [0] where it has 6 cores.
> > > >
> > > > I may be wrong, That is the only example[1], where the A55 PMU per cpu interrupts and number of a55 cores in the DT
> > > > are not matching.
> > > >
> > > > [1]
> > > > https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu
> > >
> > > Indeed, this looks like an omission, propagated through
> > > arch/arm64/boot/dts/renesas/r8a779[afg]0.dtsi.
> > >
> > > And doesn't this apply to all PPI interrupts, i.e. shouldn't the GIC
> > > in arch/arm64/boot/dts/renesas/r9a07g0{43u,44u,54}.dtsi specify the
> > > mask in their interrupts properties, too?
> > >
> > I was under the impression that the GIC_CPU_MASK_SIMPLE(x) was only
> > needed if the driver handled per-cpu stuff.
> >
> > Marc, what should be the correct usage?
>
> I'm reading the DT correctly, this system has a GICv3, which is quite
> natural for an A55-based system. For this configuration, no mask is
> required.
>
> The CPU mask stuff only applies to pre-GICv3. With GICv3+, you simply
> cannot express such a mask, as there is no practical limit to the
> number of CPUs.
>
Thank you for the clarification.

Cheers,
Prabhakar
