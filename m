Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30D75E95A7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIYTN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiIYTNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:13:51 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C52F2871E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 12:13:36 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id g1-20020a92cda1000000b002f612391d5bso3743470ild.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 12:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=P4/sNA6nYhk5IsZ3ISC86e5wYArV5qMDjQZ7sDlwQ7w=;
        b=f2HlFE592XJfHrOacw5FiwFFSsZjNIyKFQdSDso50/Js/6I5gfakc0gxG/K2mBRAXo
         FH4jLclk9Q6+trZiN+3k0TYb7xJKqEGEhxBJSa/p3TrJYsOlmXRwAiRrINGN2WvmxOZO
         ftx6nJdcNgE8AcqV+h+bEsaj/a7KuCqFUPY02D6kD84hI1H9VgG6DMzHIXEsNa3fBXN0
         tV/WqKxvA/aI07jy+QL+nm105AyKVl83oV8CUBo13NRKQ9nblvAPrl9XUbYJL2at0Tdl
         CGwhLcER223N6HixEik6Vr28uzZPY5PxRxuRQGhlNWHQQRRZH2TUqw53MeTJFAkOd18Q
         7Hng==
X-Gm-Message-State: ACrzQf3NFION9JA96SjnE+bCFuP7DltKjuvs4rQq0UFjS8e/QYU8a66T
        cLXgk8p5Zs4IOHQUvAm9FD/iCsrYzmjLOkKEJB8DhlPnjM4m
X-Google-Smtp-Source: AMsMyM5th4cc9AG9G68v+YbwJTIE3NkAA5BcCiChvZ4GBqld2AUF+wIRgEym6niLoElMu4JNLjkYWn0mXHBRczexkpgIl/nGVWst
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4907:b0:35a:88c3:594d with SMTP id
 cx7-20020a056638490700b0035a88c3594dmr10028648jab.194.1664133215806; Sun, 25
 Sep 2022 12:13:35 -0700 (PDT)
Date:   Sun, 25 Sep 2022 12:13:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002fea3f05e98535e9@google.com>
Subject: [syzbot] KASAN: invalid-free in ni_clear
From:   syzbot <syzbot+8087f82b01f173e64ea9@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    06f7db949993 Merge tag 'iommu-fixes-v6.0-rc6' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16a70260880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=8087f82b01f173e64ea9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8087f82b01f173e64ea9@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 8189
ntfs3: loop3: Different NTFS' sector size (1024) and media sector size (512)
==================================================================
BUG: KASAN: invalid-free in slab_free mm/slub.c:3534 [inline]
BUG: KASAN: invalid-free in kfree+0xe2/0x580 mm/slub.c:4562

CPU: 0 PID: 16454 Comm: syz-executor.3 Not tainted 6.0.0-rc6-syzkaller-00030-g06f7db949993 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x719 mm/kasan/report.c:433
 kasan_report_invalid_free+0x81/0x190 mm/kasan/report.c:462
 ____kasan_slab_free+0x1ab/0x1c0 mm/kasan/common.c:347
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1754 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1780
 slab_free mm/slub.c:3534 [inline]
 kfree+0xe2/0x580 mm/slub.c:4562
 kvfree+0x42/0x50 mm/util.c:655
 run_close fs/ntfs3/ntfs_fs.h:930 [inline]
 ni_clear+0x2f7/0x690 fs/ntfs3/frecord.c:123
 evict+0x2ed/0x6b0 fs/inode.c:665
 iput_final fs/inode.c:1748 [inline]
 iput.part.0+0x55d/0x810 fs/inode.c:1774
 iput+0x58/0x70 fs/inode.c:1764
 ntfs_fill_super+0x2e89/0x37f0 fs/ntfs3/super.c:1190
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x27e/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7f82549
Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7f7d410 EFLAGS: 00000296 ORIG_RAX: 0000000000000015
RAX: ffffffffffffffda RBX: 00000000f7f7d480 RCX: 0000000020000100
RDX: 0000000020000000 RSI: 0000000000000000 RDI: 00000000f7f7d4c0
RBP: 00000000f7f7d4c0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 16454:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc mm/kasan/common.c:516 [inline]
 ____kasan_kmalloc mm/kasan/common.c:475 [inline]
 __kasan_kmalloc+0xa9/0xd0 mm/kasan/common.c:525
 kmalloc_node include/linux/slab.h:623 [inline]
 kvmalloc_node+0x3e/0x190 mm/util.c:613
 kvmalloc include/linux/slab.h:750 [inline]
 run_add_entry+0x1a4/0xb30 fs/ntfs3/run.c:389
 run_unpack+0x78c/0x970 fs/ntfs3/run.c:1018
 run_unpack_ex+0xb0/0x7c0 fs/ntfs3/run.c:1057
 ntfs_read_mft fs/ntfs3/inode.c:368 [inline]
 ntfs_iget5+0xc20/0x3280 fs/ntfs3/inode.c:501
 ntfs_fill_super+0x258b/0x37f0 fs/ntfs3/super.c:1095
 get_tree_bdev+0x440/0x760 fs/super.c:1323
 vfs_get_tree+0x89/0x2f0 fs/super.c:1530
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1326/0x1e20 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __ia32_sys_mount+0x27e/0x300 fs/namespace.c:3568
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xbe/0xd0 mm/kasan/generic.c:348
 call_rcu+0x99/0x790 kernel/rcu/tree.c:2793
 mpls_dev_notify+0x617/0x9b0 net/mpls/af_mpls.c:1655
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 unregister_netdevice_many+0xa62/0x1980 net/core/dev.c:10862
 unregister_netdevice_queue+0x2dd/0x3c0 net/core/dev.c:10793
 unregister_netdevice include/linux/netdevice.h:3032 [inline]
 nsim_destroy+0x3f/0x190 drivers/net/netdevsim/netdev.c:382
 __nsim_dev_port_del+0x191/0x250 drivers/net/netdevsim/dev.c:1416
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1428 [inline]
 nsim_dev_reload_destroy+0x171/0x510 drivers/net/netdevsim/dev.c:1645
 nsim_drv_remove+0x56/0x190 drivers/net/netdevsim/dev.c:1661
 device_remove+0xc8/0x170 drivers/base/dd.c:548
 __device_release_driver drivers/base/dd.c:1249 [inline]
 device_release_driver_internal+0x4a1/0x700 drivers/base/dd.c:1275
 bus_remove_device+0x2e3/0x590 drivers/base/bus.c:529
 device_del+0x4f3/0xc80 drivers/base/core.c:3704
 device_unregister+0x1a/0xc0 drivers/base/core.c:3736
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:303 [inline]
 del_device_store+0x317/0x470 drivers/net/netdevsim/bus.c:215
 bus_attr_store+0x72/0xa0 drivers/base/bus.c:122
 sysfs_kf_write+0x110/0x160 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x3f8/0x610 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff88801bd56680
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 63 bytes to the right of
 64-byte region [ffff88801bd56680, ffff88801bd566c0)

