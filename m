Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DDD5F520D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiJEJu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiJEJuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:50:22 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553E42BE39;
        Wed,  5 Oct 2022 02:50:21 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id e22so6206720uar.5;
        Wed, 05 Oct 2022 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l6wViLeXoikJV51BSLR9er0g/1rUfL2AfJWPWHQaBO4=;
        b=RIZIhTf/zVnc34GbvTapKLkIm2Qt3SPXumJKjNedPb/RsOlEZPgk6xr+Uu6sh/fXA/
         a3aamm5MftGn6eLErbCFlCy9erPyV3qTupxYiKjhbG8QbgfkrDajd2soKx8U0YaP5Hdu
         RSMHgxrq6jkuPojH9PDqvy6gwyWqbdyzMg3kloYFw+1eR2pasOetyslwUngHQoor3Gnt
         76xoWsQ+QR6++OaAB8MFNVvuSk1Z71cmDO+lu0yKtTe8T+IBgCa6AThejgP32xDoFsBY
         /vet0ZEAslTlTaOS0bYV6JqCunSbe9FFjQ6sLzVb9p47H+xs++yhcB3cNyAq2J408n5t
         aNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l6wViLeXoikJV51BSLR9er0g/1rUfL2AfJWPWHQaBO4=;
        b=V8wj5UbJGM8F4z3d0AxbgFRm1VNxX4mZoVPLY5fPZ0ZSmELhQvqHUBxUMbr8LyOajg
         GcGhU0x9SnlKdxwB4KxnN1P6L1lXlSueBgEDSDImtQTMB36W68yCx0kFbtQrXCBvIcrN
         Km/rkcx7Y+92AlxAGNZvwmFTUOkNWjJ2AiCes9s1NCR39f6iWsfpzIwyXPWEQ8J+Vmgf
         JXEe56Y1wYn0a9Uhv+0w7Y4IycM9iwfTkb6eSsmLK+oMAv0u0o1FfxrX/nceRHLpvYdk
         udIZg1q5ea3mD+dpQUL1ypApCNNxcRfIbUBDjqQyiRADrp7ibZKC3qJqKNHkW0v8zxKc
         SxYQ==
X-Gm-Message-State: ACrzQf32+wrxYGPlJ2EPm4jkiNR+OK04F8atoKkxK7T6a6ZFwrqMP3Kp
        zLDp+OZ+1fHm6F8+V33FexZmuY3cAPiRfuSLEcVNeIB0P+o=
X-Google-Smtp-Source: AMsMyM6WfGhCJxLY6ANRM8y0SC9ko6T+AcW1yv2D3PCF2210KvNf8WkEayrKMhQLhObv4beXbQJybZ7/p5xhMMwAk9s=
X-Received: by 2002:ab0:70c8:0:b0:39f:7528:6289 with SMTP id
 r8-20020ab070c8000000b0039f75286289mr13560678ual.36.1664963420215; Wed, 05
 Oct 2022 02:50:20 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000694b7b05ea45963e@google.com>
In-Reply-To: <000000000000694b7b05ea45963e@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Wed, 5 Oct 2022 18:50:03 +0900
Message-ID: <CAKFNMonJBZpSC3GRLKcbG8NSrTKyR8EG2PN_4zeVkH5yM3fbVw@mail.gmail.com>
Subject: Re: [syzbot] memory leak in nilfs_sysfs_create_device_group
To:     syzbot <syzbot+2e2f697dbd0f429d5dae@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

On Wed, Oct 5, 2022 at 5:44 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a5088ee7251e Merge tag 'thermal-6.1-rc1' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=153f2492880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=21254cf9c7c084e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=2e2f697dbd0f429d5dae
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1556a368880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c2d2c6d22fae/disk-a5088ee7.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/3c66d2393267/vmlinux-a5088ee7.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/f2050cc3fa6c/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2e2f697dbd0f429d5dae@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff888119526520 (size 32):
>   comm "syz-executor.4", pid 4168, jiffies 4294949450 (age 9.260s)
>   hex dump (first 32 bytes):
>     6c 6f 6f 70 34 00 00 00 00 00 00 00 00 00 00 00  loop4...........
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814c5b86>] kstrdup+0x36/0x70 mm/util.c:61
>     [<ffffffff814c5c13>] kstrdup_const+0x53/0x80 mm/util.c:84
>     [<ffffffff823af0e2>] kvasprintf_const+0xc2/0x110 lib/kasprintf.c:48
>     [<ffffffff824a442b>] kobject_set_name_vargs+0x3b/0xe0 lib/kobject.c:257
>     [<ffffffff824a48ad>] kobject_add_varg lib/kobject.c:352 [inline]
>     [<ffffffff824a48ad>] kobject_init_and_add+0x6d/0xc0 lib/kobject.c:441
>     [<ffffffff81e217ba>] nilfs_sysfs_create_device_group+0x9a/0x3d0 fs/nilfs2/sysfs.c:991
>     [<ffffffff81e0a03c>] init_nilfs+0x51c/0x680 fs/nilfs2/the_nilfs.c:637
>     [<ffffffff81df608b>] nilfs_fill_super fs/nilfs2/super.c:1047 [inline]
>     [<ffffffff81df608b>] nilfs_mount+0x51b/0x890 fs/nilfs2/super.c:1317
>     [<ffffffff8164f4ab>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815e8c48>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff8162cbd7>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff8162cbd7>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162d7be>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162d7be>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162d7be>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162d7be>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff845ebbf5>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff845ebbf5>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: memory leak in kobject_set_name_vargs (5)

Looks like the same issue as above.  I'm now digging into it.

Ryusuke Konishi
