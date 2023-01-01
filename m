Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4723C65AB8F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 21:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjAAU1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 15:27:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjAAU1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 15:27:40 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2936F263A
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 12:27:38 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so16899315ilj.14
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 12:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BxVbDIB7ftmnPrYW3vj6VjsbpCtNLtapnfk/W/QNthA=;
        b=3gjA+2TA69Tn7/EzzS9hdzLXBfwupnRamnR7ggYjSMFhicv/wuJySislHBziSzicIY
         Dv+O5YvYAp9esBnyiRrWVJ9EoYo+uD9Vm4jo8JK3nyoeR21e7aBwGvpkkqrmDWftrv9Y
         eUmvxEV7+bLK0xqU1yrEmkdmZVl5Mq43gDAyIr/WhcvcEVIX4Q6UbDUeUXTjnFQNPMXh
         GCf7aRDygWtUNWaailnk/kYgBkYLhrKqYeY6OXfmNvQ1H/YUg9Ih7lu4u6iPjWO3Wbxe
         xtq5FPuS1PdpFBYeKQt2s3vK2Dmj8XMXoR/p5j+4jWPbRZvR2hgKDnNQCVp4420NeCS3
         0fxA==
X-Gm-Message-State: AFqh2kpWFrxJhZQGqkECpEjrfz9LtLEplYSnITknac1lBdxCe2tWis5G
        P2XoLa11+4TrP8bhs+w22Xy5AIoIlw1JNZl9eX8OhKSGtgr2
X-Google-Smtp-Source: AMrXdXsK2ugUjBaGQqay42xPpQLZDvBmLPf4vwromce/6jCJJNqNEtV3FNeYTBafppaKbjAkapo+ljP3qTsXejkTLi93ssYJ4/nc
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3e1a:b0:38a:af85:7eb7 with SMTP id
 co26-20020a0566383e1a00b0038aaf857eb7mr2472316jab.225.1672604857453; Sun, 01
 Jan 2023 12:27:37 -0800 (PST)
Date:   Sun, 01 Jan 2023 12:27:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000060d41f05f139aa44@google.com>
Subject: [syzbot] [ntfs3?] INFO: task hung in do_user_addr_fault (3)
From:   syzbot <syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
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

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=153167f2480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=555d27e379d75ff1
dashboard link: https://syzkaller.appspot.com/bug?extid=bed15dbf10294aa4f2ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17be0848480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169a866c480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2824225be62b/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff607a05be90/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c0b523d63d64/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/34cfdd07fe62/mount_3.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bed15dbf10294aa4f2ae@syzkaller.appspotmail.com

INFO: task syz-executor394:5211 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:25528 pid:5211  ppid:5123   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 rwsem_down_read_slowpath+0x5fe/0x950 kernel/locking/rwsem.c:1095
 __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
 mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
 do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7faec5f30aa8
RSP: 002b:00007ffc6b200128 EFLAGS: 00010206
RAX: 00007faec5f82c10 RBX: 00007faec5f811d8 RCX: 0000000000000001
RDX: 00007faec5e9df50 RSI: 0000000000000000 RDI: 00007faec5f82c10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 00007faec5f88420 R15: 0000000000000001
 </TASK>
INFO: task syz-executor394:5212 blocked for more than 143 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:26872 pid:5212  ppid:5123   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 rwsem_down_read_slowpath+0x5fe/0x950 kernel/locking/rwsem.c:1095
 __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
 mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
 do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:copy_user_enhanced_fast_string+0xa/0x40 arch/x86/lib/copy_user_64.S:166
