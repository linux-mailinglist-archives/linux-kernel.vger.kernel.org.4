Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 649E45F1C75
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiJANoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiJANn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:43:58 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A62489AF9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:43:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id h10-20020a056e021d8a00b002f99580de6cso649942ila.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=UVg3yMWLRAZOpEzmxyRpUtFRrXH9hbLLP4ZomxrUBoQ=;
        b=wUGC1XQx7dh54nbcr+idcgEcC8RXMG2lJ3grH+iB5yCIpspyTnfT3xliLYJctDZobI
         CxYUFzE9zNrW5tttpvu+gpntt7qCSmbHzMHMLG7/cGAu+HcHG8e8UUOv4m1iBv0qNXg3
         rK/l9kC1Djv3MFOeumfzuXVKjAht3ADHai1AdFj27WlHxTssY+92Sq9xEesrg9g3C5Le
         dMztnWuNzoEzVOHzNo4fCWwPj+/bNRVQmkWWb5SQxfqCNUCzQ6B3HFF85S3RWmyeyYuf
         vYzZfQfJvue8k2cbPRYdEUEyNg2+DGQzzadWoV4pt+NKh78TLGSJZf08pbyPSteksesJ
         csMQ==
X-Gm-Message-State: ACrzQf0Yc2SzOdHSco3DhZO/KdMWkTBoejR46VD0qOoZtMtX0+Wb3xKE
        c8yaoG9tbtrxa2d6K/rHWZNuBBOKb55OOyuQbK48qarH3T0O
X-Google-Smtp-Source: AMsMyM6NHGdJnjT019ctP7XSicleI1nmor/D1fXj1mXIq9oG0jwp1jq/NktqgGSQA4sIkEs1Zh7MmmiGegtib/2H2fK0kxmtfHDh
MIME-Version: 1.0
X-Received: by 2002:a05:6638:f83:b0:35a:d85:ab65 with SMTP id
 h3-20020a0566380f8300b0035a0d85ab65mr6930220jal.240.1664631818435; Sat, 01
 Oct 2022 06:43:38 -0700 (PDT)
Date:   Sat, 01 Oct 2022 06:43:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038435e05e9f94cd4@google.com>
Subject: [syzbot] KASAN: use-after-free Read in usb_anchor_resume_wakeups (4)
From:   syzbot <syzbot+59d3714b44d79d02f944@syzkaller.appspotmail.com>
To:     WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
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

HEAD commit:    3800a713b607 Merge tag 'mm-hotfixes-stable-2022-09-26' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f6999c880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=59d3714b44d79d02f944
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+59d3714b44d79d02f944@syzkaller.appspotmail.com

xpad 6-1:179.65: xpad_irq_in - usb_submit_urb failed with result -19
xpad 6-1:179.65: xpad_irq_out - usb_submit_urb failed with result -19
==================================================================
BUG: KASAN: use-after-free in register_lock_class+0xe6a/0x1120 kernel/locking/lockdep.c:1336
Read of size 1 at addr ffff88801ebd7891 by task kswapd1/128

CPU: 1 PID: 128 Comm: kswapd1 Not tainted 6.0.0-rc7-syzkaller-00029-g3800a713b607 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x6e9 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 register_lock_class+0xe6a/0x1120 kernel/locking/lockdep.c:1336
 __lock_acquire+0x109/0x56d0 kernel/locking/lockdep.c:4932
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
 __wake_up_common_lock+0xb4/0x130 kernel/sched/wait.c:136
 usb_anchor_resume_wakeups drivers/usb/core/urb.c:958 [inline]
 usb_anchor_resume_wakeups+0xbe/0xe0 drivers/usb/core/urb.c:951
 __usb_hcd_giveback_urb+0x2df/0x5c0 drivers/usb/core/hcd.c:1674
 usb_hcd_giveback_urb+0x380/0x430 drivers/usb/core/hcd.c:1754
 dummy_timer+0x11ff/0x32c0 drivers/usb/gadget/udc/dummy_hcd.c:1988
 call_timer_fn+0x1a0/0x6b0 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers.part.0+0x674/0xa80 kernel/time/timer.c:1790
 __run_timers kernel/time/timer.c:1768 [inline]
 run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1803
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571
 invoke_softirq kernel/softirq.c:445 [inline]
 __irq_exit_rcu+0x123/0x180 kernel/softirq.c:650
 irq_exit_rcu+0x5/0x20 kernel/softirq.c:662
 sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1106
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x16/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:lock_acquire+0x1ef/0x570 kernel/locking/lockdep.c:5634
Code: d1 a3 7e 83 f8 01 0f 85 e8 02 00 00 9c 58 f6 c4 02 0f 85 fb 02 00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc90001faf970 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920003f5f30 RCX: 62e6639de71c39f1
RDX: 1ffff1100314f556 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: ffffffff908e1947
R10: fffffbfff211c328 R11: 0000000000000000 R12: 0000000000000002
R13: 0000000000000000 R14: ffffffff8bf86900 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:280 [inline]
 rcu_read_lock include/linux/rcupdate.h:706 [inline]
 percpu_ref_put_many.constprop.0+0x2c/0x1a0 include/linux/percpu-refcount.h:330
 percpu_ref_put include/linux/percpu-refcount.h:351 [inline]
 css_put include/linux/cgroup.h:404 [inline]
 mem_cgroup_iter+0x2df/0x6e0 mm/memcontrol.c:1102
 shrink_node_memcgs mm/vmscan.c:3191 [inline]
 shrink_node+0x5c6/0x1e80 mm/vmscan.c:3304
 kswapd_shrink_node mm/vmscan.c:4086 [inline]
 balance_pgdat+0x8ef/0x1580 mm/vmscan.c:4277
 kswapd+0x79b/0xf80 mm/vmscan.c:4537
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

