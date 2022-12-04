Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E2B641F9D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 21:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiLDUrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 15:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiLDUrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:47:06 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2522B11C26
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 12:47:04 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d185so9429408vsd.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RBswRfvXPuJ95C6qCbJFlEJJXRBVFhSLluF0/W7PvqE=;
        b=Z4NMhss6tZWucf9Hyj6F6Uv/IJNsjx5gjrz64uM+W5wVvC2i0Bo+qwboetM4XKHU5/
         sEfdoEeta7x/cNr5qItXvpcsijfhwS8AMCHNYfSBaX9Bxn0RivBZ8wL3abm9snxVwkJ9
         TyQ0ltV5/DHMn80/3UgEId1AY7Yx1tg7SzBND6pAgH3B+JKs8HjohOh2KH0a4tpQ3qbo
         EURYUMhUUdl8ALOt/74sudjEIlGrr+408L7aYCm+znEOIuQuh1P3dVzv7gcN8PCVVQKT
         A/060MiRFwecE6WYKwP/yG4yhxOP1w6OhkLVeYPdFg+/j8ARjwT1mwcj3c3G7IwMkyvO
         Q6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RBswRfvXPuJ95C6qCbJFlEJJXRBVFhSLluF0/W7PvqE=;
        b=qrSu9ooLNIjbSvdNf+kmbXSsuM7ELYL7lYVnLNzwqdD2FsDWGmu7oEzi+wopz9InT9
         zRGxoi0+BfMk5OtUFIalV916EzIeq4MBtJSBi6FzNzkRjSq9mjDpiTID7pmw8x12V1CD
         1zDCU6Gp7+2rxYTNOR+xrXbfHw6zBI15aBKLwgKK7HQTb1+c8ULo8DxW6UXcwBzAjGON
         JuTboNB76MkExXATIA7JL73IbdITfTALWJOsPUmUqsJ8cCGxa4m9BXHvtPvGG8+2l0aw
         WXqY51qHsAWDwUMvSiQwE3cZlEyNtnpEiM0lVZFbFTUT6sUgX6Zo1T+bkAbCwzafnJVe
         2IOw==
X-Gm-Message-State: ANoB5pkIjvKitrqqlfJ7pZrTqu+Ps7ywaGmpL5nutcZ417v/UwasHFj3
        +89naaEdCaFWcEuv//oPsjkPtzcWOmDhWzL8G5sQMQ==
X-Google-Smtp-Source: AA0mqf7zvTL1J0SpfApcqmX84lFxfvFP0fvuGyZEx0msE7/D71QvbX2flDBY1a5U9+A9j/ttCiUn+DDVCaz3DTFPuzc=
X-Received: by 2002:a05:6102:3109:b0:3b1:3b81:127c with SMTP id
 e9-20020a056102310900b003b13b81127cmr1232592vsh.47.1670186821671; Sun, 04 Dec
 2022 12:47:01 -0800 (PST)
MIME-Version: 1.0
References: <20221203150539.11483-1-brgl@bgdev.pl> <CAHk-=wjD8+XZyO4H1STwXte6x1UcYsiHKaQ4OQF5ucssY=uT8g@mail.gmail.com>
In-Reply-To: <CAHk-=wjD8+XZyO4H1STwXte6x1UcYsiHKaQ4OQF5ucssY=uT8g@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 4 Dec 2022 21:46:50 +0100
Message-ID: <CAMRc=Me--X58j+tLn50osPRXSsJeqms8m=aYDcwMwktfZvFQow@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.1-rc8 - take 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 4, 2022 at 9:17 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Dec 3, 2022 at 7:05 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > Here's a fixed PR from the GPIO subsystem for the next rc.
>
> No, this cannot be right.
>
> That last commit seems *very* dubious, and in particular all those
>
>         if (!down_read_trylock(&gdev->sem))
>                 return EPOLLHUP | EPOLLERR;
>
> are a sign that something is very very wrong there.
>
> Either the lock is necessary or it isn't, and "trylock" isn't the way
> to deal with it, with random failures if you cannot take the lock.
>
> If you are using "trylock" because the data structure might go away
> from under you, you have already lost, and the code is buggy.
>
> And if the data structure cannot go away from under  you,  you should
> do an unconditional lock, and then check "gdev->chip" for being NULL
> once you have gotten the lock (the same way you did in open()).
>

No, the data can't be removed with these locks in place. It's just to
avoid going into the callbacks if gpiochip_remove() is already in
progress (the only reason why trylock would fail).

> But a "trylock and return error if it failed" just means that now you
> are randomly returning errors to user space, which is entirely
> undebuggable and makes no sense.
>

Technically these are the same errors we'll return later if gdev->chip
is NULL but I get your point.

> Or, alternatively, the trylock succeeds - because it hits fully
> *after* gpiochip_remove() has finished, and now ->chip is NULL anyway,
> which is what you claim to protect against.
>
> End result: "trylock" can never be right in this kind of context.
>
> That "call_locked() helper might make sense more along the lines of
>
>         ret = -ENODEV;
>
>         down_read(&gdev->sem))
>         // Does the device still exist?
>         if (gdev->chip)
>                 ret = func(file, cmd, arg);
>         up_read(&gdev->sem);
>
>         return ret;
>

This is a good suggestion, thanks. And with it, the two patches can
get squashed into one for easier backporting.

> or similar. Not with that odd "try to lock, and if that fails, assume error".
>
> And again - if the trylock is there because 'gdev' itself might go
> away at any time and you can't afford to wait on the lock, then it's
> broken regardless (and the above suggestion won't help either)
>
> Anyway: the end result of this all is that I think this is a
> fundamental bug in the gpio layer, and rc7 (soon to be rc8) is too
> late to try these kinds of unfinished games.
>
> Fix it properly for 6.2, and make it back-portable, because I'm not
> pulling something like this right now.
>
>                Linus

Will do. I will still resend the PR with only the resource leak fixes.

Bartosz
