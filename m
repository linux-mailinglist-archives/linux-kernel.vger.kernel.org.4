Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC85BC5C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiISJuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiISJuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:50:00 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DF1DF27;
        Mon, 19 Sep 2022 02:49:54 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id x18so6802737qkn.6;
        Mon, 19 Sep 2022 02:49:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JmfkW8xRwvt0gn536FI9P5C84QK1rTkWqIPFbAxNJRI=;
        b=ykExiImI9t06VRFHCgnVR/+ATKvgXpZl7aKMMNBy0hXNUjmrqKp3182MIU8tEF1MT0
         lShz6YLuCFzJGYEPcmukPQpy4S9T589yZbVroTi8eYNp7yqPuM2YGKFtZcJw2WtLsodF
         Qeidqaxj0OAab8b/ZboWBMo8HDBa21reh6tT5tL+745d0jMIdxiINHHqdzQuBxgghTrX
         gRQEt6qe+0vtimDucmlmUfsFjxffB7v/aGjRKRGpkqq006hsA3Ygv5Ba43kyoxWpD/+F
         NnljnBYnvRVGQZbw5Dlb8Kc4iV1y8E083zk4wllf9FcJH0nFamHY8M+Ih+E1dkqU+3rU
         VBvA==
X-Gm-Message-State: ACrzQf3NfuWxJ8JSGuWzmsfVNlzJShw7rGH8I8eTNz+QnBnhV5E9ySZH
        ElKzX+A7vMFri1YtlAVDbHAf8mtwpBJPwg==
X-Google-Smtp-Source: AMsMyM5JarFpSalEtEOLR5Ui3KaYogLTnXoPYZfQBye9rRszP9PP23I7I1M8ehEjbePXKMc23w1uNA==
X-Received: by 2002:a05:620a:2951:b0:6ce:c55e:102a with SMTP id n17-20020a05620a295100b006cec55e102amr10005659qkp.134.1663580993020;
        Mon, 19 Sep 2022 02:49:53 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id ay29-20020a05622a229d00b0031f0b43629dsm2329894qtb.23.2022.09.19.02.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:49:52 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id a67so41706086ybb.3;
        Mon, 19 Sep 2022 02:49:52 -0700 (PDT)
X-Received: by 2002:a25:3851:0:b0:6ad:9cba:9708 with SMTP id
 f78-20020a253851000000b006ad9cba9708mr14263604yba.36.1663580992123; Mon, 19
 Sep 2022 02:49:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220915233852.415407-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdUhq6nJSPdR4XfFvune2g0xHLxB-jP38yhVdwFyO8VQBg@mail.gmail.com> <CA+V-a8tbO2okH3oku+15nrd+KRdGoFQ8WRck5sAMuGhV9WcHpA@mail.gmail.com>
In-Reply-To: <CA+V-a8tbO2okH3oku+15nrd+KRdGoFQ8WRck5sAMuGhV9WcHpA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 11:49:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVeDLSbea4pYJoajQXg0RroGeNuQcS6sBbU--GnmNu0aw@mail.gmail.com>
Message-ID: <CAMuHMdVeDLSbea4pYJoajQXg0RroGeNuQcS6sBbU--GnmNu0aw@mail.gmail.com>
Subject: Re: [PATCH] ARM: shmobile: Kconfig: Drop selecting SOC_BUS
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
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

On Mon, Sep 19, 2022 at 11:46 AM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Sun, Sep 18, 2022 at 10:32 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Sep 16, 2022 at 1:39 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Don't automatically select the SOC_BUS config option as we already have
> > > automatically selected it as part of the SOC_RENESAS config option [0]
> > > as renesas-soc.c [1] uses the APIs provided by SOC_BUS config option.
> > >
> > > [0] drivers/soc/renesas/Kconfig
> > > [1] drivers/soc/renesas/renesas-soc.c
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.1.
> >
> > > --- a/arch/arm/mach-shmobile/Kconfig
> > > +++ b/arch/arm/mach-shmobile/Kconfig
> > > @@ -6,5 +6,4 @@ menuconfig ARCH_RENESAS
> > >         select GPIOLIB
> > >         select NO_IOPORT_MAP
> > >         select PINCTRL
> > > -       select SOC_BUS
> > >         select ZONE_DMA if ARM_LPAE
> >
> > Nice catch!
> > I guess it would make sense to move the GPIOLIB and PINCTRL selects
> > to drivers/soc/renesas/Kconfig, too, as they are needed for all
> > (arm32/arm64/riscv) Renesas SoCs?
> >
> Agreed, shall I move them under SOC_RENESAS?

That's the place I had in mind ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
