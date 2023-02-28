Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6476A5A48
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 14:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjB1Nrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 08:47:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjB1Nr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 08:47:27 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFF305EE;
        Tue, 28 Feb 2023 05:47:07 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id cf14so10361816qtb.10;
        Tue, 28 Feb 2023 05:47:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sH0Va/LXi8AO46HXNHI3MHsJcYt1lVFeI6M84VU58Fs=;
        b=gbADfJ9UFEzzdnZxTjqIji5Zw6fgs7FP2NXBKRaLhl8xCpsPF8vpelKwReurl8zn9L
         DhMxMeJ+5OUBNyHYnUTPv2tu0PEB7yxF02ZC/WS5DaF2V6prnWVNH3CjCl3tgOK14Wa3
         CuVmZeOBP160kdqjqpFk1OS0g7MvCUtRcRXYAy2aYWXD2MZab/kARFfmjcz4fvvbAIgW
         7v9XdRfJXQN8KclCCH21q6Ymt0wQFnmb9Ac7I1C5g/axOTioIjGOfB1r3r9CFI5ZzQMk
         q+bPBVtDAETjqt0VE70stn90/TktnQFRMVRr0Gyau8aKpE9GiPUIagK8aE3b7P7HliFz
         Ds8A==
X-Gm-Message-State: AO0yUKV0FarFYJ9hseoI3mg/qOb8pYwkaZs2lk1gZr61AB3mIRx/aNYd
        In/82+Md/t9/O27pRoy2mC8mC2jBOsU+kg==
X-Google-Smtp-Source: AK7set935ofrRTTnHfHci3VyCLN6r/PTDJt07XKUPLx7nFBC3dzjRJ9bX1LYdQOur+4hGVqYRz/ZMA==
X-Received: by 2002:ac8:5fce:0:b0:3bd:1a07:2063 with SMTP id k14-20020ac85fce000000b003bd1a072063mr4341537qta.45.1677591965437;
        Tue, 28 Feb 2023 05:46:05 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id s13-20020a05622a018d00b003bfa8e1b7d1sm6540855qtw.32.2023.02.28.05.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 05:46:05 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5384ff97993so274202127b3.2;
        Tue, 28 Feb 2023 05:46:04 -0800 (PST)
X-Received: by 2002:a5b:8b:0:b0:a48:4a16:d85e with SMTP id b11-20020a5b008b000000b00a484a16d85emr1422172ybp.7.1677591964737;
 Tue, 28 Feb 2023 05:46:04 -0800 (PST)
MIME-Version: 1.0
References: <20230228130215.289081-1-nick.alcock@oracle.com> <20230228130215.289081-10-nick.alcock@oracle.com>
In-Reply-To: <20230228130215.289081-10-nick.alcock@oracle.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 28 Feb 2023 14:45:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
Message-ID: <CAMuHMdUFePvbBk7ELH3s8QrTiqEoC0xwQN_YCr9brSaFede-ig@mail.gmail.com>
Subject: Re: [PATCH 09/20] clk: renesas: remove MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Feb 28, 2023 at 2:03 PM Nick Alcock <nick.alcock@oracle.com> wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>

Thanks for your patch!

>  drivers/clk/renesas/rcar-usb2-clock-sel.c | 1 -

I think it would make sense to make CLK_RCAR_USB2_CLOCK_SEL
tristate. Shimoda-san?
The Beacon Renesom seems to be the only board where this
is wired up, Adam?

>  drivers/clk/renesas/renesas-cpg-mssr.c    | 1 -
>  drivers/clk/renesas/rzg2l-cpg.c           | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/clk/renesas/rcar-usb2-clock-sel.c b/drivers/clk/renesas/rcar-usb2-clock-sel.c
> index 684d8937965e0..ba6b5bd67786f 100644
> --- a/drivers/clk/renesas/rcar-usb2-clock-sel.c
> +++ b/drivers/clk/renesas/rcar-usb2-clock-sel.c
> @@ -220,4 +220,3 @@ static struct platform_driver rcar_usb2_clock_sel_driver = {
>  builtin_platform_driver(rcar_usb2_clock_sel_driver);
>
>  MODULE_DESCRIPTION("Renesas R-Car USB2 clock selector Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
> index 1a0cdf001b2f2..bfe5dc9a2e36b 100644
> --- a/drivers/clk/renesas/renesas-cpg-mssr.c
> +++ b/drivers/clk/renesas/renesas-cpg-mssr.c
> @@ -1154,4 +1154,3 @@ void __init mssr_mod_reparent(struct mssr_mod_clk *mod_clks,
>  }
>
>  MODULE_DESCRIPTION("Renesas CPG/MSSR Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
> index 4bf40f6ccd1d1..93b02cdc98c25 100644
> --- a/drivers/clk/renesas/rzg2l-cpg.c
> +++ b/drivers/clk/renesas/rzg2l-cpg.c
> @@ -1440,4 +1440,3 @@ static int __init rzg2l_cpg_init(void)
>  subsys_initcall(rzg2l_cpg_init);
>
>  MODULE_DESCRIPTION("Renesas RZ/G2L CPG Driver");
> -MODULE_LICENSE("GPL v2");
> --
> 2.39.1.268.g9de2f9a303

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
