Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D63A644170
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiLFKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiLFKnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:43:43 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079686328
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:43:42 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso7599688ilj.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 02:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0mHDhQ+mvcWa7iZ4v+Z9wgRwLeST6IfrS1fLCX5EBsQ=;
        b=nPiGs4nElY+Yco6Wai54pjaOG+hanp5FwTDCEAnBMEi16jgzmXhxo7QAUwuTmKqTby
         ZyhWxHW7b6epBcqTdmCNuJliZkl1z/vYjYvyvYkKuclu3lmH9WT5RCn1FEsRzzvUUEv4
         vgSyv67xi8HBKjq69xzCx4RVlNjdZQe3I07FfkDzFBF2cVPHEJn4jjwfH3a42Gd4YYRB
         WG6wrIS+K+tZ8c7DX5+D4TphuzW35vCOVgDGhDrGcOP0N21ojMA2iotCw8U8dpeARTo/
         0YQE3YTjVPswjCVNtsBJvNFCL1LSPkc1wyE4fWUerR65GgEaZTiWhhgm5qxZwXUbBb1C
         UhDQ==
X-Gm-Message-State: ANoB5pkNovm82oo1ee/8Rv8SgdEW3MFUoapaypOB+OVyrtwjGybo2+EB
        oWSgaD19EXz+Tjb17eh80pKXWWAoY3wB+POTYf9YlYJsWWD6
X-Google-Smtp-Source: AA0mqf72n3DYCXAJcHwI5ikwjjpN/wfnjNj/AL5Hn72ZFmqUGqzJf4kJoZZQAC5UXQextsndwhvGGY4ZU8XvngVaSpCzQOjb2aAo
MIME-Version: 1.0
X-Received: by 2002:a6b:8bcc:0:b0:6e0:1738:5680 with SMTP id
 n195-20020a6b8bcc000000b006e017385680mr3012543iod.109.1670323421299; Tue, 06
 Dec 2022 02:43:41 -0800 (PST)
Date:   Tue, 06 Dec 2022 02:43:41 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fc8dc05ef267a9f@google.com>
Subject: [syzbot] KASAN: use-after-free Read in __usb_hcd_giveback_urb (2)
From:   syzbot <syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com>
To:     WeitaoWang-oc@zhaoxin.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, khalid.masum.92@gmail.com,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    ef4d3ea40565 afs: Fix server->active leak in afs_put_server
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100b244d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8e7e79f8a1e34200
dashboard link: https://syzkaller.appspot.com/bug?extid=712fd0e60dda3ba34642
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ef790e7777cd/disk-ef4d3ea4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ed3c6bc9230/vmlinux-ef4d3ea4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f1dbd004fa88/bzImage-ef4d3ea4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+712fd0e60dda3ba34642@syzkaller.appspotmail.com

xpad 3-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 3-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: use-after-free in register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
Read of size 1 at addr ffff88807a58b091 by task kworker/u4:3/46

