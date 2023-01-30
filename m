Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D39B681350
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjA3OcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbjA3OcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:32:02 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746538B64;
        Mon, 30 Jan 2023 06:30:32 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-501c3a414acso161624547b3.7;
        Mon, 30 Jan 2023 06:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iq37Qn4bWUJ4Iifx3i3bJYrue8OE5WRgP4ctLdUjknI=;
        b=WOnNnCbf9VKLlerNxG2QcDmjZvOKHT+2ZC27EJCxxD/8Kqy53ZTH/2yUCrbVZIlmoI
         PGoJjROVu1oSRTOWUmAOerHl/sf9P1r+kLUZKpUYIuT2v1kbtUQtFyDUDhD4+bz41VYV
         aLx6Bcf6oVnvaJsvmM4GIhECzi79Qxi+5irT+Jj4IfLhfwqcoWZQ7iK4KW89e5F2/X7F
         WVBQtl+Ul2moiaD8ovigfN2S3e725hQKvtWNYcyH02uQRmhJHTZAsP/L6LBNc2tFeHFa
         dhjuZdzyGvq7vBHdg5EcRuhqlf05rsf+pSJu6O4oIIg5hUkde1jwnJdNaBbZIJhLqRLr
         93Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iq37Qn4bWUJ4Iifx3i3bJYrue8OE5WRgP4ctLdUjknI=;
        b=HpcPVX17QrvTq08RgBxMHt5z6uW8a9v4sIVb74X6y0Fud6YmLkj7glLjfxtp3RtLJK
         7IeDpY8YmJshnLf9HnXDXBKFrADOt7z+zqaotgfTZZCPcjj99C/1sFpUxjTHYG8Bc6l4
         DN8vJ+k0T3L4z1TyA5eBrpxPu244eFqRCLGjZeHM7SXEGus7WA7aQ1mEDxnVhChJZVfW
         x7wZBUv0Ve5VPXTkxku+HePpyi7CFXy6iAOOt69yJFefptqgTj7skeNjLhnOwYdBQk92
         5EsT+AfQUbZcAfdEh7Z83mmRd1FqwY0Gl37K3VVDxSM6L2jZOA2IIghFWpyLJlQpVP7l
         LnWQ==
X-Gm-Message-State: AO0yUKUqiZE6GCtgX4DXsYHH/s/I1L4qy9GbSteCZvCyBN9s8ksm9wtx
        RUkZO9EFfPUCaj2yHnQ5Vq8XhYiyZCtxlRxckf8=
X-Google-Smtp-Source: AK7set9w46wwqW3xU7XlbxmOjsvFLidIOo8DCYuQkCsXmvc7aQgh/HBtXnW48alEiUDMuuqAVWFtlbz1tR/NRvVpMJQ=
X-Received: by 2002:a0d:e883:0:b0:506:3d29:a280 with SMTP id
 r125-20020a0de883000000b005063d29a280mr2715277ywe.421.1675089031407; Mon, 30
 Jan 2023 06:30:31 -0800 (PST)
MIME-Version: 1.0
References: <20230127174014.251539-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB592258905AC3979803C473D786CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8s+cZpuUXWRa573a373n7YPsHrdLnUVXHjez6O101oneQ@mail.gmail.com>
 <OS0PR01MB5922943C1E1D9329691DB02F86CC9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CA+V-a8u=xmYghCtCcGg-fU02u0kcwGqeCKOs4iSfwkdUe1MbFg@mail.gmail.com> <Y9fPsjffc7bE8ULm@FVFF77S0Q05N>
In-Reply-To: <Y9fPsjffc7bE8ULm@FVFF77S0Q05N>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 30 Jan 2023 14:30:04 +0000
Message-ID: <CA+V-a8uGTZfRc7nzK90-RNoyUVAXZVZ_W_VCxhzC5uc68C_eEg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
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

Hi Mark,

On Mon, Jan 30, 2023 at 2:10 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Mon, Jan 30, 2023 at 02:04:44PM +0000, Lad, Prabhakar wrote:
> > Hi Mark and Will,
> >
> > On Fri, Jan 27, 2023 at 9:48 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > >
> > > Hi Prabhakar,
> > >
> > >
> > > > Subject: Re: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU node
> > > >
> > > > Hi Biju,
> > > >
> > > > Thank you for the review.
> > > >
> > > > On Fri, Jan 27, 2023 at 6:38 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > > >
> > > > > Hi Prabhakar,
> > > > >
> > > > > Thanks for the patch.
> > > > >
> > > > > > Subject: [PATCH] arm64: dts: renesas: r9a07g044: Add Cortex-A55 PMU
> > > > > > node
> > > > > >
> > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > >
> > > > > > Enable the performance monitor unit for the Cortex-A55 cores on the
> > > > > > RZ/G2L
> > > > > > (r9a07g044) SoC.
> > > > > >
> > > > > > Signed-off-by: Lad Prabhakar
> > > > > > <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 5 +++++
> > > > > >  1 file changed, 5 insertions(+)
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > index 80b2332798d9..ff9bdc03a3ed 100644
> > > > > > --- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > +++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
> > > > > > @@ -161,6 +161,11 @@ opp-50000000 {
> > > > > >               };
> > > > > >       };
> > > > > >
> > > > > > +     pmu_a55 {
> > > > > > +             compatible = "arm,cortex-a55-pmu";
> > > > > > +             interrupts-extended = <&gic GIC_PPI 7
> > > > > > + IRQ_TYPE_LEVEL_HIGH>;
> > > > >
> > > > > Just a question, Is it tested?
> > > > Yes this was tested with perf test
> > > >
> > > > > timer node[1] defines irq type as LOW, here it is high.
> > > > You are right looking at the RZG2L_InterruptMapping_rev01.xlsx this should
> > > > be LOW. (I followed the SPI IRQS where all the LEVEL interrupts are HIGH)
> > > >
> > > > > Also do we need to define (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_LOW) as
> > > > it has 2 cores??
> > > > >
> > > > No this is not required for example here [0] where it has 6 cores.
> > >
> > > I may be wrong, That is the only example[1], where the A55 PMU per cpu interrupts and number of a55 cores in the DT
> > > are not matching.
> > >
> > Some SoCs specify the GIC_CPU_MASK_SIMPLE(x) while describing the PPI
> > interrupt for the PMU and some dont [1]. What should be the correct
> > usage when specifying the PPI interrupts for the PMU with multiple CPU
> > cores (we are using
> > arm,cortex-a55-pmu)?
> >
> >  [1] https://elixir.bootlin.com/linux/latest/B/ident/arm%2Ccortex-a55-pmu
>
> This is a GICv3 system. the GICv3 interrupts binding *does not* have a cpumask,
> and it's always wrong to use GIC_CPU_MASK_SIMPLE() (or any mask, for that
> matter) for GICv3
>
> The GICv2 binding has the mask, but even there it's arguably pointless.
>
> Please do not add the mask here, since it would violate the GICv3 binding.
>
Thank you for the clarification.

(Note to myself, to drop GIC_CPU_MASK_SIMPLE() from timer nodes from
rzg2l family)

Cheers,
Prabhakar
