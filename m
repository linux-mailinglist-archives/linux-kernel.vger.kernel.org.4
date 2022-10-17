Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63D5601B96
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJQV5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiJQV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:57:43 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9CB161129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:57:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id s3-20020a5eaa03000000b006bbdfc81c6fso8200465ioe.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 14:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cPdOTDLxWttWGHhja7tzFsogPrL1fh9/7lBz6DJ5CYQ=;
        b=pDVueruKt2qwtTtceJGzwNYpG7Srte1q/of7sVsfsCIVGmRIj6vw/zXxnWUgFa0hy+
         iZC0OGDf+R0OJImjSVur88bpIj0gNi9blSsb4UYQ+dnuIEXt9+jG/owxFr2UU4b63r1o
         qSVPcoMqsxCASRXXRXRF4Uvt9Tqg2zmXQ4xsRBv1R+1ueG41Dg9VBBByTpEeUCuev38u
         QlN+Cq/UHNwojfg+3Z3kyYle7xIYrnni1lsQJrr9appurOULfU0j9s/0yXj2mJEM6ZTh
         UN2kHQf3NYQEbXVw/N3xK4OVTDXpphEbIqTNVx6a5lWZhhtLhNTYX5PRtyJofPBnBcHG
         hozQ==
X-Gm-Message-State: ACrzQf2az4hXLaJEEmtkIVF1zYpkhVZp6LLBezhKw0XN6qXIcUG1yN4d
        uJCByppgXkT5E3/+8Zx5VsgrJIurqiUgI+mskEQnQokjOS7q
X-Google-Smtp-Source: AMsMyM4XKYU6+oW+t9UciF7lxiLnX5y74Wl7H1fvQFz6MDaB7LB8OkTxFGWdJFxI+LZ+KVEfIUXHg0Gs/hhNv4W2xRf+pwwr9YlJ
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1885:b0:2fa:1ae2:2902 with SMTP id
 o5-20020a056e02188500b002fa1ae22902mr5742247ilu.283.1666043859148; Mon, 17
 Oct 2022 14:57:39 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:57:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000067a90805eb42107d@google.com>
Subject: [syzbot] KASAN: use-after-free Read in nilfs_iget
From:   syzbot <syzbot+e7b15dcc1051f8b99e58@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1368e0aa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=e7b15dcc1051f8b99e58
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e7b15dcc1051f8b99e58@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 2048
==================================================================
BUG: KASAN: use-after-free in __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
BUG: KASAN: use-after-free in nilfs_iget+0x242/0x8b0 fs/nilfs2/inode.c:603
Read of size 8 at addr ffff8880201cba30 by task syz-executor.5/22617

CPU: 1 PID: 22617 Comm: syz-executor.5 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 print_address_description+0x65/0x4b0 mm/kasan/report.c:317
 print_report+0x108/0x1f0 mm/kasan/report.c:433
 kasan_report+0xc3/0xf0 mm/kasan/report.c:495
 __nilfs_read_inode fs/nilfs2/inode.c:477 [inline]
 nilfs_iget+0x242/0x8b0 fs/nilfs2/inode.c:603
 nilfs_lookup+0xca/0x110 fs/nilfs2/namei.c:63
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x10e6/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7bb388b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7bb4a20168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f7bb39abf80 RCX: 00007f7bb388b5a9
RDX: 0000000000010000 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f7bb38e6580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000082 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc185e581f R14: 00007f7bb4a20300 R15: 0000000000022000
 </TASK>

Allocated by task 22617:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 ____kasan_kmalloc+0xcd/0x100 mm/kasan/common.c:516
 kasan_kmalloc include/linux/kasan.h:234 [inline]
 kmem_cache_alloc_trace+0x97/0x310 mm/slub.c:3289
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 nilfs_find_or_create_root+0x142/0x4f0 fs/nilfs2/the_nilfs.c:747
 nilfs_attach_checkpoint+0xcd/0x4a0 fs/nilfs2/super.c:519
 nilfs_fill_super+0x2e8/0x5d0 fs/nilfs2/super.c:1064
 nilfs_mount+0x613/0x9b0 fs/nilfs2/super.c:1317
 legacy_get_tree+0xea/0x180 fs/fs_context.c:610
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 22617:
 kasan_save_stack mm/kasan/common.c:38 [inline]
 kasan_set_track+0x3d/0x60 mm/kasan/common.c:45
 kasan_set_free_info+0x1f/0x40 mm/kasan/generic.c:370
 ____kasan_slab_free+0xd8/0x120 mm/kasan/common.c:367
 kasan_slab_free include/linux/kasan.h:200 [inline]
 slab_free_hook mm/slub.c:1759 [inline]
 slab_free_freelist_hook+0x12e/0x1a0 mm/slub.c:1785
 slab_free mm/slub.c:3539 [inline]
 kfree+0xda/0x210 mm/slub.c:4567
 nilfs_evict_inode+0x253/0x3d0 fs/nilfs2/inode.c:924
 evict+0x2a4/0x620 fs/inode.c:664
 nilfs_new_inode+0x6b8/0x8a0
 nilfs_create+0xdc/0x2d0 fs/nilfs2/namei.c:85
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_creat fs/open.c:1402 [inline]
 __se_sys_creat fs/open.c:1396 [inline]
 __x64_sys_creat+0x11f/0x160 fs/open.c:1396
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x2b/0x50 mm/kasan/common.c:38
 __kasan_record_aux_stack+0xaf/0xc0 mm/kasan/generic.c:348
 kvfree_call_rcu+0x112/0x880 kernel/rcu/tree.c:3341
 drop_sysctl_table+0x307/0x480 fs/proc/proc_sysctl.c:1716
 drop_sysctl_table+0x319/0x480 fs/proc/proc_sysctl.c:1719
 unregister_sysctl_table+0x87/0x140 fs/proc/proc_sysctl.c:1754
 neigh_sysctl_unregister+0x74/0x90 net/core/neighbour.c:3871
 devinet_sysctl_unregister net/ipv4/devinet.c:2638 [inline]
 inetdev_event+0xe25/0x14a0 net/ipv4/devinet.c:1610
 notifier_call_chain kernel/notifier.c:87 [inline]
 raw_notifier_call_chain+0xe7/0x170 kernel/notifier.c:455
 call_netdevice_notifiers_info net/core/dev.c:1945 [inline]
 call_netdevice_notifiers_extack net/core/dev.c:1983 [inline]
 call_netdevice_notifiers net/core/dev.c:1997 [inline]
 dev_change_name+0x695/0x990 net/core/dev.c:1226
 do_setlink+0xa73/0x3d40 net/core/rtnetlink.c:2761
 __rtnl_newlink net/core/rtnetlink.c:3547 [inline]
 rtnl_newlink+0x1748/0x1fa0 net/core/rtnetlink.c:3594
 rtnetlink_rcv_msg+0x772/0xe60 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x9b3/0xcd0 net/netlink/af_netlink.c:1921
 sock_sendmsg_nosec net/socket.c:714 [inline]
 sock_sendmsg net/socket.c:734 [inline]
 __sys_sendto+0x46e/0x5f0 net/socket.c:2117
 __do_sys_sendto net/socket.c:2129 [inline]
 __se_sys_sendto net/socket.c:2125 [inline]
 __x64_sys_sendto+0xda/0xf0 net/socket.c:2125
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff8880201cba00
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 48 bytes inside of
 256-byte region [ffff8880201cba00, ffff8880201cbb00)

