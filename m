Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C22715AA6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 11:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjE3JuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 05:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjE3JuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 05:50:10 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67321CD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:50:09 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba86ec8047bso5986699276.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 02:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685440208; x=1688032208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mY8EOyPk9m+Ti4ct23oUFQXpV/JvMzGqMlfNe1g256c=;
        b=GaJVIlA+adxAdqMq+T5cdDZpReTWNDrvP5cvfBA8pPtz91rKqLRqUqQKlOlCgNrMvm
         U8sKwnIiyu5SETXQHS3UC5iTfqhjFN/BVUoSclrF9NhMUyukD/JgywZZyUbcwuS4MC2E
         /A127qQQ3i24P2x8I4+FLPjAzRrKKSi8w+Veuqgli9VNCrM0VlvuoTnI27fK9JDkl4QN
         gDlI/NYcuJ1K1btyiU9CjMhncg5RXig87/iZxcAwbDTlxv920ZbpP19c3AzedMDjJpNT
         sXlL0xw4/UCq5er3uaXPGnsJxKI3CWwOPUe8j4Lt9+f3u5ZQMhUfSxiDiO577JV3YO4t
         Vqow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685440208; x=1688032208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mY8EOyPk9m+Ti4ct23oUFQXpV/JvMzGqMlfNe1g256c=;
        b=gLuC5RzR3hb26Afu5CZmY4YdnI20Zj8m/bkM6vtsrJMT8jqS1hJV9sIigiF+IY8cqW
         EWN2SYFtYyLixbWpmViudMJYW3mH9IYAv4Zwjl8Vykcz31zowo+Kk/uDsxcIw0DnMceO
         fM+yPFCKwJ3O86jBx86zBFRI0wJd79pztz4kbcCYmvd3j1VnTiC2Ih7dgpB0yR7qcivf
         vs/5oQ4JVrtXjKpF7K/d5XcPJWxMs2OyR2gEqnoxWaYrQv+nQ9LLcGFQ60ZRfe7nE5x5
         BQGipoaAqNsG6wVLANX1+aabPmu/RmW/Ngw1xnqC7RioK1zD191F3TtJGeFhiwm54ywT
         +zZw==
X-Gm-Message-State: AC+VfDzR7TbWrYNL95O28gvZVMqPz42qsKuCgjOHWvAEKUbFT5v18Lpk
        6jUDIuQnf5DuQY+3vlsCq36b+PKzVJ+q7fgPzucUGg==
X-Google-Smtp-Source: ACHHUZ6YbgVeepX0NXhKYfOQl1mZjMr+b/ldYK1S0FACduOM4Cp7h1OMahvVMANhpqE3tmkfBDhU24Fs4VgMR8DGr+k=
X-Received: by 2002:a81:4993:0:b0:561:e7bb:1b27 with SMTP id
 w141-20020a814993000000b00561e7bb1b27mr1478937ywa.52.1685440208547; Tue, 30
 May 2023 02:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230530141914.672a8e59@canb.auug.org.au> <e6217d79-0e80-4478-a8f9-c52ce0f65377@app.fastmail.com>
 <CACMJSes3La5Gt7xUuhc-wUbobrTyK4zzBxup1HT7aLvj58+Kag@mail.gmail.com>
In-Reply-To: <CACMJSes3La5Gt7xUuhc-wUbobrTyK4zzBxup1HT7aLvj58+Kag@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 May 2023 11:49:57 +0200
Message-ID: <CACRpkdadRJdXTWdteKjjq-jxskNhH9sP8xdRTX8wbYV8YC55sA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the gpio-brgl tree with the arm-soc tree
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Davis <afd@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:35=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
> On Tue, 30 May 2023 at 11:29, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, May 30, 2023, at 06:19, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Today's linux-next merge of the gpio-brgl tree got a conflict in:
> > >
> > >   drivers/gpio/gpio-twl4030.c
> > >
> > > between commit:
> > >
> > >   d5f4fa60d63a ("ARM/gpio: Push OMAP2 quirk down into TWL4030 driver"=
)
> > >
> > > from the arm-soc tree and commit:
> > >
> > >   fbc8ab2ccd85 ("gpio: twl4030: Use devm_gpiochip_add_data() to
> > > simplify remove path")
> > >
> > > from the gpio-brgl tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts.
> >
> > Maybe Bartosz wants to merge Linus' gpio-omap-descriptors-v6.5 series
> > into the gpio/for-next branch as well? It touches both the
> > arch/arm/mach-omap and a lot of the drivers using the gpios, so we
> > could treat this as a shared immutable branch.
> >
> >     Arnd
>
> I was about to ask for an immutable tag. :)
>
> Linus, is this the right tag to pull from your tree?

Yups go ahead, it's totally immutable!

Sorry for not thinking about it before.

Yours,
Linus Walleij
