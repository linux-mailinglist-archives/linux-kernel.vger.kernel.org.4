Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF945BC357
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 09:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiISHFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 03:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiISHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 03:05:43 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4E91DA5F;
        Mon, 19 Sep 2022 00:05:40 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id 129so28954698vsi.10;
        Mon, 19 Sep 2022 00:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5HEKoJuYF0CySPa1nSPJ6d8EQUPdw5n9lmwFtfDXM6s=;
        b=o6E0sTdTwTu/kuehsHjSWiJENmMqeVR8mntGTFWKAfZxqx3D9gn5zxulZ2Wlm5/fU/
         oWuNM7+clNI7JxEd0cJarCIcptlUWpxGTEc/RPaIBm+tmPKM4/NtnFKBGdHhxAiGzZAG
         O99bT+dhZxd/3hRYBE3cX/kffdcuUFuwV3ZERUACym8fqF079RS4MNw4/Lv1us7OZCu7
         D3esyVUd0HU8/PYyY+zXZTmn3xbIe1S1AAktBlQwPJl0v8m00iDYNonTkXNVwel24PBr
         KAlucZ4QcOjtKOWDrw2FbYDsb/qbtQ16W939GtZ7h3eLQtZf94hqJrLH5yDx+zEF95t7
         OWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5HEKoJuYF0CySPa1nSPJ6d8EQUPdw5n9lmwFtfDXM6s=;
        b=6Sc1LPwENUzUxHapqgnXDDjrKBBMI4pmoZrD8wHqdjbvR16MLe9Rgwhl70dp9XkWf8
         0OyPY41zRMscdB/G5ScFvl7xKxRcIVkefLxRHovdMq2K1pEnFRnHxQmFJlAdBe+DPKu5
         /mx8VbuI0clbk/rkpnnyDvJJvA751Y0Ww/9ZjDTe9q2RydtsbsJUn/JdMTelDYPHKZyn
         7YzPPKyS7tyBCUF/sE1ZURbXP9Do7zOx7BtE9N79jgwQ4Zjck1GUDbV0OPsZ+bmyLgBK
         t4KtuyO6D5atmR71lkxFlMs1//gX+ej08cY3icR25J0IBvW/yycbdA2I33SloDOdtEA/
         dLUA==
X-Gm-Message-State: ACrzQf3eB9PQOEeIh407aRU4KdGav6NPzc5teHytcMixTJN9Ze/BjEWb
        LcTjbnukxCLar6mL61HRonib2hLYk1xIzKjSJ5Z6PIaLCNGnZA==
X-Google-Smtp-Source: AMsMyM5w0ML2ur0H2dNpEUQZmL4i3dA9gXS3jMiWJtKVak9Vfv+UmLHMGaxDcAl3Hc2t5P2VdM9QMpAe+oKs1mSmVRw=
X-Received: by 2002:a05:6102:2755:b0:398:4f71:86e with SMTP id
 p21-20020a056102275500b003984f71086emr5878340vsu.84.1663571139101; Mon, 19
 Sep 2022 00:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002bcef705e90199cd@google.com>
In-Reply-To: <0000000000002bcef705e90199cd@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Mon, 19 Sep 2022 16:05:22 +0900
Message-ID: <CAKFNMonaRvoUZj6kUhwrD==aB18cfyNbO4zPT89eAVNjtV4x6Q@mail.gmail.com>
Subject: Re: [syzbot] WARNING in __virt_to_phys
To:     syzbot <syzbot+443228fd71f385302265@syzkaller.appspotmail.com>
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