The buggy address belongs to the physical page:
page:ffffea0000807280 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x201ca
head:ffffea0000807280 order:1 compound_mapcount:0 compound_pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000010200 ffffea00011eb480 dead000000000005 ffff888012041b40
raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 3644, tgid 3644 (syz-executor.5), ts 137885168909, free_ts 135490844091
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x742/0x7c0 mm/page_alloc.c:4283
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5549
 alloc_slab_page+0x70/0xf0 mm/slub.c:1829
 allocate_slab+0x5e/0x520 mm/slub.c:1974
 new_slab mm/slub.c:2034 [inline]
 ___slab_alloc+0x3ee/0xc40 mm/slub.c:3036
 __slab_alloc mm/slub.c:3123 [inline]
 slab_alloc_node mm/slub.c:3214 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 __kmalloc+0x2bd/0x370 mm/slub.c:4425
 kmalloc include/linux/slab.h:605 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 new_dir fs/proc/proc_sysctl.c:978 [inline]
 get_subdir fs/proc/proc_sysctl.c:1022 [inline]
 __register_sysctl_table+0xb63/0x11e0 fs/proc/proc_sysctl.c:1373
 __addrconf_sysctl_register+0x25e/0x3b0 net/ipv6/addrconf.c:7083
 addrconf_sysctl_register+0x128/0x180 net/ipv6/addrconf.c:7130
 ipv6_add_dev+0xc44/0x1200 net/ipv6/addrconf.c:450
 ipv6_find_idev+0xa3/0x1b0 net/ipv6/addrconf.c:488
 inet6_rtm_newaddr+0x634/0x2080 net/ipv6/addrconf.c:4908
 rtnetlink_rcv_msg+0x772/0xe60 net/core/rtnetlink.c:6091
 netlink_rcv_skb+0x1f0/0x460 net/netlink/af_netlink.c:2540
 netlink_unicast_kernel net/netlink/af_netlink.c:1319 [inline]
 netlink_unicast+0x7e7/0x9c0 net/netlink/af_netlink.c:1345
 netlink_sendmsg+0x9b3/0xcd0 net/netlink/af_netlink.c:1921
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x812/0x900 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x7d/0x5f0 mm/page_alloc.c:3476
 free_slab mm/slub.c:2073 [inline]
 discard_slab mm/slub.c:2079 [inline]
 __unfreeze_partials+0x1ab/0x200 mm/slub.c:2553
 put_cpu_partial+0x106/0x170 mm/slub.c:2629
 qlist_free_all+0x2b/0x70 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x169/0x180 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x2f/0xd0 mm/kasan/common.c:447
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc_node mm/slub.c:3248 [inline]
 slab_alloc mm/slub.c:3256 [inline]
 kmem_cache_alloc_trace+0x1de/0x310 mm/slub.c:3287
 kmalloc include/linux/slab.h:600 [inline]
 kzalloc include/linux/slab.h:733 [inline]
 tomoyo_dump_page+0xdb/0x440 security/tomoyo/domain.c:906
 tomoyo_scan_bprm security/tomoyo/condition.c:130 [inline]
 tomoyo_condition+0x1cd8/0x2b70 security/tomoyo/condition.c:1120
 tomoyo_check_acl+0x17a/0x410 security/tomoyo/domain.c:177
 tomoyo_execute_permission+0x134/0x410 security/tomoyo/file.c:615
 tomoyo_find_next_domain+0x41a/0x1d80 security/tomoyo/domain.c:752
 tomoyo_bprm_check_security+0xe3/0x130 security/tomoyo/tomoyo.c:101
 security_bprm_check+0x50/0xb0 security/security.c:869
 search_binary_handler fs/exec.c:1713 [inline]
 exec_binprm fs/exec.c:1766 [inline]
 bprm_execve+0x817/0x1590 fs/exec.c:1835

Memory state around the buggy address:
 ffff8880201cb900: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880201cb980: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880201cba00: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                     ^
 ffff8880201cba80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff8880201cbb00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
