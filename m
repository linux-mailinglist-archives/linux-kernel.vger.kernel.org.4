Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F068362192A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 17:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbiKHQMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 11:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiKHQMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 11:12:44 -0500
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8472F1C42D;
        Tue,  8 Nov 2022 08:12:43 -0800 (PST)
Received: by mail-qt1-f180.google.com with SMTP id s4so8911219qtx.6;
        Tue, 08 Nov 2022 08:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgqoDDJ4Y7w9ioCT4WNS5M7fA0vMFFdNn1b0OYSBfYA=;
        b=GpmBaz0JRAPyED9Z08hosalyp7D2pqsYkfA4GqO4RWTekWGhADRQJaneEOMwEn1BPP
         FFlrbo3YNCUGA9ADE2h1PNhtlZfIaB9PpV6GQnxV9rpb1jc4YCXsLpT63DpWmiZkqAGJ
         iI7QueXpdBk7JDWX9OgSlLPxLWAnAykIeGjtfCp3roy7yr0DfqrEjTiuVXqN/quNjR5t
         x83JOcf2i9c15HPe7P9GBh953OXDODqt1RDUo494gSEQsi2byO9SdYApU8nlU4gri4FX
         Zm5I6GHC71C3NPrvzcHLqpqLhPXtusVuWgf2Nx0t7aREguYNjdSfC/uQGxJCafuCrleI
         A76A==
X-Gm-Message-State: ACrzQf2bCsw3jEVSawyjTAVifzYgyCUHbatsXjircS6gzWkyD8145Gfu
        lY7lFpydcUEvxmace1TRRAY25JensvhSHpro
X-Google-Smtp-Source: AMsMyM6leyTglIEwiKZRkfgyd4VRyLIQihgk8m+9roQQtu0NF15Hj/X/tvF3PfsbE06mhhrP5+RqpA==
X-Received: by 2002:ac8:46d3:0:b0:3a5:5a4a:2d98 with SMTP id h19-20020ac846d3000000b003a55a4a2d98mr20504768qto.50.1667923962258;
        Tue, 08 Nov 2022 08:12:42 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id v20-20020a05622a145400b0035cd6a4ba3csm8562242qtx.39.2022.11.08.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 08:12:41 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id n85so12311132yba.1;
        Tue, 08 Nov 2022 08:12:40 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr43205650ybc.89.1667923960599; Tue, 08
 Nov 2022 08:12:40 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com> <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com>
In-Reply-To: <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 17:12:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
Message-ID: <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Prabhakar,

On Tue, Nov 8, 2022 at 5:07 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Nov 8, 2022 at 3:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > > upstream kernel to boot on RZ/Five SMARC EVK board.
> > >
> > > Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> > > RZ/Five SoC is built-in.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > ---
> > > v4 -> v5
> > > * No change
> > >
> > > v3 -> v4
> > > * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
> > >   tags with this change)
> > > * Used riscv instead of RISC-V in subject line
> >
> > Thanks for the update!
> >
> > > --- a/arch/riscv/configs/defconfig
> > > +++ b/arch/riscv/configs/defconfig
> > > @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > >  CONFIG_SOC_SIFIVE=y
> > >  CONFIG_SOC_STARFIVE=y
> > >  CONFIG_SOC_VIRT=y
> > > +CONFIG_ARCH_RENESAS=y
> > > +CONFIG_ARCH_R9A07G043=y
> >
> > You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
> > Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
> > ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.
> >
> Sorry I missed your point here, could you please elaborate.

I mean that the options have moved, so you should update
your patch like this:

    --- a/arch/riscv/configs/defconfig
    +++ b/arch/riscv/configs/defconfig
    @@ -26,11 +26,10 @@ CONFIG_EXPERT=y
     # CONFIG_SYSFS_SYSCALL is not set
     CONFIG_PROFILING=y
     CONFIG_SOC_MICROCHIP_POLARFIRE=y
    +CONFIG_ARCH_RENESAS=y
     CONFIG_SOC_SIFIVE=y
     CONFIG_SOC_STARFIVE=y
     CONFIG_SOC_VIRT=y
    -CONFIG_ARCH_RENESAS=y
    -CONFIG_ARCH_R9A07G043=y
     CONFIG_SMP=y
     CONFIG_HOTPLUG_CPU=y
     CONFIG_PM=y
    @@ -163,6 +159,7 @@ CONFIG_MAILBOX=y
     CONFIG_RPMSG_CHAR=y
     CONFIG_RPMSG_CTRL=y
     CONFIG_RPMSG_VIRTIO=y
    +CONFIG_ARCH_R9A07G043=y
     CONFIG_EXT4_FS=y
     CONFIG_EXT4_FS_POSIX_ACL=y
     CONFIG_EXT4_FS_SECURITY=y

> > >  CONFIG_SMP=y
> > >  CONFIG_HOTPLUG_CPU=y
> > >  CONFIG_PM=y
> >
> > PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
> > resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
> > after the release of v6.2-rc1, when all pieces have fallen together.
> >
> Are you suggesting dropping it from defconfig?

Yes, but not right now, as that would make it depend on my
renesas-drivers-for-v6.2 branch to keep them enabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
