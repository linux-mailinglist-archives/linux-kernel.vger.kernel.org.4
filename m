Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB855BCBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiISM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiISM22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:28:28 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB93F15FF4;
        Mon, 19 Sep 2022 05:28:26 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id lc7so64123357ejb.0;
        Mon, 19 Sep 2022 05:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LIEGLLynOUu61HFX2FhrDMy2vJrTLfLnfbbHMCN9ZC8=;
        b=pONn3DI0XHw5/a0ahu0Ev7IQWOHgIN0d2iH2hExtVHp7D/6FjEehLK3g2x9aDl3iao
         Q0jFpA8OW1Cfki75OosKx2UUqyFh8Q4UF/g1+tHQAzlRIZub99dKGbJicZcjvrpL6Btw
         LU8pYSyaEOCF3gwqbHY8Bjy4zYcmU8jFkhCsWokCqxbzySzj7/BHxHvxi7LPWAeah+Ev
         LV5JT+lFVzLbjAXfwXeu+U5SWiRrcs9kQeP98DdlEF/XpdmXebdg7ljcmUw8IKmJMyoA
         Lfwuaiz0wMbVyig2XIQjCyGvjmIHG9GLnX5ik0/qZUJ1qua25dcm8rZ72qz8nIWVN14G
         bE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LIEGLLynOUu61HFX2FhrDMy2vJrTLfLnfbbHMCN9ZC8=;
        b=DQ9RO2QOq0bO8oJKUuEVEQDnplgZtqCq4noH2iwUjPq+oAgdncZG8O7Vi/IKxy5AWf
         nUae0xp5Slo+ga2MMBFj5cU+7WyUnOkl0+hNzpiHlFXxskDFl1P8MWy6D+s21VMyyG35
         pWCueFOxNBJTxwqcgbrFVBg1/JO1a1a284TEy4I/uQQFOG2vxKKa/MTE9HYNHTUPzgJK
         dGfmek6zbIMZM3GlnMgORkYtQI5uP/eLx24SCHHJTfJuJ2N9xZmf9GcOkNQnBsR5Dbrw
         PDGtxslRzXbUEj9Yuo3GOEVTrsqyBD/RcvU5arRNF5/kxjNWBqGH0Eq2y8r1kM6f18cL
         LXoA==
X-Gm-Message-State: ACrzQf2+ah1onYyjKCNXmLCPZHzKSQWYfDAIugYsibCjT1L2HFUtrAq1
        OQr1CICrBX/DmWgjOVP4VH3W9fmkbE3bElrBz6t2IUQ6qx0=
X-Google-Smtp-Source: AMsMyM5duHyULRy8NqjkmTIQ4cCTHXbqE57wzTlJy7dJfNIRrQDYMFf0PUK+jq12tj8sa8xV9WFUTz54QLcY/Uaq1Yc=
X-Received: by 2002:a17:907:3f93:b0:780:1b17:1160 with SMTP id
 hr19-20020a1709073f9300b007801b171160mr12599322ejc.196.1663590504890; Mon, 19
 Sep 2022 05:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220919115839.151442-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUaSLMtffr=7w7thY2T_5DvktUZOZaJ5vcuaLhJdtwN_A@mail.gmail.com>
In-Reply-To: <CAMuHMdUaSLMtffr=7w7thY2T_5DvktUZOZaJ5vcuaLhJdtwN_A@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 19 Sep 2022 13:27:57 +0100
Message-ID: <CA+V-a8u4CiW+JMuF0SKXDHnoyU=a=oTmGUhKQXpLwiGeuiG_XQ@mail.gmail.com>
Subject: Re: [PATCH] clk: renesas: r9a07g043: Hide WDT2 clock and reset
 entries for RZ/Five
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
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

On Mon, Sep 19, 2022 at 1:08 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Sep 19, 2022 at 2:00 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Make the clock and reset entries for WDT2 only visible for RZ/G2UL (ARM64)
> > as the RZ/Five SoC doesn't have the WDT2 channel.
> >
> > While at it, add the WDT2 clocks to r9a07g043_crit_mod_clks[] list as WDT
> > CH2 is specifically to check the operation of Cortex-M33 CPU on the RZ/G2UL
> > SoC and we dont want to turn off the clocks of WDT2 if it isn't enabled by
> > Cortex-A55.
> >
> > Fixes: 95d48d270305 ("clk: renesas: r9a07g043: Add support for RZ/Five SoC")
> > Reported-by: Biju Das <biju.das.jz@bp.renesas.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/drivers/clk/renesas/r9a07g043-cpg.c
> > +++ b/drivers/clk/renesas/r9a07g043-cpg.c
> > @@ -158,10 +158,12 @@ static struct rzg2l_mod_clk r9a07g043_mod_clks[] = {
> >                                 0x548, 0),
> >         DEF_MOD("wdt0_clk",     R9A07G043_WDT0_CLK, R9A07G043_OSCCLK,
> >                                 0x548, 1),
> > +#ifdef CONFIG_ARM64
> >         DEF_MOD("wdt2_pclk",    R9A07G043_WDT2_PCLK, R9A07G043_CLK_P0,
> >                                 0x548, 4),
> >         DEF_MOD("wdt2_clk",     R9A07G043_WDT2_CLK, R9A07G043_OSCCLK,
> >                                 0x548, 5),
> > +#endif
>
> Please move these into the existing section for arm64.
>
OK, I will move this to the existing section (and below).

Cheers,
Prabhakar

> >         DEF_MOD("spi_clk2",     R9A07G043_SPI_CLK2, R9A07G043_CLK_SPI1,
> >                                 0x550, 0),
> >         DEF_MOD("spi_clk",      R9A07G043_SPI_CLK, R9A07G043_CLK_SPI0,
> > @@ -269,7 +271,9 @@ static struct rzg2l_reset r9a07g043_resets[] = {
> >         DEF_RST(R9A07G043_OSTM1_PRESETZ, 0x834, 1),
> >         DEF_RST(R9A07G043_OSTM2_PRESETZ, 0x834, 2),
> >         DEF_RST(R9A07G043_WDT0_PRESETN, 0x848, 0),
> > +#ifdef CONFIG_ARM64
> >         DEF_RST(R9A07G043_WDT2_PRESETN, 0x848, 2),
> > +#endif
>
> Likewise.
>
> >         DEF_RST(R9A07G043_SPI_RST, 0x850, 0),
> >         DEF_RST(R9A07G043_SDHI0_IXRST, 0x854, 0),
> >         DEF_RST(R9A07G043_SDHI1_IXRST, 0x854, 1),
>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
