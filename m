Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5466680A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 11:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjA3KFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 05:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjA3KFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 05:05:51 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F55830E5;
        Mon, 30 Jan 2023 02:05:50 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id h24so9463750qta.12;
        Mon, 30 Jan 2023 02:05:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzWe6tX5adqaRlCGb9/O9HSY/b8LN8usIGob5izDvDU=;
        b=aHVPZ7vQlnu/E38d9MYa8FTon1lV/mYVxJejhKEfir4i1UhbbbjyDsNdGcs8f70z43
         czL30PxWDyREFE3b533UzHg9kLn3Sn8tgsINXHEXiZx5k2g105gx0T7CP7IImfJYhCee
         tyerpT9kMiF7NyqSEuGZm5siGcK//kK78X0T/XqAHqPIW87d/SB5DK4Fe+87PUPqzk6I
         Vm5reMuPg+kT92CYA6MW1rt2oKmrBBvttY6LM5P4mh67j4QBfmVKPL/kV0n+U6UCWqpA
         cR3hNKzjkvd8PnE678b00us0AVEyBE/uxlT029+mW12n5XOoFoOOVsXElZuaLUVMzxrg
         DhFQ==
X-Gm-Message-State: AO0yUKV14fq+qHbBknktKdD/n34NjkE4V4aA7LlJgazt5m3VzW8Dh/FL
        TOwnQ+JJZRKT21Eee4ROSyQ5JY6QzbK8CA==
X-Google-Smtp-Source: AK7set832nSp1ZDyVzpf0Y8jfYF6EU5TodfMPTRWg5wPyY829zhn56WDyDqm2EEkpohZgbfnDQlhcw==
X-Received: by 2002:ac8:5c55:0:b0:3b8:54ee:c27d with SMTP id j21-20020ac85c55000000b003b854eec27dmr9516279qtj.60.1675073149165;
        Mon, 30 Jan 2023 02:05:49 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id d187-20020a37b4c4000000b0071f636c108bsm1732180qkf.73.2023.01.30.02.05.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 02:05:49 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id a9so13327154ybb.3;
        Mon, 30 Jan 2023 02:05:48 -0800 (PST)
X-Received: by 2002:a25:9801:0:b0:7d5:b884:3617 with SMTP id
 a1-20020a259801000000b007d5b8843617mr4330104ybo.380.1675073148543; Mon, 30
 Jan 2023 02:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com> <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jan 2023 11:05:36 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWHE3wAYd7TSamN77Xy7CSxnEd8QHW8xm9ng4opsBEapg@mail.gmail.com>
Message-ID: <CAMuHMdWHE3wAYd7TSamN77Xy7CSxnEd8QHW8xm9ng4opsBEapg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > > node
> > > >
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > > RZ/G2L
> > > > (r9a07g044) SoC.
> > > >
> > > > Signed-off-by: Lad Prabhakar
> > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > ---
> > > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > @@ -161,6 +161,11 @@ opp-50000000 {
> > > >               };
> > > >       };
> > > >
> > > > +     pmu_a55 {
> > > > +             compatible = "arm,cortex-a55-pmu";
> > > > +             interrupts-extended = <&gic GIC_PPI 7
> > > > + IRQ_TYPE_LEVEL_HIGH>;
> > >
> > > Just a question, Is it tested?
> > Yes this was tested with perf test
> >
> > > timer node[1] defines irq type as LOW, here it is high.
> > You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this should
> > be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
> >
> > > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as
> > it has 2 cores??
> > >
> > No this is not required for example here [0] where it has 6 cores.
>
> I may be wrong, That is the only example[1], where the A55 PMU per cpu interrupts and number of a55 cores in the DT
> are not matching.
>
> [1]
> https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu

Indeed, this looks like an omission, propagated through
arch/arm64/boot/dts/renesas/r8a779[afg]0.dtsi.

And doesn't this apply to all PPI interrupts, i.e. shouldn't the GIC
in arch/arm64/boot/dts/renesas/r9a07g0{43u,44u,54}.dtsi specify the
mask in their interrupts properties, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