CPU: 0 PID: 46 Comm: kworker/u4:3 Not tainted 6.1.0-rc7-syzkaller-00103-gef4d3ea40565 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:284
 print_report+0x107/0x220 mm/kasan/report.c:395
 kasan_report+0x139/0x170 mm/kasan/report.c:495
 register_lock_class+0x8d2/0x9b0 kernel/locking/lockdep.c:1338
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4934
 lock_acquire+0x1a7/0x400 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd1/0x120 kernel/locking/spinlock.c:162
 __wake_up_common_lock kernel/sched/wait.c:136 [inline]
 __wake_up+0xf8/0x1c0 kernel/sched/wait.c:156
 __usb_hcd_giveback_urb+0x3a0/0x530 drivers/usb/core/hcd.c:1674
 dummy_timer+0x86b/0x3110 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0xf5/0x210 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers+0x76a/0x980 kernel/time/timer.c:1790
 run_timer_softirq+0x63/0xf0 kernel/time/timer.c:1803
 __do_softirq+0x277/0x75b kernel/softirq.c:571
 __irq_exit_rcu+0xec/0x170 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x91/0xb0 arch/x86/kernel/apic/apic.c:1107
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x21e/0x400 kernel/locking/lockdep.c:5672
Code: 23 00 74 08 4c 89 f7 e8 20 aa 75 00 f6 44 24 61 02 0f 85 76 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 04 2c 00 00 00 00 43 c7 44 2c 09 00 00 00 00 43 c7 44 2c 11
RSP: 0018:ffffc90000b77a60 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff9200016ef58 RCX: ffff888018f2c4c8
RDX: dffffc0000000000 RSI: ffffffff8b0da2a0 RDI: ffffffff8b68fcc0
RBP: ffffc90000b77bb8 R08: dffffc0000000000 R09: fffffbfff20e4c29
R10: fffffbfff20e4c29 R11: 1ffffffff20e4c28 R12: dffffc0000000000
R13: 1ffff9200016ef54 R14: ffffc90000b77ac0 R15: 0000000000000246
 rcu_lock_acquire+0x2a/0x30 include/linux/rcupdate.h:304
 rcu_read_lock include/linux/rcupdate.h:738 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:408 [inline]
 batadv_nc_worker+0xc8/0x5b0 net/batman-adv/network-coding.c:719
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 3741:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 __kasan_kmalloc+0x97/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:553 [inline]
 kzalloc include/linux/slab.h:689 [inline]
 xpad_probe+0x3de/0x1b70 drivers/input/joystick/xpad.c:1954
 usb_probe_interface+0x66e/0xb60 drivers/usb/core/driver.c:396
 call_driver_probe+0x96/0x250
 really_probe+0x24c/0x9f0 drivers/base/dd.c:639
 __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:778
 driver_probe_device+0x50/0x240 drivers/base/dd.c:808
 __device_attach_driver+0x272/0x3c0 drivers/base/dd.c:936
 bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
 __device_attach+0x372/0x5a0 drivers/base/dd.c:1008
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
 device_add+0xb20/0xf90 drivers/base/core.c:3517
 usb_set_configuration+0x1a5f/0x20e0 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0x83/0x140 drivers/usb/core/generic.c:238
 usb_probe_device+0x131/0x260 drivers/usb/core/driver.c:293
 call_driver_probe+0x96/0x250
 really_probe+0x24c/0x9f0 drivers/base/dd.c:639
 __driver_probe_device+0x1f4/0x3f0 drivers/base/dd.c:778
 driver_probe_device+0x50/0x240 drivers/base/dd.c:808
 __device_attach_driver+0x272/0x3c0 drivers/base/dd.c:936
 bus_for_each_drv+0x18a/0x210 drivers/base/bus.c:427
 __device_attach+0x372/0x5a0 drivers/base/dd.c:1008
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:487
 device_add+0xb20/0xf90 drivers/base/core.c:3517
 usb_new_device+0xbc2/0x18b0 drivers/usb/core/hub.c:2573
 hub_port_connect+0x103b/0x2910 drivers/usb/core/hub.c:5353
 hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
 port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
 hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 3709:
 kasan_save_stack mm/kasan/common.c:45 [inline]
 kasan_set_track+0x4c/0x70 mm/kasan/common.c:52
 kasan_save_free_info+0x27/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0x71/0x110 mm/slub.c:3674
 xpad_disconnect+0x332/0x450 drivers/input/joystick/xpad.c:2135
 usb_unbind_interface+0x1f2/0x860 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x5bc/0x8a0 drivers/base/dd.c:1275
 bus_remove_device+0x2fd/0x410 drivers/base/bus.c:529
 device_del+0x6ec/0xbe0 drivers/base/core.c:3704
 usb_disable_device+0x3dd/0x820 drivers/usb/core/message.c:1419
 usb_disconnect+0x346/0x890 drivers/usb/core/hub.c:2235
 hub_port_connect+0x296/0x2910 drivers/usb/core/hub.c:5197
 hub_port_connect_change+0x619/0xbe0 drivers/usb/core/hub.c:5497
 port_event+0xec6/0x13b0 drivers/usb/core/hub.c:5653
 hub_event+0x5c1/0xd80 drivers/usb/core/hub.c:5735
 process_one_work+0x81c/0xd10 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88807a58b000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 145 bytes inside of
 1024-byte region [ffff88807a58b000, ffff88807a58b400)

