Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F135FD630
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJMI3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJMI3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:29:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B0153A79
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:28:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u21so1553402edi.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2RSx++nLdbWusRvUAX1UxoEHYyvfKLnrruTdURiPd8=;
        b=O3wWomBa3yH12+Agw/mGGWfUxt7S0Bo6p5Qhg2Kqkd/FIK47pmCo7HY12CPYEVed4a
         eqhdP8c4GNB6JT/KCHCPH3Dth/TsWQjWkY0AhbuAgRvUZt9rtkh2GKjhocIMNBspVPQN
         GTq8Sxf7O5EJwunhKu9BR/14cFZk+zJOTIrVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2RSx++nLdbWusRvUAX1UxoEHYyvfKLnrruTdURiPd8=;
        b=pnNO0GwB5eRmUcgeLKSKWhl0wrkLyvxB+iQgA6dEtP5UU/dpnM75skG4M1mdnefOfN
         3kcob3Z+xuJrH1eS9wPgGD5Wisfry/SUIA3h0bHHVtLbbCRvyyalmyUasU4TCC+TrX1L
         yQQk0Ub+LL8Du4OdAcLC0N4aAhrtxqtffh3zhvW1dNfbpoIU2t5qtyKa9VqSuO/24n9y
         CfLQhWIU1eWyVgTY1aQMuMe2vPQEwyPTPuH7VGEXm35xYuY+IokwWukZitD9OvLAXhW6
         xXgvCcjc0NUvJGwmHXg+ymlOxp1GCTiTGGTZQfAtuQ0q4zzAimbrs9fbYPEe/OTV9vzc
         YpSw==
X-Gm-Message-State: ACrzQf0oKZzI+GdVIkvdD9zrBLE3OiM6oeGUNcB0unXpoj4nsIkN626D
        OOkooCtgUQzKE70zEJXIg0QGXFbJWq9lkw74XWCPSw==
X-Google-Smtp-Source: AMsMyM7kjqDEnuqGBguoweTmcPf0WGp/UNk2W9Bft5nzy0AjJ0XkIfTS5yc/t/wq0Lp+3DjCcKiu0Y5ke1akUsn1Pgw=
X-Received: by 2002:a05:6402:448:b0:45c:8de5:4fc with SMTP id
 p8-20020a056402044800b0045c8de504fcmr9647181edw.133.1665649736979; Thu, 13
 Oct 2022 01:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000aa237005eae5f9da@google.com>
In-Reply-To: <000000000000aa237005eae5f9da@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 13 Oct 2022 10:28:45 +0200
Message-ID: <CAJfpegtyWgdZDxPoYgwE=LekX1bNi8x0+Odvh-KYthSVxZMx7Q@mail.gmail.com>
Subject: Re: [syzbot] memory leak in vfs_tmpfile_open
To:     syzbot <syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000e4c92705eae64ce5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e4c92705eae64ce5
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

