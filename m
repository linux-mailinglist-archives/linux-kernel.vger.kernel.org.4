Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEDF647FA7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 09:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLII5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 03:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiLII5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 03:57:46 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603913DD8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 00:57:44 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id z9-20020a6be009000000b006e0577c3686so1788797iog.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 00:57:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8N5uA/S0DpG25/Y8QsbGP2w+sYQpSLnGRWahlvUerdw=;
        b=NWTMZWmXwaK5Z83YqNOw7luG8J2hPwXfx3V5MicKvnh71nOUfma7jG6ZqZ4P+j/1u3
         f8lgSu8wpxGdt7Y6fIgMo6w7w0H5JAeWiA1iPPYJQoSWnBHtTzG0gZvwWkcInrdovbEO
         EP4ueBH0eEhpcVCbDpa+bwoUvwhWeqC5VF1zdC1C4HQTD9bhRH2JFD7tnPMXli4NAG0t
         TiURcD7D57FNz3pC2IlmNML6525OGQCnpd9oCB/Qkm6jA4+lgz19tOWjaBwHT0CwhrMz
         QXaLtmZz4eD6EB9X/RAwr3yH0V02J1g312pHKgy2Rgpgcel5NQTSw+LEtdM1I1aoq0/O
         asKw==
X-Gm-Message-State: ANoB5pkm6b6veEHbLcJHRYYRTEHrIB8i7RQFcb/V8NogFS65aThnk8Q+
        OaQcycWNEBtngL2xpmQzR+laztrMfZLIVzsqPTdxkOcfXxiZ
X-Google-Smtp-Source: AA0mqf5cNz/uScMtPhZKIfmabh7C5f/fPWhTo2csXvp0tF2fdgji3oP+/VN+auo/xJE0g4PYFT+IRNFsGtwagRzu/iW1YqiVzomt
MIME-Version: 1.0
X-Received: by 2002:a02:c80c:0:b0:38a:159d:d7de with SMTP id
 p12-20020a02c80c000000b0038a159dd7demr14837492jao.290.1670576264120; Fri, 09
 Dec 2022 00:57:44 -0800 (PST)
Date:   Fri, 09 Dec 2022 00:57:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb121205ef615844@google.com>
Subject: [syzbot] possible deadlock in ntfs_fallocate
From:   syzbot <syzbot+adacb2b0c896bc427962@syzkaller.appspotmail.com>
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

HEAD commit:    f3e8416619ce Merge tag 'soc-fixes-6.1-5' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ab680b880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d58e7fe7f9cf5e24
dashboard link: https://syzkaller.appspot.com/bug?extid=adacb2b0c896bc427962
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/628abc27cbe7/disk-f3e84166.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2f19ea836174/vmlinux-f3e84166.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2e1347e85a5/bzImage-f3e84166.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adacb2b0c896bc427962@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0 Not tainted
------------------------------------------------------
syz-executor.2/8526 is trying to acquire lock:
ffff88803100bc00 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
ffff88803100bc00 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_fallocate+0x83f/0xfb0 fs/ntfs3/file.c:666

