Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6B65C01F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237521AbjACMqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbjACMp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:45:56 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7828E397
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:45:51 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id h24-20020a056e021d9800b0030be8a5dd68so17936603ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:45:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8MynO4leFA2w1GPk1xqqPyeqjfOjx4gAYINSVbjhYAM=;
        b=uxIvyE/nnaDcOt62BxRZSKUkNtldtC+MrVeTxQGj7AbLTd6UiiqfNTVkj0cHktenBY
         iqXaGk5gMAxnlOQi3/Ye8ByqvGo2j+lBHCI4pU6dWnSNm1spQmumvroSKIon/y1NE/yz
         W4rayGLtLIcne9bPU9fyNN2ctjlaIDIeoKrxVTIIOBIrd0db5bKaSaAYYUMLlZS040Cd
         wJ98KA7AQ5dGhzZ3DXZ+EevIl1jZ8fbCkTmcKgSNHCf1TvbuIGPf5tlZrltZ2nOC72nB
         54zQ59cSuO4rUPUMwtd3tWN30tfsmlvWzwWeDKyeMUmQz3k+8fjunY6zaCS/PHnrzM7X
         Z2Tg==
X-Gm-Message-State: AFqh2kqTOEJWkAIKK5hEEPMY/qH1vs8iV/MfYXg/UTpIm/V/KSWoTA3V
        iIO1p3zSD5TWXMyEUswaZS6kTfCRTniEkWVlM3Pdvsaw1sOA
X-Google-Smtp-Source: AMrXdXvv8lzplegQVVEUG26Ou9yTdSFrFpt8PznM38pG9PwEleavOKPYN1GQaOukHlroxx3nfxqj+NaMePr3+iUsxTVG2h5z8K94
MIME-Version: 1.0
X-Received: by 2002:a92:d0c:0:b0:30b:f63e:306e with SMTP id
 12-20020a920d0c000000b0030bf63e306emr3429955iln.137.1672749950813; Tue, 03
 Jan 2023 04:45:50 -0800 (PST)
Date:   Tue, 03 Jan 2023 04:45:50 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009dceeb05f15b726e@google.com>
Subject: [syzbot] [ntfs3?] possible deadlock in ntfs_mark_rec_free
From:   syzbot <syzbot+f83f0dbef763c426e3cf@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    69b41ac87e4a Merge tag 'for-6.2-rc2-tag' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d88034480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=affadc28955d87c3
dashboard link: https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f83f0dbef763c426e3cf@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.2.0-rc2-syzkaller-00010-g69b41ac87e4a #0 Not tainted
------------------------------------------------------
kworker/u17:4/9698 is trying to acquire lock:
ffff888073da4120 (&wnd->rw_lock/1){+.+.}-{3:3}, at: ntfs_mark_rec_free+0x229/0x310 fs/ntfs3/fsntfs.c:741

