Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A96393D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 05:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKZEHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 23:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiKZEHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 23:07:08 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7CC1E739
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:07:07 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id n8-20020a056e021ba800b00302c73f42d9so3977815ili.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 20:07:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Xlm0ihDzdy1MS5dffHdYdsawho2WoKhIqDxe/mjLS0=;
        b=xtTH4JEl23EaKoiUpRmqPicC3s1lvQlU8AWdHcPQxB9yyyKmSXvgvkenE1eANWvhCZ
         AdjAi5L56yDHhtz59US8gkJzrWXBOISph5VP7GQ1BbFzK9H9+b1AtpSMyRw+2SeIGKWb
         LB0YmQWh8soDILhXIY8Ttdm4fq+00hmhoGKhLJ3Of/WgvLwelaVW+E8xM6r4L7hmoJpC
         9AJUS/40etXWL03CqJxETV9rnr0N296GxQd1CXyaVlh8lk53ltFIxHs68cfgtW87w3k5
         NiILrF5hOHBVRvaNPxC7VoNFg/E4TIyXmKiecFXSsCAHZou6xKaanfPBj8Du8dQZSyqJ
         MpEg==
X-Gm-Message-State: ANoB5plFqLIXNaHyIQU+ZYGJDsutAZ76T6HSPEPbSvfm9jDsoR6kds8U
        YJ8fOaUVbDxSXpUQMe15UjodAZTFb+20o8iaz2dd0mh0HKr0
X-Google-Smtp-Source: AA0mqf6HSfGRMDCDMsESzkAVqboet0zi9qQSj3SoY6AuYQvUVgyxoEqoMshqZLS8H+TqoSrHKRg9u8xFORRuFIq8rALt8QId/TmD
MIME-Version: 1.0
X-Received: by 2002:a92:b50c:0:b0:302:f954:e74 with SMTP id
 f12-20020a92b50c000000b00302f9540e74mr2622394ile.220.1669435626576; Fri, 25
 Nov 2022 20:07:06 -0800 (PST)
Date:   Fri, 25 Nov 2022 20:07:06 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f649605ee57c509@google.com>
Subject: [syzbot] WARNING in diUnmount
From:   syzbot <syzbot+47366a6b503c7edf6bbb@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a77d28d13789 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15e01df9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4c990190d758078
dashboard link: https://syzkaller.appspot.com/bug?extid=47366a6b503c7edf6bbb
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c4b04ddbeb3/disk-a77d28d1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ecedb0cf6ca/vmlinux-a77d28d1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/44c59c4393c7/Image-a77d28d1.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47366a6b503c7edf6bbb@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 3130 at mm/slab_common.c:923 free_large_kmalloc+0x3c/0x144 mm/slab_common.c:924
Modules linked in:
CPU: 0 PID: 3130 Comm: syz-executor.5 Not tainted 6.1.0-rc6-syzkaller-32651-ga77d28d13789 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : free_large_kmalloc+0x3c/0x144 mm/slab_common.c:924
lr : kfree+0xb8/0x118 mm/slab_common.c:1001
sp : ffff800012dcbba0
x29: ffff800012dcbba0 x28: ffff0000c4169a40 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff0000eccb8800
x23: ffff80000d5d8000 x22: ffff0000f2113018 x21: 0000000040000000
x20: ffff800008d57fd4 x19: fffffc0004768200 x18: 000000000000017a
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000406 x12: ffff80000d4f7298
x11: ff8080000805b050 x10: 0000000000000000 x9 : fffffc0000000000
x8 : ffff80000d990000 x7 : ffff8000083e0fd4 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000002
x2 : 0000000000000008 x1 : ffff00011da08000 x0 : fffffc0004768200
Call trace:
 free_large_kmalloc+0x3c/0x144 mm/slab_common.c:924
 kfree+0xb8/0x118 mm/slab_common.c:1001
 diUnmount+0x74/0x8c fs/jfs/jfs_imap.c:195
 jfs_umount+0x94/0x190 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x6c/0x104 fs/jfs/super.c:194
 generic_shutdown_super+0x94/0x198 fs/super.c:492
 kill_block_super+0x30/0x78 fs/super.c:1428
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
irq event stamp: 3932962
hardirqs last  enabled at (3932961): [<ffff80000c0b6d44>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (3932961): [<ffff80000c0b6d44>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (3932962): [<ffff80000c0a4074>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:405
softirqs last  enabled at (3932812): [<ffff80000801c38c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (3932810): [<ffff80000801c358>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
object pointer: 0x000000001b0e773b
page:00000000b707f24b refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x15da08
flags: 0x5ffc00000000000(node=0|zone=2|lastcpupid=0x7ff)
raw: 05ffc00000000000 fffffc0003bf0008 ffff0001feff4c20 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)
------------[ cut here ]------------
kernel BUG at include/linux/mm.h:757!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3130 Comm: syz-executor.5 Tainted: G        W          6.1.0-rc6-syzkaller-32651-ga77d28d13789 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : put_page_testzero include/linux/mm.h:757 [inline]
pc : __free_pages+0xc0/0x168 mm/page_alloc.c:5640
lr : put_page_testzero include/linux/mm.h:757 [inline]
lr : __free_pages+0xc0/0x168 mm/page_alloc.c:5640
sp : ffff800012dcbb70
x29: ffff800012dcbb70 x28: ffff0000c4169a40 x27: 0000000000000000
x26: 00000000000000c0 x25: 0000000000000002 x24: ffff0000eccb8800
x23: ffff80000d5d8000 x22: 0000000000000000 x21: fffffffffffff000
x20: 0000000000000000 x19: fffffc0004768200 x18: 00000000000001ba
x17: 3030303030303030 x16: ffff80000dc18158 x15: ffff0000c4169a40
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c4169a40
x11: ff808000081c4d40 x10: 0000000000000000 x9 : 0db713de61b9aa00
x8 : 0db713de61b9aa00 x7 : ffff80000c0b1cb4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 000000000000003e
Call trace:
 put_page_testzero include/linux/mm.h:757 [inline]
 __free_pages+0xc0/0x168 mm/page_alloc.c:5640
 free_large_kmalloc+0xac/0x144 mm/slab_common.c:932
 kfree+0xb8/0x118 mm/slab_common.c:1001
 diUnmount+0x74/0x8c fs/jfs/jfs_imap.c:195
 jfs_umount+0x94/0x190 fs/jfs/jfs_umount.c:63
 jfs_put_super+0x6c/0x104 fs/jfs/super.c:194
 generic_shutdown_super+0x94/0x198 fs/super.c:492
 kill_block_super+0x30/0x78 fs/super.c:1428
 deactivate_locked_super+0x70/0xe8 fs/super.c:332
 deactivate_super+0xd0/0xd4 fs/super.c:363
 cleanup_mnt+0x184/0x1c0 fs/namespace.c:1186
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1193
 task_work_run+0x100/0x148 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 do_notify_resume+0x174/0x1f0 arch/arm64/kernel/signal.c:1127
 prepare_exit_to_user_mode arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:142 [inline]
 el0_svc+0x9c/0x150 arch/arm64/kernel/entry-common.c:638
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d0023861 91245021 aa1303e0 97fe88b8 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
