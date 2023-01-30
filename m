Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20D6680E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 14:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbjA3NOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 08:14:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235989AbjA3NOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 08:14:06 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB012870;
        Mon, 30 Jan 2023 05:13:53 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-4fda31c3351so158403597b3.11;
        Mon, 30 Jan 2023 05:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuIsIC5WkjlnYbFhp4do2Gvm2A9ljg1sUa4uVtjOdgU=;
        b=IKBdjSrJ4VJn2rHtWs60QnO5mRjsEER3YCBTtAIeZiTrCvdG2vBjbcpf0pxp6uQ0xX
         8gATo3iO6H84h0x2ry2SDtyvA8Mjk/i1AZPF/PaXsiPUTARNirqPoQuJ156nzKRbqqLh
         iDxHhNsecBReJ8CzDc4F9lWk3QWPfMl49KzYVoYX6GRusgCIia2MRrYyWRMzJ+QTHhay
         xWfptfUX5EFM1pbj7JT7RPR/fVzhZT9nCxK7rtUKW30xHlZ8NnrD6+Ap8SFrNTp2dWhp
         Ed4DXSQjJixwgUCqhs9w7APNmHcJfT+jPbQBeBraCktRAlz2w8nUVz/us5O6IexCT/g/
         sbwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuIsIC5WkjlnYbFhp4do2Gvm2A9ljg1sUa4uVtjOdgU=;
        b=5BNbNoghTqt7ofKg+g24opvaApZSSFXejQTSVVYgu7nI1n286w0hbtldB4FFXvTEDu
         pkRp93YQJLkeQpRUITuvV/KTz93utgr+Q7JiZ633O2HfYNBMa8vVzOO+YIv3h87eH/DV
         Ua+K/IhaTgVYsEMzDN84sv3D8p4v/U40X7OXjnUbps061KRD3kgVGaScBzLDnwQjcAVu
         KMw/bPluOPT8O1UAUwHGuMyWb+YQV8Y2i775+F5e8JbH7x4k+KqAf5/rFcD6JK/zCyUk
         D5YTb0A0F4M8vB/F8wIkYMOZOLjXiV1O/yFdM9Rb3EseHclJA3KUYu4AHBqVjxlxlwHN
         L+tw==
X-Gm-Message-State: AFqh2kpjw2SIDsgWe1HpTZeVMZhCBmDEAkzQ7V6xIcNj0UuWZMIfpu2K
        9s1dzlkihsmgbk3a4B/Xk1gTJFHSwyTgsoI0oto=
X-Google-Smtp-Source: AMrXdXvyV4vHU4lm4qhXJxoTcPF2urcHfYEtL9TUBmeWZ/fYbZf+ZAfC9QTyp+bogQscsTO7ydYqVZ8jHchtCG5QYzo=
X-Received: by 2002:a81:e801:0:b0:500:5624:904c with SMTP id
 a1-20020a81e801000000b005005624904cmr4374481ywm.258.1675084432986; Mon, 30
 Jan 2023 05:13:52 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
 <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdWHE3wAYd7TSamN77Xy7CSxnEd8QHW8xm9ng4opsBEapg@mail.gmail.com>
In-Reply-To: <CAMuHMdWHE3wAYd7TSamN77Xy7CSxnEd8QHW8xm9ng4opsBEapg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Jan 2023 13:13:26 +0000
Message-ID: <CA+V-a8vBFSKbFJo1nEX7eN+S8eJazDDfCrzO7oFHsiF5yvpZ+g@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
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

Hi Geert,

On Mon, Jan 30, 2023 at 10:05 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Fri, Jan 27, 2023 at 10:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > > > node
> > > > >
> > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > >
> > > > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > > > RZ/G2L
> > > > > (r9a07g044) SoC.
> > > > >
> > > > > Signed-off-by: Lad Prabhakar
> > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > ---
> > > > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > > > >  1 file changed, 5 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > @@ -161,6 +161,11 @@ opp-50000000 {
> > > > >               };
> > > > >       };
> > > > >
> > > > > +     pmu_a55 {
> > > > > +             compatible = "arm,cortex-a55-pmu";
> > > > > +             interrupts-extended = <&gic GIC_PPI 7
> > > > > + IRQ_TYPE_LEVEL_HIGH>;
> > > >
> > > > Just a question, Is it tested?
> > > Yes this was tested with perf test
> > >
> > > > timer node[1] defines irq type as LOW, here it is high.
> > > You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this should
> > > be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
> > >
> > > > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as
> > > it has 2 cores??
> > > >
> > > No this is not required for example here [0] where it has 6 cores.
> >
> > I may be wrong, That is the only example[1], where the A55 PMU per cpu interrupts and number of a55 cores in the DT
> > are not matching.
> >
> > [1]
> > https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu
>
> Indeed, this looks like an omission, propagated through
> arch/arm64/boot/dts/renesas/r8a779[afg]0.dtsi.
>
> And doesn't this apply to all PPI interrupts, i.e. shouldn't the GIC
> in arch/arm64/boot/dts/renesas/r9a07g0{43u,44u,54}.dtsi specify the
> mask in their interrupts properties, too?
>
I was under the impression that the GIC_CPU_MASK_SIMPLE(x) was only
needed if the driver handled per-cpu stuff.

Marc, what should be the correct usage?

Cheers,
Prabhakar
