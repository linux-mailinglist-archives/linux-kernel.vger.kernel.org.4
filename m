Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4DE749416
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbjGFDNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjGFDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:12:55 -0400
Received: from mail-pg1-f206.google.com (mail-pg1-f206.google.com [209.85.215.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88319B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 20:12:54 -0700 (PDT)
Received: by mail-pg1-f206.google.com with SMTP id 41be03b00d2f7-55bf5cd4e75so75753a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 20:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688613173; x=1691205173;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tIHj4QmuWu9KwgHAblppgwTZ0kyepiOAwQrdIOp1Lsw=;
        b=FsYSLMeQxcHYcWbeQyH5I3JWjpYaikP2nqmVNfISfseBu7Sq32QzJPVzsq+Yw7txsd
         yhUYRPy2g3nf//TJF515cy3CoXo4upRGocGyjCZ0d5jqZ4UbtpRMvrl+RHXFj6buxYs+
         Zj5ESWMS4qAV+l9lN9cefPDbbzp5UmbTi4+GWrnwMkp++fTFi3Hl3wUKx240YM/eCH7i
         z5dvhE38+RNNAhE8IiXWQ2dvvUJViKqGaNSOJXTWFxHcgiEx7HnXRoyZ75iRirSSL2Ka
         OyIF9rp/gCBYbfPvJYpV9mm6xptIoLCf9NAtlu527dzjYICrBS00PkbDhJ4xycCsQMRC
         AhKg==
X-Gm-Message-State: ABy/qLbbGKrhqLjWxygtb5gJ2P5EJ5h6xdBVBp8+Dr780BaCOZ/g5N/o
        qyfhQ5avlwStL/oocRmG/C14+Ogx1gj6o1xT5UhK0ovdDyXe
X-Google-Smtp-Source: APBJJlGmyGKCqdhaloRdGCWie5+2seMif5gh0auQC4fgsx754855wFM7hdJLgjHS8Ctp3KUNn4MxctjWbkXqw12jmD/Ry3STZ6Os
MIME-Version: 1.0
X-Received: by 2002:a63:741e:0:b0:55b:22f8:30bb with SMTP id
 p30-20020a63741e000000b0055b22f830bbmr281646pgc.3.1688613173621; Wed, 05 Jul
 2023 20:12:53 -0700 (PDT)
Date:   Wed, 05 Jul 2023 20:12:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000607ff905ffc8e477@google.com>
Subject: [syzbot] [mm?] WARNING: suspicious RCU usage in mas_walk (2)
From:   syzbot <syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=105632c8a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=db74cd5aa6878807
dashboard link: https://syzkaller.appspot.com/bug?extid=8645fe63c4d22c8d27b8
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e7b15164da6/disk-a901a356.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9880c1d81d68/vmlinux-a901a356.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6d5b0c0d9670/bzImage-a901a356.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8645fe63c4d22c8d27b8@syzkaller.appspotmail.com

SELinux:  policy capability cgroup_seclabel=1
SELinux:  policy capability nnp_nosuid_transition=1
SELinux:  policy capability genfs_seclabel_symlinks=0
SELinux:  policy capability ioctl_skip_cloexec=0
=============================
WARNING: suspicious RCU usage
6.4.0-syzkaller-10173-ga901a3568fd2 #0 Not tainted
-----------------------------
lib/maple_tree.c:860 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by init/1.

stack backtrace:
CPU: 1 PID: 1 Comm: init Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x208/0x3a0 kernel/locking/lockdep.c:6719
 mas_root lib/maple_tree.c:860 [inline]
 mas_root lib/maple_tree.c:858 [inline]
 mas_start lib/maple_tree.c:1402 [inline]
 mas_start lib/maple_tree.c:1392 [inline]
 mas_state_walk lib/maple_tree.c:3861 [inline]
 mas_walk+0x4e8/0x7c0 lib/maple_tree.c:4980
 mas_find_setup lib/maple_tree.c:5924 [inline]
 mas_find+0x1cb/0x340 lib/maple_tree.c:5965
 vma_next include/linux/mm.h:865 [inline]
 validate_mm+0xd2/0x470 mm/mmap.c:301
 do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f36cc8e9817
Code: ff ff 76 10 48 8b 15 10 36 0d 00 f7 d8 64 89 02 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 35 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff12a54cf8 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f36cc8e9817
RDX: 0000000000000000 RSI: 00000000000415ce RDI: 00007f36cc6b1000
RBP: 00005613cf216bf0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f36cc6b1000 R15: 00007f36cc72a16d
 </TASK>

=============================
WARNING: suspicious RCU usage
6.4.0-syzkaller-10173-ga901a3568fd2 #0 Not tainted
-----------------------------
lib/maple_tree.c:816 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
no locks held by init/1.

stack backtrace:
CPU: 0 PID: 1 Comm: init Not tainted 6.4.0-syzkaller-10173-ga901a3568fd2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x208/0x3a0 kernel/locking/lockdep.c:6719
 mt_slot lib/maple_tree.c:816 [inline]
 mt_slot lib/maple_tree.c:813 [inline]
 mtree_range_walk+0x602/0x940 lib/maple_tree.c:2976
 mas_state_walk lib/maple_tree.c:3868 [inline]
 mas_walk+0x393/0x7c0 lib/maple_tree.c:4980
 mas_find_setup lib/maple_tree.c:5924 [inline]
 mas_find+0x1cb/0x340 lib/maple_tree.c:5965
 vma_next include/linux/mm.h:865 [inline]
 validate_mm+0xd2/0x470 mm/mmap.c:301
 do_vmi_align_munmap+0x1199/0x1680 mm/mmap.c:2561
 do_vmi_munmap+0x266/0x430 mm/mmap.c:2619
 __vm_munmap+0x137/0x380 mm/mmap.c:2899
 __do_sys_munmap mm/mmap.c:2916 [inline]
 __se_sys_munmap mm/mmap.c:2913 [inline]
 __x64_sys_munmap+0x62/0x80 mm/mmap.c:2913
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f36cc8e9817
Code: ff ff 76 10 48 8b 15 10 36 0d 00 f7 d8 64 89 02 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 35 0d 00 f7 d8 64 89 01 48
RSP: 002b:00007fff12a54cf8 EFLAGS: 00000246 ORIG_RAX: 000000000000000b
RAX: ffffffffffffffda RBX: 000000000000001f RCX: 00007f36cc8e9817
RDX: 0000000000000000 RSI: 00000000000415ce RDI: 00007f36cc6b1000
RBP: 00005613cf216bf0 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f36cc6b1000 R15: 00007f36cc72a16d
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
