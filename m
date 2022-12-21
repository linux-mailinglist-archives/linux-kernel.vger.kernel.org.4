Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00527653171
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 14:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbiLUNMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 08:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUNMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 08:12:39 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54752FCA
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:12:37 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id x10-20020a056e021bca00b00302b6c0a683so10203297ilv.23
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 05:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3KzDwTKvvtB1byU+u7yE9rT5IKKlEhqY016hDUceD0=;
        b=yzdR4rZRhMbBmFXpvSbPmHv+lW4OElyZDooUKfH2v1CW8XSdt3YswmcE82xEOifXd9
         l0BpauTKZc1gPLgkPSNNV6bpkiZVK9gP1mXHMN2zIRCtAtA8Hz1CYFMlRikADgMyx8Z9
         ocvRsfo8G+oPtNQjViJVvwXDZnqGDtgZhuXRMKjym+WHQdGB1DrFL195/1adGMAW8p7r
         s4+SFPqRQGRGDCckdobhjzYXq/b8gOZEJOpGdfU8YX7Txh4qOhlq+XQlyS5iZTGRdvmU
         pyuZtwrehx3aCHeXqaYq/vWlVMWAzJqJn8MphoEW3UKVX7rFbP5uH53P7eTw21Cb0k5L
         +AWg==
X-Gm-Message-State: AFqh2kpMR39NHycUksNcvKAeoVF2+u/OLeUqtewFPW6GDGJJr2DJ8Pc3
        aEDRgaTiTze7mF7B4pkkFUJYp1+rHwDGOwTmeFnGAa42aJqo
X-Google-Smtp-Source: AMrXdXsH1XUX30n4swbgXk5Q7LiZ4AQ7JqrJO+OxVhfXJFdjUNdyWmpMyzZsLmhzaAy3pLqjAw29XsaE9f8j+fcqjsZb7af9uARJ
MIME-Version: 1.0
X-Received: by 2002:a02:b899:0:b0:38a:fdf:fad4 with SMTP id
 p25-20020a02b899000000b0038a0fdffad4mr108012jam.186.1671628356651; Wed, 21
 Dec 2022 05:12:36 -0800 (PST)
Date:   Wed, 21 Dec 2022 05:12:36 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065139305f0564e37@google.com>
Subject: [syzbot] [reiserfs?] INFO: task hung in reiserfs_sync_fs
From:   syzbot <syzbot+4dadbee41d087d9c6234@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    77856d911a8c Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=159ff477880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=334a10f27a9ee2e0
dashboard link: https://syzkaller.appspot.com/bug?extid=4dadbee41d087d9c6234
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1262b2e7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11e552b7880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c104bd9fd890/disk-77856d91.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ab4bff3f176/vmlinux-77856d91.xz
kernel image: https://storage.googleapis.com/syzbot-assets/207eba05f0ef/bzImage-77856d91.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b0b4c97d530b/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dadbee41d087d9c6234@syzkaller.appspotmail.com

INFO: task kworker/0:0:7 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:27608 pid:7     ppid:2      flags:0x00004000
Workqueue: events_long flush_old_commits
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_sync_fs+0x81/0x130 fs/reiserfs/super.c:76
 flush_old_commits+0xfb/0x200 fs/reiserfs/super.c:111
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:0:22 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:28264 pid:22    ppid:2      flags:0x00004000
Workqueue: events_long flush_old_commits
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_sync_fs+0x81/0x130 fs/reiserfs/super.c:76
 flush_old_commits+0xfb/0x200 fs/reiserfs/super.c:111
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:1:26 blocked for more than 143 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:1     state:D stack:28512 pid:26    ppid:2      flags:0x00004000
Workqueue: events_long flush_old_commits
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_sync_fs+0x81/0x130 fs/reiserfs/super.c:76
 flush_old_commits+0xfb/0x200 fs/reiserfs/super.c:111
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task kworker/1:3:2689 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:3     state:D stack:28888 pid:2689  ppid:2      flags:0x00004000
Workqueue: events_long flush_old_commits
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_sync_fs+0x81/0x130 fs/reiserfs/super.c:76
 flush_old_commits+0xfb/0x200 fs/reiserfs/super.c:111
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x669/0x1090 kernel/workqueue.c:2436
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: task syz-executor214:5087 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:24592 pid:5087  ppid:5071   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 rwsem_down_write_slowpath+0x600/0x12e0 kernel/locking/rwsem.c:1190
 __down_write_common kernel/locking/rwsem.c:1305 [inline]
 __down_write_common kernel/locking/rwsem.c:1302 [inline]
 __down_write kernel/locking/rwsem.c:1314 [inline]
 down_write+0x1e8/0x220 kernel/locking/rwsem.c:1563
 inode_lock include/linux/fs.h:756 [inline]
 reiserfs_sync_file+0xab/0x320 fs/reiserfs/file.c:155
 vfs_fsync_range+0x13e/0x230 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2882 [inline]
 generic_file_write_iter+0x25a/0x350 mm/filemap.c:3936
 call_write_iter include/linux/fs.h:2186 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8fc2f12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7a0 RCX: 00007fe8fc345669
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fe8fc3981b8 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7a8
 </TASK>