Code: ff c9 75 f2 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 01 ca c3 8d 0c ca 89 ca eb 20 0f 01 cb 83 fa 40 72 38 89 d1 <f3> a4 31 c0 0f 01 ca c3 89 ca eb 0a 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc900043bfa38 EFLAGS: 00050206
RAX: ffffffff84434c01 RBX: 00007fffffffe000 RCX: 0000000000001000
RDX: 0000000000001000 RSI: 000000002042f000 RDI: ffff8880736be000
RBP: ffff888144ecb010 R08: dffffc0000000000 R09: ffffed100e6d7e00
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: ffff8880736be000 R15: 000000002042f000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:52 [inline]
 _copy_from_user+0xf0/0x160 lib/usercopy.c:16
 copy_from_user include/linux/uaccess.h:161 [inline]
 snd_rawmidi_kernel_write1+0x3bd/0x660 sound/core/rawmidi.c:1547
 snd_rawmidi_write+0x615/0xbe0 sound/core/rawmidi.c:1616
 vfs_write+0x2e5/0xbb0 fs/read_write.c:582
 ksys_write+0x19b/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faec5e8b2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faec5f837e0 RCX: 00007faec5edf939
RDX: 00000000fffffd2c RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f837e8
 </TASK>
INFO: task syz-executor394:5214 blocked for more than 144 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:23504 pid:5214  ppid:5123   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
 ntfs_get_block_vbo+0x374/0xd20 fs/ntfs3/inode.c:573
 do_mpage_readpage+0x98b/0x1bb0 fs/mpage.c:208
 mpage_read_folio+0x103/0x1d0 fs/mpage.c:379
 filemap_read_folio+0x1ba/0x7f0 mm/filemap.c:2426
 filemap_update_page+0x3ca/0x550 mm/filemap.c:2511
 filemap_get_pages+0x8d8/0x1110 mm/filemap.c:2624
 filemap_read+0x3e7/0xee0 mm/filemap.c:2694
 call_read_iter include/linux/fs.h:2180 [inline]
 generic_file_splice_read+0x24e/0x650 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faec5e6a2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007faec5f837f0 RCX: 00007faec5edf939
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f837f8
 </TASK>
INFO: task syz-executor394:5221 blocked for more than 145 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:25448 pid:5221  ppid:5123   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
 ntfs_file_mmap+0x4cc/0x780 fs/ntfs3/file.c:296
 call_mmap include/linux/fs.h:2191 [inline]
 mmap_region+0x1022/0x1e60 mm/mmap.c:2621
 do_mmap+0x8d9/0xf30 mm/mmap.c:1411
 vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faebdc492e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007faec5f83800 RCX: 00007faec5edf939
RDX: 0000000000800006 RSI: 0000000002047ffb RDI: 0000000020001000
RBP: 00007faec5f50808 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f83808
 </TASK>
INFO: task syz-executor394:5222 blocked for more than 145 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:26216 pid:5222  ppid:5123   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
 folio_lock include/linux/pagemap.h:938 [inline]
 truncate_inode_pages_range+0xc8d/0x1650 mm/truncate.c:421
 truncate_inode_pages mm/truncate.c:448 [inline]
 truncate_pagecache mm/truncate.c:743 [inline]
 truncate_setsize+0xcb/0xf0 mm/truncate.c:768
 ntfs_truncate fs/ntfs3/file.c:395 [inline]
 ntfs3_setattr+0x5a5/0xca0 fs/ntfs3/file.c:696
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x219/0x300 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x273d/0x2de0 fs/namei.c:3714
 do_filp_open+0x275/0x500 fs/namei.c:3741
 do_sys_openat2+0x13b/0x500 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faebdc282f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007faec5f83810 RCX: 00007faec5edf939
RDX: 00007faec5edf939 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f83818
 </TASK>
INFO: task syz-executor394:6046 blocked for more than 146 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:26328 pid:6046  ppid:5125   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 rwsem_down_read_slowpath+0x5fe/0x950 kernel/locking/rwsem.c:1095
 __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
 mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
 do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0033:0x7faec5f30aa8
RSP: 002b:00007ffc6b200128 EFLAGS: 00010206
RAX: 00007faec5f82c10 RBX: 00007faec5f811d8 RCX: 0000000000000001
RDX: 00007faec5e9df50 RSI: 0000000000000000 RDI: 00007faec5f82c10
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000010
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: 00007faec5f88420 R15: 0000000000000001
 </TASK>
