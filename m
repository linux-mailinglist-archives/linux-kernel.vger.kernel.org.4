Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332B5F5064
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJEHfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiJEHfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:35:44 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706B61A226;
        Wed,  5 Oct 2022 00:35:32 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id u189so17004617vsb.4;
        Wed, 05 Oct 2022 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=UnlVopcenrxnIzPUN7hMKPgiR4uUFKoxv5q1QlfHtqY=;
        b=IYWPte5kvifK48+UBRVDhCDymveps1Wx1hbbEQwNugmB5yXTGrntRkBprkpVZ9aKKf
         4lU3fsL+/sECth5N9Lxtjj9D2MUNlOQBUZ6xRgXoT55WLfmz1D1Fz6Mh32vh1Bx1aW/W
         tU41tlsGy1YzFrvxAgScsGASrTPvPvuJ+PeDjaVipkG4rjelMdU32Yzfd/gb7keAMNH8
         zh8Mb71KTtLFzB3hJA5LtIhSfTmYn4nX/i/Hx/90rx7riKZ6MhTynqiB70JE0B55Ec1G
         Otlo5RBWh0guTmIXS4QphHe57HLf+QPtpLT2hQIQNmJ78QEbf/ACOkr4dzsDZTZQ0g8+
         PyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UnlVopcenrxnIzPUN7hMKPgiR4uUFKoxv5q1QlfHtqY=;
        b=JAIxiQhE8qb6wVCY/aYrpewYXvPEuOUWu0naLc+IadkjOrZlBmlJNJ7FfJJIbWFlGC
         zuOs6XNReJJGgSVE1nWUnM34hYfnqath5s+uUXfu5doGbLGDYvJJz0YQsE7QdqI467J6
         FRjI8LBr4kWXQnUAJIquIoh4MPBG25g2RPfV6ZHaUUzEt9nwJYr33MWz0Ew7LMeXcYIo
         Of/AiQJ9D+D+JsJL2D2m/8193ZYdPR4/s+cPyRlhoMDp7Sdzprp8+9y6k7dFkWxjpHFk
         2rpLYJQqlYFEU0NzQwrV+nPUo62wSMlMRNo1sN39ziTWtOMYIq0AkvSinOTMp5dBwz/J
         5A0Q==
X-Gm-Message-State: ACrzQf1p33Y97TgqVmsZTbUJoZfD4eI56LeMk62bWQef/3TveYHnD23n
        47jPoqyX9a3acwuJKq21HTLAI8F9LCbrcZtOY+q0d/sh
X-Google-Smtp-Source: AMsMyM7heUrjceVZ+R5uN97ymp06pmva6lcuKwhr3KKSY+JNsp9tLm+5mHYYMQB2y6Q5Cd4uwzLfRBo7NcpXfFF8d4s=
X-Received: by 2002:a67:a20d:0:b0:39b:181d:bd35 with SMTP id
 l13-20020a67a20d000000b0039b181dbd35mr15648357vse.39.1664955331555; Wed, 05
 Oct 2022 00:35:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220603190509.45986-1-romain.perier@gmail.com>
 <20220603190509.45986-2-romain.perier@gmail.com> <20220930191742.9A9FEC433C1@smtp.kernel.org>
