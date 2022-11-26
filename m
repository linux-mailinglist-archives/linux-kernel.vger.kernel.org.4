Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B1A6392D2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKZAjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:39:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiKZAjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:39:42 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D3532E9;
        Fri, 25 Nov 2022 16:39:41 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so5461261pjb.0;
        Fri, 25 Nov 2022 16:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iy24li/lZEtUgoEsffQvKORgIKqhd2Cp00J/gtw5dXA=;
        b=NxECGrts1XdkydiIfjssX5TTYxpOEH3ZI76K9vOs0BaacmofUIH/OkHpWSdJSIkNzJ
         JwvUKyauDXHBd0hgggn3agvW3sGXJ8mUesUCwmOl4AqS23Pfu5/doevEKLKhqIGc6n+9
         r8/eqLdkqPUMFE6yHOu8+ZNd6JvacQ5dp9bwNLoyWTvcTBosyI/+VXhbP4y5AOWsNplq
         sOyY9MES7u2MORbgLI3H85U5cvOPMSc7eHbxml7ux2al8cIdYhutCwKGSkxUD2iCl+GM
         6RGLywWI2Nm0UmyEhLq6HS1TyQh1vTZ2m30vAgSq+TuWKy2bxjNkqH9FqMwiyfyT5m5X
         3kRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iy24li/lZEtUgoEsffQvKORgIKqhd2Cp00J/gtw5dXA=;
        b=3s+/FHaFt5AOfx1YSv7UuNkpOY+s+S9Lzz8lK1b/zTz2Kf1GfoYpaZ62Ziyc82m5NL
         H4s5Mv7zB+AvA52VDt2veXVZIKdS0h844VNWD4preDbumoUIlvWaT8Ks9Vabv6rPshOX
         h3wHZov2V15x6unoRDWhd1AwQusZUfWD6aDrFc0uUOrOIyaEdr6S8pTtBt7qFY1cXIfL
         22eUvC/8QffFbDpQZrxsPidw7VfwX+Zj72+Z9JzDo9vYO6yo4lJhKjqWgi/DyiDlvi+P
         a/nfUdOz3PvVT3lsZcyH70ogAzoCQUdn85GUY4+rdIckYAgDF2LBzlTKotDptEuoyoL+
         We9A==
X-Gm-Message-State: ANoB5pmcddBqlYBHy8J4B97tq3XIubyKFFQo9PjUdZyJaSJC2iM5ff90
        lMZj7UUinRUbJOWJmMmo2Ow=
X-Google-Smtp-Source: AA0mqf5pGcek+K2g9x1da1F0Z5eO7QlEzgfitST/IF2NlEa3avDkyhvG8Dqa6L6dzoXfZSem56ND0Q==
X-Received: by 2002:a17:902:ab1d:b0:188:f5de:a8e4 with SMTP id ik29-20020a170902ab1d00b00188f5dea8e4mr22347287plb.133.1669423180911;
        Fri, 25 Nov 2022 16:39:40 -0800 (PST)
Received: from sol (110-174-14-241.tpgi.com.au. [110.174.14.241])
        by smtp.gmail.com with ESMTPSA id t4-20020a1709027fc400b001895d871c95sm3815577plb.70.2022.11.25.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 16:39:40 -0800 (PST)
Date:   Sat, 26 Nov 2022 08:39:35 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
Message-ID: <Y4FgR3EmYNVKItO2@sol>
References: <20221125153257.528826-1-brgl@bgdev.pl>
 <Y4DsTxPH1tv5eEwf@sol>
 <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com>
 <Y4EBubusGqo4IroP@smile.fi.intel.com>
 <CAMRc=MdHtJC4Tmn3KgcnefmHTrpXy=ROAAXJLN9uv=ouJ-hQSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRc=MdHtJC4Tmn3KgcnefmHTrpXy=ROAAXJLN9uv=ouJ-hQSw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 10:03:06PM +0100, Bartosz Golaszewski wrote:
> On Fri, Nov 25, 2022 at 6:56 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Nov 25, 2022 at 05:48:02PM +0100, Bartosz Golaszewski wrote:
> > > On Fri, Nov 25, 2022 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > ...
> >
> > > Then at the subsystem level, the GPIO device struct would need a lock
> > > that would be taken by every user-space operation AND the code
> > > unregistering the device so that we don't do what you described (i.e.
> > > if there's a thread doing a read(), then let's wait until it returns
> > > before we drop the device).
> >
> > It's called a reference counting, basically you need to get device and then
> > put when it makes sense.
> >
> 
> Andy: I am aware of struct device reference counting but this isn't
> it. You can count references all you want, but when I disconnect my
> CP2112, the USB bus calls gpiochip_remove(), struct gpio_chip * inside
> struct gpio_device is set to NULL and while the underlying struct
> device itself is still alive, the GPIO chip is no longer usable.
> 
> Reference counting won't help because the device is no longer there,
> so this behavior is correct but there's an issue with user-space still
> being able to hold certain resources and we need to make sure that
> when it tries to use them, we return an error instead of crashing.
> 
> I think that a good solution is to make sure, we cannot set gdev->gc
> to NULL as long as there are user-space operations in progress. After
> all, it's better to try to send a USB request to an unplugged device
> than to dereference a NULL pointer. To that end, we could have a
> user-space lock that would also be taken by gpiochip_remove().
> 

This is basically the answer I was hoping for - that there is some
barrier in place to prevent chip removal while an ioctl is active.
Then the check makes total sense - it is ensuring that the chip wasn't
removed before the ioctl began and the barrier went up.

On the other end, the caller of gpiochip_remove() needs to be prepared
to gracefully fail calls on the chip until gpiochip_remove() returns.
You would hope that is already the case...

> But this is still a per-subsystem solution. Most other subsystems
> suffer from the same issue.
> 

Does that prevent us addressing the problem in gpio until a more general
solution comes along?

Anyway, I'm basically ok with your patch as a first step, as it greatly
reduces the chances of triggering the fault, but it is only a band-aid
over a larger issue and a more complete solution would be preferable.
Without that, highlight in the checkin comment that it is not a complete
fix.

Cheers,
Kent.
