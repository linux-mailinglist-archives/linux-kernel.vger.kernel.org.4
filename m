Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1E165BFB1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237343AbjACMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjACMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:13:45 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF931005
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:13:44 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id e9-20020a056e020b2900b003036757d5caso19309595ilu.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:13:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eyFfBghNmCNohuQgi0p9x+tyF3wB+UXjN3PPo7fNH6Y=;
        b=t+rpFlt668DGi9qpzYteUufIwWEjScN3bLSW0eZ/IVgvmy6ky1b3evAx7IqUGOQqhr
         pboIHCBI/skT/tR+DB/Ex6KxumtLdUKAm93fIO/H67JEVPHOS5jJnHfpiKi2rMOJkyvt
         vRZIoYCXdWlOKxYqg3gTXQNCu5YBPIiqptXQWZXzg6B6LKvRu8Cc4IabmFy7zANp1Fnh
         lQgTGM425KS1vvaQ2yJvUm6AbH2a42SCq1yBNvP8pQMGslWZ16GW+8hxUzhAW/g0zYgC
         RuSVnm7r40KtF8pKUCyqlxnk/QYn8grhanHa4WH6D5IxKAb/geWMnhPqXqjfqrcIO0i6
         st5g==
X-Gm-Message-State: AFqh2kr8hC3+RF1Dn46KNhMIpwZVQF+XK6mICIP8GF6x4uiQ+Ie2EnEE
        CIGN4RI9JCDIpAKPzYKgQI93n+981pyyHcjCeUx8hjXHtiQH
X-Google-Smtp-Source: AMrXdXuDsBAA0yBj17SvetkfjdsUCkvKGhqHIz/2Hh45gO952qewy8LRA8J8UpAGL67J7ZHXX7/v0hIR4pAFS9l3lOTSTIfU9Zvq
MIME-Version: 1.0
X-Received: by 2002:a92:c052:0:b0:30c:1693:594b with SMTP id
 o18-20020a92c052000000b0030c1693594bmr1687564ilf.210.1672748023758; Tue, 03
 Jan 2023 04:13:43 -0800 (PST)
Date:   Tue, 03 Jan 2023 04:13:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c146a005f15aff1b@google.com>
Subject: [syzbot] [ntfs?] possible deadlock in __ntfs_cluster_free
From:   syzbot <syzbot+6a2409526a801cf8c0ef@syzkaller.appspotmail.com>
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

HEAD commit:    2258c2dc850b Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1543182a480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=6a2409526a801cf8c0ef
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/aee4b2292a64/disk-2258c2dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ecfc816182c/vmlinux-2258c2dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f24ffaf1255a/bzImage-2258c2dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6a2409526a801cf8c0ef@syzkaller.appspotmail.com

ntfs: volume version 3.1.
======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc1-syzkaller-00043-g2258c2dc850b #0 Not tainted
------------------------------------------------------
syz-executor.3/28063 is trying to acquire lock:
ffff88801e35d9f8 (&vol->lcnbmp_lock){+.+.}-{3:3}, at: __ntfs_cluster_free+0xd4/0x890 fs/ntfs/lcnalloc.c:862

but task is already holding lock:
ffff888039ccc390 (&lcnbmp_mrec_lock_key){+.+.}-{3:3}, at: map_mft_record+0x46/0x610 fs/ntfs/mft.c:154

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&lcnbmp_mrec_lock_key){+.+.}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       map_mft_record+0x46/0x610 fs/ntfs/mft.c:154
       __ntfs_write_inode+0x80/0xc90 fs/ntfs/inode.c:2978
       ntfs_commit_inode fs/ntfs/inode.h:300 [inline]
       ntfs_put_super+0x3ba/0xf80 fs/ntfs/super.c:2283
       generic_shutdown_super+0x130/0x310 fs/super.c:492
       kill_block_super+0x79/0xd0 fs/super.c:1386
       deactivate_locked_super+0xa7/0xf0 fs/super.c:332
       cleanup_mnt+0x494/0x520 fs/namespace.c:1291
       task_work_run+0x243/0x300 kernel/task_work.c:179
       resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
       exit_to_user_mode_loop+0x124/0x150 kernel/entry/common.c:171
       exit_to_user_mode_prepare+0xb2/0x140 kernel/entry/common.c:203
       __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
       syscall_exit_to_user_mode+0x26/0x60 kernel/entry/common.c:296
       do_syscall_64+0x49/0xb0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&vol->lcnbmp_lock){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       __ntfs_cluster_free+0xd4/0x890 fs/ntfs/lcnalloc.c:862
       ntfs_cluster_free fs/ntfs/lcnalloc.h:96 [inline]
       ntfs_truncate+0x119c/0x2720 fs/ntfs/inode.c:2695
       ntfs_truncate_vfs fs/ntfs/inode.c:2862 [inline]
       ntfs_setattr+0x2b9/0x3a0 fs/ntfs/inode.c:2914
       notify_change+0xe50/0x1100 fs/attr.c:482
       do_truncate+0x200/0x2f0 fs/open.c:65
       handle_truncate fs/namei.c:3216 [inline]
       do_open fs/namei.c:3561 [inline]
       path_openat+0x272b/0x2dd0 fs/namei.c:3714
       do_file_open_root+0x339/0x790 fs/namei.c:3766
       file_open_root+0x234/0x290 fs/open.c:1290
       do_handle_open+0x565/0x950 fs/fhandle.c:232
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lcnbmp_mrec_lock_key);
                               lock(&vol->lcnbmp_lock);
                               lock(&lcnbmp_mrec_lock_key);
  lock(&vol->lcnbmp_lock);

 *** DEADLOCK ***

4 locks held by syz-executor.3/28063:
 #0: ffff888038f60460 (sb_writers#21){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888039ccc670 (&sb->s_type->i_mutex_key#33){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888039ccc670 (&sb->s_type->i_mutex_key#33){+.+.}-{3:3}, at: do_truncate+0x1ec/0x2f0 fs/open.c:63
 #2: ffff888039ccc300 (&lcnbmp_runlist_lock_key){++++}-{3:3}, at: ntfs_truncate+0x1d8/0x2720 fs/ntfs/inode.c:2378
 #3: ffff888039ccc390 (&lcnbmp_mrec_lock_key){+.+.}-{3:3}, at: map_mft_record+0x46/0x610 fs/ntfs/mft.c:154

stack backtrace:
CPU: 0 PID: 28063 Comm: syz-executor.3 Not tainted 6.2.0-rc1-syzkaller-00043-g2258c2dc850b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
 __ntfs_cluster_free+0xd4/0x890 fs/ntfs/lcnalloc.c:862
 ntfs_cluster_free fs/ntfs/lcnalloc.h:96 [inline]
 ntfs_truncate+0x119c/0x2720 fs/ntfs/inode.c:2695
 ntfs_truncate_vfs fs/ntfs/inode.c:2862 [inline]
 ntfs_setattr+0x2b9/0x3a0 fs/ntfs/inode.c:2914
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x200/0x2f0 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x272b/0x2dd0 fs/namei.c:3714
 do_file_open_root+0x339/0x790 fs/namei.c:3766
 file_open_root+0x234/0x290 fs/open.c:1290
 do_handle_open+0x565/0x950 fs/fhandle.c:232
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f169e08c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f169ee1f168 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007f169e1abf80 RCX: 00007f169e08c0a9
RDX: 0000000000000202 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f169e0e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffecb030f6f R14: 00007f169ee1f300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
