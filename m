Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4136EC7C1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 10:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjDXIUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 04:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjDXIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 04:20:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD610C;
        Mon, 24 Apr 2023 01:20:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-246f856d751so2967758a91.0;
        Mon, 24 Apr 2023 01:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682324431; x=1684916431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UPel+0qwmJUcqYks5xvHkpCgxM5ZV0cSQB2llgEFPmk=;
        b=a+uON3acHnhWWUbX2uWHWCBnxkDxdzZ4OY1uSXkvu/x6k46fp3RQ1NwkXM7RPTu6BE
         PzZX2haJrXVhMzHhGQpNpS65UOnKvmFcoyaamy0bRocsffnWkCU0etB1P2h0Cz6oDH0S
         TaIIzOYJb4GG7DRSF8OOXtdh+4ax7PzPdUf2r0SjouOu8aSQ7C72FksFjpDZBgjjqKTf
         sRqNwNIUC2CYf5ON6RKfb9AokWMaCdAOojLS0cN5rOl/G6HUUMH+HI7eGE+XR7lsavjn
         JwcO43uTX1qM/WVmBPVVmjqf5adq4eesEeHk3eyOC2YRHxwQ8RNctN2JP4EThgZ390ra
         uoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682324431; x=1684916431;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UPel+0qwmJUcqYks5xvHkpCgxM5ZV0cSQB2llgEFPmk=;
        b=A3wGvJ4xUiYXOe7TDOzfArKPQ7XwxFiv1ginMhPRKCtuw7kyA1IuHxiPD0v/xK1SfS
         wSCqno4pb3rIrY0CSv7m9OyM73Oqp6noMaUQM/eQFGDt8Lzq5bjdqEKRJRtIXL4Pu6wZ
         7uIA55aDbwKlUCJATqVrctHJ4KOocFZmXwImGqqwb9E1u0d7smfJLY5+g+nchNJo72a8
         wect5mhtCbI5ZX7VAcgBKG/IPo/opQLrWr3CgO5robivySrlit5H0IJjq2aw2jdKapPs
         ifGmcs1IW1EalfDM3nVHkonWn21aSxKnJjcKxZ1mitmLx+njvzrrLPuAXGnseaPd24lu
         18Kw==
X-Gm-Message-State: AAQBX9d+S9U9uPrGfxUTzGHovJVgyN0chBKxbStu+naohpHe3vUxlaIz
        LKtW9tXC1x4DTfjydNSBGfGWLNKStXrnETDKw9A=
X-Google-Smtp-Source: AKy350YfpxYkSpoKB+T3acIYkkeF7g6IpyVT5u2rKBjSrnk4treer5PatKrSnsW1dIYvmTPLG5uOaGueVwKszLtZuso=
X-Received: by 2002:a17:90a:ca90:b0:23f:b177:9082 with SMTP id
 y16-20020a17090aca9000b0023fb1779082mr11601147pjt.49.1682324431102; Mon, 24
 Apr 2023 01:20:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230420121615.967487-1-d-gole@ti.com> <24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com>
In-Reply-To: <24ec3728-9720-ae6a-9ff5-3e2e13a96f76@gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 24 Apr 2023 10:20:20 +0200
Message-ID: <CAOiHx==7TV3879ADbiWGbHT0NysNck4FUQXkXEocjkD2BzEoRA@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: remove PM_SLEEP based conditional compilation
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Dhruva Gole <d-gole@ti.com>, Mark Brown <broonie@kernel.org>,
        Vaishnav Achath <vaishnav.a@ti.com>, Vignesh <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 at 19:17, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 4/20/23 05:16, Dhruva Gole wrote:
> > Get rid of conditional compilation based on CONFIG_PM_SLEEP because
> > it may introduce build issues with certain configs where it maybe disabled
> > This is because if above config is not enabled the suspend-resume
> > functions are never part of the code but the bcm63xx_spi_pm_ops struct
> > still inits them to non-existent suspend-resume functions.
> >
> > Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
> >
> > Signed-off-by: Dhruva Gole <d-gole@ti.com>
> > ---
> >   drivers/spi/spi-bcm63xx.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> > index 96633a0051b1..99395932074c 100644
> > --- a/drivers/spi/spi-bcm63xx.c
> > +++ b/drivers/spi/spi-bcm63xx.c
> > @@ -617,7 +617,6 @@ static void bcm63xx_spi_remove(struct platform_device *pdev)
> >       clk_disable_unprepare(bs->clk);
> >   }
> >
> > -#ifdef CONFIG_PM_SLEEP
> >   static int bcm63xx_spi_suspend(struct device *dev)
>
> Don't we need a __maybe_unused here?

Actually the premise of this patch is wrong, and should rather be reverted.

The bcm63xx_spi_pm_ops struct is initialized with
SET_SYSTEM_SLEEP_PM_OPS(), which is defined as

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif

so for !CONFIG_PM_SLEEP it won't initialize the struct at all (or
reference non-existing functions), and therefore there will be no
build issues.

Regards,
Jonas