On Mon, Sep 19, 2022 at 3:12 PM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=14fc366f080000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
> dashboard link: https://syzkaller.appspot.com/bug?extid=443228fd71f385302265
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
> vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+443228fd71f385302265@syzkaller.appspotmail.com
>
> virt_to_phys used for non-linear address: 00000000b6fc6bf9 (0x44006b7369643d45)
> WARNING: CPU: 0 PID: 24583 at arch/arm64/mm/physaddr.c:15 __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
> Modules linked in:
> CPU: 0 PID: 24583 Comm: syz-executor.3 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
> lr : __virt_to_phys+0x7c/0x98 arch/arm64/mm/physaddr.c:12
> sp : ffff80001f993b00
> x29: ffff80001f993b00 x28: 0000000000000000 x27: ffff0000ed649d68
> x26: ffff0000fa388000 x25: 00000000ffff8000
>  x24: 0000000000000000
>
> x23: ffff000108325800 x22: 00000000ffff8000 x21: 0000000040000000
> x20: 44016b7369643d45 x19: 44006b7369643d45 x18: 00000000000001b8
> x17: ffff80000c00d6bc
>  x16: ffff80000db78658 x15: ffff0000fa388000
> x14: 0000000000000000 x13: 00000000ffffffff x12: 0000000000040000
> x11: 0000000000005389 x10: ffff800017fb2000 x9 : 48cd7cd042b5b300
> x8 : ffff80000cf0e000 x7 : ffff800008162e5c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000007 x1 : 0000000100000000 x0 : 000000000000004f
> Call trace:
>  __virt_to_phys+0x80/0x98 arch/arm64/mm/physaddr.c:17
>  virt_to_folio include/linux/mm.h:856 [inline]
>  kfree+0x70/0x348 mm/slub.c:4556
>  nilfs_mdt_destroy+0x24/0x3c fs/nilfs2/mdt.c:497
>  nilfs_free_inode+0x2c/0x54 fs/nilfs2/super.c:168
>  i_callback fs/inode.c:249 [inline]
>  alloc_inode+0xdc/0x104 fs/inode.c:274
>  new_inode_pseudo fs/inode.c:1019 [inline]
>  new_inode+0x2c/0xc0 fs/inode.c:1047
>  nilfs_new_inode+0x48/0x378 fs/nilfs2/inode.c:334
>  nilfs_create+0x74/0x17c fs/nilfs2/namei.c:85
>  vfs_create+0x1c8/0x270 fs/namei.c:3115
>  do_mknodat+0x274/0x3e8 fs/namei.c:3942
>  __do_sys_mknodat fs/namei.c:3970 [inline]
>  __se_sys_mknodat fs/namei.c:3967 [inline]
>  __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3967
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> irq event stamp: 2368
> hardirqs last  enabled at (2367): [<ffff800008162eec>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
> hardirqs last  enabled at (2367): [<ffff800008162eec>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
> hardirqs last disabled at (2368): [<ffff80000bfc5c8c>] el1_dbg+0x24/0x5c arch/arm64/kernel/entry-common.c:395
> softirqs last  enabled at (2364): [<ffff8000080102e4>] _stext+0x2e4/0x37c
> softirqs last disabled at (2287): [<ffff800008017c48>] ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
> ---[ end trace 0000000000000000 ]---
> Unable to handle kernel paging request at virtual address 000fffadd38710c8
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> [000fffadd38710c8] address between user and kernel address ranges
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 24583 Comm: syz-executor.3 Tainted: G        W          6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
> pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : _compound_head include/linux/page-flags.h:253 [inline]
> pc : virt_to_folio include/linux/mm.h:858 [inline]
> pc : kfree+0x80/0x348 mm/slub.c:4556
> lr : virt_to_folio include/linux/mm.h:856 [inline]
> lr : kfree+0x70/0x348 mm/slub.c:4556
> sp : ffff80001f993b20
> x29: ffff80001f993b30 x28: 0000000000000000 x27: ffff0000ed649d68
> x26: ffff0000fa388000 x25: 00000000ffff8000 x24: 0000000000000000
> x23: ffff000108325800
>  x22: 00000000ffff8000
>  x21: 010fffadd38710c0
> x20: ffff800008f58ab8
>  x19: 44006b7369643d45 x18: 00000000000001b8
> x17: ffff80000c00d6bc
>  x16: ffff80000db78658 x15: ffff0000fa388000
> x14: 0000000000000000
>  x13: 00000000ffffffff x12: 0000000000040000
> x11: 0000000000005389
>  x10: ffff800017fb2000 x9 : fffffc0000000000
> x8 : 0004400eb74e1c43 x7 : ffff800008162e5c x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000007 x1 : 0000000100000000 x0 : 4400eb7521c43d45
> Call trace:
>  virt_to_folio include/linux/mm.h:856 [inline]
>  kfree+0x80/0x348 mm/slub.c:4556
>  nilfs_mdt_destroy+0x24/0x3c fs/nilfs2/mdt.c:497
>  nilfs_free_inode+0x2c/0x54 fs/nilfs2/super.c:168
>  i_callback fs/inode.c:249 [inline]
>  alloc_inode+0xdc/0x104 fs/inode.c:274
>  new_inode_pseudo fs/inode.c:1019 [inline]
>  new_inode+0x2c/0xc0 fs/inode.c:1047
>  nilfs_new_inode+0x48/0x378 fs/nilfs2/inode.c:334
>  nilfs_create+0x74/0x17c fs/nilfs2/namei.c:85
>  vfs_create+0x1c8/0x270 fs/namei.c:3115
>  do_mknodat+0x274/0x3e8 fs/namei.c:3942
>  __do_sys_mknodat fs/namei.c:3970 [inline]
>  __se_sys_mknodat fs/namei.c:3967 [inline]
>  __arm64_sys_mknodat+0x4c/0x64 fs/namei.c:3967
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
>  el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
>  el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:624
>  el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:642
>  el0t_64_sync+0x18c/0x190
> Code: d34cfc08 cb953108 b25657e9 8b081935 (f94006a8)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   d34cfc08        lsr     x8, x0, #12
>    4:   cb953108        sub     x8, x8, x21, asr #12
>    8:   b25657e9        mov     x9, #0xfffffc0000000000         // #-4398046511104
>    c:   8b081935        add     x21, x9, x8, lsl #6
> * 10:   f94006a8        ldr     x8, [x21, #8] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

This looks like the same issue as the report [1]:

[1] https://lore.kernel.org/all/CAFcO6XOcf1Jj2SeGt=jJV59wmhESeSKpfR0omdFRq+J9nD1vfQ@mail.gmail.com/T/#u

The bug fix patch for this, is queued in the vfs tree with the title
"fs: fix UAF/GPF bug in nilfs_mdt_destroy"  [2]:

[2] https://lkml.kernel.org/r/20220816040859.659129-1-dzm91@hust.edu.cn

It's found in the latest linux-next as well.
As the outlook for now, this patch would be merged to the mainline
after Linux kernel 6.0 is released, and then backported to stable
trees.

Thanks,
Ryusuke Konishi
