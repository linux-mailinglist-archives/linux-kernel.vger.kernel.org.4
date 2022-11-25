Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537896390F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 22:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiKYVDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKYVDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 16:03:21 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF9E442C5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:03:18 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id e24so1917345uam.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 13:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OVEFqwCX0va+VfJ7c+eGlux97SoQeyh4xYOkEeZpCiI=;
        b=5kpozuC8hYlXhFyeFbWRwWNpcWQ04RgM5YwI8JPfPklrr+LrcPKGJq6P5tqWAr2OGB
         j9Z4/lUd3QB0P76YCwSM6krQPxjiDz96rOa9tN0lUEgEL8Fn2ekZcK0pM7iwvgNaWhlY
         Td+Q6iOGsoykmpBC/aF4spDDi82QSnQ0Yd+H3K0VPWP0eyj9yKQQrsqMwiiThQh5OpDR
         7w9z6M8/t9TkxmiwQ6oCJ3RZLIfTX8Z4Ttz+9oQo8nNSLNLFmAp6nSwl0ETbEppyNofL
         y+5anKUiY2u0eePOQo2Cy2jtuGdRzKnq1MaBG6izLxAVt35uNUUrF0qumnAL2JbHcqfe
         UG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OVEFqwCX0va+VfJ7c+eGlux97SoQeyh4xYOkEeZpCiI=;
        b=CW3+nEvSrTkgKsAmyhxGiNxu2SYs7vVwVeshrZZ5dqqpTfu6veqlrFKCZ3kM3WzZaW
         oCnBeWg0js0BQUQ1kwCGjpWhrpJAOI0WlYUhdSP+GpFeDue2GwjL3Mjp7KPGB/HkMuMl
         3A9XdhGoj0OkNlZ5HtOEm+2o33Rbubz7nHUSyeBQjFNIVRtCulE8QhS2GI1LQnTp5JXw
         Oo5yhbyrcfGbpuylvpOyfepIZMbW/YKIBYnK5wjAxWp3jLDqA2qPvWMj26fSl4TVTskP
         E+25qjWztfDwY2zorQT1zS297WQ94KXSeq7oDLDn5JoaD2VfjRkf6RLSj2eALwn85TIx
         CXhw==
X-Gm-Message-State: ANoB5pmrnMuN+7uwX+7OlrakCIhGmAuQ5gN1C9Dfhy6NFZSWu76YhODs
        LJ6hQrUYSnTFyeSIhARQ6s17iTIxMBB1IUSL7SysDQ==
X-Google-Smtp-Source: AA0mqf67ml0/y5Y6L0uB229FME78wZM/z+mBuVEXKMVNFI9Rv0NZ/gTWjiZKnZ5pNjCI7CxDjsDgzvDXrqcFxcDotaY=
X-Received: by 2002:ab0:6015:0:b0:418:c2fa:f8a6 with SMTP id
 j21-20020ab06015000000b00418c2faf8a6mr15600391ual.119.1669410197837; Fri, 25
 Nov 2022 13:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20221125153257.528826-1-brgl@bgdev.pl> <Y4DsTxPH1tv5eEwf@sol>
 <CAMRc=Me83-_oiGEmwy4BUrzLEMT6ZsoMwWYsb6iXwg19yHMHdQ@mail.gmail.com> <Y4EBubusGqo4IroP@smile.fi.intel.com>
In-Reply-To: <Y4EBubusGqo4IroP@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 25 Nov 2022 22:03:06 +0100
Message-ID: <CAMRc=MdHtJC4Tmn3KgcnefmHTrpXy=ROAAXJLN9uv=ouJ-hQSw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: fix NULL-pointer dereferences
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
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

On Fri, Nov 25, 2022 at 6:56 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Nov 25, 2022 at 05:48:02PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Nov 25, 2022 at 5:24 PM Kent Gibson <warthog618@gmail.com> wrote:
>
> ...
>
> > Then at the subsystem level, the GPIO device struct would need a lock
> > that would be taken by every user-space operation AND the code
> > unregistering the device so that we don't do what you described (i.e.
> > if there's a thread doing a read(), then let's wait until it returns
> > before we drop the device).
>
> It's called a reference counting, basically you need to get device and then
> put when it makes sense.
>

Andy: I am aware of struct device reference counting but this isn't
it. You can count references all you want, but when I disconnect my
CP2112, the USB bus calls gpiochip_remove(), struct gpio_chip * inside
struct gpio_device is set to NULL and while the underlying struct
device itself is still alive, the GPIO chip is no longer usable.

Reference counting won't help because the device is no longer there,
so this behavior is correct but there's an issue with user-space still
being able to hold certain resources and we need to make sure that
when it tries to use them, we return an error instead of crashing.

I think that a good solution is to make sure, we cannot set gdev->gc
to NULL as long as there are user-space operations in progress. After
all, it's better to try to send a USB request to an unplugged device
than to dereference a NULL pointer. To that end, we could have a
user-space lock that would also be taken by gpiochip_remove().

But this is still a per-subsystem solution. Most other subsystems
suffer from the same issue.

Bartosz
