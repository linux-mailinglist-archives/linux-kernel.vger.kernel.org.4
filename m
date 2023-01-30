Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EEF6810A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbjA3OFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:05:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbjA3OFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:05:12 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD6AEFAE;
        Mon, 30 Jan 2023 06:05:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d8so12145477ybe.9;
        Mon, 30 Jan 2023 06:05:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ty2ml3wSVoKc3is0oCpzDfV64faryTo2VnyKv6Wq3iU=;
        b=OeLX2i7exeW03cqixbmRbmIepL5omBVCgMP9jyoZjwuogP+jb8swbVnHg1m3c9WxyL
         ibo2a38AHIBH0W5cwmg9DbC9OYA5Vu19BSFXIoqMeLLH5f3AyRxg0veJQfGm6Gc02uK9
         3gFYaqmPZK9vGYNij5ge4zqm71B1uMDMQ6N8CHr9xwU3DrvW4ytPHlLhSlbsULSgJ5Y+
         gJCeVSrCLAzT+DgH0OAR+DWyOY7opTw89O+JZPH4On359cV+Pl9rguKloK5tBp9TiLl1
         rphzZnzT4AcO/1EW6iY7Ibe5casW3eT19BZmW1wgdw/k/dw3N01FoLLOjZxizwzC2EoG
         y2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty2ml3wSVoKc3is0oCpzDfV64faryTo2VnyKv6Wq3iU=;
        b=vTB9RLJVPVYsAVgVmQ3j6vTjEjgOEhHCkTAS1LBTbWoJHNIMV/AadYA4uoMFzj+RjH
         xfNP2iN8TyJ59qdsIxw4igBk1FKQXmzz6WJveFcgU/m8NXioSl+70PIV0eGY05jTuPU0
         ZgIOS39m/9LUlA7qhwcMw9T4hXZAyGcWaDnDYdLGBa5uk9uoyphbOOA+3iVZzwGec5Vx
         fcSyUL1Vor8VzOpYFssiyh6Y7fG8Q+6lW6z4+eM5XW366bidFvGO/zpHXNrvbKr9SgQ9
         n333l2gQ1T4wOrFnnGNzuY51SKGyopjYwZ/2zju/vvPHXl3lc/Q4mGhY2Vbaugt6tmzy
         HjwQ==
X-Gm-Message-State: AFqh2kpVfu408REu3CLK2DDKpbFLe+jWw2n2Unf9k+2dVnke/bZVou0x
        vwQCY1QvDFULxBFsQ4RyGbaM2ovTd39E+FJ+AeA=
X-Google-Smtp-Source: AMrXdXvr18tj/FmFIZQy/2+3YdcHiCFXvT0LNcqjHYWknrShQgifrgMr6/b2qxaq+bVRK6KbzbPRMccx9aWzuVz2KDo=
X-Received: by 2002:a25:d68d:0:b0:801:e42b:29da with SMTP id
 n135-20020a25d68d000000b00801e42b29damr2880898ybg.369.1675087510727; Mon, 30
 Jan 2023 06:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com> <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Jan 2023 14:04:44 +0000
Message-ID: <CA+V-a8u=xmYghCtCcGg-fU02u0kcwGqeCKOs4iSfwkdUe1MbFg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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

Hi Mark and Will,

On Fri, Jan 27, 2023 at 9:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
>
> Hi Prabhakar,
>
>
> > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> >
> > Hi Biju,
> >
> > Thank you for the review.
> >
> > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > > Thanks for the patch.
> > >
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
Some SoCs specify the GIC_CPU_MASK_SIMPLE(x) while describing the PPI
interrupt for the PMU and some dont [1]. What should be the correct
usage when specifying the PPI interrupts for the PMU with multiple CPU
cores (we are using
arm,cortex-a55-pmu)?

 [1] https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu

Cheers,
Prabhakar
