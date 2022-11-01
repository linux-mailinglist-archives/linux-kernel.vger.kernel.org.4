Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D0614C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 14:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKANw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKANwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:52:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C41654A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 06:52:51 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i6-20020a5d88c6000000b006d088a0e518so4642136iol.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 06:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQAebY4LnEcog0Ro8jb3Rg8R813uV+gD3mxSZiPxCoQ=;
        b=TmxNgPzt11IoSNplvkSO9tNWfXEa2i6GbHaOXsOOUMydkIALaE+9GtA6ZuXtxec3RX
         qZ4ubD4yFEQhmDpVvOfD1ukjSuWO4faqVGGdFE49qAUiIa8fxToQosy2pI66FSBAVSKQ
         bEoOFtmiSOnvyR7aVnDp+6YO4L64QgCBroYCj0MGzdZo8/AJNRzcgNdqaBoHQ8BdkQcU
         AvAxre0f+9Ik5tbE2h7/9n8K9lMrRYah5umyVEkDVl0v+/NDLxWZitz4hfPIiqzGCmts
         SJxSowoV75s0rgDiHqSipU2tEg381BVgS5tO5lPGijnyfIdFywM+N2vgKtdFxGLHzOs6
         EbVA==
X-Gm-Message-State: ACrzQf1B/ySa3lYBS0P864ioTuzO2AxFlhBfSin5puNSRfHOQM73gmrE
        XgOyosnSaCsdNwaWLIvxKtvxT6K6gzckFRaILrjZfG/F2dPl
X-Google-Smtp-Source: AMsMyM6hA5kLdV+BQ+h0fjUMKrTA8PxVHxiYXgm3WOfQCTf+bK3LMshz9k4wo/6c4EuiMZGqIV9A8/DtZ2FZ6UfFTXoIrbBXQFe9
MIME-Version: 1.0
X-Received: by 2002:a92:7c0b:0:b0:300:bde4:2a72 with SMTP id
 x11-20020a927c0b000000b00300bde42a72mr4502584ilc.304.1667310770561; Tue, 01
 Nov 2022 06:52:50 -0700 (PDT)
Date:   Tue, 01 Nov 2022 06:52:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035aab005ec690a00@google.com>
Subject: [syzbot] KASAN: use-after-free Read in gsm_cleanup_mux
From:   syzbot <syzbot+893c55305230e719a203@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=135f174a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=893c55305230e719a203
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7a7054f95968/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/907d97ef4d30/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5f5f3eb6d623/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+893c55305230e719a203@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in gsm_cleanup_mux+0x785/0x800 drivers/tty/n_gsm.c:2487
Read of size 4 at addr ffff888043d4900c by task syz-executor.0/29846

CPU: 0 PID: 29846 Comm: syz-executor.0 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 gsm_cleanup_mux+0x785/0x800 drivers/tty/n_gsm.c:2487
 gsm_config drivers/tty/n_gsm.c:2752 [inline]
 gsmld_ioctl+0x52f/0x1060 drivers/tty/n_gsm.c:3113
 tty_ioctl+0x741/0x1590 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fe6f6a8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe6f5dff168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe6f6bac050 RCX: 00007fe6f6a8b5a9
RDX: 0000000020000040 RSI: 00000000404c4701 RDI: 0000000000000004
RBP: 00007fe6f6ae67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe6f6ccfb1f R14: 00007fe6f5dff300 R15: 0000000000022000
 </TASK>

