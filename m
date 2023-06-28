Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 998AA7409EF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 09:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjF1Hym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 03:54:42 -0400
Received: from mail-oi1-f206.google.com ([209.85.167.206]:62481 "EHLO
        mail-oi1-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjF1Hxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 03:53:39 -0400
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-3a069a048ebso672682b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 00:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687938818; x=1690530818;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3iKbl9WBTsP5fifVfjkISaF/U7eNVldSY1T6pLhUc7I=;
        b=iv4jpJpasqHOmrKWl8EaMUYSrl9pFB9LmY55I0uvOGu/ngi5+tcjSpretiLpuzu8ox
         j/jd0yu7A7xRvXVZEo3UpGlLqFL9nkxhV8KyQeZh2k1pGm7QLREqH5Wgyfa9c2a5JMWE
         emkQ0w30b8o8ZL7tCpAceB2ewL3T4a2XULHoQkkuGeIE01lt287x8ggp47P90CBri0dD
         IoL0exd07H1xGPquLZwqkOFopznSUuFGu/ZetgYwuh7KWOpFzxUdNep36wYW5gLq+Hua
         5c8DKkAGbCMRVawDec3CAH+Fd4LXSdcrGz0tAVwzVWySRpKdOqkQSRs59vP5lZ51EnyH
         3Wgw==
X-Gm-Message-State: AC+VfDxFt8pLss+hDeZa63uJy9Wl/kgcQb3++n5KaYgPF71MiuqQhFtj
        dFSQ5ksWFPlZepFQ446+h6ePUzrivCWzpLgKpW+GF8zvQU2F
X-Google-Smtp-Source: ACHHUZ7DIg7jPb8nW84aSw4eGGkEfwA3e6tUlgBKU0KloXTbZojvd9GygQ4wlcc1VP4S7xLwS/HCmXvYqSV503tEFI8quCL7NdI8
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1781:b0:3a1:ed87:f6e with SMTP id
 bg1-20020a056808178100b003a1ed870f6emr848565oib.2.1687938301906; Wed, 28 Jun
 2023 00:45:01 -0700 (PDT)
Date:   Wed, 28 Jun 2023 00:45:01 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e355b705ff2bc283@google.com>
Subject: [syzbot] [bluetooth?] WARNING: refcount bug in sco_sock_timeout (2)
From:   syzbot <syzbot+c689847e27e0fa3e7a5d@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    42234a752679 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1351201b280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e95897d034d60fb8
dashboard link: https://syzkaller.appspot.com/bug?extid=c689847e27e0fa3e7a5d
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f608eaee38d2/disk-42234a75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/266fc376435a/vmlinux-42234a75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/464f23f26a65/Image-42234a75.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c689847e27e0fa3e7a5d@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 7887 at lib/refcount.c:25 refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
Modules linked in:
CPU: 0 PID: 7887 Comm: kworker/0:9 Not tainted 6.4.0-rc7-syzkaller-g42234a752679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events sco_sock_timeout
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
lr : refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
sp : ffff800099ca7af0
x29: ffff800099ca7af0 x28: ffff0001b423c600 x27: ffff0000d2d42218
x26: ffff0000cb783250 x25: 1fffe0001a5a8443 x24: dfff800000000000
x23: dfff800000000000 x22: 0000000000000000 x21: 0000000000000002
x20: ffff0000dd30a080 x19: ffff800090b09000 x18: ffff800099ca6fc0
x17: 0000000000000000 x16: ffff80008a443320 x15: 0000000000000003
x14: 0000000000000000 x13: fffffffffffdc038 x12: 0000000000000001
x11: 0000000000000001 x10: 0000000000000000 x9 : fd2dea7152733000
x8 : fd2dea7152733000 x7 : fffffffffffdc038 x6 : fffffffffffdbfe8
x5 : ffff800099ca73d8 x4 : ffff80008df78f00 x3 : ffff800080597614
x2 : 0000000000000001 x1 : 0000000100000001 x0 : 0000000000000000
Call trace:
 refcount_warn_saturate+0x1a8/0x20c lib/refcount.c:25
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 sock_hold include/net/sock.h:777 [inline]
 sco_sock_timeout+0x19c/0x25c net/bluetooth/sco.c:89
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853
irq event stamp: 183728
hardirqs last  enabled at (183727): [<ffff800080351108>] __up_console_sem+0x60/0xb4 kernel/printk/printk.c:347
hardirqs last disabled at (183728): [<ffff80008a43ed34>] el1_dbg+0x24/0x80 arch/arm64/kernel/entry-common.c:407
softirqs last  enabled at (183698): [<ffff8000803a4f6c>] local_bh_enable+0xc/0x2c include/linux/bottom_half.h:32
softirqs last disabled at (183694): [<ffff8000803a4f40>] local_bh_disable+0xc/0x2c include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 7887 Comm: kworker/0:9 Tainted: G        W          6.4.0-rc7-syzkaller-g42234a752679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events sco_sock_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 assign_lock_key+0x234/0x268 kernel/locking/lockdep.c:982
 register_lock_class+0x144/0x6a4 kernel/locking/lockdep.c:1295
 __lock_acquire+0x184/0x7604 kernel/locking/lockdep.c:4965
 lock_acquire+0x23c/0x71c kernel/locking/lockdep.c:5705
 lock_sock_nested+0x5c/0x11c net/core/sock.c:3469
 lock_sock include/net/sock.h:1709 [inline]
 sco_sock_timeout+0xbc/0x25c net/bluetooth/sco.c:97
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853
==================================================================
BUG: KASAN: slab-out-of-bounds in sco_sock_timeout+0xe8/0x25c net/bluetooth/sco.c:99
Read of size 8 at addr ffff0000dd30a4a0 by task kworker/0:9/7887

CPU: 0 PID: 7887 Comm: kworker/0:9 Tainted: G        W          6.4.0-rc7-syzkaller-g42234a752679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events sco_sock_timeout
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:351 [inline]
 print_report+0x174/0x514 mm/kasan/report.c:462
 kasan_report+0xd4/0x130 mm/kasan/report.c:572
 __asan_report_load8_noabort+0x20/0x2c mm/kasan/report_generic.c:381
 sco_sock_timeout+0xe8/0x25c net/bluetooth/sco.c:99
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853

Allocated by task 25544:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x7c mm/kasan/common.c:52
 kasan_save_alloc_info+0x24/0x30 mm/kasan/generic.c:510
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0xcc/0x1b8 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 kzalloc include/linux/slab.h:680 [inline]
 ops_init+0x90/0x548 net/core/net_namespace.c:126
 setup_net+0x424/0xaac net/core/net_namespace.c:339
 copy_net_ns+0x3c4/0x644 net/core/net_namespace.c:491
 create_new_namespaces+0x344/0x614 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x108/0x158 kernel/nsproxy.c:228
 ksys_unshare+0x45c/0x874 kernel/fork.c:3441
 __do_sys_unshare kernel/fork.c:3512 [inline]
 __se_sys_unshare kernel/fork.c:3510 [inline]
 __arm64_sys_unshare+0x3c/0x50 kernel/fork.c:3510
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x98/0x2c0 arch/arm64/kernel/syscall.c:52
 el0_svc_common+0x138/0x244 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x64/0x198 arch/arm64/kernel/syscall.c:191
 el0_svc+0x4c/0x160 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

Last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:501
 __call_rcu_common kernel/rcu/tree.c:2627 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2741
 netlink_release+0x12c0/0x1818 net/netlink/af_netlink.c:828
 __sock_release net/socket.c:653 [inline]
 sock_release+0x84/0x140 net/socket.c:681
 netlink_kernel_release+0x50/0x70 net/netlink/af_netlink.c:2098
 nfnetlink_net_exit_batch+0x6c/0xb4 net/netfilter/nfnetlink.c:782
 ops_exit_list net/core/net_namespace.c:175 [inline]
 cleanup_net+0x5dc/0x8d0 net/core/net_namespace.c:614
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853

Second to last potentially related work creation:
 kasan_save_stack+0x40/0x6c mm/kasan/common.c:45
 __kasan_record_aux_stack+0xcc/0xe8 mm/kasan/generic.c:491
 kasan_record_aux_stack_noalloc+0x14/0x20 mm/kasan/generic.c:501
 __call_rcu_common kernel/rcu/tree.c:2627 [inline]
 call_rcu+0x104/0xaf4 kernel/rcu/tree.c:2741
 netlink_release+0x12c0/0x1818 net/netlink/af_netlink.c:828
 __sock_release net/socket.c:653 [inline]
 sock_close+0xb8/0x1fc net/socket.c:1397
 __fput+0x30c/0x7bc fs/file_table.c:321
 ____fput+0x20/0x30 fs/file_table.c:349
 task_work_run+0x230/0x2e0 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x63c/0x1f58 kernel/exit.c:874
 do_group_exit+0x194/0x22c kernel/exit.c:1024
 get_signal+0x14b0/0x159c kernel/signal.c:2876
 do_signal arch/arm64/kernel/signal.c:1249 [inline]
 do_notify_resume+0x3cc/0x3c90 arch/arm64/kernel/signal.c:1302
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:137 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:144 [inline]
 el0_svc+0x94/0x160 arch/arm64/kernel/entry-common.c:648
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:591

The buggy address belongs to the object at ffff0000dd30a000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 128 bytes to the right of
 allocated 1056-byte region [ffff0000dd30a000, ffff0000dd30a420)

The buggy address belongs to the physical page:
page:0000000078acc899 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11d308
head:0000000078acc899 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x5ffc00000010200(slab|head|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000010200 ffff0000c0002900 fffffc00035a2400 dead000000000002
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000dd30a380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff0000dd30a400: 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc fc
>ffff0000dd30a480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                               ^
 ffff0000dd30a500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff0000dd30a580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=00000001662e9000
[0000000000000000] pgd=080000011715b003, p4d=080000011715b003, pud=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 7887 Comm: kworker/0:9 Tainted: G    B   W          6.4.0-rc7-syzkaller-g42234a752679 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events sco_sock_timeout
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : sco_sock_timeout+0xf4/0x25c net/bluetooth/sco.c:99
sp : ffff800099ca7b20
x29: ffff800099ca7b20 x28: ffff0001b423c600 x27: ffff0000d2d42218
x26: ffff0000cb783250 x25: 1fffe0001a5a8443 x24: dfff800000000000
x23: dfff800000000000 x22: 0000000000000000 x21: ffff0000cb783208
x20: ffff0000dd30a000 x19: ffff0000dd30a080 x18: 1fffe000368447c6
x17: ffff80008debd000 x16: ffff80008a441e20 x15: 0000000000000002
x14: 0000000000000000 x13: 0000000040000002 x12: 0000000000000001
x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 1fffe000368447c7 x6 : ffff80008028cc04
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000801b9aec
x2 : 0000000000000001 x1 : 0000000000000000 x0 : ffff0000dd30a000
Call trace:
 0x0
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853
Code: ???????? ???????? ???????? ???????? (????????) 
---[ end trace 0000000000000000 ]---


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
