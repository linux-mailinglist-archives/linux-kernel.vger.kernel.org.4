Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4F65BF832
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiIUHuX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 21 Sep 2022 03:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiIUHuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:50:16 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A067A751;
        Wed, 21 Sep 2022 00:50:14 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id w2so3509210qtv.9;
        Wed, 21 Sep 2022 00:50:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PAJBhuT5HKP0LRGiFEK7TtSMq0xYtERZFgLWgla/nls=;
        b=om3dzTPLA4HKTLREXEePNh1oL60ag0ucUGA0s+Te+j/i4yI03aNrM+Inuncn04RYgL
         r4zWtYLE6bZTBkxeklMjFwwruo1kBT850Fh29SYm0EzygJvLE5IyjX5dK9/kN90+cBOq
         fHYgFzBM5SF+KUBdBJfaOaBe/IEVCabQQU6W3sXcza8zyj4Eiv3n3hXIdXCJeQRj2egH
         MJEsEDX3QWML76NKC6ziGdOKemwnRJh4Hup9v8pJXeSJXgZett/P35D0/sg3FiDt0JaG
         qV7/ldeMuoqBMdBpEwuF64D5w6HmmUsH2cWAJjWKrgg8LdsvvD728kZZmODJeJFofgwE
         qhcQ==
X-Gm-Message-State: ACrzQf01v94pjxOnlQHTPQqax8PsBwbRYulCDEtBRrErSgeBDuW1a5SD
        xvNcIZlRFfMGvRNGjv3Wbpo9AKdK2AvEyw==
X-Google-Smtp-Source: AMsMyM5ilQNtnrKpZtbl+1Kb3va5PLRiHUSQJJD85vL4Bn03mJg5w4z/c1j9AqJ7CF9SEPPC+1y+0g==
X-Received: by 2002:a05:622a:1789:b0:35c:d9cf:5063 with SMTP id s9-20020a05622a178900b0035cd9cf5063mr18089318qtk.82.1663746613201;
        Wed, 21 Sep 2022 00:50:13 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id i15-20020a05620a404f00b006ccc96c78easm1401147qko.134.2022.09.21.00.50.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:50:12 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3454b0b1b6dso54786357b3.4;
        Wed, 21 Sep 2022 00:50:11 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr22453571ywe.283.1663746611002; Wed, 21
 Sep 2022 00:50:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220815050815.22340-1-samuel@sholland.org> <20220815050815.22340-7-samuel@sholland.org>
 <20220815141159.10edeba5@donnerap.cambridge.arm.com> <3cd9ed5b-8348-38ac-feb1-9a7da858cebc@microchip.com>
 <932aaefd-e2ca-ef26-bf30-e315fb271ec5@sholland.org> <ff9e8bd3-c5f7-6319-060e-250151087a8e@microchip.com>
 <c6cba83ea9eea7fc41a9e78d0e45487b21f0f560.camel@icenowy.me>
 <c7599abd-c4cf-9ddd-1e74-e47dec9366d4@microchip.com> <CAMuHMdUHVpj9ikE2NxpBSBtTG8K6v92vGdbw3GLmEYUoVzatvg@mail.gmail.com>
 <538ae41e-664f-2efb-f941-9a063b727b6a@microchip.com> <CAMuHMdWWbR+Y=bJ7gdqV3d+ffHE1-hwQf-Owb8FAvZAaScdOgA@mail.gmail.com>
 <44b6f601-1a11-aacf-5592-5b61550afb9f@microchip.com> <C0B4F750-1C99-408A-A2DA-B72BBF7361B4@jrtc27.com>
 <b3fdb3cc-a8fc-b980-c8f4-f96d4733ce56@sholland.org> <CAMuHMdUMM9H4jLJ8-zOz9SXoqmK-s4zRWzGCsU8jt_sDgY1h+Q@mail.gmail.com>
In-Reply-To: <CAMuHMdUMM9H4jLJ8-zOz9SXoqmK-s4zRWzGCsU8jt_sDgY1h+Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 21 Sep 2022 09:49:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV1n00JNR7SuUXY5pVHcnG_1PHne95cUdsW+ZHgqvZW=A@mail.gmail.com>
Message-ID: <CAMuHMdV1n00JNR7SuUXY5pVHcnG_1PHne95cUdsW+ZHgqvZW=A@mail.gmail.com>
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
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Sep 9, 2022 at 5:42 AM Samuel Holland <samuel@sholland.org> wrote:
> > On 8/22/22 10:29 AM, Jessica Clarke wrote:
> > > On 22 Aug 2022, at 14:56, conor.dooley@microchip.com wrote:
> > >> On 22/08/2022 13:31, Geert Uytterhoeven wrote:
> > >>>> Do you think this is worth doing? Or are you just providing an
> > >>>> example of what could be done?
> > >>>
> > >>> Just some brainstorming...
> > >>>
> > >>>> Where would you envisage putting these macros? I forget the order
> > >>>> of the CPP operations that are done, can they be put in the dts?
> > >>>
> > >>> The SOC_PERIPHERAL_IRQ() macro should be defined in the
> > >>> ARM-based SoC.dtsi file and the RISC-V-based SoC.dtsi file.
> > >>
> > >> Right, one level up but ~the same result.
> > >>
> > >>>>> Nice! But it's gonna be a very large interrupt-map.
> > >>>>
> > >>>> I quite like the idea of not duplicating files across the archs
> > >>>> if it can be helped, but not at the expense of making them hard to
> > >>>> understand & I feel like unfortunately the large interrupt map is
> > >>>> in that territory.
> > >>>
> > >>> I feel the same.
> > >>> Even listing both interrupt numbers in SOC_PERIPHERAL_IRQ(na, nr)
> > >>> is a risk for making mistakes.
> > >>>
> > >>> So personally, I'm in favor of teaching dtc arithmetic, so we can
> > >>> handle the offset in SOC_PERIPHERAL_IRQ().
> > >>
> > >> Yup, in the same boat here. mayb I'll get bored enough to bite..
> > >
> > > Note that GPL’ed dtc isn’t the only implementation. FreeBSD uses a
> > > BSD-licensed implementation[1] and so adding new features like this to
> > > GPL dtc that actually get used would require us to reimplement it too.
> > > I don’t know how much effort it would be but please keep this in mind.
> >
> > I plan to go with the "SOC_PERIPHERAL_IRQ(na, nr)" implementation for v2. I like
> > that it only affects the DT source, and does not leak into the DTB. We still
> > have the freedom to switch to using arithmetic later when all of the tools
> > support it.
>
> May I suggest an alternative solution, which would be more generic,
> and can be extended to other/more CPU cores easily:
>
> Specify both interrupts in the .dtsi, but wrapped inside e.g. ARM()
> resp. RISCV() macros:
>
>     ARM(interrupts = <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>;)
>     RISCV(interrupts = <412 IRQ_TYPE_LEVEL_HIGH>;)
>
> The same construct can be used for e.g. interrupt-parent.
> The ARM .dts would define:
>
>     #define ARM(x...)    x
>     #define RISCV(x....)
>
> before including the .dtsi.
> The RISC-V DTS would define instead:
>
>     #define ARM(x...)
>     #define RISCV(x...)    x
>
> Cfr. the AR_CLASS(), M_CLASS(), ARM(), and THUMB() macros in
> arch/arm/include/asm/unified.h.

I brought it up with the DT people in a separate thread[1].
Please continue the discussion there.
Thanks!

[1] https://lore.kernel.org/r/CAMuHMdUPm36RsxHdVwspR3NCAR3C507AyB6R65W42N2gXWq0ag@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
