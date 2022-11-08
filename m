Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FAA621A5D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiKHRXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiKHRXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:23:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866F063AD;
        Tue,  8 Nov 2022 09:23:15 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id u24so23484849edd.13;
        Tue, 08 Nov 2022 09:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dC3L8rB3CkJyDbuZvPYnhdgYhGJJjGWGEHVBgM03GHs=;
        b=IgUA4OfmcJprV1FMZVj2AsH/Vv1caqsiAxOyP8ItQcOxavflQq6m1SHf/Z2Q7sKksH
         jNmhReqyWRlHw4PbXsnx68KMkNLWHbdcR7rGKfNLLTGG6+83KRD6GIVe2k9+Mp3egB0p
         LlizWFnOdvO29+5sXSJpzOe/SV7T30jeGHby2i8VYybQTLqjzUXdv1wW921WMl6D9H8j
         MXcGeS4Q1Qu9g3E2NxbhNCO4ldjzExw+gFvFQtsoR6WCeFRLIRBR+O0QmcZuSS8ebc3l
         cj6DnW2hoRv3LIN+/6S1+aF7PhqwvVZyvoV3Q+5uA6uyWlWr3oWWQ44cQR+3MFl3tKNX
         Zyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC3L8rB3CkJyDbuZvPYnhdgYhGJJjGWGEHVBgM03GHs=;
        b=C0Uqei7YxWHZgjgYTbknjI1H0aMvS2WrD/Lwi74IhT1OefAYlBa1zFvkrmVTDRIYLd
         v5ulGoG8wQNzZQCePK1SucotVC7xlWQxwS5xHS9AfaMdFhpWvJHV5U3aXC2RBM1oFXdp
         EjEG9ePAArygsBA/ZJeG4SHT0g2ITXfy2xH+KYx+aRM5UNM4dQoJu7dstUyiSadzo4AN
         t3oxLEJ+t0JoVXyoWtLDaBlesWy+u7bswKN9KvUcNWSyJdetRHSQdT88tu6W5XhLzO5e
         2wRWsip1bFvTopvhtbDctaqIBwxy35oA5RKtToTB5ECOZ27Sayj2KnngAck0VskQbQPJ
         bU7w==
X-Gm-Message-State: ACrzQf1gMjRN7ZtiRTJ00OAUKvgCHl9CqCzpODprdprIUMghFheFFlF9
        j3RJWuJUm0W6Ak8A1UlMaLS3Pug275wxZSGWxkE=
X-Google-Smtp-Source: AMsMyM4KBxQ83QplDTic1T/lCguYhFxZcj0K/xWDI5KytX5mkaRDpx64THZabd4ot55hyo8nCD5UsMnDqg9b2zQGIzM=
X-Received: by 2002:aa7:c389:0:b0:463:5926:7254 with SMTP id
 k9-20020aa7c389000000b0046359267254mr49367313edq.255.1667928194005; Tue, 08
 Nov 2022 09:23:14 -0800 (PST)
MIME-Version: 1.0
References: <20221028165921.94487-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221028165921.94487-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUKVxO24Qgyx37tbs5+m0Us0VF3eTZCC2KV=AC8z2JneQ@mail.gmail.com>
 <CA+V-a8t5Qah3MNm2m__xnmgK-52=HC9QBPPudnB+1j4-FYJ_NA@mail.gmail.com> <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
In-Reply-To: <CAMuHMdWTJf24XR+KR8yVJOnfpgs-PkUf9b8B=PX9Dd4mfawD5Q@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Tue, 8 Nov 2022 17:22:47 +0000
Message-ID: <CA+V-a8vCGDHL1SUTEnD-WvoUGKSVL=xzDeQxy77=1vFJdk+fYg@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] riscv: configs: defconfig: Enable Renesas RZ/Five SoC
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, Nov 8, 2022 at 4:12 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Tue, Nov 8, 2022 at 5:07 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Tue, Nov 8, 2022 at 3:52 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Oct 28, 2022 at 6:59 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Enable Renesas RZ/Five SoC config in defconfig. It allows the default
> > > > upstream kernel to boot on RZ/Five SMARC EVK board.
> > > >
> > > > Alongside enable SERIAL_SH_SCI config so that the serial driver used by
> > > > RZ/Five SoC is built-in.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > v4 -> v5
> > > > * No change
> > > >
> > > > v3 -> v4
> > > > * Explicitly enabled ARCH_R9A07G043 config (note I have restored the RB
> > > >   tags with this change)
> > > > * Used riscv instead of RISC-V in subject line
> > >
> > > Thanks for the update!
> > >
> > > > --- a/arch/riscv/configs/defconfig
> > > > +++ b/arch/riscv/configs/defconfig
> > > > @@ -29,6 +29,8 @@ CONFIG_SOC_MICROCHIP_POLARFIRE=y
> > > >  CONFIG_SOC_SIFIVE=y
> > > >  CONFIG_SOC_STARFIVE=y
> > > >  CONFIG_SOC_VIRT=y
> > > > +CONFIG_ARCH_RENESAS=y
> > > > +CONFIG_ARCH_R9A07G043=y
> > >
> > > You forgot to refresh after moving ARCH_RENESAS in v5 of "riscv:
> > > Kconfig.socs: Add ARCH_RENESAS kconfig option", and after relying on
> > > ARCH_R9A07G043 in drivers/soc/renesas/Kconfig.
> > >
> > Sorry I missed your point here, could you please elaborate.
>
> I mean that the options have moved, so you should update
> your patch like this:
>
Ouch got that.

>     --- a/arch/riscv/configs/defconfig
>     +++ b/arch/riscv/configs/defconfig
>     @@ -26,11 +26,10 @@ CONFIG_EXPERT=y
>      # CONFIG_SYSFS_SYSCALL is not set
>      CONFIG_PROFILING=y
>      CONFIG_SOC_MICROCHIP_POLARFIRE=y
>     +CONFIG_ARCH_RENESAS=y
>      CONFIG_SOC_SIFIVE=y
>      CONFIG_SOC_STARFIVE=y
>      CONFIG_SOC_VIRT=y
>     -CONFIG_ARCH_RENESAS=y
>     -CONFIG_ARCH_R9A07G043=y
>      CONFIG_SMP=y
>      CONFIG_HOTPLUG_CPU=y
>      CONFIG_PM=y
>     @@ -163,6 +159,7 @@ CONFIG_MAILBOX=y
>      CONFIG_RPMSG_CHAR=y
>      CONFIG_RPMSG_CTRL=y
>      CONFIG_RPMSG_VIRTIO=y
>     +CONFIG_ARCH_R9A07G043=y
>      CONFIG_EXT4_FS=y
>      CONFIG_EXT4_FS_POSIX_ACL=y
>      CONFIG_EXT4_FS_SECURITY=y
>
> > > >  CONFIG_SMP=y
> > > >  CONFIG_HOTPLUG_CPU=y
> > > >  CONFIG_PM=y
> > >
> > > PM and GPIOLIB are auto-selected by ARCH_R9A07G043 (through ARCH_RZG2L)
> > > resp. SOC_RENESAS, so they can be dropped.  But it's better to do this
> > > after the release of v6.2-rc1, when all pieces have fallen together.
> > >
> > Are you suggesting dropping it from defconfig?
>
> Yes, but not right now, as that would make it depend on my
> renesas-drivers-for-v6.2 branch to keep them enabled.
>
I was wondering if that's required by other platforms though.
CONFIG_PM was added for VIRT machine and GPIOLIB for HiFive.

Cheers,
Prabhakar
