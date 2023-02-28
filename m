Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181046A5A8C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjB1OHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1OHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:07:34 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA232B62F;
        Tue, 28 Feb 2023 06:07:33 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id y19so5730129pgk.5;
        Tue, 28 Feb 2023 06:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGXSekdrp8g7zN92T4Fa+/JgB01svrkzjIIvtpETtVA=;
        b=qNVJe5/A6zOiD+AUsXFWAKqDNH3NNnKLi18vVrwp0+zcmjR7m/pnqrr+xj0pJIS2Uz
         3Lw1d3nU8IqOA/ebWBNpTuZD2FybCCQlWBlf9oj+TobnKN+vnx1maN8e4TV7Wd8prQja
         Em88pIPTEq5lBom7Lwv0BQQvV2ZK587s3VOkANaiy5jqwQCZNlKpb/+UP8CLFMu+Gycu
         cN+cLmCFK9dVrdxTZ4KLdv37xPgGkYLAF8yd1W8Y83vzsDxkxk31At07BVFitiIcJ9x/
         MhkZNpYlCXkl6qEedPy7GKXGoTAHLX4quDNf1DKMnXU+j+j+ATtnIWmx1o2ZGP150gve
         TVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGXSekdrp8g7zN92T4Fa+/JgB01svrkzjIIvtpETtVA=;
        b=LwzjpdsMCy6nGTk6srYo6XnHH3XUX+GM42psTa3TTm5s0g9bdk1Kne4seDmpk8bYul
         hj3okjOQpeJJ2a8d8Q4Zr6dQVSu36cttMS9FTpfzOolu1z6k0Ndwf4KreKDiUn5SkRj7
         CIQjQ8C7AaSK+9m/4XK8XWMrWfMvQcUSanVITsZgjlz7xg+QSyoUDgFxjciTCNB4xTgL
         vO2shiSOsZHDTOwb7f6sYyS8PtnrJdWhHLdtdhFjYP1+jjIbLM72Dmz1WwV7AMhFHDMv
         DRErDVHBXJttz4KF72VH/1lOqIpvK9/0yskkrHM42B5t534TofW9Z+otNJLXsN2GzPxD
         TOVw==
X-Gm-Message-State: AO0yUKWGZfwIlW3nCIu9PVaXN+8GNg/noUJZ4XFmfPUVV8NEThJNEdcX
        qXqkZJH5ymtBfO2+AEK6abogYetU3dEy8HPutpM=
X-Google-Smtp-Source: AK7set8j/6l+jbx2LPhyRYrp/J6I+uqco+blmrGdJMWFUTjBCu0YReNhNAwlaCL5EKIQAzqm8RvL5jlU/32MVUHATUg=
X-Received: by 2002:a63:3508:0:b0:4fc:2058:fa2b with SMTP id
 c8-20020a633508000000b004fc2058fa2bmr844532pga.3.1677593252542; Tue, 28 Feb
 2023 06:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20230228130215.289081-1-nick.alcock@oracle.com>
 <20230228130215.289081-10-nick.alcock@oracle.com> <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
In-Reply-To: <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 28 Feb 2023 08:07:21 -0600
Message-ID: <CAHCN7xJHXbmBoSv6eHoqc3e_GJpCjY+nQPWNG7-56VfypCEmJQ@mail.gmail.com>
Subject: Re: [PATCH 09/20] clk: renesas: remove MODULE_LICENSE in non-modules
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 7:46=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Nick,
>
> On Tue, Feb 28, 2023 at 2:03 PM Nick Alcock <nick.alcock@oracle.com> wrot=
e:
> > Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> > Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> > are used to identify modules. As a consequence, uses of the macro
> > in non-modules will cause modprobe to misidentify their containing
> > object file as a module when it is not (false positives), and modprobe
> > might succeed rather than failing with a suitable error message.
> >
> > So remove it in the files in this commit, none of which can be built as
> > modules.
> >
> > Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> > Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
>
> Thanks for your patch!
>
> >  drivers/clk/renesas/rcar-usb2-clock-sel.c | 1 -
>
> I think it would make sense to make CLK_RCAR_USB2_CLOCK_SEL
> tristate. Shimoda-san?
> The Beacon Renesom seems to be the only board where this
> is wired up, Adam?

The CLK_RCAR_USB2_CLOCK_SEL is basically glue that lets the user
select between an external oscillator or a crystal oscillator.  The
Beacon board uses an external clock instead of a crystal, so this
driver is plumbed in to make sure the external clock is enabled on
demand and the SoC isn't trying to excite the crystal.

The CLK_RCAR_USB2_CLOCK_SEL is currently set to 'y' in the defconfig,
but it looks like the USB_RENESAS_USB3 and USB_RENESAS_USBHS drivers
are all modules.  I am not an expert in this area, but it seems to me
like the CLK_RCAR_USB2_CLOCK_SEL could likely be tri-state as well.  I
am not sure how the dependency and/or loading order would be
established.

adam

>
> >  drivers/clk/renesas/renesas-cpg-mssr.c    | 1 -
> >  drivers/clk/renesas/rzg2l-cpg.c           | 1 -
> >  3 files changed, 3 deletions(-)
> >
> > diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/re=
nesas/rcar-usb2-clock-sel.c
> > index 684d8937965e0..ba6b5bd67786f 100644
> > --- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
> > +++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
> > @@ -220,4 +220,3 @@ static struct platform_driver rcar_usb2_clock_sel_d=
river =3D {
> >  builtin_platform_driver(rcar_usb2_clock_sel_driver);
> >
> >  MODULE_DESCRIPTION("Renesas R-Car USB2 clock selector Driver");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renes=
as/renesas-cpg-mssr.c
> > index 1a0cdf001b2f2..bfe5dc9a2e36b 100644
> > --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> > +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> > @@ -1154,4 +1154,3 @@ void __init mssr_mod_reparent(struct mssr_mod_clk=
 *mod_clks,
> >  }
> >
> >  MODULE_DESCRIPTION("Renesas CPG/MSSR Driver");
> > -MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2=
l-cpg.c
> > index 4bf40f6ccd1d1..93b02cdc98c25 100644
> > --- a/drivers/clk/renesas/rzg2l-cpg.c
> > +++ b/drivers/clk/renesas/rzg2l-cpg.c
> > @@ -1440,4 +1440,3 @@ static int __init rzg2l_cpg_init(void)
> >  subsys_initcall(rzg2l_cpg_init);
> >
> >  MODULE_DESCRIPTION("Renesas RZ/G2L CPG Driver");
> > -MODULE_LICENSE("GPL v2");
> > --
> > 2.39.1.268.g9de2f9a303
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
