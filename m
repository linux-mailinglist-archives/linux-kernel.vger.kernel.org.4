Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A196224DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKIHrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiKIHrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:47:10 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870AF18B16;
        Tue,  8 Nov 2022 23:47:08 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id i9so10477256qki.10;
        Tue, 08 Nov 2022 23:47:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iy4mDC1gBsOXs8MITh+tDfMo44TwiYSg8FQ+wHggFpo=;
        b=gCAGDPj/hgEbw8I72qXiyTX0FfApDZ9+eBr1iLN05/TBHSO6MOmFE3NaFvI3mdnXS0
         ffZpbwjxQhZs+jr4EC2tFs4k301uliB7uOLWUYaQ/RB6/AL/jpg/TiV7/kSK+BZp8pbd
         FnlU5iFWBJX7OmwRvzWtLLZP3UtlWDwaEt9iIgJeHWe+nTAQdVhuPVX9VvrQH4UK7tcO
         2V0l/GeYcUQUj4yh+q9f4s4Vz+Fe/JCKqoxz0XcuNfdg3/XgEh0zAD4gk7vEwFo98BqU
         u86B4QPHm6mEziwHyWvvTkGtM8Vt0gnpdRMHf051YNwEchpxEDMYc7yOc8gP/14SyaVE
         hU3g==
X-Gm-Message-State: ACrzQf1XFCtvCXv6FBtnpABW8GbbOfOys//vJm1wxXM7PiMMrHgDKRzg
        xWsdTjzZs382MZPTMMp2TnEI3d+TryFjudDX
X-Google-Smtp-Source: AMsMyM4uRcTLxr6tnY729xPOtfMIYXOIapHOPQSnto+aeCYO1UBKER5LFRzf6w9y+Ylc64BBPKn0yg==
X-Received: by 2002:a37:8041:0:b0:6fa:a2a6:9f28 with SMTP id b62-20020a378041000000b006faa2a69f28mr17217364qkd.673.1667980027505;
        Tue, 08 Nov 2022 23:47:07 -0800 (PST)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com. [209.85.219.170])
        by smtp.gmail.com with ESMTPSA id l2-20020ac80782000000b00343057845f7sm9237338qth.20.2022.11.08.23.47.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 23:47:06 -0800 (PST)
Received: by mail-yb1-f170.google.com with SMTP id y186so15425521yby.10;
        Tue, 08 Nov 2022 23:47:05 -0800 (PST)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr46193922ybc.89.1667980025410; Tue, 08
 Nov 2022 23:47:05 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
 <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com>
 <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
 <CA+V-a8vCGDHL1SUTEnD-WvoUGKSVL=xzDeQxy77=1vFJdk+fYg@mail.gmail.com>
 <CAMuHMdU=K0o6KHVPUdfEu0tkH8kDMBg-WaRFcYS7r=azWEnfTQ@mail.gmail.com> <CA+V-a8s6Amvb35wRE7pbwXHxwzk8znT8OWsbA9DRpX76E8Uh+w@mail.gmail.com>
