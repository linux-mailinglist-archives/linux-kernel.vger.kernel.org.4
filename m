Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE39762FEF1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiKRUmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbiKRUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:41:59 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12BE40901
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:41:57 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id i10so15833189ejg.6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kAEQIObXYXs01AedR7NhUuwjdIVskhWhkMQWbzqkou4=;
        b=Vpojzz/ztT/sbjtP8yfZ5lGtSrV53cZHJlBK1vNHaE6XnPGAkB3nKt/FEzHdQDS2ky
         v4AkK/RaWxmls8tAp0J+B12ppgaqkLrFkG8U9X1DQi6rdQBH6FQtfulUbEiYVQXG/4hg
         vsx3e1vs/Fh6EGP8BDXwGlRssMABbji2WlVs7RnbdG8eVOXaR5Ep+jPSFUD0JPp8ppT8
         uP0J2A3kBoy9dsmd+iHVCUA7rJuRxftb020CmemeZjb3E4fihiN0hMPSX0lP3BKW5DWj
         wS86fd6Wgok9hLXUSslzRntfQeKDqxib0Ob5z2wUIe/akIZB3hHglv2RPV1CemQf7f6F
         2uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAEQIObXYXs01AedR7NhUuwjdIVskhWhkMQWbzqkou4=;
        b=TPmYbnCdNryIXLKei9iCC1cliKTaeonuZaJV0QdlqiwSG7nJYZevFeu4HKZ+lxYUWL
         SEiinr7DBa54jbsEaUH6s5m0UUJ5XUtYAMjWHBjS10sTZOQjapMeRmrrychLPa07BII5
         VYh2icwHzlmoUSGFVllwHKAkExi/9FwBYLCLuPF5TtJ7eJF19skOwTx7qmXdv2aPdmVe
         Q5TZfRqiV1qQpvoCn9cWXIInZk1R180W70raje+msKw7Afesfn5JS3WQ+IV6Cfot/xmK
         KO9TGfTsJw8EPZMXBch9Qu/xJTtWDErBhI8f+OBhHcHWKRSeZD57i5ZeGZd4UI3Qea36
         Q9oA==
X-Gm-Message-State: ANoB5pkkj9IFPXQv+uW2eX8RbdEshSqo7QqTTqr+1rRXeL+47PQvN1+z
        kesedKfbde2FH8swb+WCmkUwfd7YQ5cZFys5mtU=
X-Google-Smtp-Source: AA0mqf7wYVTUuGNDWPj3ntxrnm7wwFhYspmYTMNn8Jdntjr8DZx37CQVJ+M1/36Un/1Gd89jSxgH0dnb0HAGyf51m5k=
X-Received: by 2002:a17:906:4e04:b0:78d:9b4f:44ee with SMTP id
 z4-20020a1709064e0400b0078d9b4f44eemr7423999eju.679.1668804116204; Fri, 18
 Nov 2022 12:41:56 -0800 (PST)
MIME-Version: 1.0
References: <e97bc607-a913-dbbd-1965-b60d55d956b8@gmail.com>
 <c5edaa34-6f85-c6a8-84f5-75413dc864ea@gmail.com> <202208091600.D19DFF9C7D@keescook>
In-Reply-To: <202208091600.D19DFF9C7D@keescook>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Fri, 18 Nov 2022 15:41:44 -0500
Message-ID: <CAC=U0a3F6172JH+xvA0pSb0bewu_0PX9XFKmL32ge+KyTOdaZA@mail.gmail.com>
Subject: Re: Invalid pstore_blk use?
To:     Kees Cook <keescook@chromium.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

I am in the process of implementing  mmcpstore  backend for mmc  based
on the mtdpstore driver

This is what is registered with register_pstore_device(&cxt->dev);
cxt->dev.flags = PSTORE_FLAGS_DMESG;
cxt->dev.zone.read = mmcpstore_read;
cxt->dev.zone.write = mmcpstore_write;
cxt->dev.zone.erase = mmcpstore_erase;
cxt->dev.zone.panic_write = mmcpstore_panic_write;