On Thu, 13 Oct 2022 at 10:05, syzbot
<syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    49da07006239 Merge tag 'memblock-v6.1-rc1' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12fea734880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a068149f16da5bd
> dashboard link: https://syzkaller.appspot.com/bug?extid=fd749a7ea127a84e0ffd
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14dfc1a4880000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123af8aa880000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/827598b3022b/disk-49da0700.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a6e5b024841f/vmlinux-49da0700.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+fd749a7ea127a84e0ffd@syzkaller.appspotmail.com
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 23.770s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 23.770s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 23.760s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 23.760s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 25.050s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 25.050s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 25.040s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 25.040s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 26.330s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 26.330s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 26.320s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 26.320s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 27.580s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 27.580s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 27.570s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 27.570s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.460s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.460s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.450s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.450s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105a4b500 (size 256):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.490s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     a0 04 7d 07 81 88 ff ff 00 8f b0 0e 81 88 ff ff  ..}.............
>   backtrace:
>     [<ffffffff815dbadf>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff815dbadf>] __alloc_file+0x1f/0xf0 fs/file_table.c:138
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff8881024495a0 (size 24):
>   comm "syz-executor426", pid 3643, jiffies 4294961352 (age 31.490s)
>   hex dump (first 24 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00                          ........
>   backtrace:
>     [<ffffffff82222e7a>] kmem_cache_zalloc include/linux/slab.h:702 [inline]
>     [<ffffffff82222e7a>] lsm_file_alloc security/security.c:575 [inline]
>     [<ffffffff82222e7a>] security_file_alloc+0x2a/0xb0 security/security.c:1529
>     [<ffffffff815dbb1d>] __alloc_file+0x5d/0xf0 fs/file_table.c:143
>     [<ffffffff815dc6e9>] alloc_empty_file_noaccount+0x19/0x50 fs/file_table.c:209
>     [<ffffffff815efee6>] vfs_tmpfile_open+0x26/0x90 fs/namei.c:3644
>     [<ffffffff81bf7e0c>] ovl_do_tmpfile fs/overlayfs/overlayfs.h:317 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:747 [inline]
>     [<ffffffff81bf7e0c>] ovl_do_copy_up fs/overlayfs/copy_up.c:839 [inline]
>     [<ffffffff81bf7e0c>] ovl_copy_up_one+0xe5c/0x1670 fs/overlayfs/copy_up.c:1007
>     [<ffffffff81bf8727>] ovl_copy_up_flags+0x107/0x170 fs/overlayfs/copy_up.c:1053
>     [<ffffffff81bf8890>] ovl_maybe_copy_up+0x100/0x130 fs/overlayfs/copy_up.c:1085
>     [<ffffffff81bedeb2>] ovl_open+0x52/0x100 fs/overlayfs/file.c:152
>     [<ffffffff815d009f>] do_dentry_open+0x2ff/0x7c0 fs/open.c:882
>     [<ffffffff815f68ef>] do_open fs/namei.c:3557 [inline]
>     [<ffffffff815f68ef>] path_openat+0x161f/0x1b70 fs/namei.c:3713
>     [<ffffffff815f96e1>] do_filp_open+0xc1/0x1b0 fs/namei.c:3740
>     [<ffffffff815d3a0d>] do_sys_openat2+0xed/0x260 fs/open.c:1310
>     [<ffffffff815d429d>] do_sys_open fs/open.c:1326 [inline]
>     [<ffffffff815d429d>] __do_sys_open fs/open.c:1334 [inline]
>     [<ffffffff815d429d>] __se_sys_open fs/open.c:1330 [inline]
>     [<ffffffff815d429d>] __x64_sys_open+0x7d/0xe0 fs/open.c:1330
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888105b4b900 (size 176):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.480s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff81283347>] prepare_creds+0x27/0x470 kernel/cred.c:260
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> BUG: memory leak
> unreferenced object 0xffff888100c4bb80 (size 32):
>   comm "syz-executor426", pid 3645, jiffies 4294961353 (age 31.480s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 b0 12 bb 00 81 88 ff ff  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<ffffffff814ce961>] __do_kmalloc_node mm/slab_common.c:954 [inline]
>     [<ffffffff814ce961>] __kmalloc+0x41/0x130 mm/slab_common.c:968
>     [<ffffffff82223655>] kmalloc include/linux/slab.h:581 [inline]
>     [<ffffffff82223655>] kzalloc include/linux/slab.h:712 [inline]
>     [<ffffffff82223655>] lsm_cred_alloc security/security.c:540 [inline]
>     [<ffffffff82223655>] security_prepare_creds+0xa5/0xd0 security/security.c:1705
>     [<ffffffff81283606>] prepare_creds+0x2e6/0x470 kernel/cred.c:291
>     [<ffffffff81be20cd>] ovl_fill_super+0xad/0x2730 fs/overlayfs/super.c:2007
>     [<ffffffff815df27c>] mount_nodev+0x5c/0xc0 fs/super.c:1446
>     [<ffffffff8164321b>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:610
>     [<ffffffff815dcd78>] vfs_get_tree+0x28/0x100 fs/super.c:1530
>     [<ffffffff81620c37>] do_new_mount fs/namespace.c:3040 [inline]
>     [<ffffffff81620c37>] path_mount+0xc37/0x10d0 fs/namespace.c:3370
>     [<ffffffff8162181e>] do_mount fs/namespace.c:3383 [inline]
>     [<ffffffff8162181e>] __do_sys_mount fs/namespace.c:3591 [inline]
>     [<ffffffff8162181e>] __se_sys_mount fs/namespace.c:3568 [inline]
>     [<ffffffff8162181e>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3568
>     [<ffffffff84600f65>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>     [<ffffffff84600f65>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>     [<ffffffff84800087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
> executing program
> executing program
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

--000000000000e4c92705eae64ce5
Content-Type: text/x-patch; charset="US-ASCII"; name="ovl-fix-tmpfile-leak.patch"
Content-Disposition: attachment; filename="ovl-fix-tmpfile-leak.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l96stpik0>
X-Attachment-Id: f_l96stpik0

RnJvbTogTWlrbG9zIFN6ZXJlZGkgPG1zemVyZWRpQHJlZGhhdC5jb20+ClN1YmplY3Q6IG92bDog
Zml4IHRtcGZpbGUgbGVhawoKTWlzc2VkIGFuIGVycm9yIGNsZWFudXAuCgpSZXBvcnRlZC1ieTog
c3l6Ym90K2ZkNzQ5YTdlYTEyN2E4NGUwZmZkQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KRml4
ZXM6IDJiMWE3NzQ2MWYxNiAoIm92bDogdXNlIHZmc190bXBmaWxlX29wZW4oKSBoZWxwZXIiKQpT
aWduZWQtb2ZmLWJ5OiBNaWtsb3MgU3plcmVkaSA8bXN6ZXJlZGlAcmVkaGF0LmNvbT4KLS0tCiBm
cy9vdmVybGF5ZnMvY29weV91cC5jIHwgICAgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pCgotLS0gYS9mcy9vdmVybGF5ZnMvY29weV91cC5jCisrKyBi
L2ZzL292ZXJsYXlmcy9jb3B5X3VwLmMKQEAgLTc1NCw3ICs3NTQsNyBAQCBzdGF0aWMgaW50IG92
bF9jb3B5X3VwX3RtcGZpbGUoc3RydWN0IG92CiAJaWYgKCFjLT5tZXRhY29weSAmJiBjLT5zdGF0
LnNpemUpIHsKIAkJZXJyID0gb3ZsX2NvcHlfdXBfZmlsZShvZnMsIGMtPmRlbnRyeSwgdG1wZmls
ZSwgYy0+c3RhdC5zaXplKTsKIAkJaWYgKGVycikKLQkJCXJldHVybiBlcnI7CisJCQlnb3RvIG91
dF9mcHV0OwogCX0KIAogCWVyciA9IG92bF9jb3B5X3VwX21ldGFkYXRhKGMsIHRlbXApOwo=
--000000000000e4c92705eae64ce5--