INFO: task syz-executor214:5098 blocked for more than 144 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:23488 pid:5098  ppid:5071   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_get_block+0x1f6/0x4150 fs/reiserfs/inode.c:680
 do_mpage_readpage+0x765/0x19e0 fs/mpage.c:208
 mpage_readahead+0x344/0x580 fs/mpage.c:361
 read_pages+0x1a2/0xd40 mm/readahead.c:161
 page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
 ondemand_readahead+0x6b3/0x1000 mm/readahead.c:682
 page_cache_sync_ra+0x1c9/0x200 mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 filemap_get_pages+0x2ca/0x16b0 mm/filemap.c:2600
 filemap_read+0x315/0xc00 mm/filemap.c:2694
 generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2840
 __kernel_read+0x2ca/0x7c0 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x195/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x642/0x7b0 security/integrity/ima/ima_api.c:292
 process_measurement+0xd23/0x18b0 security/integrity/ima/ima_main.c:339
 ima_file_check+0xb0/0x100 security/integrity/ima/ima_main.c:519
 do_open fs/namei.c:3559 [inline]
 path_openat+0x15f1/0x2a50 fs/namei.c:3714
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8f42d02f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7b0 RCX: 00007fe8fc345669
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007fe8fc3981b8 R08: 00007fe8f42d0700 R09: 0000000000000000
R10: 00007fe8f42d0700 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7b8
 </TASK>
INFO: task syz-executor214:5103 blocked for more than 145 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:28648 pid:5103  ppid:5071   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 io_schedule+0xbe/0x130 kernel/sched/core.c:8811
 folio_wait_bit_common+0x394/0x9b0 mm/filemap.c:1297
 __folio_lock mm/filemap.c:1660 [inline]
 folio_lock include/linux/pagemap.h:938 [inline]
 folio_lock include/linux/pagemap.h:934 [inline]
 __filemap_get_folio+0xb71/0xd80 mm/filemap.c:1932
 pagecache_get_page+0x2e/0x280 mm/folio-compat.c:98
 find_or_create_page include/linux/pagemap.h:612 [inline]
 grab_cache_page include/linux/pagemap.h:742 [inline]
 grab_tail_page fs/reiserfs/inode.c:2201 [inline]
 reiserfs_truncate_file+0x5bb/0x1070 fs/reiserfs/inode.c:2269
 reiserfs_setattr+0xed3/0x1460 fs/reiserfs/inode.c:3395
 notify_change+0xca7/0x1420 fs/attr.c:482
 do_truncate+0x143/0x200 fs/open.c:65
 vfs_truncate+0x3c2/0x490 fs/open.c:111
 do_sys_truncate.part.0+0x11e/0x140 fs/open.c:134
 do_sys_truncate fs/open.c:128 [inline]
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6d/0xa0 fs/open.c:144
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8f42af2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7c0 RCX: 00007fe8fc345669
RDX: 00007fe8f42af700 RSI: 0000000000000006 RDI: 00000000200001c0
RBP: 00007fe8fc3981b8 R08: 00007fe8f42af700 R09: 0000000000000000
R10: 00007fe8f42af700 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7c8
 </TASK>
INFO: task syz-executor214:5120 blocked for more than 145 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:24376 pid:5120  ppid:5069   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 rwsem_down_write_slowpath+0x600/0x12e0 kernel/locking/rwsem.c:1190
 __down_write_common kernel/locking/rwsem.c:1305 [inline]
 __down_write_common kernel/locking/rwsem.c:1302 [inline]
 __down_write kernel/locking/rwsem.c:1314 [inline]
 down_write+0x1e8/0x220 kernel/locking/rwsem.c:1563
 inode_lock include/linux/fs.h:756 [inline]
 generic_file_write_iter+0x92/0x350 mm/filemap.c:3929
 call_write_iter include/linux/fs.h:2186 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8fc2f12f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7a0 RCX: 00007fe8fc345669
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fe8fc3981b8 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7a8
 </TASK>
