Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23141746908
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjGDFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 01:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDFgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:36:42 -0400
Received: from mail-pg1-f207.google.com (mail-pg1-f207.google.com [209.85.215.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A97E49
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 22:36:41 -0700 (PDT)
Received: by mail-pg1-f207.google.com with SMTP id 41be03b00d2f7-553d42a7069so6917039a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 22:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688449001; x=1691041001;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzZN9jlPehEb8cghfE21EWBk0+wXMjWesy+weSTEmgw=;
        b=XzIFwVcMQBiCy8knJAde28llBvvGrzv1UMrxEDVwTkfxyMZKYRzC+LwU14UaGotKOI
         LZTnda0nST+r76/+cHBovhGwavacLWlCG0OvZVGmzsVKXwf4fYfy0LhYeTVEZqBpO8qA
         3vPKSqQx56xyYbOOa/S89B2Y1eNbJjxZ43rmsprbgCvK77B8vneEew+Pd6Q0qKWrYY68
         M7muYoIS2cbXq6lBX92xcoZQvedYFBL9jj6chjJEhlQ1IhvJqHyngPkbCad/5AaDgKM6
         sjLUdX/69loL7fcIxcZB0JR7yztOkn785bsuZ0lV7InpCSka2iFyG68EsE18N2VSbsVe
         0w5A==
X-Gm-Message-State: ABy/qLZXpElZMK0URJfUdOuKaBxJVs5qL3Eb+f4uKtY/g73+nzf5btjl
        /pJj8hcmaQzNe84Xw3M6bQeziqmtduUsXeS8R0zn7lSD1H8C
X-Google-Smtp-Source: APBJJlFq+v07C3Lu+aXR0klaUE4KT+gsgrbf39NKpG0N4FGQee9DhVNNA6CkPxjV30vLxTBljvFsyHwVaYSrz+1VGjlXbwroLHmz
MIME-Version: 1.0
X-Received: by 2002:a63:4183:0:b0:553:3b6c:b3b3 with SMTP id
 o125-20020a634183000000b005533b6cb3b3mr7364924pga.4.1688449000896; Mon, 03
 Jul 2023 22:36:40 -0700 (PDT)
Date:   Mon, 03 Jul 2023 22:36:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eb827e05ffa2aa4a@google.com>
Subject: [syzbot] [crypto?] KASAN: slab-out-of-bounds Write in
 crypto_sha3_final (2)
From:   syzbot <syzbot+e436ef6c393283630f64@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ae230642190a Merge branch 'af_unix-followup-fixes-for-so_p..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d7cc7f280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c9bf1936936ca698
dashboard link: https://syzkaller.appspot.com/bug?extid=e436ef6c393283630f64
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8c060db03f09/disk-ae230642.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1b9b937ece91/vmlinux-ae230642.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0c7eb1c82bf0/bzImage-ae230642.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e436ef6c393283630f64@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in crypto_sha3_final+0x5e3/0x650 crypto/sha3_generic.c:220
Write of size 1 at addr ffff88802edbd4e3 by task syz-executor.4/14380

CPU: 0 PID: 14380 Comm: syz-executor.4 Not tainted 6.4.0-rc7-syzkaller-01948-gae230642190a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:351
 print_report mm/kasan/report.c:462 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:572
 crypto_sha3_final+0x5e3/0x650 crypto/sha3_generic.c:220
 shash_final_unaligned+0x154/0x220 crypto/shash.c:157
 shash_finup_unaligned+0x5b/0x70 crypto/shash.c:191
 crypto_shash_finup+0xdc/0x160 crypto/shash.c:212
 shash_ahash_finup+0xdf/0x3a0 crypto/shash.c:333
 crypto_ahash_op crypto/ahash.c:303 [inline]
 crypto_ahash_op crypto/ahash.c:292 [inline]
 crypto_ahash_finup+0xed/0x1e0 crypto/ahash.c:332
 hash_sendmsg+0x9d0/0x1150 crypto/algif_hash.c:149
 sock_sendmsg_nosec net/socket.c:724 [inline]
 sock_sendmsg+0xde/0x190 net/socket.c:747
 sock_write_iter+0x295/0x3d0 net/socket.c:1128
 call_write_iter include/linux/fs.h:1868 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x945/0xd50 fs/read_write.c:584
 ksys_write+0x1ec/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f81fd88c389
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f81fe5e8168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f81fd9ac120 RCX: 00007f81fd88c389
RDX: 000000000000010f RSI: 0000000020000300 RDI: 0000000000000006
RBP: 00007f81fd8d7493 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff1397ccff R14: 00007f81fe5e8300 R15: 0000000000022000
 </TASK>

Allocated by task 14377:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc+0x5e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 sock_kmalloc+0xb2/0x100 net/core/sock.c:2683
 hash_accept_parent_nokey+0x54/0x2e0 crypto/algif_hash.c:416
 hash_accept_parent+0x60/0x80 crypto/algif_hash.c:443
 af_alg_accept+0x172/0x5d0 crypto/af_alg.c:436
 do_accept+0x380/0x510 net/socket.c:1871
 __sys_accept4_file net/socket.c:1912 [inline]
 __sys_accept4+0x9a/0x120 net/socket.c:1942
 __do_sys_accept net/socket.c:1959 [inline]
 __se_sys_accept net/socket.c:1956 [inline]
 __x64_sys_accept+0x75/0xb0 net/socket.c:1956
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 netlink_release+0xcde/0x1e40 net/netlink/af_netlink.c:828
 __sock_release+0xcd/0x290 net/socket.c:653
 sock_close+0x1c/0x20 net/socket.c:1385
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaa3/0x29b0 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Second to last potentially related work creation:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 __kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:491
 __call_rcu_common.constprop.0+0x99/0x7e0 kernel/rcu/tree.c:2627
 netlink_release+0xcde/0x1e40 net/netlink/af_netlink.c:828
 __sock_release+0xcd/0x290 net/socket.c:653
 sock_close+0x1c/0x20 net/socket.c:1385
 __fput+0x27c/0xa90 fs/file_table.c:321
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xaa3/0x29b0 kernel/exit.c:874
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
 __do_sys_exit_group kernel/exit.c:1035 [inline]
 __se_sys_exit_group kernel/exit.c:1033 [inline]
 __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88802edbd000
 which belongs to the cache kmalloc-2k of size 2048
The buggy address is located 123 bytes to the right of
 allocated 1128-byte region [ffff88802edbd000, ffff88802edbd468)

The buggy address belongs to the physical page:
page:ffffea0000bb6e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88802edb9000 pfn:0x2edb8
head:ffffea0000bb6e00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 00fff00000010200 ffff888012442000 ffffea0001df1e00 dead000000000002
raw: ffff88802edb9000 0000000080080007 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0x1d20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC|__GFP_HARDWALL), pid 5043, tgid 5043 (syz-executor.4), ts 168507470584, free_ts 0
 set_page_owner include/linux/page_owner.h:31 [inline]
 post_alloc_hook+0x2db/0x350 mm/page_alloc.c:1731
 prep_new_page mm/page_alloc.c:1738 [inline]
 get_page_from_freelist+0xf41/0x2c00 mm/page_alloc.c:3502
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:4768
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2279
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x25f/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3192
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3291
 __slab_alloc_node mm/slub.c:3344 [inline]
 slab_alloc_node mm/slub.c:3441 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3490
 __do_kmalloc_node mm/slab_common.c:965 [inline]
 __kmalloc+0x4e/0x190 mm/slab_common.c:979
 kmalloc include/linux/slab.h:563 [inline]
 sk_prot_alloc+0x140/0x290 net/core/sock.c:2077
 sk_alloc+0x3a/0x7f0 net/core/sock.c:2130
 __netlink_create+0x63/0x380 net/netlink/af_netlink.c:649
 netlink_create+0x3b1/0x5f0 net/netlink/af_netlink.c:712
 __sock_create+0x380/0x850 net/socket.c:1535
 sock_create net/socket.c:1586 [inline]
 __sys_socket_create net/socket.c:1623 [inline]
 __sys_socket_create net/socket.c:1608 [inline]
 __sys_socket+0x133/0x250 net/socket.c:1651
 __do_sys_socket net/socket.c:1664 [inline]
 __se_sys_socket net/socket.c:1662 [inline]
 __x64_sys_socket+0x73/0xb0 net/socket.c:1662
page_owner free stack trace missing

Memory state around the buggy address:
 ffff88802edbd380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88802edbd400: 00 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc
>ffff88802edbd480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff88802edbd500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802edbd580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


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
