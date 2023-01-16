Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F9C66C00A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjAPNpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjAPNpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:45:20 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA7520071
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:45:18 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id n190so25168013vsc.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 05:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZYMqo57pf7oiWqADEXPTCPel4aW11TrQn6QBwhj8KJo=;
        b=5UV6FNPGgFMvRw1EmVO2fT8h9aqpIJM0a+RhKzHSyCORoqiaWuOYAp/iZha32hyX1N
         jtWeDco01Ytnx+w0ZY2MZeIDY+o9pLt9O9cCTl9Xew0+EXX7mFUO++Hu9smSTLn0VGXU
         uKz1yw9EjzMewVcPUhqs77Qvnf10D36B9X7iDSofAb/ALsJW0WMXl8zp9JPZgVOG/gEg
         dZJEQY/MxGbLhb7El4PF/wZQcfnAZt5WZdUl8/W30G+owzDKKpa0TkurDZvtuEskyQgO
         sGj0TxrLTjd3cBaMEKY2X2qRsL0D1GccfvUMTcdn57K4YufOTSG5Se78BcFlZIMjqzyt
         eF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYMqo57pf7oiWqADEXPTCPel4aW11TrQn6QBwhj8KJo=;
        b=BnpRa5GF2X2gytNgN36r9XdC0MeRoEi4qjQlENwMKbSUdnIqFJF5OadWISvsB2dtMN
         ey3qMGycFYhoQoHR1UPXiTDZlI16mh47Tlv7LdcbIjGDbigpUmmH5w6FvjLsQyR9kCvU
         9BlGBZBCf88gwfy/OawKlqLxzS91HHt4Y4PsekLlsTFtZajYO8BBcl6ZLDSTX7Zg70Ud
         kw1RpIXlbDhtYpRkhoMJt6beASvWz6lV0utgMOC8icQAlsSde7wCrkcYRMfDDYhHRkxR
         QlndLeyOAAa5Fl1kEafFPmgKW6mxUp5EIOEhLr+vxdyicznH1qd5LtBa5gH9VZl1CcyO
         OTpA==
X-Gm-Message-State: AFqh2kqaMyUtCsiGQKjpdoip6L+PfzDLH6rt7bicRAxP6OmK+Z+3qZ9v
        Q+19lhNpXKTAly+sA5Cua8jO0d4BY13FlxdgNiM55RDUTOGNLw==
X-Google-Smtp-Source: AMrXdXvQW9iRzlavGnthN1s0ea9lNXqNIPJ3tvOFFvltRGwXkhrPxEnlWKuzrpnmbYRjvWT0oB36EsKQjkvOPZqp0hE=
X-Received: by 2002:a05:6102:83b:b0:3d1:3753:9a3c with SMTP id
 k27-20020a056102083b00b003d137539a3cmr1530842vsb.73.1673876717477; Mon, 16
 Jan 2023 05:45:17 -0800 (PST)
MIME-Version: 1.0
References: <Y8U9vrwzHVAyBZHK@francesco-nb.int.toradex.com>
 <CAMRc=Mc5YgWqRsmw=n6EV8PW5OZfMZYotiqSy=gSvHH1PbVN4w@mail.gmail.com>
 <CACMJSesujoLTRFXMRuA2tBAJhainmy6-CmoeuO8OwW9VifaiKw@mail.gmail.com> <10740fc72ae6fb7aeb7d5ea243495bc225ca656f.camel@toradex.com>
In-Reply-To: <10740fc72ae6fb7aeb7d5ea243495bc225ca656f.camel@toradex.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 16 Jan 2023 14:45:06 +0100
Message-ID: <CAMRc=Me0ewbyGi+e2mxijsvLUqUZSF5nNCtUfONT2-q=U0VCLw@mail.gmail.com>
Subject: Re: spidev regression in 6.2-rc kernel
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     "francesco@dolcini.it" <francesco@dolcini.it>,
        "bartosz.golaszewski@linaro.org" <bartosz.golaszewski@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 2:23 PM Max Krummenacher