Allocated by task 29778:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:371 [inline]
 ____kasan_kmalloc mm/kasan/common.c:330 [inline]
 __kasan_kmalloc+0xa1/0xb0 mm/kasan/common.c:380
 kmalloc include/linux/slab.h:576 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 gsm_dlci_alloc+0x46/0x480 drivers/tty/n_gsm.c:2060
 gsm_activate_mux drivers/tty/n_gsm.c:2534 [inline]
 gsm_config drivers/tty/n_gsm.c:2776 [inline]
 gsmld_ioctl+0x7fc/0x1060 drivers/tty/n_gsm.c:3113
 tty_ioctl+0x741/0x1590 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 29841:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 kasan_set_track+0x21/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2a/0x40 mm/kasan/generic.c:511
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:177 [inline]
 slab_free_hook mm/slub.c:1724 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0xab/0x3b0 mm/slub.c:3674
 tty_port_destructor drivers/tty/tty_port.c:296 [inline]
 kref_put include/linux/kref.h:65 [inline]
 tty_port_put+0x158/0x1c0 drivers/tty/tty_port.c:311
 dlci_put drivers/tty/n_gsm.c:2116 [inline]
 gsm_dlci_release drivers/tty/n_gsm.c:2149 [inline]
 gsm_cleanup_mux+0x2f6/0x800 drivers/tty/n_gsm.c:2508
 gsm_config drivers/tty/n_gsm.c:2752 [inline]
 gsmld_ioctl+0x52f/0x1060 drivers/tty/n_gsm.c:3113
 tty_ioctl+0x741/0x1590 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2798
 netlink_release+0xeff/0x1db0 net/netlink/af_netlink.c:815
 __sock_release net/socket.c:650 [inline]
 sock_release+0x87/0x1b0 net/socket.c:678
 netlink_kernel_release+0x4b/0x60 net/netlink/af_netlink.c:2107
 nfnetlink_net_exit_batch+0x10e/0x320 net/netfilter/nfnetlink.c:781
 ops_exit_list+0x125/0x170 net/core/net_namespace.c:174
 cleanup_net+0x4ea/0xb00 net/core/net_namespace.c:601
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Second to last potentially related work creation:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:481
 call_rcu+0x99/0x820 kernel/rcu/tree.c:2798
 netlink_release+0xeff/0x1db0 net/netlink/af_netlink.c:815
 __sock_release+0xcd/0x280 net/socket.c:650
 sock_close+0x18/0x20 net/socket.c:1365
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16b/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xb35/0x2a20 kernel/exit.c:820
 do_group_exit+0xd0/0x2a0 kernel/exit.c:950
 get_signal+0x21a1/0x2430 kernel/signal.c:2858
 arch_do_signal_or_restart+0x82/0x2300 arch/x86/kernel/signal.c:869
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x15f/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x19/0x50 kernel/entry/common.c:296
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff888043d49000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 12 bytes inside of
 2048-byte region [ffff888043d49000, ffff888043d49800)

The buggy address belongs to the physical page:
page:ffffea00010f5200 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x43d48
head:ffffea00010f5200 order:3 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 0000000000000000 dead000000000001 ffff888011842000
raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3654, tgid 3654 (syz-executor.0), ts 139828475845, free_ts 12080707870
 prep_new_page mm/page_alloc.c:2538 [inline]
 get_page_from_freelist+0x10b5/0x2d50 mm/page_alloc.c:4287
 __alloc_pages+0x1c7/0x5a0 mm/page_alloc.c:5554
 alloc_pages+0x1a6/0x270 mm/mempolicy.c:2285
 alloc_slab_page mm/slub.c:1794 [inline]
 allocate_slab+0x213/0x300 mm/slub.c:1939
 new_slab mm/slub.c:1992 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3180
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3279
 slab_alloc_node mm/slub.c:3364 [inline]
 __kmem_cache_alloc_node+0x191/0x3e0 mm/slub.c:3437
 __do_kmalloc_node mm/slab_common.c:954 [inline]
 __kmalloc+0x44/0xc0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:581 [inline]
 kzalloc include/linux/slab.h:712 [inline]
 ops_init+0x241/0x680 net/core/net_namespace.c:125
 setup_net+0x5d1/0xc50 net/core/net_namespace.c:332
 copy_net_ns+0x318/0x760 net/core/net_namespace.c:478
 create_new_namespaces+0x3f6/0xb20 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0xc1/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x445/0x920 kernel/fork.c:3188
 __do_sys_unshare kernel/fork.c:3259 [inline]
 __se_sys_unshare kernel/fork.c:3257 [inline]
 __x64_sys_unshare+0x2d/0x40 kernel/fork.c:3257
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1458 [inline]
 free_pcp_prepare+0x65c/0xd90 mm/page_alloc.c:1508
 free_unref_page_prepare mm/page_alloc.c:3386 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3482
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9492
 destroy_args+0xa8/0x64c mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2954/0x29e5 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0x13d/0x780 init/main.c:1303
 do_initcall_level init/main.c:1376 [inline]
 do_initcalls init/main.c:1392 [inline]
 do_basic_setup init/main.c:1411 [inline]
 kernel_init_freeable+0x6ff/0x788 init/main.c:1631
 kernel_init+0x1a/0x1d0 init/main.c:1519
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff888043d48f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888043d48f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff888043d49000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                      ^
 ffff888043d49080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888043d49100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