Allocated by task 3966:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa6/0xd0 mm/kasan/common.c:525
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x25a/0x460 mm/slab.c:3559
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 xpad_probe+0x26c/0x1c20 drivers/input/joystick/xpad.c:1757
 usb_probe_interface+0x30b/0x7f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_set_configuration+0x1019/0x1900 drivers/usb/core/message.c:2170
 usb_generic_driver_probe+0xba/0x100 drivers/usb/core/generic.c:238
 usb_probe_device+0xd4/0x2c0 drivers/usb/core/driver.c:293
 call_driver_probe drivers/base/dd.c:560 [inline]
 really_probe+0x249/0xb90 drivers/base/dd.c:639
 __driver_probe_device+0x1df/0x4d0 drivers/base/dd.c:778
 driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:808
 __device_attach_driver+0x1d0/0x2e0 drivers/base/dd.c:936
 bus_for_each_drv+0x15f/0x1e0 drivers/base/bus.c:427
 __device_attach+0x1e4/0x530 drivers/base/dd.c:1008
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:487
 device_add+0xbd5/0x1e90 drivers/base/core.c:3517
 usb_new_device.cold+0x685/0x10ad drivers/usb/core/hub.c:2573
 hub_port_connect drivers/usb/core/hub.c:5353 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x26c7/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Freed by task 3889:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track+0x21/0x30 mm/kasan/common.c:45
 kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:370
 ____kasan_slab_free mm/kasan/common.c:367 [inline]
 ____kasan_slab_free+0x13d/0x1a0 mm/kasan/common.c:329
 kasan_slab_free include/linux/kasan.h:200 [inline]
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x173/0x390 mm/slab.c:3786
 xpad_disconnect+0x1cb/0x530 drivers/input/joystick/xpad.c:1905
 usb_unbind_interface+0x1d8/0x8e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:550 [inline]
 device_remove+0x11f/0x170 drivers/base/dd.c:542
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 usb_disable_device+0x356/0x7a0 drivers/usb/core/message.c:1419
 usb_disconnect.cold+0x259/0x6ed drivers/usb/core/hub.c:2235
 hub_port_connect drivers/usb/core/hub.c:5197 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5497 [inline]
 port_event drivers/usb/core/hub.c:5653 [inline]
 hub_event+0x1f86/0x4610 drivers/usb/core/hub.c:5735
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

The buggy address belongs to the object at ffff88801ebd7800
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 145 bytes inside of
 1024-byte region [ffff88801ebd7800, ffff88801ebd7c00)

The buggy address belongs to the physical page:
page:ffffea00007af5c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1ebd7
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea00007c1a48 ffffea00006c7b48 ffff888011840700
raw: 0000000000000000 ffff88801ebd7000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x2c20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_THISNODE), pid 3637, tgid 3637 (sshd), ts 59138614373, free_ts 55806174800
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages_slowpath.constprop.0+0x34d/0x2300 mm/page_alloc.c:5084
 __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 slab_alloc_node mm/slab.c:3220 [inline]
 kmem_cache_alloc_node_trace+0x50a/0x570 mm/slab.c:3601
 __do_kmalloc_node mm/slab.c:3623 [inline]
 __kmalloc_node_track_caller+0x38/0x60 mm/slab.c:3638
 kmalloc_reserve net/core/skbuff.c:362 [inline]
 __alloc_skb+0xd9/0x2f0 net/core/skbuff.c:434
 alloc_skb_fclone include/linux/skbuff.h:1307 [inline]
 tcp_stream_alloc_skb+0x38/0x580 net/ipv4/tcp.c:861
 tcp_sendmsg_locked+0xc36/0x2f80 net/ipv4/tcp.c:1325
 tcp_sendmsg+0x2b/0x40 net/ipv4/tcp.c:1483
 inet_sendmsg+0x99/0xe0 net/ipv4/af_inet.c:819
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:734
 sock_write_iter+0x291/0x3d0 net/socket.c:1108
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x1e8/0x250 fs/read_write.c:631
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 slab_destroy mm/slab.c:1615 [inline]
 slabs_destroy+0x89/0xc0 mm/slab.c:1635
 cache_flusharray mm/slab.c:3389 [inline]
 ___cache_free+0x2a8/0x3d0 mm/slab.c:3452
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x4f/0x1b0 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x97/0xb0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slab.c:3232 [inline]
 kmem_cache_alloc_node+0x2f1/0x560 mm/slab.c:3583
 alloc_task_struct_node kernel/fork.c:172 [inline]
 dup_task_struct kernel/fork.c:969 [inline]
 copy_process+0x5c2/0x7090 kernel/fork.c:2085
 kernel_clone+0xe7/0xab0 kernel/fork.c:2671
 __do_sys_clone+0xba/0x100 kernel/fork.c:2805
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Memory state around the buggy address:
 ffff88801ebd7780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88801ebd7800: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88801ebd7880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                         ^
 ffff88801ebd7900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88801ebd7980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================
----------------
Code disassembly (best guess):
   0:	d1 a3 7e 83 f8 01    	shll   0x1f8837e(%rbx)
   6:	0f 85 e8 02 00 00    	jne    0x2f4
   c:	9c                   	pushfq
   d:	58                   	pop    %rax
   e:	f6 c4 02             	test   $0x2,%ah
  11:	0f 85 fb 02 00 00    	jne    0x312
  17:	48 83 7c 24 08 00    	cmpq   $0x0,0x8(%rsp)
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