The buggy address belongs to the physical page:
page:ffffea00006f5580 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1bd56
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0000768280 dead000000000004 ffff888011842640
raw: 0000000000000000 0000000080200020 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x12cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_NORETRY), pid 3713, tgid 3713 (syz-executor.2), ts 162757960446, free_ts 59215741058
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5515
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:1824 [inline]
 allocate_slab+0x27e/0x3d0 mm/slub.c:1969
 new_slab mm/slub.c:2029 [inline]
 ___slab_alloc+0x7f1/0xe10 mm/slub.c:3031
 __slab_alloc.constprop.0+0x4d/0xa0 mm/slub.c:3118
 slab_alloc_node mm/slub.c:3209 [inline]
 slab_alloc mm/slub.c:3251 [inline]
 kmem_cache_alloc_trace+0x323/0x3e0 mm/slub.c:3282
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 mpls_add_dev net/mpls/af_mpls.c:1455 [inline]
 mpls_dev_notify+0x253/0x9b0 net/mpls/af_mpls.c:1612
 notifier_call_chain+0xb5/0x200 kernel/notifier.c:87
 call_netdevice_notifiers_info+0xb5/0x130 net/core/dev.c:1945
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 register_netdevice+0x1127/0x1680 net/core/dev.c:10103
 veth_newlink+0x33f/0x9a0 drivers/net/veth.c:1764
 rtnl_newlink_create net/core/rtnetlink.c:3363 [inline]
 __rtnl_newlink+0x1087/0x17e0 net/core/rtnetlink.c:3580
 rtnl_newlink+0x64/0xa0 net/core/rtnetlink.c:3593
 rtnetlink_rcv_msg+0x43a/0xca0 net/core/rtnetlink.c:6090
 netlink_rcv_skb+0x153/0x420 net/netlink/af_netlink.c:2501
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 __folio_put_small mm/swap.c:105 [inline]
 __folio_put+0xc1/0x130 mm/swap.c:128
 folio_put include/linux/mm.h:1125 [inline]
 put_page include/linux/mm.h:1177 [inline]
 free_page_and_swap_cache+0x253/0x2c0 mm/swap_state.c:296
 __tlb_remove_table arch/x86/include/asm/tlb.h:34 [inline]
 __tlb_remove_table_free mm/mmu_gather.c:114 [inline]
 tlb_remove_table_rcu+0x85/0xe0 mm/mmu_gather.c:169
 rcu_do_batch kernel/rcu/tree.c:2245 [inline]
 rcu_core+0x7b5/0x1890 kernel/rcu/tree.c:2505
 __do_softirq+0x1d3/0x9c6 kernel/softirq.c:571

Memory state around the buggy address:
 ffff88801bd56580: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801bd56600: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
>ffff88801bd56680: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                                                ^
 ffff88801bd56700: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff88801bd56780: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
==================================================================
----------------
Code disassembly (best guess):
   0:	03 74 c0 01          	add    0x1(%rax,%rax,8),%esi
   4:	10 05 03 74 b8 01    	adc    %al,0x1b87403(%rip)        # 0x1b8740d
   a:	10 06                	adc    %al,(%rsi)
   c:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
  10:	10 07                	adc    %al,(%rdi)
  12:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
  16:	10 08                	adc    %cl,(%rax)
  18:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1c:	00 00                	add    %al,(%rax)
  1e:	00 00                	add    %al,(%rax)
  20:	00 51 52             	add    %dl,0x52(%rcx)
  23:	55                   	push   %rbp
  24:	89 e5                	mov    %esp,%ebp
  26:	0f 34                	sysenter
  28:	cd 80                	int    $0x80
* 2a:	5d                   	pop    %rbp <-- trapping instruction
  2b:	5a                   	pop    %rdx
  2c:	59                   	pop    %rcx
  2d:	c3                   	retq
  2e:	90                   	nop
  2f:	90                   	nop
  30:	90                   	nop
  31:	90                   	nop
  32:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  39:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
