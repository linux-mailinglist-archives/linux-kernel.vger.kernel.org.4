Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DEE659185
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbiL2U23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbiL2U22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:28:28 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2313F12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:28:26 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id 186so21687238ybe.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39vmEvDUiA/aRZqSAoUZ+FtQACt8A9KX/csWheBbyBc=;
        b=OsGK9KiusQpyermVRhKNv9nv8wGA/Bn+ihJCscdf+iVUIYHv70QLFwEUZhzA+ptvpn
         CM3fv5B9LQpwP8m01ST1tMKf6zwooqtzcxwqhhCwtfWuY411Xpb+IRj2kZvGrgH/8MO8
         VDuqyRaYk07nc5pQaRs7DBIxFYzfvhVl+xE4eOI5+CJJ7dT5kfltt5g6LHmO8JFbf4hB
         MTLtlHFAANeJfJ3KzDNx62T9f+xSKOIzRGwoafpDCOLfeDFHDsOMoIjFLQu/Z7VL1dIm
         IiSXVGcvkmLozqCR5QbunuzAnHabdv9BlJVkd9V6cGUOVyjE4hiDQ3SRXIf8FzNi5kL4
         qcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39vmEvDUiA/aRZqSAoUZ+FtQACt8A9KX/csWheBbyBc=;
        b=5NMAeKWglmgiFrVSMDuWU6q/iRSep/ADpk0G2Js5eOzQ/r/KtfQBMy5plCIR1ItOGK
         PRxibHNc7EKUA/zHH3RVdqI3z3UuTG1Y1uHuJO/lZW+WCgrFCxnCWudotMb/PDxnpRcv
         iv8wRQbd6qKV6zFBPGQ4wiZP3bv3Ntwof3TFun1d3yTKsE9LLODuj4Yus0n0FDJ93eRk
         fUz5IODUKOvaDKnN7dkSp/xXPSYGPpr22E6fHgr1G8jmYU4QXUT2mr8YXeQoyIHaFOc7
         9licoo2/kJad7x7TgzfBYd9KkZuPjlxxByKF/Gl4nD+f9TJDsZxiEumRvTcHu/v5eQ9X
         Xceg==
X-Gm-Message-State: AFqh2kqYVtJFHAE5C7iIk6L6s9RJaUIsnE1yWiwwklSS14QKLSf8cFNf
        BElSfd4tOc4eZgTedetV4pbMPSkL2m6uG/Q2qNFq9g==
X-Google-Smtp-Source: AMrXdXveUjb1MNXk9v+25y93ROJ6jz5/vfQMf9nh0DdQcpgBt6HkDbMhz7vHqtSN6kWdfLuUa7VhiyxE5J+4HXwTd6M=
X-Received: by 2002:a25:aa8a:0:b0:74d:e2b6:d5fa with SMTP id
 t10-20020a25aa8a000000b0074de2b6d5famr2850343ybi.226.1672345705413; Thu, 29
 Dec 2022 12:28:25 -0800 (PST)
MIME-Version: 1.0
References: <03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de> <CAODwPW8=1R53Dir+CFHu-NADygCZVqDjsg0q+xT-KheZHghxtw@mail.gmail.com>
In-Reply-To: <CAODwPW8=1R53Dir+CFHu-NADygCZVqDjsg0q+xT-KheZHghxtw@mail.gmail.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 29 Dec 2022 12:28:14 -0800
Message-ID: <CABXOdTcvBe5PzO6RrUDC-NcYpWYuabZkN1qXA=gSqbhPHLxqsw@mail.gmail.com>
Subject: Re: memcpy: detected field-spanning write (size 168) of single field
 "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
To:     Julius Werner <jwerner@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Jack Rosenthal <jrosenth@chromium.org>, coreboot@coreboot.org,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 6:43 AM Julius Werner <jwerner@chromium.org> wrote:
>
> I can confirm that this warning is a false positive, at least. We're
> intentionally copying bytes from beyond the end of the header
> structure in this case.
>
> I don't know what kind of kernel system detects this stuff at runtime
> and how to silence it. Probably need to add a void pointer cast or
> something?
>

This is part of kernel hardening code. Kees Cook might know what to do about it.

Guenter

