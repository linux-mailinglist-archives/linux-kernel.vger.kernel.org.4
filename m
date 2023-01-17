Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C12066DA13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjAQJfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:35:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjAQJeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:34:22 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170422709
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:15 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id i188so31567702vsi.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SPLRrX/lkmvIYyo+lXDf/6xOCiRheu67g1vboFBjt4k=;
        b=YhkxfUPuOSnAZKIC5PVYRU0HHkKDR83Qc5FTJDrN9KEKPwOzxV6TOmJyEKXuP3SFmo
         bv4bDO5yAfeI6dg9kjobthIQA+Xb2Y/wEvnF/1FYGW6zKncwfp2aTUtFQh6qfF9wD4HJ
         ScJ/Y60+buCEPvbvj3GoPrZ+2EPLH7gMGvAr+vJxSodohUlrqPD1accL10ZDBkIkNMTL
         LJXocAkHl3qfoFJvgayG0Nj0VQnxi33lUKfgQpCuEu7R+D6pmryBYN2P7s0w1tuaLXQ/
         EiwM8kwFrTkCeFE/QPyp7t7g1AwmcYQyYDs9CbJpZD9twrGyUiV+D7cTIsoNSYRR4beY
         rZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPLRrX/lkmvIYyo+lXDf/6xOCiRheu67g1vboFBjt4k=;
        b=SIIRGWZ6Y6R0vH9LNWqGLVr/NRRWNKz/hreT0biq7jnNqonTzRHRP88dQOYJ79bkpH
         Z0DniPt9Ruwy6pPc6D706ejuGvA1nboLM3kb2aUurhH49c5Pfvmr3J3om6y26paNXZ+W
         dySCpWCzY5DT3+8sLmG+KjOJIump4ORyf0tmoFShnQ9diSswsNApOLv5ov/GJLkrK1aO
         wrKkRQ35tNmjNXFOBzA1R9Jjl//+EPSY+ytqEAEskM1f7+wwm7w4sI/S4CbzpUtCDlsQ
         0uJkmi0+FRvA6ynqnW91IeXJoBfAweq9RorqvwwzwTMZpHWBv8Fpb0Mz7F8iq+nTj0RI
         YkEQ==
X-Gm-Message-State: AFqh2kp8YrGs+nqyptP2m78iY5fGS2tSZwjM+nIn0uvpFiP9iH/LLff8
        qVO2oybtU5Ndpwv3CfTOfFA6QtqWNuIFeb24AuJ20Q==
X-Google-Smtp-Source: AMrXdXvlHFwkzfAYKYwIbSsieM9kY7tjHuD7qtMLpv7l0zYKKl31RjNnNEMqRXrKipi4xZlGIr9pc0F0JnPy/n2vWvQ=
X-Received: by 2002:a05:6102:3e08:b0:3c5:1ac1:bf38 with SMTP id
 j8-20020a0561023e0800b003c51ac1bf38mr309928vsv.78.1673948054194; Tue, 17 Jan
 2023 01:34:14 -0800 (PST)
MIME-Version: 1.0
References: <20230116140811.27201-1-pierluigi.p@variscite.com>
 <2403894.jE0xQCEvom@steina-w> <AM6PR08MB4376F0179AA62C60AA30280BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
In-Reply-To: <AM6PR08MB4376F0179AA62C60AA30280BFFC69@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 17 Jan 2023 10:34:03 +0100
Message-ID: <CAMRc=MdfueZQts=ur-+hVBATWs-oO_jowbbi=mqX6Bp-zhkUVQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: fix linker errors when GPIOLIB is disabled
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        Nate Drude <Nate.D@variscite.com>,
        Francesco Ferraro <francesco.f@variscite.com>,
        "pierluigi.passaro@gmail.com" <pierluigi.passaro@gmail.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 8:44 AM Pierluigi Passaro
<pierluigi.p@variscite.com> wrote:
>
> On Tue, Jan 17, 2023 at 7:23 AM Alexander Stein <alexander.stein@ew.tq-group.com> wrote:
> > Hi,
> >
> > Am Montag, 16. Januar 2023, 15:08:11 CET schrieb Pierluigi Passaro:
> > > Both the functions gpiochip_request_own_desc and
> > > gpiochip_free_own_desc are exported from
> > >     drivers/gpio/gpiolib.c
> > > but this file is compiled only when CONFIG_GPIOLIB is enabled.
> > > Move the protototypes under "#ifdef CONFIG_GPIOLIB" and provide
> > > reasonable definitions in the "#else" branch.
> > >
> > > Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > ---
> > >  include/linux/gpio/driver.h | 20 ++++++++++++++++++--
> > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> > > index 44783fc16125..ed77c6fc0beb 100644
> > > --- a/include/linux/gpio/driver.h
> > > +++ b/include/linux/gpio/driver.h
> > > @@ -758,6 +758,8 @@ gpiochip_remove_pin_ranges(struct gpio_chip *gc)
> > >
> > >  #endif /* CONFIG_PINCTRL */
> > >
> > > +#ifdef CONFIG_GPIOLIB
> > > +
> > >  struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip *gc,
> > >                                           unsigned int hwnum,
> > >                                           const char *label,
> > > @@ -765,8 +767,6 @@ struct gpio_desc *gpiochip_request_own_desc(struct
> > > gpio_chip *gc, enum gpiod_flags dflags);
> > >  void gpiochip_free_own_desc(struct gpio_desc *desc);
> > >
> > > -#ifdef CONFIG_GPIOLIB
> > > -
> > >  /* lock/unlock as IRQ */
> > >  int gpiochip_lock_as_irq(struct gpio_chip *gc, unsigned int offset);
> > >  void gpiochip_unlock_as_irq(struct gpio_chip *gc, unsigned int offset);
> > > @@ -776,6 +776,22 @@ struct gpio_chip *gpiod_to_chip(const struct gpio_desc
> > > *desc);
> > >
> > >  #else /* CONFIG_GPIOLIB */
> > >
> > > +static inline struct gpio_desc *gpiochip_request_own_desc(struct gpio_chip
> > > *gc, +                                            unsigned int hwnum,
> > > +                                         const char *label,
> > > +                                         enum gpio_lookup_flags
> > lflags,
> > > +                                         enum gpiod_flags dflags)
> > > +{
> > > +     /* GPIO can never have been requested */
> > > +     WARN_ON(1);
> >
> > This will raise the warning on each invocation. How about using
> > WARN_ON_ONCE(1), or even WARN_ONCE("Kernel compiled without CONFIG_GPIOLIB
> > support")?
> >
> No problem on my side, but this would create a misalignment with all other
> GPIOLIB "dummy" calls.
> Personally I would prefer WARN_ONCE("Kernel compiled without CONFIG_GPIOLIB
> support").
> Please confirm your preferences and I'll provide a patch v2.
> Thanks
> >
> > > +     return ERR_PTR(-ENODEV);
> > > +}
> > > +
> > > +static inline void gpiochip_free_own_desc(struct gpio_desc *desc)
> > > +{
> > > +     WARN_ON(1);
> >
> > Same as above.
> >
> > Best regards,
> > Alexander
> >
> > > +}
> > > +
> > >  static inline struct gpio_chip *gpiod_to_chip(const struct gpio_desc *desc)
> > > {
> > >       /* GPIO can never have been requested */

If someone calls these functions without GPIOLIB enabled then they
deserve lots of warnings to remind them to fix their config. :)

Let's keep it like in other places.

Bart
