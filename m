Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9361960393C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiJSF3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJSF3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:29:49 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4272A22BD6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:29:47 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id n14-20020a056e02100e00b002f9e283e850so14949238ilj.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9NUwqpIdBttTPj8K9pQIi/NNyR2At6DBFKWl3s/Tb4=;
        b=KIsw3iID6Y0TVsWS5AvP23+uUPwU6QLIxm5Pz9ZVvDlv8ytXi41jlYdNmF9NOC6H5X
         Odm+POiJjRXkjH+bXeWUKCXSveL4VrQIPOg2Lw+/xs1Ypw/2FaMIqjMIYC6A9ENOiHwP
         YnmR9WsLffeaWDB3fw2NMaS8YpeTzElG1IUmJ3WjxoSJI7oRrWEC4TIDAUYdfB4U0lto
         Q7r1Mc6BDEFrY8AFjwLkUbIdwD3DMVdB+JprA1s+bxgX2HMqtJqZVlFWWAP8bbiDJqQW
         3WSmOwBxWqjY7uOjG1dFBvMHy9sARnSv8wV2S/ooVun9JYMOimAjzseERquDJ/D/LKZR
         oFSw==
X-Gm-Message-State: ACrzQf1vplDKmzmyA1wDmD2os40TLlwCu/EX10PF43QxEx6MXieNMSK7
        vqsUhUkwkhzWxdf5mk+mOgvdpQCbHLEdZCMFUVoEYo2LB64e
X-Google-Smtp-Source: AMsMyM5xzBR1WblA0XzGk+3WTikONBzPm7AlPYDrKdBgMKN98Nkpd06xpF/KTihpS3p5Z9Bjx1gloSY98RDuo80aSh3NH5cPiKFm
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:2fc:1a4f:bfb with SMTP id
 h14-20020a92c26e000000b002fc1a4f0bfbmr4003527ild.58.1666157386556; Tue, 18
 Oct 2022 22:29:46 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:29:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002a6cba05eb5c7fbd@google.com>
Subject: [syzbot] possible deadlock in map_mft_record
From:   syzbot <syzbot+cb1fdea540b46f0ce394@syzkaller.appspotmail.com>
To:     anton@tuxera.com, linux-kernel@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17c6e19a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=cb1fdea540b46f0ce394
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb1fdea540b46f0ce394@syzkaller.appspotmail.com

ntfs: (device loop3): is_boot_sector_ntfs(): Invalid boot sector checksum.
ntfs: volume version 3.1.
======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.3/9828 is trying to acquire lock:
ffff00010ca1f5d0 (&ni->mrec_lock){+.+.}-{3:3}, at: map_mft_record+0x40/0xfc fs/ntfs/mft.c:154

but task is already holding lock:
ffff00010ca1f540 (&rl->lock){++++}-{3:3}, at: ntfs_truncate+0xa8/0xf6c fs/ntfs/inode.c:2371

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rl->lock){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       ntfs_read_block+0x2d0/0x1110 fs/ntfs/aops.c:248
       ntfs_read_folio+0x594/0x758 fs/ntfs/aops.c:436
       filemap_read_folio+0x68/0x33c mm/filemap.c:2394
       do_read_cache_folio+0x1c8/0x588 mm/filemap.c:3519
       do_read_cache_page mm/filemap.c:3561 [inline]
       read_cache_page+0x40/0x178 mm/filemap.c:3570
       read_mapping_page include/linux/pagemap.h:756 [inline]
       ntfs_map_page fs/ntfs/aops.h:75 [inline]
       ntfs_sync_mft_mirror+0xb4/0x109c fs/ntfs/mft.c:480
       write_mft_record_nolock+0x814/0xc70 fs/ntfs/mft.c:787
       write_mft_record+0xe4/0x230 fs/ntfs/mft.h:95
       __ntfs_write_inode+0x32c/0x554 fs/ntfs/inode.c:3043
       ntfs_write_inode+0x3c/0x4c fs/ntfs/super.c:2655
       write_inode fs/fs-writeback.c:1440 [inline]
       __writeback_single_inode+0x240/0x2e4 fs/fs-writeback.c:1652
       writeback_sb_inodes+0x3e4/0x85c fs/fs-writeback.c:1865
       wb_writeback+0x198/0x328 fs/fs-writeback.c:2039
       wb_do_writeback+0xc8/0x384 fs/fs-writeback.c:2182
       wb_workfn+0x70/0x15c fs/fs-writeback.c:2222
       process_one_work+0x2d8/0x504 kernel/workqueue.c:2289
       worker_thread+0x340/0x610 kernel/workqueue.c:2436
       kthread+0x12c/0x158 kernel/kthread.c:376
       ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

-> #0 (&ni->mrec_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       map_mft_record+0x40/0xfc fs/ntfs/mft.c:154
       ntfs_truncate+0xd8/0xf6c fs/ntfs/inode.c:2376
       ntfs_truncate_vfs fs/ntfs/inode.c:2855 [inline]
       ntfs_setattr+0x1ac/0x228 fs/ntfs/inode.c:2907
       notify_change+0x758/0x7f0 fs/attr.c:420
       do_truncate+0x108/0x150 fs/open.c:65
       vfs_truncate+0x1dc/0x24c fs/open.c:111
       do_sys_truncate+0x94/0x140 fs/open.c:134
       __do_sys_truncate fs/open.c:146 [inline]
       __se_sys_truncate fs/open.c:144 [inline]
       __arm64_sys_truncate+0x20/0x30 fs/open.c:144
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rl->lock);
                               lock(&ni->mrec_lock);
                               lock(&rl->lock);
  lock(&ni->mrec_lock);

 *** DEADLOCK ***

3 locks held by syz-executor.3/9828:
 #0: ffff0001067af460 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff00010ca1f8b0 (&sb->s_type->i_mutex_key#32){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff00010ca1f8b0 (&sb->s_type->i_mutex_key#32){+.+.}-{3:3}, at: do_truncate+0xf4/0x150 fs/open.c:63
 #2: ffff00010ca1f540 (&rl->lock){++++}-{3:3}, at: ntfs_truncate+0xa8/0xf6c fs/ntfs/inode.c:2371

stack backtrace:
CPU: 1 PID: 9828 Comm: syz-executor.3 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 map_mft_record+0x40/0xfc fs/ntfs/mft.c:154
 ntfs_truncate+0xd8/0xf6c fs/ntfs/inode.c:2376
 ntfs_truncate_vfs fs/ntfs/inode.c:2855 [inline]
 ntfs_setattr+0x1ac/0x228 fs/ntfs/inode.c:2907
 notify_change+0x758/0x7f0 fs/attr.c:420
 do_truncate+0x108/0x150 fs/open.c:65
 vfs_truncate+0x1dc/0x24c fs/open.c:111
 do_sys_truncate+0x94/0x140 fs/open.c:134
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __arm64_sys_truncate+0x20/0x30 fs/open.c:144
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