> On Thu, Dec 29, 2022 at 11:46 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Linux folks,
> >
> >
> > Running Linux v6.2-rc1+ on a motherboard using coreboot as firmware, the
> > warning below is shown.
> >
> > ```
> > [    1.630244] ------------[ cut here ]------------
> > [    1.630249] memcpy: detected field-spanning write (size 168) of
> > single field "&device->entry" at
> > drivers/firmware/google/coreboot_table.c:103 (size 8)
> > [    1.630299] WARNING: CPU: 1 PID: 150 at
> > drivers/firmware/google/coreboot_table.c:103
> > coreboot_table_probe+0x1ea/0x210 [coreboot_table]
> > [    1.630307] Modules linked in: coreboot_table(+) sg binfmt_misc fuse
> > ipv6 autofs4
> > [    1.630316] CPU: 1 PID: 150 Comm: systemd-udevd Not tainted
> > 6.2.0-rc1-00097-gaebfba447cae #407
> > [    1.630318] Hardware name: ASUS F2A85-M_PRO/F2A85-M_PRO, BIOS
> > 4.18-4-gb3dd5af9c5 12/28/2022
> > [    1.630320] RIP: 0010:coreboot_table_probe+0x1ea/0x210 [coreboot_table]
> > [    1.630326] Code: 08 00 00 00 4c 89 c6 4c 89 04 24 48 c7 c2 50 81 60
> > c0 48 c7 c7 98 81 60 c0 4c 89 4c 24 08 c6 05 ab 1e 00 00 01 e8 e1 ca 47
> > d3 <0f> 0b 4c 8b 4c 24 08 4c 8b 04 24 e9 35 ff ff ff 41 be ea ff ff ff
> > [    1.630329] RSP: 0018:ffffb409c046fc30 EFLAGS: 00010286
> > [    1.630332] RAX: 0000000000000000 RBX: ffffb409c0175018 RCX:
> > 0000000000000000
> > [    1.630334] RDX: 0000000000000001 RSI: ffffffff94222bcd RDI:
> > 00000000ffffffff
> > [    1.630336] RBP: ffff937a44a06c00 R08: 0000000000000000 R09:
> > 00000000ffffdfff
> > [    1.630338] R10: ffffb409c046fad8 R11: ffffffff9452a948 R12:
> > 0000000000000000
> > [    1.630339] R13: ffffb409c0175000 R14: 0000000000000000 R15:
> > ffff937a40beb410
> > [    1.630341] FS:  0000000000000000(0000) GS:ffff937abb500000(0063)
> > knlGS:00000000f7f43800
> > [    1.630343] CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
> > [    1.630345] CR2: 00000000f7e3c2cf CR3: 00000001046de000 CR4:
> > 00000000000406e0
> > [    1.630347] Call Trace:
> > [    1.630348]  <TASK>
> > [    1.630351]  platform_probe+0x3f/0xa0
> > [    1.630357]  really_probe+0xe1/0x390
> > [    1.630361]  ? pm_runtime_barrier+0x50/0x90
> > [    1.630365]  __driver_probe_device+0x78/0x180
> > [    1.630369]  driver_probe_device+0x1e/0x90
> > [    1.630372]  __driver_attach+0xd2/0x1c0
> > [    1.630375]  ? __pfx___driver_attach+0x10/0x10
> > [    1.630378]  bus_for_each_dev+0x78/0xc0
> > [    1.630382]  bus_add_driver+0x1a9/0x200
> > [    1.630385]  driver_register+0x8f/0xf0
> > [    1.630387]  ? __pfx_init_module+0x10/0x10 [coreboot_table]
> > [    1.630392]  coreboot_table_driver_init+0x2d/0xff0 [coreboot_table]
> > [    1.630397]  do_one_initcall+0x44/0x220
> > [    1.630401]  ? kmalloc_trace+0x25/0x90
> > [    1.630405]  do_init_module+0x4c/0x1f0
> > [    1.630409]  __do_sys_finit_module+0xb4/0x130
> > [    1.630413]  __do_fast_syscall_32+0x6f/0xf0
> > [    1.630418]  do_fast_syscall_32+0x2f/0x70
> > [    1.630421]  entry_SYSCALL_compat_after_hwframe+0x71/0x79
> > [    1.630425] RIP: 0023:0xf7f49549
> > [    1.630428] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10
> > 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 cd 0f 05 cd
> > 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> > [    1.630430] RSP: 002b:00000000ffa7bbbc EFLAGS: 00200292 ORIG_RAX:
> > 000000000000015e
> > [    1.630433] RAX: ffffffffffffffda RBX: 0000000000000010 RCX:
> > 00000000f7f28e09
> > [    1.630434] RDX: 0000000000000000 RSI: 00000000568cb4c0 RDI:
> > 000000005689fc50
> > [    1.630436] RBP: 0000000000000000 R08: 00000000ffa7bbbc R09:
> > 0000000000000000
> > [    1.630437] R10: 0000000000000000 R11: 0000000000200292 R12:
> > 0000000000000000
> > [    1.630439] R13: 0000000000000000 R14: 0000000000000000 R15:
> > 0000000000000000
> > [    1.630442]  </TASK>
> > [    1.630443] ---[ end trace 0000000000000000 ]---
> > ```
> >
> > Another user reported this with Linux 6.1.1 in the Arch Linux forum [1].
> >
> >
> > Kind regards,
> >
> > Paul
> >
> >
> > [1]: https://bbs.archlinux.org/viewtopic.php?id=282245
> >       "6.1.1-arch1-1 - dmesg"