In-Reply-To: <CA+V-a8s6Amvb35wRE7pbwXHxwzk8znT8OWsbA9DRpX76E8Uh+w@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Nov 2022 08:46:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2cQ_9a6HcXzMQPNUoJ78i4y04oAkZ0HnRLzyYq2MsuA@mail.gmail.com>
Message-ID: <CAMuHMdU2cQ_9a6HcXzMQPNUoJ78i4y04oAkZ0HnRLzyYq2MsuA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Tue, Nov 8, 2022 at 11:05 PM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Nov 8, 2022 at 7:20 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Nov 8, 2022 at 6:23 PM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > On Tue, Nov 8, 2022 at 4:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > On Tue, Nov 8, 2022 at 5:07 PM Lad, Prabhakar
> > > > <prabhakar.csengg@gmail.com> wrote:
> > > > > On Tue, Nov 8, 2022 at 3:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > > > On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > >
> > > > > > > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > > > > > > upstream kernel to boot on RZ/Five SMARC EVK board.
> > > > > > >
> > > > > > > Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> > > > > > > RZ/Five SoC is built-in.
> > > > > > >
> > > > > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > > > > ---
> > > > > > > v4 -> v5
> > > > > > > * No change
> > > > > > >
> > > > > > > v3 -> v4
> > > > > > > * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
> > > > > > >   tags with this change)
> > > > > > > * Used riscv instead of RISC-V in subject line
> > > > > >
> > > > > > Thanks for the update!
> > > > > >
> > > > > > > --- a/arch/riscv/configs/defconfig
> > > > > > > +++ b/arch/riscv/configs/defconfig
> > > > > > > @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > > > > > >  CONFIG_SOC_SIFIVE=y
> > > > > > >  CONFIG_SOC_STARFIVE=y
> > > > > > >  CONFIG_SOC_VIRT=y
> > > > > > > +CONFIG_ARCH_RENESAS=y
> > > > > > > +CONFIG_ARCH_R9A07G043=y
> > > > > >
> > > > > > You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
> > > > > > Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
> > > > > > ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.
> > > > > >
> > > > > Sorry I missed your point here, could you please elaborate.
> > > >
> > > > I mean that the options have moved, so you should update
> > > > your patch like this:
> > > >
> > > Ouch got that.
> > >
> > > >     --- a/arch/riscv/configs/defconfig
> > > >     +++ b/arch/riscv/configs/defconfig
> > > >     @@ -26,11 +26,10 @@ CONFIG_EXPERT=y
> > > >      # CONFIG_SYSFS_SYSCALL is not set
> > > >      CONFIG_PROFILING=y
> > > >      CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > > >     +CONFIG_ARCH_RENESAS=y
> > > >      CONFIG_SOC_SIFIVE=y
> > > >      CONFIG_SOC_STARFIVE=y
> > > >      CONFIG_SOC_VIRT=y
> > > >     -CONFIG_ARCH_RENESAS=y
> > > >     -CONFIG_ARCH_R9A07G043=y
> > > >      CONFIG_SMP=y
> > > >      CONFIG_HOTPLUG_CPU=y
> > > >      CONFIG_PM=y
> > > >     @@ -163,6 +159,7 @@ CONFIG_MAILBOX=y
> > > >      CONFIG_RPMSG_CHAR=y
> > > >      CONFIG_RPMSG_CTRL=y
> > > >      CONFIG_RPMSG_VIRTIO=y
> > > >     +CONFIG_ARCH_R9A07G043=y
> > > >      CONFIG_EXT4_FS=y
> > > >      CONFIG_EXT4_FS_POSIX_ACL=y
> > > >      CONFIG_EXT4_FS_SECURITY=y
> > > >
> > > > > > >  CONFIG_SMP=y
> > > > > > >  CONFIG_HOTPLUG_CPU=y
> > > > > > >  CONFIG_PM=y
> > > > > >
> > > > > > PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
> > > > > > resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
> > > > > > after the release of v6.2-rc1, when all pieces have fallen together.
> > > > > >
> > > > > Are you suggesting dropping it from defconfig?
> > > >
> > > > Yes, but not right now, as that would make it depend on my
> > > > renesas-drivers-for-v6.2 branch to keep them enabled.
> > > >
> ^^^
> > > I was wondering if that's required by other platforms though.
> > > CONFIG_PM was added for VIRT machine and GPIOLIB for HiFive.
> >
> > Does that matter? They would still get it, as long as they use the
> > defconfig.
> >
> Confused, didnt you say about dropping it from defconfig...

Yes, I did, but not right now, only after v6.2-rc1.

  - Once the defconfig has CONFIG_ARCH_R9A07G043=y, ARCH_RZG2L will
    be auto-selected (commit ebd0e06f3063cc2e ("soc: renesas: Identify
    RZ/Five SoC") is already upstream), and CONFIG_PM as well. So there
    is no longer a need for the defconfig to enable it explicitly.
  - Once the defconfig has CONFIG_ARCH_RENESAS=y, SOC_RENESAS will
    be auto-selected, but auto-selecting CONFIG_GPIOLIB depends on commit
    b3acbca3c80e6124 ("soc: renesas: Kconfig: Explicitly select GPIOLIB and
    PINCTRL config under SOC_RENESAS") is only in renesas-drivers-for-v6.2.

Please run "make savedefconfig", and compare the generated defconfig
with arch/riscv/configs/defconfig.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
