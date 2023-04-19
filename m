Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB7E6E7383
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 08:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjDSGtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 02:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjDSGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 02:49:50 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF010CE
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:49:48 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-328f6562564so68483305ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 23:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681886987; x=1684478987;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YZsQ5aPD6oFSjY71lAPkFKmwRM62j4k/Q+fhL8soLuk=;
        b=bLEJTyLPuGHuF+JWJ2pICbDstNsExQJggw/Hd3dwv5yVan1VwM4V7UGp+SXcPoZ7Yh
         mndVF+RkQ+RkzqTYIdZWzuxNDZoTlLF9OcFv9u0/5hTfp20jcfZgTdbTesaSQyhkop8R
         ZRDWselthTb1nZalaMNR0sXbNqDyggt49FqF7uv2xPwr4Z6DT/qa3jxIJhpTnNnC/aWq
         zke5DbB2fP1L0V41x8wQ4NNSMBx1zVlfnxcl84+vLAtcxWQKYs6v9hfuIavyhOuFjcfG
         tamM754QseG1vFI7IMOlb3GEuFiBVfh2r+pNaLvb8new2Rh7F4Gp6jWztEzRW0Wm1/wd
         7ttA==
X-Gm-Message-State: AAQBX9fcD/nmPKfRAgPfjmXmVtyZxH9vtH30lrwaGOh4IcrevGhtFOeX
        OIVOqRWrpF9eYBPCkhoG3VHL5/UpNkI+MHVahoQciqyy+RJBDbo=
X-Google-Smtp-Source: AKy350bcTeZTLNjnTPUNbGZEAm+soJGSmpILNbRMwQxWgi7b0y5S7B6oLoM+Vc3yybC3BHO1ejrbXiywpZY1W8ZAVsNskwlD6AcB
MIME-Version: 1.0
X-Received: by 2002:a92:d0c1:0:b0:32b:5e:e209 with SMTP id y1-20020a92d0c1000000b0032b005ee209mr5974257ila.1.1681886987332;
 Tue, 18 Apr 2023 23:49:47 -0700 (PDT)
Date:   Tue, 18 Apr 2023 23:49:47 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006eb4a605f9aad43b@google.com>
Subject: [syzbot] [media?] KASAN: slab-out-of-bounds Read in
 v4l2_compat_put_array_args (2)
From:   syzbot <syzbot+3cea453754f73db49fa5@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        mchehab@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    95abc817ab3a Merge tag 'acpi-6.3-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147a14e7c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=3cea453754f73db49fa5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3cea453754f73db49fa5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user include/linux/instrumented.h:119 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user lib/usercopy.c:40 [inline]
BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x11a/0x150 lib/usercopy.c:34
Read of size 16 at addr ffff88801bd7d658 by task syz-executor.3/15229

CPU: 0 PID: 15229 Comm: syz-executor.3 Not tainted 6.3.0-rc6-syzkaller-00168-g95abc817ab3a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_copy_to_user include/linux/instrumented.h:119 [inline]
 _copy_to_user lib/usercopy.c:40 [inline]
 _copy_to_user+0x11a/0x150 lib/usercopy.c:34
 copy_to_user include/linux/uaccess.h:169 [inline]
 v4l2_compat_put_array_args+0x484/0x830 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1154
 video_usercopy+0x46e/0x15f0 drivers/media/v4l2-core/v4l2-ioctl.c:3435
 v4l2_ioctl+0x1b7/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x23b/0x2a0 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1253
 __do_compat_sys_ioctl+0x255/0x2b0 fs/ioctl.c:968
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82
RIP: 0023:0xf7fb7579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f7fb25cc EFLAGS: 00000296 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00000000c0cc5604
RDX: 0000000020000480 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Allocated by task 15229:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 ____kasan_kmalloc mm/kasan/common.c:374 [inline]
 ____kasan_kmalloc mm/kasan/common.c:333 [inline]
 __kasan_kmalloc+0xa2/0xb0 mm/kasan/common.c:383
 kasan_kmalloc include/linux/kasan.h:196 [inline]
 __do_kmalloc_node mm/slab_common.c:967 [inline]
 __kmalloc_node+0x61/0x1a0 mm/slab_common.c:974
 kmalloc_node include/linux/slab.h:610 [inline]
 kvmalloc_node+0xa2/0x1a0 mm/util.c:603
 kvmalloc include/linux/slab.h:737 [inline]
 video_usercopy+0x642/0x15f0 drivers/media/v4l2-core/v4l2-ioctl.c:3386
 v4l2_ioctl+0x1b7/0x250 drivers/media/v4l2-core/v4l2-dev.c:364
 v4l2_compat_ioctl32+0x23b/0x2a0 drivers/media/v4l2-core/v4l2-compat-ioctl32.c:1253
 __do_compat_sys_ioctl+0x255/0x2b0 fs/ioctl.c:968
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x33/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x70/0x82