The buggy address belongs to the physical page:
page:ffffea0001e96200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x7a588
head:ffffea0001e96200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888012841dc0
raw: 0000000000000000 0000000000100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd2a20(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3623, tgid 3621 (syz-fuzzer), ts 88914482150, free_ts 88747836155
 prep_new_page mm/page_alloc.c:2539 [inline]
 get_page_from_freelist+0x72b/0x7a0 mm/page_alloc.c:4291
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 alloc_slab_page+0x70/0xf0 mm/slub.c:1794
 allocate_slab+0x5e/0x4b0 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0x7f4/0xeb0 mm/slub.c:3180
 __slab_alloc mm/slub.c:3279 [inline]
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x252/0x310 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc_node_track_caller+0x9c/0x190 mm/slab_common.c:975
 kmalloc_reserve net/core/skbuff.c:437 [inline]
 __alloc_skb+0x11d/0x620 net/core/skbuff.c:509
 alloc_skb include/linux/skbuff.h:1267 [inline]
 __tcp_send_ack+0x98/0x5f0 net/ipv4/tcp_output.c:3960
 tcp_cleanup_rbuf net/ipv4/tcp.c:1628 [inline]
 tcp_recvmsg_locked+0x1cf8/0x25f0 net/ipv4/tcp.c:2649
 tcp_recvmsg+0x22b/0x8b0 net/ipv4/tcp.c:2679
 inet_recvmsg+0x13a/0x250 net/ipv4/af_inet.c:861
 sock_recvmsg_nosec net/socket.c:995 [inline]
 sock_recvmsg net/socket.c:1013 [inline]
 sock_read_iter+0x3fa/0x530 net/socket.c:1086
 call_read_iter include/linux/fs.h:2193 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7cf/0xbc0 fs/read_write.c:470
 ksys_read+0x19b/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1459 [inline]
 free_pcp_prepare+0x80c/0x8f0 mm/page_alloc.c:1509
 free_unref_page_prepare mm/page_alloc.c:3387 [inline]
 free_unref_page+0x7d/0x630 mm/page_alloc.c:3483
 __skb_frag_unref include/linux/skbuff.h:3385 [inline]
 skb_release_data+0x37a/0x6d0 net/core/skbuff.c:783
 skb_release_all net/core/skbuff.c:854 [inline]
 __kfree_skb+0x56/0x1d0 net/core/skbuff.c:868
 tcp_eat_recv_skb net/ipv4/tcp.c:1638 [inline]
 tcp_recvmsg_locked+0x14b2/0x25f0 net/ipv4/tcp.c:2633
 tcp_recvmsg+0x22b/0x8b0 net/ipv4/tcp.c:2679
 inet_recvmsg+0x13a/0x250 net/ipv4/af_inet.c:861
 sock_recvmsg_nosec net/socket.c:995 [inline]
 sock_recvmsg net/socket.c:1013 [inline]
 sock_read_iter+0x3fa/0x530 net/socket.c:1086
 call_read_iter include/linux/fs.h:2193 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x7cf/0xbc0 fs/read_write.c:470
 ksys_read+0x19b/0x2c0 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88807a58af80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807a58b000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88807a58b080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88807a58b100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88807a58b180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	23 00                	and    (%rax),%eax
   2:	74 08                	je     0xc
   4:	4c 89 f7             	mov    %r14,%rdi
   7:	e8 20 aa 75 00       	callq  0x75aa2c
   c:	f6 44 24 61 02       	testb  $0x2,0x61(%rsp)
  11:	0f 85 76 01 00 00    	jne    0x18d
  17:	41 f7 c7 00 02 00 00 	test   $0x200,%r15d
  1e:	74 01                	je     0x21
  20:	fb                   	sti
  21:	48 c7 44 24 40 0e 36 	movq   $0x45e0360e,0x40(%rsp)
  28:	e0 45
* 2a:	4b c7 04 2c 00 00 00 	movq   $0x0,(%r12,%r13,1) <-- trapping instruction
  31:	00
  32:	43 c7 44 2c 09 00 00 	movl   $0x0,0x9(%r12,%r13,1)
  39:	00 00
  3b:	43                   	rex.XB
  3c:	c7                   	.byte 0xc7
  3d:	44 2c 11             	rex.R sub $0x11,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
