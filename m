Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542E35BC5B7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiISJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiISJqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:46:21 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5641581D;
        Mon, 19 Sep 2022 02:46:17 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z13so26442379edb.13;
        Mon, 19 Sep 2022 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ncpu9fPsrvP8rBB8yOGACoIFv5j6li/K92NfJk6qjOM=;
        b=mKOFky0BEuANtdZFCmnaJCvWDk/Prn8YU3potatp1aiFzey/6rREnqc+qobmrb5Qlx
         LA+sU3kc+NaHOs7ximgIdhitxZADJKtehemG/S1uIjFSUhy2DA46RjA5WSxHjZo22q0t
         kNQGG1qK+1y3gofj+fM7Clp/JnkROMTN4zNGKxkdkHQiQ0L8PsmxtCG2LH+w7R2+EXO1
         Y0PDeEsliyVv2eevqOaKeSzIdwIkybXVwN9b4GVOHhUMC4Fg5vNZQ4NZ4OxbMszYI6HN
         YQaOT+IRkwvGJ8nM4uFeH1y7MElFpIekEDKaa39fegOzgvIP8p0NhDTKEfVgMuYBuO49
         IMIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ncpu9fPsrvP8rBB8yOGACoIFv5j6li/K92NfJk6qjOM=;
        b=0xf6iDyOs2n6zWNma67T9IIpepfsFK8bWIJJdnx7o5SJgFKbbvmTW0xPUUJUCbIzLK
         edfZDMvvYIhueKgpYmLqlA/3MPW5/ETfv3u87szakl6Rtfy1W/Jcl4kYpWpjGMRoWESW
         0HDiAOWx+tY6FmTFDMNdMuiH0jozt+0fT3GWGyZEJF9SHuE/THAc1lXM6umO2XLf3LS3
         F18dMlkn43DRGDa6S2pDKSFG0Y0evefVanOgarIYdONup4nxpHVX3fxqdpVM76CNrXvI
         ySL4CoImDaf6eSrTANtLI9N15FNf12ilEZYpkNiIwKrKFD73DHKl/MrYZtCCcFxbFwgL
         fvmg==
X-Gm-Message-State: ACrzQf1y2ASKIz2UDip1j2bXbOYtpe9ec90jn//hvKSnUHsz/yB+PUM4
        1w7ZO3KdVdPKgj82yqlmXKoeS/f9PxbiI745pXM=
X-Google-Smtp-Source: AMsMyM68B2nGHcwBnVYWFXO6+wYWx5TzDTNBNtGa47/KGnoKpATUd4NlZPguKTJNhpLG7t9/4XI57oalJmG5SXUAopo=
X-Received: by 2002:a05:6402:f11:b0:44f:e1ff:801a with SMTP id
 i17-20020a0564020f1100b0044fe1ff801amr15033168eda.109.1663580776408; Mon, 19
 Sep 2022 02:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com>
In-Reply-To: <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 10:45:49 +0100
Message-ID: <CA+V-a8tbO2okH3oku+15nrd+KRdGoFQ8WRck5sAMuGhV9WcHpA@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Kconfig: Drop selecting SOC_BUS
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Thank you for the review.

On Sun, Sep 18, 2022 at 10:32 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, Sep 16, 2022 at 1:39 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Don't automatically select the SOC_BUS config option as we already have
> > automatically selected it as part of the SOC_RENESAS config option [0]
> > as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.
> >
> > [0] drivers/soc/renesas/Kconfig
> > [1] drivers/soc/renesas/renesas-soc.c
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.1.
>
> > --- a/arch/arm/mach-shmobile/Kconfig
> > +++ b/arch/arm/mach-shmobile/Kconfig
> > @@ -6,5 +6,4 @@ menuconfig ARCH_RENESAS
> >         select GPIOLIB
> >         select NO_IOPORT_MAP
> >         select PINCTRL
> > -       select SOC_BUS
> >         select ZONE_DMA if ARM_LPAE
>
> Nice catch!
> I guess it would make sense to move the GPIOLIB and PINCTRL selects
> to drivers/soc/renesas/Kconfig, too, as they are needed for all
> (arm32/arm64/riscv) Renesas SoCs?
>
Agreed, shall I move them under SOC_RENESAS?

Cheers,
Prabhakar
