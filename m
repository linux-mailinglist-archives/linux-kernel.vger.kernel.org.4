Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50A66B0614
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCHLgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:36:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjCHLgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:36:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31684AF294;
        Wed,  8 Mar 2023 03:36:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a25so64692931edb.0;
        Wed, 08 Mar 2023 03:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678275361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pkqtkcAPDhHcKXHJJhzZGkadcuoCSlM8Je8c/sebOSk=;
        b=Uxditw6bMjdlAa4tQirez9bPQT80pkxBdU0vkvdov83E7EJCKgtMgvvEzigUMmICqo
         7r/28EKK/HXqXqGNu15VJbPT/3FwMttnWz4rKiQcNDFj1ZpavEgj7JulU+J/Q0vYFNQO
         Dg4rQpFnQetRbBsl2TFx10mpdUpQ9XHuPuDagLxxMQ2VCgIYgBul67bTcSjTYfNmluYF
         WJQvqrJRnlRhnNV10ouHOMtcuwSlTh5yQP9UcydhkTx16LtxJJcFrsk3f0MhooN+RwQ8
         qHPdkuOKtekXLgETObHPMZqt4UJw/xk5X4tfcJYCHGQ7qCWSpoOspReezBbzdOt2ZpJA
         lVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678275361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pkqtkcAPDhHcKXHJJhzZGkadcuoCSlM8Je8c/sebOSk=;
        b=tXNX81rztjA3XYCJ97q0PVaAkPH6rZSWCGMkOMIiKt/qGc8fyF9WTQCn8HZpFs6fAR
         uk/XCkHdIAqeoplov+ACdx0hsehAblQDgROlbk5MkuNNybDX/XGQ9Oq0io/kdkDaXfZc
         fI0nPxhosgJN9wBWBaxK7q0J+VR2U6ezRhcCZoAFqMqL0e78F6zKO2SxtJ/0dt+ygopu
         yfi6R1VeJmFbWU0X80gbRLv6kCS8+kIHHs+uLUdHdz51Vl2gIhbbEzGjydljfMUINCt2
         5tRYfDDfOK46RtapZtSsLBHHruOiXCjJl69iVUVYujoPMaDpSV/aOG+E7R16F1Hck3JT
         B+dg==
X-Gm-Message-State: AO0yUKVzzeRIRrWAHVHtcTdo3PkypiBPJagSdDyzK6k6YxwI1Xjza1RJ
        ICouQhVxifU4s41IndZcX42dxtBWqhCnSRAdsZ0=
X-Google-Smtp-Source: AK7set+8IVqHUCP7lpW4Tu0PFR/uGhVXOh2XCgJ0nI8owJdMs3y7iNlYcasQPs28+hxxB5z53ejUH1b0gSyCIQYYEl4=
X-Received: by 2002:a50:baa6:0:b0:4c1:6acc:ea5 with SMTP id
 x35-20020a50baa6000000b004c16acc0ea5mr9818706ede.4.1678275361500; Wed, 08 Mar
 2023 03:36:01 -0800 (PST)
MIME-Version: 1.0
References: <20230302125215.214014-1-keguang.zhang@gmail.com>
 <20230302125215.214014-3-keguang.zhang@gmail.com> <CAMRc=Me3yVwQm8=CmUVM2gyYnFxntW47-OOPdmq1TzXTJB5ETg@mail.gmail.com>
 <CAJhJPsX1q6PGSb+eoCSdCC2_vDtbaShLLzEbuNOqD_Jzd8Ozdw@mail.gmail.com> <2d5521ff21ea4b99be3dd2e449f53934@AcuMS.aculab.com>
In-Reply-To: <2d5521ff21ea4b99be3dd2e449f53934@AcuMS.aculab.com>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 8 Mar 2023 19:35:45 +0800
Message-ID: <CAJhJPsUy0U-SdP2Vk9B8qz=CGA=oDSxbaaqqS+HOiDnQoBAThA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] gpio: loongson1: Use readl() & writel()
To:     David Laight <David.Laight@aculab.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
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

On Wed, Mar 8, 2023 at 5:42=E2=80=AFPM David Laight <David.Laight@aculab.co=
m> wrote:
>
> From: Keguang Zhang
> > Sent: 07 March 2023 03:46
> >
> > On Mon, Mar 6, 2023 at 5:30=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> > >
> > > On Thu, Mar 2, 2023 at 1:52=E2=80=AFPM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > > >
> > > > This patch replace __raw_readl() & __raw_writel() with readl() & wr=
itel().
> > > >
> > >
> > > Please say WHY you're doing this.
> > >
> > readl & writel contain memory barriers which can guarantee access order=
.
>
> So what...
>
> There is a data dependency between the read and write.
> The read can't be scheduled before the lock is acquired.
> The write can't be scheduled after the lock is released.
>
> So any barriers in readl()/writel() aren't needed.
>
> If they are only compile barriers they'll have no real effect.
> OTOH if the cpu needs actual synchronising instructions (as some
> ppc do) then they will slow things down.
>
Thanks for the explanation.
The intention of this change is to prevent possible order issues.
At present, __raw_readl() & __raw_writel() do work fine.
I will drop this patch in the next version.


>         David
>
> >
> > > Bart
> > >
> > > > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > > > ---
> > > > V1 -> V2: Split this change to a separate patch
> > > > ---
> > > >  drivers/gpio/gpio-loongson1.c | 8 ++++----
> > > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loon=
gson1.c
> > > > index 8862c9ea0d41..b6c11caa3ade 100644
> > > > --- a/drivers/gpio/gpio-loongson1.c
> > > > +++ b/drivers/gpio/gpio-loongson1.c
> > > > @@ -23,8 +23,8 @@ static int ls1x_gpio_request(struct gpio_chip *gc=
, unsigned int offset)
> > > >         unsigned long flags;
> > > >
> > > >         raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> > > > -       __raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) | BIT(of=
fset),
> > > > -                    gpio_reg_base + GPIO_CFG);
> > > > +       writel(readl(gpio_reg_base + GPIO_CFG) | BIT(offset),
> > > > +              gpio_reg_base + GPIO_CFG);
> > > >         raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> > > >
> > > >         return 0;
> > > > @@ -35,8 +35,8 @@ static void ls1x_gpio_free(struct gpio_chip *gc, =
unsigned int offset)
> > > >         unsigned long flags;
> > > >
> > > >         raw_spin_lock_irqsave(&gc->bgpio_lock, flags);
> > > > -       __raw_writel(__raw_readl(gpio_reg_base + GPIO_CFG) & ~BIT(o=
ffset),
> > > > -                    gpio_reg_base + GPIO_CFG);
> > > > +       writel(readl(gpio_reg_base + GPIO_CFG) & ~BIT(offset),
> > > > +              gpio_reg_base + GPIO_CFG);
> > > >         raw_spin_unlock_irqrestore(&gc->bgpio_lock, flags);
> > > >  }
> > > >
> > > > --
> > > > 2.34.1
> > > >
> >
> >
> >
> > --
> > Best regards,
> >
> > Kelvin Cheung
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1=
 1PT, UK
> Registration No: 1397386 (Wales)



--
Best regards,

Kelvin Cheung