INFO: task syz-executor214:5127 blocked for more than 146 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:23752 pid:5127  ppid:5069   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 schedule_preempt_disabled+0x13/0x20 kernel/sched/core.c:6690
 __mutex_lock_common kernel/locking/mutex.c:679 [inline]
 __mutex_lock+0xa48/0x1360 kernel/locking/mutex.c:747
 reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
 reiserfs_get_block+0x1f6/0x4150 fs/reiserfs/inode.c:680
 do_mpage_readpage+0x765/0x19e0 fs/mpage.c:208
 mpage_readahead+0x344/0x580 fs/mpage.c:361
 read_pages+0x1a2/0xd40 mm/readahead.c:161
 page_cache_ra_unbounded+0x477/0x5e0 mm/readahead.c:270
 do_page_cache_ra mm/readahead.c:300 [inline]
 page_cache_ra_order+0x6ec/0xa00 mm/readahead.c:560
 ondemand_readahead+0x6b3/0x1000 mm/readahead.c:682
 page_cache_sync_ra+0x1c9/0x200 mm/readahead.c:709
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 filemap_get_pages+0x2ca/0x16b0 mm/filemap.c:2600
 filemap_read+0x315/0xc00 mm/filemap.c:2694
 generic_file_read_iter+0x3ad/0x5b0 mm/filemap.c:2840
 __kernel_read+0x2ca/0x7c0 fs/read_write.c:428
 integrity_kernel_read+0x7f/0xb0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm+0x2aa/0x3b0 security/integrity/ima/ima_crypto.c:485
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x195/0x4a0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x642/0x7b0 security/integrity/ima/ima_api.c:292
 process_measurement+0xd23/0x18b0 security/integrity/ima/ima_main.c:339
 ima_file_check+0xb0/0x100 security/integrity/ima/ima_main.c:519
 do_open fs/namei.c:3559 [inline]
 path_openat+0x15f1/0x2a50 fs/namei.c:3714
 do_filp_open+0x1ba/0x410 fs/namei.c:3741
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_open fs/open.c:1334 [inline]
 __se_sys_open fs/open.c:1330 [inline]
 __x64_sys_open+0x11d/0x1c0 fs/open.c:1330
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8f42d02f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7b0 RCX: 00007fe8fc345669
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000200
RBP: 00007fe8fc3981b8 R08: 00007fe8f42d0700 R09: 0000000000000000
R10: 00007fe8f42d0700 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7b8
 </TASK>
