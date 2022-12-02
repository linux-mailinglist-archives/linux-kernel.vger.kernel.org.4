Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4E56408C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:50:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiLBOuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiLBOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:49:57 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C499D2D84
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 06:49:56 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k185so4843070vsc.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 06:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LwKp7YBF8+BNhNNgEh8PMnKC4MGb0f7CjXdYQAvgABM=;
        b=Y/i8wa2FRUJ3n5zX6A0rW0Fa1iRkzphVQh1lE9PyreOEaWAIOwu7XfSllE9Bl2RWU8
         zI8cC9cnfGFkr11DeUEFDzQz+BnAULAnOYWmimdcrRqvf08ttGis47jdgresU62iG5lE
         GwIlJeCtvZ9t1RTyLJxrZd/ysIjS8NXsz4ntLZJi2woFtfYKhj5LWNtzPbQna4cGw+Zr
         t3WMJ/3IwsKS5nrvnusMbqpK5yL5NqepJTA0/PicnKQByhdS9TbzK+QTVR/H0060LRIv
         iu23wXJcgLAaNmgMM4JWjD5L4htmvvENMfS3ddgVtMeTJK+bOWgkMqamCP2TeK8yky7L
         uwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwKp7YBF8+BNhNNgEh8PMnKC4MGb0f7CjXdYQAvgABM=;
        b=nl6BRQ5YTFC6mgXDe6a0Oemvp4ivYQUE8IoXhmKLF6ZzhEfem/Y8EWQPx54iWNR7iR
         d41B8F7SJGw5Cl+SjVP/lmYQMlNH94U3N3s9IIH15RgZq2fLdhXkIQCBmr4w+GoAAuM7
         B1Q5D1kNbCfpjhtzkpS71T83eHKWUg4JWVcbrzPY0bHoypmY6Pb7ZjIxgehGNWXxv4fi
         +WBs1LXjWNSiIjEXdqFcbIkaXv6FGwJF4lrlDvCyvraWXPJwVMLaLUxn1ZxGGiGyGM5g
         P1YNF1j/DCAeR94pfEoeWZf26Zdqc4MsZPEygwdFAGjkPzJAcge4ZyiGhGsEdhuLIkcu
         c7vQ==
X-Gm-Message-State: ANoB5pntWdwFTv+9I0muW3IangthKA4Ys7iBx9AFTGFdfiIBi3B2++EI
        Pbm+MOceHVTMEwG/kCa9+oQJgHJB3GQXWi2m3e2M+g==
X-Google-Smtp-Source: AA0mqf7pBeAdmidjj+BDq+93ELTbr4P4aLS8tDMFYNZUOs4gx/OA+MP6GJBmqIAGTIxGEAyqG1T2wxuipA3/1tfvNaA=
X-Received: by 2002:a05:6102:722:b0:3b0:eec8:ce04 with SMTP id
 u2-20020a056102072200b003b0eec8ce04mr5912547vsg.16.1669992595230; Fri, 02 Dec
 2022 06:49:55 -0800 (PST)
MIME-Version: 1.0
References: <20221202095455.83356-1-brgl@bgdev.pl>
In-Reply-To: <20221202095455.83356-1-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 2 Dec 2022 15:49:44 +0100
Message-ID: <CAMRc=MdqYiJ4JpWzN0ry5woH9XT5L2J2mMBRgW40XBh6nsfHmQ@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v6.1-rc8
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

On Fri, Dec 2, 2022 at 10:54 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Linus,
>
> Here's the last round of fixes for the upcoming release. The two resource leak
> fixes are self-explanatory. The two character device commits need some more
> backstory:
>
> I recently listened to Laurent Pinchart's talk from this year's LPC[1] where he
> discussed an issue with many subsystems that export device nodes to user-space
> where one can open the device file, unbind the underlying device from the
> driver, then call any of the relevant system calls and observe the kernel crash
> with a NULL-pointer derefence.
>
> I verified that the problem exists with the GPIO subsystem as well. The reason
> for that is: when a GPIO chip is removed, we drop the chip's data from the
> GPIO device and set the relevant pointer to NULL but don't check it in syscall
> callbacks in the character device's code. That's fixed by the first patch.
>
> However that fix alone leaves the character device vulnerable to a race
> condition in which the GPIO chip is removed when a syscall is in progress.
> To avoid that, we have a second fix that uses a lock to protect the device's
> structure from being disabled before all syscall callbacks returned.
>
> Laurent blamed the issue on devres but I believe the problem comes from the
> fact that many driver developers are simply unaware that resources exported
> to user-space need to survive the driver unbind and only be released when the
> device's reference count goes down to 0. Devres' docs are pretty clear on that:
> the resources get freed on driver unbind. Resources that should survive it,
> must not be managed. This is however a topic for a separate discussion which
> I intend to start soon.
>
> Please pull,
> Bartosz Golaszewski
>
> [1] https://www.youtube.com/watch?v=kW8LHWlJPTU
>
> The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:
>
>   Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1-rc8
>
> for you to fetch changes up to 98d8b93c617139aeaf745c1573c02d86830f25d1:
>
>   gpiolib: protect the GPIO device against being dropped while in use by user-space (2022-12-01 19:17:47 +0100)
>
> ----------------------------------------------------------------
> gpio fixes for v6.1-rc8
>
> - fix a memory leak in gpiochip_setup_dev() in core gpiolib
> - fix a reference leak in gpio-amd8111
> - fix a problem with user-space being able to trigger a NULL-pointer
>   dereference ovet the GPIO character device
>
> ----------------------------------------------------------------
> Bartosz Golaszewski (2):
>       gpiolib: cdev: fix NULL-pointer dereferences
>       gpiolib: protect the GPIO device against being dropped while in use by user-space
>
> Xiongfeng Wang (1):
>       gpio: amd8111: Fix PCI device reference count leak
>
> Zeng Heng (1):
>       gpiolib: fix memory leak in gpiochip_setup_dev()
>
>  drivers/gpio/gpio-amd8111.c |   4 +
>  drivers/gpio/gpiolib-cdev.c | 193 +++++++++++++++++++++++++++++++++++++++-----
>  drivers/gpio/gpiolib.c      |  46 +++++++----
>  drivers/gpio/gpiolib.h      |   5 ++
>  4 files changed, 210 insertions(+), 38 deletions(-)

Linus,

Please don't pull this just yet, there's a build issue that was
reported to me with the last commit in that PR. I need to fix it and
redo the PR.

Bartosz