<max.krummenacher@toradex.com> wrote:
>
> Hi
>
> On Mon, 2023-01-16 at 13:47 +0100, Bartosz Golaszewski wrote:
> > On Mon, 16 Jan 2023 at 13:19, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > On Mon, Jan 16, 2023 at 1:06 PM Francesco Dolcini <francesco@dolcini.it> wrote:
> > > >
> > > > Hello,
> > > > we spotted a regression on spidev on latest 6.2-rc kernel.
> > > >
> > > > [  214.047619]
> > > > [  214.049198] ============================================
> > > > [  214.054533] WARNING: possible recursive locking detected
> > > > [  214.059858] 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1 Not tainted
> > > > [  214.065969] --------------------------------------------
> > > > [  214.071290] spidev_test/1454 is trying to acquire lock:
> > > > [  214.076530] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x8e0/0xab8
> > > > [  214.084164]
> > > > [  214.084164] but task is already holding lock:
> > > > [  214.090007] c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > > > [  214.097537]
> > > > [  214.097537] other info that might help us debug this:
> > > > [  214.104075]  Possible unsafe locking scenario:
> > > > [  214.104075]
> > > > [  214.110004]        CPU0
> > > > [  214.112461]        ----
> > > > [  214.114916]   lock(&spidev->spi_lock);
> > > > [  214.118687]   lock(&spidev->spi_lock);
> > > > [  214.122457]
> > > > [  214.122457]  *** DEADLOCK ***
> > > > [  214.122457]
> > > > [  214.128386]  May be due to missing lock nesting notation
> > > > [  214.128386]
> > > > [  214.135183] 2 locks held by spidev_test/1454:
> > > > [  214.139553]  #0: c4925dbc (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x44/0xab8
> > > > [  214.147524]  #1: c4925e14 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x70/0xab8
> > > > [  214.155493]
> > > > [  214.155493] stack backtrace:
> > > > [  214.159861] CPU: 0 PID: 1454 Comm: spidev_test Not tainted 6.2.0-rc3-0.0.0-devel+git.97ec4d559d93 #1
> > > > [  214.169012] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> > > > [  214.175555]  unwind_backtrace from show_stack+0x10/0x14
> > > > [  214.180819]  show_stack from dump_stack_lvl+0x60/0x90
> > > > [  214.185900]  dump_stack_lvl from __lock_acquire+0x874/0x2858
> > > > [  214.191584]  __lock_acquire from lock_acquire+0xfc/0x378
> > > > [  214.196918]  lock_acquire from __mutex_lock+0x9c/0x8a8
> > > > [  214.202083]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> > > > [  214.207597]  mutex_lock_nested from spidev_ioctl+0x8e0/0xab8
> > > > [  214.213284]  spidev_ioctl from sys_ioctl+0x4d0/0xe2c
> > > > [  214.218277]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> > > > [  214.223351] Exception stack(0xe75cdfa8 to 0xe75cdff0)
> > > > [  214.228422] dfa0:                   00000000 00001000 00000003 40206b00 bee266e8 bee266e0
> > > > [  214.236617] dfc0: 00000000 00001000 006a71a0 00000036 004c0040 004bfd18 00000000 00000003
> > > > [  214.244809] dfe0: 00000036 bee266c8 b6f16dc5 b6e8e5f6
> > > >
> > > >
> > > > This is not running the latest rc4, but on sha 97ec4d559d93 (this is
> > > > just what our CI had available when this test was run). I was not able
> > > > to bisect it, but it seems something that you could have introduced.
> > > >
> > > > The log is from an apalis-imx6, but I have the same on other ARM SOC.
> > > >
> > > > Can you have a look?
> > > > Thanks
> > > >
> > > > Francesco
> > > >
> > >
> > > Eek! Yes it's commit 1f4d2dd45b6e ("spi: spidev: fix a race condition
> > > when accessing spidev->spi"): spidev_ioctl() takes the lock and in
> > > certain instances can end up calling spidev_compat_ioc_message() which
> > > takes the same lock again. I'll send a fix shortly.
> > >
> > > Bart
> >
> > Seems, like that's not it... Francesco: what is the output of:
> >
> > ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x44/0xab8
> >
> > and
> >
> > ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x44/0xab8
> >
> > on the spidev.o object for that build?
> >
> > Bart
> >
> I did this for Francesco.
>
> The CI build isn't configured for this:
> ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x44/0xab8
> ERROR: CONFIG_DEBUG_INFO not enabled
>
> So I recompiled the kernel and rerun the test.
> [  146.916497] ============================================
> [  146.921821] WARNING: possible recursive locking detected
> [  146.927143] 6.2.0-rc3-00349-g97ec4d559d93 #4 Not tainted
> [  146.932467] --------------------------------------------
> [  146.937786] spidev_test/558 is trying to acquire lock:
> [  146.942935] c4c79c3c (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x89c/0xa78
> [  146.950565]
> [  146.950565] but task is already holding lock:
> [  146.956405] c4c79c3c (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x40/0xa78
> [  146.963932]
> [  146.963932] other info that might help us debug this:
> [  146.970467]  Possible unsafe locking scenario:
> [  146.970467]
> [  146.976394]        CPU0
> [  146.978849]        ----
> [  146.981302]   lock(&spidev->spi_lock);
> [  146.985071]   lock(&spidev->spi_lock);
> [  146.988838]
> [  146.988838]  *** DEADLOCK ***
> [  146.988838]
> [  146.994765]  May be due to missing lock nesting notation
> [  146.994765]
> [  147.001561] 2 locks held by spidev_test/558:
> [  147.005842]  #0: c4c79c3c (&spidev->spi_lock){+.+.}-{3:3}, at: spidev_ioctl+0x40/0xa78
> [  147.013808]  #1: c4c79c94 (&spidev->buf_lock){+.+.}-{3:3}, at: spidev_ioctl+0x6c/0xa78
> [  147.021774]
> [  147.021774] stack backtrace:
> [  147.026141] CPU: 0 PID: 558 Comm: spidev_test Not tainted 6.2.0-rc3-00349-g97ec4d559d93 #4
> [  147.034419] Hardware name: Freescale i.MX7 Dual (Device Tree)
> [  147.040180]  unwind_backtrace from show_stack+0x10/0x14
> [  147.045433]  show_stack from dump_stack_lvl+0x58/0x70
> [  147.050506]  dump_stack_lvl from __lock_acquire+0x13cc/0x28e0
> [  147.056279]  __lock_acquire from lock_acquire+0xf4/0x368
> [  147.061616]  lock_acquire from __mutex_lock+0x80/0x8a0
> [  147.066783]  __mutex_lock from mutex_lock_nested+0x1c/0x24
> [  147.072295]  mutex_lock_nested from spidev_ioctl+0x89c/0xa78
> [  147.077983]  spidev_ioctl from sys_ioctl+0x540/0xddc
> [  147.082972]  sys_ioctl from ret_fast_syscall+0x0/0x1c
> [  147.088043] Exception stack(0xf1159fa8 to 0xf1159ff0)
> [  147.093111] 9fa0:                   00000000 00001000 00000003 40206b00 befe3a28 befe3a20
> [  147.101303] 9fc0: 00000000 00001000 014b01a0 00000036 00420040 0041fd18 00000000 00000003
> [  147.109493] 9fe0: 00000036 befe3a08 b6e86dc5 b6dfe5f6
>
> Using the changed code layout from this warning I get:
>
> $ ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x89c/0xa78
> spidev_ioctl+0x89c/0xa78:
> spidev_sync at /home/krm/git.toradex.com/linux-toradex-mainline/drivers/spi/spidev.c:99
> (inlined by) spidev_message at /home/krm/git.toradex.com/linux-toradex-mainline/drivers/spi/spidev.c:297
> (inlined by) spidev_ioctl at /home/krm/git.toradex.com/linux-toradex-mainline/drivers/spi/spidev.c:504
>
> $ ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x40/0xa78
> spidev_ioctl+0x40/0xa78:
> spidev_ioctl at /home/krm/git.toradex.com/linux-toradex-mainline/drivers/spi/spidev.c:363
>
> $ ./scripts/faddr2line drivers/spi/spidev.o spidev_ioctl+0x6c/0xa78
> spidev_ioctl+0x6c/0xa78:
> spidev_ioctl at /home/krm/git.toradex.com/linux-toradex-mainline/drivers/spi/spidev.c:377
>
> Regards
> Max

Thanks Max, that makes sense now, working on a fix.

Bart