but task is already holding lock:
ffff8880765ba920 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1142 [inline]
ffff8880765ba920 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x1c2/0x3120 fs/ntfs3/frecord.c:3255

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&ni->ni_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:603 [inline]
       __mutex_lock+0x12f/0x1360 kernel/locking/mutex.c:747
       ntfs_set_state fs/ntfs3/fsntfs.c:946 [inline]
       ntfs_set_state+0x1d5/0x6b0 fs/ntfs3/fsntfs.c:921
       attr_set_size+0x134e/0x2ac0 fs/ntfs3/attrib.c:867
       ntfs_extend_mft+0x296/0x430 fs/ntfs3/fsntfs.c:526
       ntfs_look_free_mft+0x548/0xe60 fs/ntfs3/fsntfs.c:589
       ni_create_attr_list+0xbce/0x12b0 fs/ntfs3/frecord.c:873
       ni_ins_attr_ext+0x3ca/0xba0 fs/ntfs3/frecord.c:968
       ni_insert_attr+0x3ee/0x850 fs/ntfs3/frecord.c:1135
       ni_insert_resident+0xd9/0x3a0 fs/ntfs3/frecord.c:1519
       ntfs_set_ea+0xa28/0x1310 fs/ntfs3/xattr.c:432
       ntfs_save_wsl_perm+0x123/0x3b0 fs/ntfs3/xattr.c:962
       ntfs3_setattr+0xb07/0xd30 fs/ntfs3/file.c:722
       notify_change+0xca7/0x1420 fs/attr.c:482
       chown_common+0x60a/0x6f0 fs/open.c:736
       do_fchownat+0x12a/0x1e0 fs/open.c:767
       __do_sys_fchownat fs/open.c:782 [inline]
       __se_sys_fchownat fs/open.c:779 [inline]
       __x64_sys_fchownat+0xbe/0x160 fs/open.c:779
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&ni->file.run_lock#2){++++}-{3:3}:
       down_write+0x94/0x220 kernel/locking/rwsem.c:1562
       ntfs_extend_mft+0x127/0x430 fs/ntfs3/fsntfs.c:510
       ntfs_look_free_mft+0x548/0xe60 fs/ntfs3/fsntfs.c:589
       ni_create_attr_list+0xbce/0x12b0 fs/ntfs3/frecord.c:873
       ni_ins_attr_ext+0x3ca/0xba0 fs/ntfs3/frecord.c:968
       ni_insert_attr+0x3ee/0x850 fs/ntfs3/frecord.c:1135
       ni_insert_resident+0xd9/0x3a0 fs/ntfs3/frecord.c:1519
       ntfs_set_ea+0xa28/0x1310 fs/ntfs3/xattr.c:432
       ntfs_save_wsl_perm+0x123/0x3b0 fs/ntfs3/xattr.c:962
       ntfs3_setattr+0xb07/0xd30 fs/ntfs3/file.c:722
       notify_change+0xca7/0x1420 fs/attr.c:482
       chown_common+0x60a/0x6f0 fs/open.c:736
       do_fchownat+0x12a/0x1e0 fs/open.c:767
       __do_sys_fchownat fs/open.c:782 [inline]
       __se_sys_fchownat fs/open.c:779 [inline]
       __x64_sys_fchownat+0xbe/0x160 fs/open.c:779
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&wnd->rw_lock/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain kernel/locking/lockdep.c:3831 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
       lock_acquire kernel/locking/lockdep.c:5668 [inline]
       lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
       down_write_nested+0x98/0x220 kernel/locking/rwsem.c:1672
       ntfs_mark_rec_free+0x229/0x310 fs/ntfs3/fsntfs.c:741
       ni_write_inode+0x10a8/0x3120 fs/ntfs3/frecord.c:3348
       write_inode fs/fs-writeback.c:1451 [inline]
       __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1663
       writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1889
       wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2063
       wb_do_writeback fs/fs-writeback.c:2206 [inline]
       wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2246
       process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
       worker_thread+0x669/0x1090 kernel/workqueue.c:2436
       kthread+0x2e8/0x3a0 kernel/kthread.c:376
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

other info that might help us debug this:

Chain exists of:
  &wnd->rw_lock/1 --> &ni->file.run_lock#2 --> &ni->ni_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ni->ni_lock);
                               lock(&ni->file.run_lock#2);
                               lock(&ni->ni_lock);
  lock(&wnd->rw_lock/1);

 *** DEADLOCK ***

3 locks held by kworker/u17:4/9698:
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888042906938 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90003917da8 ((work_completion)(&(&wb->dwork)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff8880765ba920 (&ni->ni_lock){+.+.}-{3:3}, at: ni_trylock fs/ntfs3/ntfs_fs.h:1142 [inline]
 #2: ffff8880765ba920 (&ni->ni_lock){+.+.}-{3:3}, at: ni_write_inode+0x1c2/0x3120 fs/ntfs3/frecord.c:3255

stack backtrace:
CPU: 2 PID: 9698 Comm: kworker/u17:4 Not tainted 6.2.0-rc2-syzkaller-00010-g69b41ac87e4a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: writeback wb_workfn (flush-7:2)
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain kernel/locking/lockdep.c:3831 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5055
 lock_acquire kernel/locking/lockdep.c:5668 [inline]
 lock_acquire+0x1e3/0x630 kernel/locking/lockdep.c:5633
 down_write_nested+0x98/0x220 kernel/locking/rwsem.c:1672
 ntfs_mark_rec_free+0x229/0x310 fs/ntfs3/fsntfs.c:741
 ni_write_inode+0x10a8/0x3120 fs/ntfs3/frecord.c:3348
 write_inode fs/fs-writeback.c:1451 [inline]
 __writeback_single_inode+0xcfc/0x1440 fs/fs-writeback.c:1663
 writeback_sb_inodes+0x54d/0xf90 fs/fs-writeback.c:1889
 wb_writeback+0x2c5/0xd70 fs/fs-writeback.c:2063
 wb_do_writeback fs/fs-writeback.c:2206 [inline]
 wb_workfn+0x2e0/0x12f0 fs/fs-writeback.c:2246
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