# dmesg | grep pstor
[    0.000000] Kernel command line: pstore_blk.blkdev=/dev/mmcblk1p8
crash_kexec_post_notifiers printk.always_kmsg_dump
[    1.993986] pstore_zone: registered pstore_blk as backend for
kmsg(Oops,panic_write) pmsg
[    2.002582] pstore: Using crash dump compression: deflate
[    2.008133] pstore: Registered pstore_blk as persistent store backend
[    2.020907] mmcpstore: /dev/mmcblk1p8 size 131072 start sector
34468 registered as psblk backend
[   17.868753] psz_kmsg_recover_meta: pstore_zone: no valid data in
kmsg dump zone 0
[   18.298933] psz_recover_zone: pstore_zone: no valid data in zone pmsg
[   18.305398] psz_recovery: pstore_zone: recover end!

The driver is successfully registered and the read path works when
/sys/fs/pstor is mounted , however mmc_pstore_panic_write is not
called.
Need help in understanding what could be missing. I am using the
latest upstream kernel for testing.

Kamal

On Tue, Aug 9, 2022 at 7:06 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Aug 09, 2022 at 11:35:08AM -0700, Florian Fainelli wrote:
> > Hi Kees, WeiXiong,
> >
> > On 7/14/22 20:49, Florian Fainelli wrote:
> > > Hi Kees, WeiXiong,
> > >
> > > I am trying to make use of pstore_blk which is BTW exactly what I had
> > > been looking for to store panic/console logs onto an eMMC partition.
> > >
> > > Using the 5.10 kernel plus:
> > >
> > > 7e2e92e9861b Revert "mark pstore-blk as broken"
> > > 01c28bc8f389 pstore/blk: Use the normal block device I/O path
> > > 2a7507999638 pstore/blk: remove {un,}register_pstore_blk
> > > fef0b337cd25 pstore/zone: cap the maximum device size
> > >
> > > or the android13-5.15 (at Merge 5.15.40 into android13-5.15) kernel with
> > > no changes and using:
> > >
> > > mount -t pstore pstore /sys/fs/pstore
> > > modprobe pstore_blk blkdev=/dev/mmcblk1p9 best_effort=yes
> > >
> > > upon triggering a crash with:
> > >
> > > echo c > /proc/sysrq-trigger
> > >
> > > and rebooting and remounting the pstore filesystem and loading
> > > pstore_blk, I only have:
> > >
> > > # ls /sys/fs/pstore/
> > > console-pstore_blk-0
> > >
> > > which contains the entire console log up to, but excluding the crash.
> > > The kernel does show that pstore_blk was used for all 3 types of kmsg,
> > > pmsg and console:
> > >
> > > [   28.649514] pstore_zone: capping size to 128MiB
> > > [   28.712894] pstore_zone: registered pstore_blk as backend for
> > > kmsg(Oops) pmsg console
> > > [   28.721145] pstore: Using crash dump compression: deflate
> > > [   28.906253] printk: console [pstore_blk-1] enabled
> > > [   28.911229] pstore: Registered pstore_blk as persistent store backend
> > > [   28.917735] pstore_blk: attached pstore_blk:/dev/mmcblk1p9
> > > (134217728) (no dedicated panic_write!)
> > >
> > > there is no automatic reboot upon panic, so I just tend to reboot after
> > > 2-3 seconds manually. The kernel is configured with the default
> > > CONFIG_PSTORE_* options.
> > >
> > > Is the observed behavior a limitation of the best_effort mode? If so, do
> > > we have any plans to implementing a non-best effort mode for eMMC
> > > devices?
> >
> > Any feedback on my email? I did try to get kernel panics to be dumped out to
>
> Hi! Sorry I lost this email originally. :)
>
> > a dedicated /dev/mtdblock* partition for which there ought to be support for
> > mtd->panic_write, but it still did not work any better. Is there something
>
> With the mtdblock driver, do you still see:
>
>     pstore_blk: attached pstore_blk:/dev/... (no dedicated panic_write!)
>                                               ^^^^^^^^^^^^^^^^^^^^^^^^^
>
> > obvious that I am missing which prevents kernel panics from being logged?
>
> Unfortunately it really depends on how the drivers are built. If the
> block layer is shut down during a panic, pstore_blk won't catch the
> panic. :(
>
> --
> Kees Cook
