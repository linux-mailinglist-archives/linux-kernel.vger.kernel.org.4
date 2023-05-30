Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3CD715A48
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjE3JfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbjE3JfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:35:14 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64842A3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:35:12 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565eb83efe4so34790897b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685439311; x=1688031311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wAtnkiymSsa0zjCECnvHixXJojMj1jUcew0fzmvrOXU=;
        b=Kgdbf1D3AS2i8/69a2WN1A9HFNChWxhW9DJy4I3yt+TJywPcrOPT/rUFRMzq27H1Fa
         7fpF5mFu74z+x4JXDOYEp9SluYLyyFxgEB113Dj7V6E0QooNYBdTZS+MZDZbOiwbF83O
         jwfwi5oA/x4qZg3LPyhBlLJL1bp0tjQ9Otxmnu1yU/b9irTedz2vln4a3Tu6yVpmP8UC
         54QJZm0HWXSYL1o4uFwLixywh3Y/j1L7gyXnkm6yjF2upjhfW9s0Px9VMU5V6CSSk5rA
         qaN3adxai+EwVXou4OPRZNfr0Yb7140d13ByZjffnwN/vHKLsYeim/axeU6JHUcymO90
         N9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685439311; x=1688031311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wAtnkiymSsa0zjCECnvHixXJojMj1jUcew0fzmvrOXU=;
        b=RjBEFUrtki5AibK2tTEQBhQil2VnqtE83bm8qevU7NPzxT6sRmYEwn8eWGICSL+DrC
         BmhObxfpbJl/KjBIW5jhiCH5JlRuCJfiNPOd/tfrNkNTJ+0d+vrKm91s/vZbpF4dzaGJ
         ANV0D/FdlU8EK6Nn5wBGgGkm84RsWFl2FeOu0aXCiTwmh9xlKXkFyHyd6yP+zuQvIwQu
         j+X61S8QCMdtGZyOatx3/aK2lOqDUKmjRGCKvw6HFCDr7pH/7jOI7XRIBc/xbzUDxWOF
         Ze2s/xiix8RTPBbiIxRDv5VTGOKxhqhJx3XH6sQG1lmvtDRRaDw7qEaakOGUky4Lmdr2
         szgw==
X-Gm-Message-State: AC+VfDx1htgk/Kxb2m2uw9rvppvc/bbTzXcNQY5sttm2mkaYbmv0YNqw
        J346fysj16XHRpuk+0Owf/9A37SEmwQXtqVAuSbKIw==
X-Google-Smtp-Source: ACHHUZ531amOVqZSHwCwc5OgdxvJRmaVfSbMntD1FYwcgW3ZzgP84h2rZAtCviYMoQBVTNqu9y6ZYo4WRxCP+G+yg2U=
X-Received: by 2002:a81:5d89:0:b0:561:179b:1276 with SMTP id
 r131-20020a815d89000000b00561179b1276mr1572669ywb.26.1685439311423; Tue, 30
 May 2023 02:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230530141914.672a8e59@canb.auug.org.au> <e6217d79-0e80-4478-a8f9-c52ce0f65377@app.fastmail.com>
In-Reply-To: <e6217d79-0e80-4478-a8f9-c52ce0f65377@app.fastmail.com>
From:   Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Tue, 30 May 2023 11:35:00 +0200
Message-ID: <CACMJSes3La5Gt7xUuhc-wUbobrTyK4zzBxup1HT7aLvj58+Kag@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the arm-soc tree
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 at 11:29, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, May 30, 2023, at 06:19, Stephen Rothwell wrote:
> > Hi all,
> >
> > Today's linux-next merge of the gpio-brgl tree got a conflict in:
> >
> >   drivers/gpio/gpio-twl4030.c
> >
> > between commit:
> >
> >   d5f4fa60d63a ("ARM/gpio: Push OMAP2 quirk down into TWL4030 driver")
> >
> > from the arm-soc tree and commit:
> >
> >   fbc8ab2ccd85 ("gpio: twl4030: Use devm_gpiochip_add_data() to
> > simplify remove path")
> >
> > from the gpio-brgl tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
>
> Maybe Bartosz wants to merge Linus' gpio-omap-descriptors-v6.5 series
> into the gpio/for-next branch as well? It touches both the
> arch/arm/mach-omap and a lot of the drivers using the gpios, so we
> could treat this as a shared immutable branch.
>
>     Arnd

I was about to ask for an immutable tag. :)

Linus, is this the right tag to pull from your tree?

Bart