INFO: task syz-executor394:6047 blocked for more than 147 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:25656 pid:6047  ppid:5125   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 rwsem_down_read_slowpath+0x5fe/0x950 kernel/locking/rwsem.c:1095
 __down_read_common+0x54/0x2a0 kernel/locking/rwsem.c:1260
 mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
 do_user_addr_fault+0x4b7/0xcb0 arch/x86/mm/fault.c:1379
 handle_page_fault arch/x86/mm/fault.c:1519 [inline]
 exc_page_fault+0x7a/0x120 arch/x86/mm/fault.c:1575
 asm_exc_page_fault+0x22/0x30 arch/x86/include/asm/idtentry.h:570
RIP: 0010:copy_user_enhanced_fast_string+0xa/0x40 arch/x86/lib/copy_user_64.S:166
Code: ff c9 75 f2 89 d1 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 31 c0 0f 01 ca c3 8d 0c ca 89 ca eb 20 0f 01 cb 83 fa 40 72 38 89 d1 <f3> a4 31 c0 0f 01 ca c3 89 ca eb 0a 66 2e 0f 1f 84 00 00 00 00 00
RSP: 0018:ffffc900064b7a38 EFLAGS: 00050206
RAX: ffffffff84434c01 RBX: 00007fffffffe000 RCX: 0000000000001000
RDX: 0000000000001000 RSI: 0000000020f37000 RDI: ffff88807f772000
RBP: ffff888023d7f210 R08: dffffc0000000000 R09: ffffed100feee600
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000001000
R13: 0000000000001000 R14: ffff88807f772000 R15: 0000000020f37000
 copy_user_generic arch/x86/include/asm/uaccess_64.h:37 [inline]
 raw_copy_from_user arch/x86/include/asm/uaccess_64.h:52 [inline]
 _copy_from_user+0xf0/0x160 lib/usercopy.c:16
 copy_from_user include/linux/uaccess.h:161 [inline]
 snd_rawmidi_kernel_write1+0x3bd/0x660 sound/core/rawmidi.c:1547
 snd_rawmidi_write+0x615/0xbe0 sound/core/rawmidi.c:1616
 vfs_write+0x2e5/0xbb0 fs/read_write.c:582
 ksys_write+0x19b/0x2c0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faec5e8b2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007faec5f837e0 RCX: 00007faec5edf939
RDX: 00000000fffffd2c RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f837e8
 </TASK>
INFO: task syz-executor394:6048 blocked for more than 147 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:24072 pid:6048  ppid:5125   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
 ntfs_get_block_vbo+0x374/0xd20 fs/ntfs3/inode.c:573
 do_mpage_readpage+0x98b/0x1bb0 fs/mpage.c:208
 mpage_read_folio+0x103/0x1d0 fs/mpage.c:379
 filemap_read_folio+0x1ba/0x7f0 mm/filemap.c:2426
 filemap_update_page+0x3ca/0x550 mm/filemap.c:2511
 filemap_get_pages+0x8d8/0x1110 mm/filemap.c:2624
 filemap_read+0x3e7/0xee0 mm/filemap.c:2694
 call_read_iter include/linux/fs.h:2180 [inline]
 generic_file_splice_read+0x24e/0x650 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x2a0/0x3f0 fs/splice.c:974
 do_sendfile+0x641/0xfd0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x178/0x1e0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faec5e6a2f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007faec5f837f0 RCX: 00007faec5edf939
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f837f8
 </TASK>