The buggy address belongs to the object at ffff88801bd7d640
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes to the right of
 allocated 24-byte region [ffff88801bd7d640, ffff88801bd7d658)

The buggy address belongs to the physical page:
page:ffffea00006f5f40 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88801bd7d840 pfn:0x1bd7d
ksm flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff888012442500 ffffea000079bb40 dead000000000003
raw: ffff88801bd7d840 0000000080400032 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x112cc0(GFP_USER|__GFP_NOWARN|__GFP_NORETRY), pid 28974, tgid 28974 (syz-executor.1), ts 809995593806, free_ts 808146796979
 prep_new_page mm/page_alloc.c:2553 [inline]
 get_page_from_freelist+0x1190/0x2e20 mm/page_alloc.c:4326
 __alloc_pages+0x1cb/0x4a0 mm/page_alloc.c:5592
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_slab_page mm/slub.c:1853 [inline]
 allocate_slab+0xa7/0x390 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 __kmem_cache_alloc_node+0x136/0x320 mm/slub.c:3491
 __do_kmalloc_node mm/slab_common.c:966 [inline]
 __kmalloc_node+0x51/0x1a0 mm/slab_common.c:974
 kmalloc_array_node include/linux/slab.h:697 [inline]
 kcalloc_node include/linux/slab.h:702 [inline]
 memcg_alloc_slab_cgroups+0x8f/0x150 mm/memcontrol.c:2899
 account_slab mm/slab.h:653 [inline]
 allocate_slab+0x2d6/0x390 mm/slub.c:2016
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 kmem_cache_alloc_node+0x138/0x3e0 mm/slub.c:3497
 alloc_task_struct_node kernel/fork.c:171 [inline]
 dup_task_struct kernel/fork.c:974 [inline]
 copy_process+0x3aa/0x7590 kernel/fork.c:2098
 kernel_clone+0xeb/0x890 kernel/fork.c:2682
 __do_compat_sys_ia32_clone+0x9e/0xd0 arch/x86/kernel/sys_ia32.c:254
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 do_int80_syscall_32+0x4a/0x90 arch/x86/entry/common.c:132
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1454 [inline]
 free_pcp_prepare+0x5d5/0xa50 mm/page_alloc.c:1504
 free_unref_page_prepare mm/page_alloc.c:3388 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3483
 vfree+0x180/0x7e0 mm/vmalloc.c:2742
 delayed_vfree_work+0x57/0x70 mm/vmalloc.c:2663
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Memory state around the buggy address:
 ffff88801bd7d500: 00 00 00 00 fc fc fc fc fa fb fb fb fc fc fc fc
 ffff88801bd7d580: fb fb fb fb fc fc fc fc fa fb fb fb fc fc fc fc
>ffff88801bd7d600: 00 00 00 00 fc fc fc fc 00 00 00 fc fc fc fc fc
                                                    ^
 ffff88801bd7d680: 00 00 00 00 fc fc fc fc 00 00 00 00 fc fc fc fc
 ffff88801bd7d700: fb fb fb fb fc fc fc fc 00 00 00 00 fc fc fc fc
==================================================================
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	10 06                	adc    %al,(%rsi)
   2:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
   6:	10 07                	adc    %al,(%rdi)
   8:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
   c:	10 08                	adc    %cl,(%rax)
   e:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
  1e:	00 51 52             	add    %dl,0x52(%rcx)
  21:	55                   	push   %rbp
  22:	89 e5                	mov    %esp,%ebp
  24:	0f 34                	sysenter
  26:	cd 80                	int    $0x80
* 28:	5d                   	pop    %rbp <-- trapping instruction
  29:	5a                   	pop    %rdx
  2a:	59                   	pop    %rcx
  2b:	c3                   	retq
  2c:	90                   	nop
  2d:	90                   	nop
  2e:	90                   	nop
  2f:	90                   	nop
  30:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi
  37:	8d b4 26 00 00 00 00 	lea    0x0(%rsi,%riz,1),%esi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