INFO: task syz-executor214:5129 blocked for more than 146 seconds.
      Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor214 state:D stack:28984 pid:5129  ppid:5069   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0xb8a/0x5450 kernel/sched/core.c:6555
 schedule+0xde/0x1b0 kernel/sched/core.c:6631
 io_schedule+0xbe/0x130 kernel/sched/core.c:8811
 folio_wait_bit_common+0x394/0x9b0 mm/filemap.c:1297
 __folio_lock mm/filemap.c:1660 [inline]
 folio_lock include/linux/pagemap.h:938 [inline]
 folio_lock include/linux/pagemap.h:934 [inline]
 __filemap_get_folio+0xb71/0xd80 mm/filemap.c:1932
 pagecache_get_page+0x2e/0x280 mm/folio-compat.c:98
 find_or_create_page include/linux/pagemap.h:612 [inline]
 grab_cache_page include/linux/pagemap.h:742 [inline]
 grab_tail_page fs/reiserfs/inode.c:2201 [inline]
 reiserfs_truncate_file+0x5bb/0x1070 fs/reiserfs/inode.c:2269
 reiserfs_setattr+0xed3/0x1460 fs/reiserfs/inode.c:3395
 notify_change+0xca7/0x1420 fs/attr.c:482
 do_truncate+0x143/0x200 fs/open.c:65
 vfs_truncate+0x3c2/0x490 fs/open.c:111
 do_sys_truncate.part.0+0x11e/0x140 fs/open.c:134
 do_sys_truncate fs/open.c:128 [inline]
 __do_sys_truncate fs/open.c:146 [inline]
 __se_sys_truncate fs/open.c:144 [inline]
 __x64_sys_truncate+0x6d/0xa0 fs/open.c:144
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe8fc345669
RSP: 002b:00007fe8f42af2f8 EFLAGS: 00000246 ORIG_RAX: 000000000000004c
RAX: ffffffffffffffda RBX: 00007fe8fc3cb7c0 RCX: 00007fe8fc345669
RDX: 00007fe8f42af700 RSI: 0000000000000006 RDI: 00000000200001c0
RBP: 00007fe8fc3981b8 R08: 00007fe8f42af700 R09: 0000000000000000
R10: 00007fe8f42af700 R11: 0000000000000246 R12: 0030656c69662f2e
R13: 7366726573696572 R14: 65732f636f72702f R15: 00007fe8fc3cb7c8
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/0:0/7:
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900000c7da8 ((work_completion)(&(&sbi->old_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff8880212dc0e0 (&type->s_umount_key#41){++++}-{3:3}, at: flush_old_commits+0x7c/0x200 fs/reiserfs/super.c:97
 #3: ffff88801dc65090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8c590b70 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8c590870 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x26/0xc70 kernel/rcu/tasks.h:507
4 locks held by kworker/1:0/22:
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900001c7da8
 ((work_completion)(&(&sbi->old_work)->work)
){+.+.}-{0:0}
, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: 
ffff88807d9740e0 (&type->s_umount_key#41){++++}-{3:3}, at: flush_old_commits+0x7c/0x200 fs/reiserfs/super.c:97
 #3: ffff8881452ea090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by kworker/1:1/26:
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc90000a1fda8 ((work_completion)(&(&sbi->old_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff88807c5be0e0 (&type->s_umount_key#41){++++}-{3:3}, at: flush_old_commits+0x7c/0x200 fs/reiserfs/super.c:97
 #3: 
ffff8880203d8090
 (
&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
1 lock held by khungtaskd/28:
 #0: ffffffff8c5916c0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x57/0x264 kernel/locking/lockdep.c:6494
5 locks held by kworker/u4:2/41:
4 locks held by kworker/1:3/2689:
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc9000aff7da8 ((work_completion)(&(&sbi->old_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff88802abe20e0 (&type->s_umount_key#41){++++}-{3:3}, at: flush_old_commits+0x7c/0x200 fs/reiserfs/super.c:97
 #3: ffff8880177a3090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
1 lock held by klogd/4419:
 #0: ffff8880b9a3b598 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2f/0x120 kernel/sched/core.c:537
2 locks held by getty/4746:
 #0: ffff88802b03b098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x26/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015802f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xef4/0x13e0 drivers/tty/n_tty.c:2177
2 locks held by syz-executor214/5087:
 #0: ffff8880212dc460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff8880212dc460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff8880212dc460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 #1: ffff88807355be80 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88807355be80 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: reiserfs_sync_file+0xab/0x320 fs/reiserfs/file.c:155
3 locks held by syz-executor214/5098:
 #0: ffff88801ba6faa0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff88807355c020 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff88807355c020 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffff88801dc65090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by syz-executor214/5103:
 #0: ffff8880212dc460 (sb_writers#9){.+.+}-{0:0}, at: vfs_truncate+0xee/0x490 fs/open.c:84
 #1: ffff88807355be80 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88807355be80 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff88807355bc58 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_setattr+0xe9d/0x1460 fs/reiserfs/inode.c:3393
 #3: ffff88801dc65090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
2 locks held by syz-executor214/5120:
 #0: ffff88807c5be460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff88807c5be460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff88807c5be460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 #1: ffff88807363d260 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88807363d260 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: generic_file_write_iter+0x92/0x350 mm/filemap.c:3929
3 locks held by syz-executor214/5127:
 #0: ffff888027ac4860 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff88807363d400 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff88807363d400 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffff8880203d8090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by syz-executor214/5129:
 #0: ffff88807c5be460 (sb_writers#9){.+.+}-{0:0}, at: vfs_truncate+0xee/0x490 fs/open.c:84
 #1: 
ffff88807363d260 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
ffff88807363d260 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff88807363d038 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_setattr+0xe9d/0x1460 fs/reiserfs/inode.c:3393
 #3: ffff8880203d8090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by kworker/0:4/5174:
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012065538 ((wq_completion)events_long){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900047c7da8 ((work_completion)(&(&sbi->old_work)->work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264
 #2: ffff88807d3a80e0 (&type->s_umount_key#41){++++}-{3:3}, at: flush_old_commits+0x7c/0x200 fs/reiserfs/super.c:97
 #3: ffff88801bc5f090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
2 locks held by syz-executor214/5267:
 #0: ffff88807d974460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff88807d974460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff88807d974460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 #1: ffff88806e877a20 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88806e877a20 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: generic_file_write_iter+0x92/0x350 mm/filemap.c:3929
3 locks held by syz-executor214/5274:
 #0: ffff888078d08ce0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff88806e877bc0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff88806e877bc0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffff8881452ea090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by syz-executor214/5276:
 #0: ffff88807d974460 (sb_writers#9){.+.+}-{0:0}, at: vfs_truncate+0xee/0x490 fs/open.c:84
 #1: ffff88806e877a20 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88806e877a20 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff88806e8777f8 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_setattr+0xe9d/0x1460 fs/reiserfs/inode.c:3393
 #3: ffff8881452ea090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
2 locks held by syz-executor214/5281:
 #0: ffff88802abe2460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff88802abe2460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff88802abe2460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 #1: ffff888073781d60 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888073781d60 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: generic_file_write_iter+0x92/0x350 mm/filemap.c:3929
3 locks held by syz-executor214/5289:
 #0: ffff88801ba6fe00 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff888073781f00 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff888073781f00 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffff8880177a3090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by syz-executor214/5290:
 #0: ffff88802abe2460 (sb_writers#9){.+.+}-{0:0}, at: vfs_truncate+0xee/0x490 fs/open.c:84
 #1: ffff888073781d60 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888073781d60 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff888073781b38 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_setattr+0xe9d/0x1460 fs/reiserfs/inode.c:3393
 #3: ffff8880177a3090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
2 locks held by syz-executor214/5309:
 #0: ffff88807d3a8460 (sb_writers#9){.+.+}-{0:0}, at: __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 #0: ffff88807d3a8460 (sb_writers#9){.+.+}-{0:0}, at: __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 #0: ffff88807d3a8460 (sb_writers#9){.+.+}-{0:0}, at: __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 #1: ffff88807363ece0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88807363ece0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: reiserfs_sync_file+0xab/0x320 fs/reiserfs/file.c:155
3 locks held by syz-executor214/5313:
 #0: ffff88801ca5de00 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3ab/0x18b0 security/integrity/ima/ima_main.c:260
 #1: ffff88807363ee80 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff88807363ee80 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: page_cache_ra_unbounded+0x153/0x5e0 mm/readahead.c:226
 #2: ffff88801bc5f090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
4 locks held by syz-executor214/5314:
 #0: ffff88807d3a8460 (sb_writers#9){.+.+}-{0:0}, at: vfs_truncate+0xee/0x490 fs/open.c:84
 #1: ffff88807363ece0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff88807363ece0 (&sb->s_type->i_mutex_key#15){+.+.}-{3:3}, at: do_truncate+0x131/0x200 fs/open.c:63
 #2: ffff88807363eab8 (&ei->tailpack){+.+.}-{3:3}, at: reiserfs_setattr+0xe9d/0x1460 fs/reiserfs/inode.c:3393
 #3: ffff88801bc5f090 (&sbi->lock){+.+.}-{3:3}, at: reiserfs_write_lock+0x79/0x100 fs/reiserfs/lock.c:27
2 locks held by kworker/1:4/5335:
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:636 [inline]
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:663 [inline]
 #0: ffff888012066538 ((wq_completion)rcu_gp){+.+.}-{0:0}, at: process_one_work+0x86d/0x1710 kernel/workqueue.c:2260
 #1: ffffc900058b7da8 ((work_completion)(&rew->rew_work)){+.+.}-{0:0}, at: process_one_work+0x8a1/0x1710 kernel/workqueue.c:2264

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x333/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc75/0xfc0 kernel/hung_task.c:377
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.0-syzkaller-13031-g77856d911a8c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:lockdep_hardirqs_on_prepare kernel/locking/lockdep.c:4302 [inline]
RIP: 0010:lockdep_hardirqs_on_prepare+0x19a/0x410 kernel/locking/lockdep.c:4273
Code: 01 00 00 48 c7 c7 e0 4d 2c 8a e8 01 00 96 08 b8 ff ff ff ff 65 0f c1 05 7c 00 9f 7e 83 f8 01 0f 85 ff 00 00 00 5b 5d c3 9c 58 <f6> c4 02 0f 85 59 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 da
RSP: 0018:ffffc90000177db8 EFLAGS: 00000046
RAX: 0000000000000046 RBX: ffffffff919f6a00 RCX: 1ffffffff1ca59b5
RDX: 0000000000000004 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffffffff8174faee R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff8fd53057 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc4c528ff8 CR3: 000000000c28e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 trace_hardirqs_on+0x31/0x180 kernel/trace/trace_preemptirq.c:49
 tick_nohz_idle_enter+0x19e/0x250 kernel/time/tick-sched.c:1162
 do_idle+0x9a/0x590 kernel/sched/idle.c:277
 cpu_startup_entry+0x18/0x20 kernel/sched/idle.c:400
 start_secondary+0x256/0x300 arch/x86/kernel/smpboot.c:264
 secondary_startup_64_no_verify+0xce/0xdb
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