INFO: task syz-executor394:6055 blocked for more than 148 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:25448 pid:6055  ppid:5125   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6690
 __mutex_lock_common+0xecf/0x26c0 kernel/locking/mutex.c:679
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x17/0x20 kernel/locking/mutex.c:799
 ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
 ntfs_file_mmap+0x4cc/0x780 fs/ntfs3/file.c:296
 call_mmap include/linux/fs.h:2191 [inline]
 mmap_region+0x1022/0x1e60 mm/mmap.c:2621
 do_mmap+0x8d9/0xf30 mm/mmap.c:1411
 vm_mmap_pgoff+0x1e5/0x2f0 mm/util.c:520
 ksys_mmap_pgoff+0x48c/0x6d0 mm/mmap.c:1457
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faebdc492e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: ffffffffffffffda RBX: 00007faec5f83800 RCX: 00007faec5edf939
RDX: 0000000000800006 RSI: 0000000002047ffb RDI: 0000000020001000
RBP: 00007faec5f50808 R08: 0000000000000008 R09: 0000000000000000
R10: 0000000000000011 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f83808
 </TASK>
INFO: task syz-executor394:6058 blocked for more than 149 seconds.
      Not tainted 6.2.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:26216 pid:6058  ppid:5125   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5244 [inline]
 __schedule+0x9d1/0xe40 kernel/sched/core.c:6555
 schedule+0xcb/0x190 kernel/sched/core.c:6631
 io_schedule+0x83/0x100 kernel/sched/core.c:8811
 folio_wait_bit_common+0x8ca/0x1390 mm/filemap.c:1297
 folio_lock include/linux/pagemap.h:938 [inline]
 truncate_inode_pages_range+0xc8d/0x1650 mm/truncate.c:421
 truncate_inode_pages mm/truncate.c:448 [inline]
 truncate_pagecache mm/truncate.c:743 [inline]
 truncate_setsize+0xcb/0xf0 mm/truncate.c:768
 ntfs_truncate fs/ntfs3/file.c:395 [inline]
 ntfs3_setattr+0x5a5/0xca0 fs/ntfs3/file.c:696
 notify_change+0xe50/0x1100 fs/attr.c:482
 do_truncate+0x219/0x300 fs/open.c:65
 handle_truncate fs/namei.c:3216 [inline]
 do_open fs/namei.c:3561 [inline]
 path_openat+0x273d/0x2de0 fs/namei.c:3714
 do_filp_open+0x275/0x500 fs/namei.c:3741
 do_sys_openat2+0x13b/0x500 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7faec5edf939
RSP: 002b:00007faebdc282f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007faec5f83810 RCX: 00007faec5edf939
RDX: 00007faec5edf939 RSI: 0000000000000000 RDI: 0000000020000000
RBP: 00007faec5f50808 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 6c75727363616f6e
R13: 6573726168636f69 R14: 0030656c69662f2e R15: 00007faec5f83818
 </TASK>

Showing all locks held in the system:
1 lock held by rcu_tasks_kthre/12:
 #0: ffffffff8d523910 (rcu_tasks.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by rcu_tasks_trace/13:
 #0: ffffffff8d524110 (rcu_tasks_trace.tasks_gp_mutex){+.+.}-{3:3}, at: rcu_tasks_one_gp+0x30/0xd00 kernel/rcu/tasks.h:507
1 lock held by khungtaskd/28:
 #0: ffffffff8d523740 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x0/0x30
2 locks held by getty/4749:
 #0: ffff88814aad8098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x21/0x70 drivers/tty/tty_ldisc.c:244
 #1: ffffc900015902f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6e8/0x1e50 drivers/tty/n_tty.c:2177
1 lock held by syz-executor394/5211:
 #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
1 lock held by syz-executor394/5212:
 #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
3 locks held by syz-executor394/5214:
 #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
 #1: ffff888073930ca0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff888073930ca0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_update_page+0x72/0x550 mm/filemap.c:2478
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
2 locks held by syz-executor394/5221:
 #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff88802c7bc758 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
 #1: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #1: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
3 locks held by syz-executor394/5222:
 #0: ffff88801ee04460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888073930b00 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888073930b00 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: do_truncate+0x205/0x300 fs/open.c:63
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_truncate fs/ntfs3/file.c:393 [inline]
 #2: ffff888073930860 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x596/0xca0 fs/ntfs3/file.c:696
