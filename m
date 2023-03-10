Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5EE6B4DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjCJQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjCJQv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:51:59 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B0E683F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:48:50 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id h34so3944796uag.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 08:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112; t=1678466930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u36L6KftAz9SvqMP+IydF0oRW2VVD9OB9u4yXp0rAoU=;
        b=wbdbKYE/INqbqeoPrYR3GVKtd0bpDJqk202FtdJZS6WD8Ug0+xI3YRSvqPY6/aOS1S
         s75bG3MpzBivS4c78RzTjoPZZ63VYIf+UoV93go/FS/PIcd1UhMm0w9VUEZZ6XDyoOpK
         4L8icZkEu4oUzRbkKtsi6sWKsIrVTkXNLJFvFHMUs5CWXnKAu4vrC6Cj7n4MnCnKIA9S
         IpOpvASVo2VBd562UqvWV1TKUqH+uMnqlYbo4MbI7M1C+/tuV5ZX9dXfuTzehxmYI+bh
         IU2S2QHsp1xERgKuT4f0AK61D2mcvOmBFT3Mc3OkuxzSuvXy/k2mbs6BXIWn3sFonk4y
         4FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678466930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u36L6KftAz9SvqMP+IydF0oRW2VVD9OB9u4yXp0rAoU=;
        b=lxS3kYZhkEIcFnBzI+MIoTiLloo7CuurMZ9rK9yCC+Fr18muyd0/SA4246II6IFg2O
         ESGc4/KOUgNJbgUQLpBKTTTitxCKrBLlIRnkR4F4+zgdVyxYmH+YgThbOkNKrwyfwtnW
         QLEzwJcTJ0Ir+muLd873XJ2TmtGeJ9mOTOlwUHXUsOKgHdTlyxE9wD6TNGctcI0nDEpL
         QnzyNO9cex3jk+TQ2hKDfkBcA2v2gSHeyItihK23UbuRyiXp3ApCio+qBWlfk3XxTm9y
         4uyfotaLWtT+M+xpBy2G9xHRIMX679DNRHcvrG8IeE0JLUQZlnfqTRgHXmlbubvzBkk+
         hAEw==
X-Gm-Message-State: AO0yUKUriQCfhpXQJL6e4yqItvobgILK9T8jEnD84A29TSBLp5WKzZhZ
        QE3Ba8yF1wr1MPHp93ZHHwMgEEeHe1gj18bRfx8juQ==
X-Google-Smtp-Source: AK7set9iU4mLOUuJIxSw02g9TfJc0TByl8xMVSjGmR6w/Lifpjp4Jf/pQ8A/woVlFhHygaFZkihLUJ0dEvmQJI5BJvE=
X-Received: by 2002:a1f:fcce:0:b0:430:ae33:a424 with SMTP id
 a197-20020a1ffcce000000b00430ae33a424mr884218vki.1.1678466929973; Fri, 10 Mar
 2023 08:48:49 -0800 (PST)
MIME-Version: 1.0
References: <20230307182557.42215-1-andriy.shevchenko@linux.intel.com>
 <20230307182557.42215-4-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdW7JjWvJUtvwJDwWLB5ygPiCRWLNM8E0iyRoD=HbzfVw@mail.gmail.com> <ZAoq+yAyPnI4zgto@smile.fi.intel.com>
In-Reply-To: <ZAoq+yAyPnI4zgto@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Mar 2023 17:48:39 +0100
Message-ID: <CAMRc=McQKK2e86m1w7q4ysGCJcSSgDjV-tkAkFa626ko+eTeUA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] gpiolib: Move gpiodevice_*() to gpiodev namespace
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 7:52=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 08, 2023 at 11:49:53AM +0100, Bartosz Golaszewski wrote:
> > On Tue, Mar 7, 2023 at 7:25=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The functions that operates on the same device object would
> > > have the same namespace for better code understanding and
> > > maintenance.
>
> ...
>
> > > -static void gpiodevice_release(struct device *dev)
> > > +static void gpiodev_release(struct device *dev)
> > >  {
> > >         struct gpio_device *gdev =3D to_gpio_device(dev);
> > >         unsigned long flags;
> > > @@ -617,7 +617,7 @@ static int gpiochip_setup_dev(struct gpio_device =
*gdev)
> > >                 return ret;
> > >
> > >         /* From this point, the .release() function cleans up gpio_de=
vice */
> > > -       gdev->dev.release =3D gpiodevice_release;
> > > +       gdev->dev.release =3D gpiodev_release;
> > >
> > >         ret =3D gpiochip_sysfs_register(gdev);
> > >         if (ret)
>
> > But the only other function that's in the gpiodev_ namespace operates
> > on struct gpio_device so that change doesn't make much sense to me.
>
> I'm not sure I understood the comment.
> After this change we will have
>
> static int gpiodev_add_to_list(struct gpio_device *gdev)
> static void gpiodev_release(struct device *dev)
>

Do you want to use the same prefix for both because struct device in
the latter is embedded in struct gpio_device in the former?

Bart

> There are also gpio_device_*() I have noticed, so may be these should be
> actually in that namespace?
>
> And we have
>
> static int gpiochip_setup_dev(struct gpio_device *gdev)
> static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev=
)
>
> That said, what do you think is the best to make this more consistent?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
