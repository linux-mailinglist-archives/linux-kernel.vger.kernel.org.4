Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90FB0649925
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 08:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiLLHDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 02:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiLLHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 02:03:04 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584920D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:03 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso5798969ioh.22
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 23:03:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pRxe8xcGVdH/WupVjdusylJxDyL2uy8nmSKsprdS8g=;
        b=l0BsBiGRneNC99Jk0FYRNBMj4f9cdshmtRjzqhPAxzGDZQgo5xEALDnCz+rHJjEOsj
         zTI57V20gjI6oTyKnNnj/yFaJ3TIXDOtqAjyMAShzPhWyHjEiot8sDqvfcbPiBrx3knd
         vejVN9C8f+4TEu4C0IQOFo/roPhPGdmU5AavzkXUaUp5pCuB++7wl57JbC6INIXXuTp2
         Iz//Fz9QYd5gbRbdDmeEVRN9mRwZRsdD0T84Fl+ac0uVPBEQKCw5wMIV1efSBlcRBIWE
         nSfM5aQtGVv26/sHCvZ2T2XSzWXVYc/zrTsD7HL6Zq6yRNpVVVjpAb3sIKU/ArB1rDTU
         Vhng==
X-Gm-Message-State: ANoB5pkp3NQ/k8VMO0RH6rQSVjJA/fyQfTI2GDjbzhLTtF0PMmX6ER/R
        KzU0lo3nTOeuALoZYB9QOPvnLOoBTqgg29Gr4rajjo8KRo+y
X-Google-Smtp-Source: AA0mqf5ocQ6LCSq9AEL78yKX4L9ZLbLE2Nd320kFza0By6V8AFx8E6kWiL9tcUBasx22xuVfo3B9c2g3xGAn93bQvF+mHXI8T6oY
MIME-Version: 1.0
X-Received: by 2002:a02:5442:0:b0:389:d81a:1d80 with SMTP id
 t63-20020a025442000000b00389d81a1d80mr24546860jaa.80.1670828583189; Sun, 11
 Dec 2022 23:03:03 -0800 (PST)
Date:   Sun, 11 Dec 2022 23:03:03 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002e833305ef9c18a3@google.com>
Subject: [syzbot] INFO: trying to register non-static key in xfs_buf_delwri_submit_buffers
From:   syzbot <syzbot+11d99e499adff05631cc@syzkaller.appspotmail.com>
To:     djwong@kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=126cf0cd880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=11d99e499adff05631cc
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11918e67880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=116013db880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/afae3f863cb9/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11d99e499adff05631cc@syzkaller.appspotmail.com

XFS (loop1): Quotacheck: Done.
syz-executor383 (9789): drop_caches: 2
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 9789 Comm: syz-executor383 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:981
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1294
 __lock_acquire+0xa8/0x3084 kernel/locking/lockdep.c:4934
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
 down+0x2c/0x68 kernel/locking/semaphore.c:59
 xfs_buf_lock fs/xfs/xfs_buf.c:1120 [inline]
 xfs_buf_delwri_submit_buffers+0x15c/0x394 fs/xfs/xfs_buf.c:2164
 xfs_buf_delwri_submit+0x4c/0x160 fs/xfs/xfs_buf.c:2242
 xfs_qm_shrink_scan+0x94/0x174 fs/xfs/xfs_qm.c:514
 do_shrink_slab+0x240/0x55c mm/vmscan.c:842
 shrink_slab+0xe4/0x1b8 mm/vmscan.c:1002
 drop_slab_node mm/vmscan.c:1037 [inline]
 drop_slab+0xc8/0x19c mm/vmscan.c:1047
 drop_caches_sysctl_handler+0x130/0x22c fs/drop_caches.c:66
 proc_sys_call_handler+0x240/0x3d8 fs/proc/proc_sysctl.c:604
 proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:630
 do_iter_write+0x318/0x560 fs/read_write.c:861
 vfs_iter_write+0x4c/0x6c fs/read_write.c:902
 iter_file_splice_write+0x2a8/0x518 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x4c/0xe0 fs/splice.c:931
 splice_direct_to_actor+0x1dc/0x3e4 fs/splice.c:886
 do_splice_direct+0xc4/0x14c fs/splice.c:974
 do_sendfile+0x298/0x68c fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __arm64_sys_sendfile64+0x14c/0x230 fs/read_write.c:1309
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
list_add corruption. prev is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:24!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 9789 Comm: syz-executor383 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0x78/0xb8 lib/list_debug.c:23
lr : __list_add_valid+0x78/0xb8 lib/list_debug.c:23
sp : ffff80001795b5b0
x29: ffff80001795b5b0 x28: ffff8000178c3aa8 x27: 0000000000000003
x26: 0000000000000000 x25: ffff800008e51208 x24: ffff80001795b5c8
x23: ffff8000178c39f0 x22: 0000000000000000 x21: 7fffffffffffffff
x20: ffff8000178c39a8 x19: 0000000000000002 x18: 00000000000002d4
x17: 6e69676e45206574 x16: 0000000000000002 x15: 0000000000000000
x14: 0000000000000000 x13: 205d393837395420 x12: 5b5d353332323338
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 73a8e374c5aaba00
x8 : 73a8e374c5aaba00 x7 : 205b5d3533323233 x6 : ffff80000c091ebc
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000022
Call trace:
 __list_add_valid+0x78/0xb8 lib/list_debug.c:23
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 ___down_common+0x5c/0x17c kernel/locking/semaphore.c:214
 __down_common kernel/locking/semaphore.c:246 [inline]
 __down+0x28/0x44 kernel/locking/semaphore.c:254
 down+0x64/0x68 kernel/locking/semaphore.c:63
 xfs_buf_lock fs/xfs/xfs_buf.c:1120 [inline]
 xfs_buf_delwri_submit_buffers+0x15c/0x394 fs/xfs/xfs_buf.c:2164
 xfs_buf_delwri_submit+0x4c/0x160 fs/xfs/xfs_buf.c:2242
 xfs_qm_shrink_scan+0x94/0x174 fs/xfs/xfs_qm.c:514
 do_shrink_slab+0x240/0x55c mm/vmscan.c:842
 shrink_slab+0xe4/0x1b8 mm/vmscan.c:1002
 drop_slab_node mm/vmscan.c:1037 [inline]
 drop_slab+0xc8/0x19c mm/vmscan.c:1047
 drop_caches_sysctl_handler+0x130/0x22c fs/drop_caches.c:66
 proc_sys_call_handler+0x240/0x3d8 fs/proc/proc_sysctl.c:604
 proc_sys_write+0x2c/0x3c fs/proc/proc_sysctl.c:630
 do_iter_write+0x318/0x560 fs/read_write.c:861
 vfs_iter_write+0x4c/0x6c fs/read_write.c:902
 iter_file_splice_write+0x2a8/0x518 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x4c/0xe0 fs/splice.c:931
 splice_direct_to_actor+0x1dc/0x3e4 fs/splice.c:886
 do_splice_direct+0xc4/0x14c fs/splice.c:974
 do_sendfile+0x298/0x68c fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1317 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __arm64_sys_sendfile64+0x14c/0x230 fs/read_write.c:1309
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: d4210000 9001b740 913c9c00 94aa8a26 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