1 lock held by syz-executor394/6046:
 #0: ffff888018eead18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
1 lock held by syz-executor394/6047:
 #0: ffff888018eead18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_lock+0x17/0x50 include/linux/mmap_lock.h:117
3 locks held by syz-executor394/6048:
 #0: ffff888021b06460 (sb_writers#9){.+.+}-{0:0}, at: do_sendfile+0x61c/0xfd0 fs/read_write.c:1254
 #1: ffff888075aec7a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:811 [inline]
 #1: ffff888075aec7a0 (mapping.invalidate_lock#3){.+.+}-{3:3}, at: filemap_update_page+0x72/0x550 mm/filemap.c:2478
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
2 locks held by syz-executor394/6055:
 #0: ffff888018eead18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff888018eead18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
 #1: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #1: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: attr_data_get_block+0x4a6/0x2e40 fs/ntfs3/attrib.c:919
3 locks held by syz-executor394/6058:
 #0: ffff888021b06460 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3b/0x80 fs/namespace.c:508
 #1: ffff888075aec600 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff888075aec600 (&sb->s_type->i_mutex_key#14){+.+.}-{3:3}, at: do_truncate+0x205/0x300 fs/open.c:63
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ni_lock fs/ntfs3/ntfs_fs.h:1122 [inline]
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs_truncate fs/ntfs3/file.c:393 [inline]
 #2: ffff888075aec360 (&ni->ni_lock/4){+.+.}-{3:3}, at: ntfs3_setattr+0x596/0xca0 fs/ntfs3/file.c:696
1 lock held by syz-executor394/8235:
 #0: ffff88807efb8a18 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:87 [inline]
 #0: ffff88807efb8a18 (&mm->mmap_lock){++++}-{3:3}, at: vm_mmap_pgoff+0x18f/0x2f0 mm/util.c:518
1 lock held by syz-executor394/8237:
 #0: ffff8880b993a1d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x25/0x110 kernel/sched/core.c:537
4 locks held by syz-executor394/8253:

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 28 Comm: khungtaskd Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2d0 lib/dump_stack.c:106
 nmi_cpu_backtrace+0x4e3/0x560 lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x19b/0x3e0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xcd5/0xd20 kernel/hung_task.c:377
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 21 Comm: ksoftirqd/1 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:unwind_next_frame+0x146/0x24c0 arch/x86/kernel/unwind_orc.c:467
Code: 48 89 df e8 8c 44 a6 00 49 b9 00 00 00 00 00 fc ff df f6 03 03 0f 85 96 0f 00 00 48 8b 04 24 4c 8d 78 35 4c 89 fd 48 c1 ed 03 <42> 8a 44 0d 00 84 c0 0f 85 99 1b 00 00 4d 0f be 27 48 8b 44 24 30
RSP: 0018:ffffc900001b7500 EFLAGS: 00000a03
RAX: ffffc900001b75e0 RBX: 0000000000000000 RCX: ffffffff92168003
RDX: dffffc0000000000 RSI: ffffffff8155e5a1 RDI: 0000000000000001
RBP: 1ffff92000036ec2 R08: 0000000000000007 R09: dffffc0000000000
R10: fffff52000036ec8 R11: 1ffff92000036ec6 R12: ffffc900001b7618
R13: ffffc900001b7628 R14: ffffffff8155e5a1 R15: ffffc900001b7615
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020024000 CR3: 0000000022990000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_stack_walk+0x112/0x140 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x12d/0x1f0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:518
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0x94/0x1d0 mm/slub.c:3809
 rcu_do_batch kernel/rcu/tree.c:2246 [inline]
 rcu_core+0xa91/0x1790 kernel/rcu/tree.c:2506
 __do_softirq+0x277/0x75b kernel/softirq.c:571
 run_ksoftirqd+0xc1/0x120 kernel/softirq.c:934
 smpboot_thread_fn+0x533/0xa10 kernel/smpboot.c:164
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.096 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