but task is already holding lock:
ffff88803100c040 (mapping.invalidate_lock#4){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:801 [inline]
ffff88803100c040 (mapping.invalidate_lock#4){++++}-{3:3}, at: ntfs_fallocate+0x38a/0xfb0 fs/ntfs3/file.c:583

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (mapping.invalidate_lock#4){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_read+0x39/0x50 kernel/locking/rwsem.c:1509
       filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
       filemap_fault+0x2fb/0x1060 mm/filemap.c:3127
       __do_fault+0x136/0x4f0 mm/memory.c:4202
       do_shared_fault mm/memory.c:4608 [inline]
       do_fault mm/memory.c:4686 [inline]
       handle_pte_fault mm/memory.c:4954 [inline]
       __handle_mm_fault mm/memory.c:5096 [inline]
       handle_mm_fault+0x1bca/0x3630 mm/memory.c:5217
       faultin_page mm/gup.c:1009 [inline]
       __get_user_pages+0x4db/0x1200 mm/gup.c:1230
       __get_user_pages_locked mm/gup.c:1434 [inline]
       get_user_pages_unlocked+0x568/0x890 mm/gup.c:2343
       __gup_longterm_unlocked+0x48/0x140 mm/gup.c:2954
       internal_get_user_pages_fast+0xcf4/0xee0 mm/gup.c:3044
       __iov_iter_get_pages_alloc+0x3b4/0xa90 lib/iov_iter.c:1460
       iov_iter_get_pages2+0xcb/0x120 lib/iov_iter.c:1503
       dio_refill_pages+0x8d/0x580 fs/direct-io.c:172
       dio_get_page fs/direct-io.c:215 [inline]
       do_direct_IO fs/direct-io.c:932 [inline]
       __blockdev_direct_IO+0x1230/0x3c90 fs/direct-io.c:1266
       blockdev_direct_IO include/linux/fs.h:3222 [inline]
       ntfs_direct_IO+0x1a6/0x360 fs/ntfs3/inode.c:769
       generic_file_read_iter+0x330/0x540 mm/filemap.c:2798
       do_iter_read+0x6e3/0xc10 fs/read_write.c:796
       vfs_readv fs/read_write.c:916 [inline]
       do_preadv+0x1f4/0x330 fs/read_write.c:1008
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #2 (&mm->mmap_lock#2){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __might_fault+0xb2/0x110 mm/memory.c:5645
       _copy_to_user+0x26/0x130 lib/usercopy.c:29
       copy_to_user include/linux/uaccess.h:169 [inline]
       fiemap_fill_next_extent+0x22e/0x410 fs/ioctl.c:144
       ni_fiemap+0x950/0x1130 fs/ntfs3/frecord.c:2030
       ntfs_fiemap+0x134/0x180 fs/ntfs3/file.c:1245
       ioctl_fiemap fs/ioctl.c:219 [inline]
       do_vfs_ioctl+0x187f/0x29a0 fs/ioctl.c:810
       __do_sys_ioctl fs/ioctl.c:868 [inline]
       __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&ni->file.run_lock#3){++++}-{3:3}:
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       down_write+0x9c/0x270 kernel/locking/rwsem.c:1562
       ntfs_truncate fs/ntfs3/file.c:493 [inline]
       ntfs3_setattr+0x504/0xb00 fs/ntfs3/file.c:792
       notify_change+0xe38/0x10f0 fs/attr.c:420
       do_truncate+0x1fb/0x2e0 fs/open.c:65
       handle_truncate fs/namei.c:3216 [inline]
       do_open fs/namei.c:3561 [inline]
       path_openat+0x2770/0x2df0 fs/namei.c:3714
       do_filp_open+0x264/0x4f0 fs/namei.c:3741
       do_sys_openat2+0x124/0x4e0 fs/open.c:1310
       do_sys_open fs/open.c:1326 [inline]
       __do_sys_creat fs/open.c:1402 [inline]
       __se_sys_creat fs/open.c:1396 [inline]
       __x64_sys_creat+0x11f/0x160 fs/open.c:1396
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&ni->ni_lock/4){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3097 [inline]
       check_prevs_add kernel/locking/lockdep.c:3216 [inline]
       validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
       __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
       lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
       __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
       ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
       ntfs_fallocate+0x83f/0xfb0 fs/ntfs3/file.c:666
       vfs_fallocate+0x515/0x670 fs/open.c:323
       ksys_fallocate fs/open.c:346 [inline]
       __do_sys_fallocate fs/open.c:354 [inline]
       __se_sys_fallocate fs/open.c:352 [inline]
       __x64_sys_fallocate+0xb9/0x100 fs/open.c:352
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &ni->ni_lock/4 --> &mm->mmap_lock#2 --> mapping.invalidate_lock#4

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(mapping.invalidate_lock#4);
                               lock(&mm->mmap_lock#2);
                               lock(mapping.invalidate_lock#4);
  lock(&ni->ni_lock/4);

 *** DEADLOCK ***

3 locks held by syz-executor.2/8526:
 #0: ffff888022762460 (sb_writers#13){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2944 [inline]
 #0: ffff888022762460 (sb_writers#13){.+.+}-{0:0}, at: vfs_fallocate+0x489/0x670 fs/open.c:322
 #1: ffff88803100bea0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88803100bea0 (&sb->s_type->i_mutex_key#21){+.+.}-{3:3}, at: ntfs_fallocate+0x2d4/0xfb0 fs/ntfs3/file.c:569
 #2: ffff88803100c040 (mapping.invalidate_lock#4){++++}-{3:3}, at: filemap_invalidate_lock include/linux/fs.h:801 [inline]
 #2: ffff88803100c040 (mapping.invalidate_lock#4){++++}-{3:3}, at: ntfs_fallocate+0x38a/0xfb0 fs/ntfs3/file.c:583

stack backtrace:
CPU: 1 PID: 8526 Comm: syz-executor.2 Not tainted 6.1.0-rc8-syzkaller-00035-gf3e8416619ce #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2177
 check_prev_add kernel/locking/lockdep.c:3097 [inline]
 check_prevs_add kernel/locking/lockdep.c:3216 [inline]
 validate_chain+0x1898/0x6ae0 kernel/locking/lockdep.c:3831
 __lock_acquire+0x1292/0x1f60 kernel/locking/lockdep.c:5055
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 __mutex_lock_common+0x1bd/0x26e0 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1108 [inline]
 ntfs_fallocate+0x83f/0xfb0 fs/ntfs3/file.c:666
 vfs_fallocate+0x515/0x670 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0xb9/0x100 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3b4288c0d9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3b435fd168 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007f3b429ac050 RCX: 00007f3b4288c0d9
RDX: 0000000000000000 RSI: 0000000000000020 RDI: 0000000000000004
RBP: 00007f3b428e7ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000020000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe40f08bef R14: 00007f3b435fd300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
