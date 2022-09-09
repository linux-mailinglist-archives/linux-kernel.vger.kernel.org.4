Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCF75B2F81
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiIIHK4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Sep 2022 03:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiIIHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:10:53 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D128674DDF;
        Fri,  9 Sep 2022 00:10:51 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id z18so642397qts.7;
        Fri, 09 Sep 2022 00:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GbISm7ahSLrwT2Au2tPllsLxCWm8oBE76/YUTIUdxx0=;
        b=ALEaS9djRposrd0/TdJ2bvrMCLrj9nQZ545tn4rBuQHLzty5dTqVcp2UOluudD2IAu
         AKGuJ6VbE37Nvclzux6plqgR2+bwyjRvcnZIo54psyipD82LTKAxKLLaTGkrtufzj7cv
         ZudxBk/udJbNn87feLcUYvAjCsrq+WtaCYTGqcYwijinFxj3ComI8yQoxkX3I7PXNM0C
         mTpphcT2QetdLfUij3eUGoS2LDFRHRmC2wSpD/9qDdDKe1gA/CLo0YVPjHBuLkttFEeS
         GhY13gxu6N+alNebkKxR2uwYQFrUXDJItZagEnM6+g4k4RoNA4iypFJ/Oc6rrZN8QOvr
         ACWQ==
X-Gm-Message-State: ACgBeo2Av0zi9fpN+0XQkn3OBTHXiu/YVm5EhL2JDIb4d89LgUc1JwK1
        7rkaskGmdoAMvwoM58EqZYXGpCtySvA1Ng==
X-Google-Smtp-Source: AA6agR6pekS6cZwD/H9qkwPK+BPlu/q2HipkIMT8iVX2ZPWaKNKa1Y6St+WWt1rtfYKD/fGg8LZbgg==
X-Received: by 2002:a05:622a:1a02:b0:343:7465:7cab with SMTP id f2-20020a05622a1a0200b0034374657cabmr11416697qtb.175.1662707450637;
        Fri, 09 Sep 2022 00:10:50 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a448500b006bb0f9b89cfsm790448qkp.87.2022.09.09.00.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:10:50 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id 130so1357864ybz.9;
        Fri, 09 Sep 2022 00:10:49 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr8823957yba.36.1662707449504; Fri, 09
 Sep 2022 00:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com> <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org> <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com> <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
 <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com> <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
 <44b6f601-1a11-aacf-5592-5b61550afb9f@microchip.com> <C0B4F750-1C99-408A-A2DA-B72BBF7361B4@jrtc27.com>
 <b3fdb3cc-a8fc-b980-c8f4-f96d4733ce56@sholland.org>
In-Reply-To: <b3fdb3cc-a8fc-b980-c8f4-f96d4733ce56@sholland.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Sep 2022 09:10:37 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUMM9H4jLJ8-zOz9SXoqmK-s4zRWzGCsU8jt_sDgY1h+Q@mail.gmail.com>
Message-ID: <CAMuHMdUMM9H4jLJ8-zOz9SXoqmK-s4zRWzGCsU8jt_sDgY1h+Q@mail.gmail.com>
Subject: Re: [PATCH 06/12] riscv: dts: allwinner: Add the D1 SoC base devicetree
To:     Samuel Holland <samuel@sholland.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        devicetree <devicetree@vger.kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-sunxi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

On Fri, Sep 9, 2022 at 5:42 AM Samuel Holland <samuel@sholland.org> wrote:
> On 8/22/22 10:29 AM, Jessica Clarke wrote:
> > On 22 Aug 2022, at 14:56, conor.dooley@microchip.com wrote:
> >> On 22/08/2022 13:31, Geert Uytterhoeven wrote:
> >>>> Do you think this is worth doing? Or are you just providing an
> >>>> example of what could be done?
> >>>
> >>> Just some brainstorming...
> >>>
> >>>> Where would you envisage putting these macros? I forget the order
> >>>> of the CPP operations that are done, can they be put in the dts?
> >>>
> >>> The SOC_PERIPHERAL_IRQ() macro should be defined in the
> >>> ARM-based SoC.dtsi file and the RISC-V-based SoC.dtsi file.
> >>
> >> Right, one level up but ~the same result.
> >>
> >>>>> Nice! But it's gonna be a very large interrupt-map.
> >>>>
> >>>> I quite like the idea of not duplicating files across the archs
> >>>> if it can be helped, but not at the expense of making them hard to
> >>>> understand & I feel like unfortunately the large interrupt map is
> >>>> in that territory.
> >>>
> >>> I feel the same.
> >>> Even listing both interrupt numbers in SOC_PERIPHERAL_IRQ(na, nr)
> >>> is a risk for making mistakes.
> >>>
> >>> So personally, I'm in favor of teaching dtc arithmetic, so we can
> >>> handle the offset in SOC_PERIPHERAL_IRQ().
> >>
> >> Yup, in the same boat here. mayb I'll get bored enough to bite..
> >
> > Note that GPL’ed dtc isn’t the only implementation. FreeBSD uses a
> > BSD-licensed implementation[1] and so adding new features like this to
> > GPL dtc that actually get used would require us to reimplement it too.
> > I don’t know how much effort it would be but please keep this in mind.
>
> I plan to go with the "SOC_PERIPHERAL_IRQ(na, nr)" implementation for v2. I like
> that it only affects the DT source, and does not leak into the DTB. We still
> have the freedom to switch to using arithmetic later when all of the tools
> support it.

May I suggest an alternative solution, which would be more generic,
and can be extended to other/more CPU cores easily:

Specify both interrupts in the .dtsi, but wrapped inside e.g. ARM()
resp. RISCV() macros:

    ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
    RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)

The same construct can be used for e.g. interrupt-parent.
The ARM .dts would define:

    #define ARM(x...)    x
    #define RISCV(x....)

before including the .dtsi.
The RISC-V DTS would define instead:

    #define ARM(x...)
    #define RISCV(x...)    x

Cfr. the AR_CLASS(), M_CLASS(), ARM(), and THUMB() macros in
arch/arm/include/asm/unified.h.

Note that this is not exactly a new issue.  It's fairly common for
SoCs to have separate application and real-time cores, and on-SoC
devices may be wired to multiple interrupt controllers serving
the AP resp. RT cores. If both core sets are ARM, both interrupt
controllers may be GIC, and the problem may be less severe and just
need a different #interrupt-parent.
But in case of ARM vs. RISC-V, or different wirings from devices
to interrupt controllers, you do need completely different interrupts
properties.

> My other concern is that the big interrupt-map property would make DT overlays
> even more painful to deal with. I don't think overlays can append to a property,
> only replace it.

Indeed, overlays can only add/replace/delete properties.
Same for plain DTS files, BTW.
But I agree having /append-property/ would be useful in general.


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