In-Reply-To: <20220930191742.9A9FEC433C1@smtp.kernel.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Wed, 5 Oct 2022 09:35:20 +0200
Message-ID: <CABgxDoLPMPP2zzrGbxrtKS6SgqQW3-u=jSZRnCF_sRs766ifsw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 1/1] clk: mstar: msc313 cpupll clk driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 30 sept. 2022 =C3=A0 21:17, Stephen Boyd <sboyd@kernel.org> a =C3=
=A9crit :
>
> Quoting Romain Perier (2022-06-03 12:05:09)
> > From: Daniel Palmer <daniel@0x0f.com>
> >
> > Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> > in MStar SoCs.
> >
> > Currently there is no documentation for this block so it's possible
> > this driver isn't entirely correct.
> >
> > Only tested on the version of this IP in the MStar/SigmaStar
> > ARMv7 SoCs.
> >
> > Co-authored-by: Willy Tarreau <w@1wt.eu>
>
> This is not a standard tag, maybe Co-developed-by is what you want? A
> Signed-off-by tag should be here from Willy Tarreau then.
>
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
>
> Your Signed-off-by needs to be here. I can't apply this otherwise.
>
> > diff --git a/drivers/clk/mstar/Kconfig b/drivers/clk/mstar/Kconfig
> > index de37e1bce2d2..146eeb637318 100644
> > --- a/drivers/clk/mstar/Kconfig
> > +++ b/drivers/clk/mstar/Kconfig
> > @@ -1,4 +1,11 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > +config MSTAR_MSC313_CPUPLL
> > +       bool "MStar CPUPLL driver"
> > +       depends on ARCH_MSTARV7 || COMPILE_TEST
> > +       default ARCH_MSTARV7
> > +       help
> > +         Support for the CPU PLL present on MStar/Sigmastar SoCs.
> > +
> >  config MSTAR_MSC313_MPLL
> >         bool "MStar MPLL driver"
> >         depends on ARCH_MSTARV7 || COMPILE_TEST
> > @@ -7,3 +14,4 @@ config MSTAR_MSC313_MPLL
> >         help
> >           Support for the MPLL PLL and dividers block present on
> >           MStar/Sigmastar SoCs.
> > +
> > diff --git a/drivers/clk/mstar/Makefile b/drivers/clk/mstar/Makefile
> > index f8dcd25ede1d..21296a04e65a 100644
> > --- a/drivers/clk/mstar/Makefile
> > +++ b/drivers/clk/mstar/Makefile
> > @@ -2,5 +2,5 @@
> >  #
> >  # Makefile for mstar specific clk
> >  #
> > -
> > +obj-$(CONFIG_MSTAR_MSC313_CPUPLL) +=3D clk-msc313-cpupll.o
> >  obj-$(CONFIG_MSTAR_MSC313_MPLL) +=3D clk-msc313-mpll.o
> > diff --git a/drivers/clk/mstar/clk-msc313-cpupll.c b/drivers/clk/mstar/=
clk-msc313-cpupll.c
> > new file mode 100644
> > index 000000000000..c57b509e8c20
> > --- /dev/null
> > +++ b/drivers/clk/mstar/clk-msc313-cpupll.c
> > @@ -0,0 +1,221 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2019 Daniel Palmer <daniel@thingy.jp>
> > + */
> > +
> > +#include <linux/clk-provider.h>
> > +#include <linux/of_address.h>
> > +#include <linux/platform_device.h>
>
> Ought to include kernel.h and device.h too.
>
> > +
> [...]
> > +
> > +static const struct clk_ops msc313_cpupll_ops =3D {
> > +       .recalc_rate    =3D msc313_cpupll_recalc_rate,
> > +       .round_rate     =3D msc313_cpupll_round_rate,
> > +       .set_rate       =3D msc313_cpupll_set_rate,
> > +};
> > +
> > +static const struct of_device_id msc313_cpupll_of_match[] =3D {
> > +       { .compatible =3D "mstar,msc313-cpupll" },
> > +       {}
> > +};
> > +
> > +static const struct clk_parent_data cpupll_parent =3D {
>
> Why not put this on the stack? It doesn't have to live forever.
>
> > +       .index  =3D 0,
> > +};
> > +
> > +static int msc313_cpupll_probe(struct platform_device *pdev)
> > +{
> > +       struct clk_init_data clk_init =3D {};
> > +       struct device *dev =3D &pdev->dev;
> > +       struct msc313_cpupll *cpupll;
> > +       int ret;
> > +
> > +       cpupll =3D devm_kzalloc(&pdev->dev, sizeof(*cpupll), GFP_KERNEL=
);
> > +       if (!cpupll)
> > +               return -ENOMEM;
> > +
> > +       cpupll->base =3D devm_platform_ioremap_resource(pdev, 0);
> > +       if (IS_ERR(cpupll->base))
> > +               return PTR_ERR(cpupll->base);
> > +
> > +       /* LPF might not contain the current frequency so fix that up *=
/
> > +       msc313_cpupll_reg_write32(cpupll, REG_LPF_LOW_L,
> > +                                 msc313_cpupll_reg_read32(cpupll, REG_=
CURRENT));
> > +
> > +       clk_init.name =3D dev_name(dev);
> > +       clk_init.ops =3D &msc313_cpupll_ops;
> > +       clk_init.parent_data =3D &cpupll_parent;
> > +       clk_init.num_parents =3D 1;
> > +       cpupll->clk_hw.init =3D &clk_init;
> > +
> > +       ret =3D devm_clk_hw_register(dev, &cpupll->clk_hw);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return of_clk_add_hw_provider(pdev->dev.of_node, of_clk_hw_simp=
le_get, &cpupll->clk_hw);
>
> Use devm to add the provider too.


Ok, it does not seem to be huge to change, I will send another iteration.

Thanks,
Cheers,
Romain
