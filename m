Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504015F2521
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJBT3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 15:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbiJBT3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 15:29:43 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F81099
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 12:29:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id d24-20020a05660225d800b006a466ec7746so5708455iop.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 12:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MFDICdfTvPWSJ5V56JVSExMkpdS7Samc8eSArXQcQR0=;
        b=gXgO9nD6+Fb/x31Q78xNdPEda2wGpT9hXbUInOGvYXFoe5oqWaIi23dlNrG/Vl4v2o
         Gp7ByRnhWmYi/Sevg11Zg7PZX0rObq74TRFMc/7KoLtOJSFmCLKsMIJCOW1GvI257Ns1
         MqRw9YQvkhPP1a2kwbQVg2FxtargBjHETv0eC9j/cXjnaJ3e/i0KmvxeQiZD2wgscbA+
         uURNbKe8pdyIaZbXEZ58RcV9aW8YmcKRvwoBlfmhZU+va5juQGI3CSLoNg0p+o/QNO0w
         UXhtsE681LoWuvT6/NyabgzdUO6ELeRH6x9bQ1KDop4EVYq37D9gvRgmERTF4+N3Vmw8
         bTsA==
X-Gm-Message-State: ACrzQf3MLsTMv5lWBe5rZNV6vHQJ5E0lXofzUADDaA5aocQiiehHZDWW
        CsaZHXwVaxtL8xsqsMS21WCEP+scNiZgsnylky68zropyUZH
X-Google-Smtp-Source: AMsMyM5+0LxCfDZcgwN0Jgu/eiCLA955K4aUaojg6OF/RFDwYXrHG20gXBlu7T9/uzILB9eDa0+TInHCKu3ZwxmUUVZuBYmulQQm
MIME-Version: 1.0
X-Received: by 2002:a05:6638:449a:b0:358:440a:cbcf with SMTP id
 bv26-20020a056638449a00b00358440acbcfmr9241122jab.297.1664738979658; Sun, 02
 Oct 2022 12:29:39 -0700 (PDT)
Date:   Sun, 02 Oct 2022 12:29:39 -0700
In-Reply-To: <000000000000b98bb905e9f944ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086c91005ea123fb5@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in hex_dump_to_buffer
From:   syzbot <syzbot+489783e0c22fbb27d8e9@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    b357fd1c2afc Merge tag 'usb-6.0-final' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15677614880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=489783e0c22fbb27d8e9
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e2eeb8880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1201c8cc880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+489783e0c22fbb27d8e9@syzkaller.appspotmail.com

ffff88806c856a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
ffff88806c856a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
==================================================================
BUG: KASAN: slab-out-of-bounds in hex_dump_to_buffer+0xdc1/0xdf0 lib/hexdump.c:193
Read of size 1 at addr ffff88806c856a40 by task syz-executor371/3608

CPU: 1 PID: 3608 Comm: syz-executor371 Not tainted 6.0.0-rc7-syzkaller-00239-gb357fd1c2afc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:317 [inline]
 print_report.cold+0x2ba/0x6e9 mm/kasan/report.c:433
 kasan_report+0xb1/0x1e0 mm/kasan/report.c:495
 hex_dump_to_buffer+0xdc1/0xdf0 lib/hexdump.c:193
 print_hex_dump+0x12f/0x1d0 lib/hexdump.c:276
 ea_get.cold+0xaa/0x190 fs/jfs/xattr.c:561
 __jfs_getxattr+0xc4/0x3d0 fs/jfs/xattr.c:807
 jfs_xattr_get+0x39/0x50 fs/jfs/xattr.c:931
 __vfs_getxattr+0xd9/0x140 fs/xattr.c:411
 inode_doinit_use_xattr+0xb5/0x340 security/selinux/hooks.c:1321
 inode_doinit_with_dentry+0xcd3/0x12e0 security/selinux/hooks.c:1443
 selinux_d_instantiate+0x23/0x30 security/selinux/hooks.c:6327
 security_d_instantiate+0x50/0xe0 security/security.c:2056
 d_splice_alias+0x8c/0xc80 fs/dcache.c:3155
 jfs_lookup+0x20c/0x2f0 fs/jfs/namei.c:1467
 lookup_open.isra.0+0x76a/0x12a0 fs/namei.c:3391
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feb33d6a0c9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff94f813e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007feb33d6a0c9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000340
RBP: 00007feb33d29890 R08: 00005555560782c0 R09: 0000000000000000
R10: 00007fff94f812b0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000fc R15: 0000000000000000
 </TASK>

Allocated by task 3608:
 kasan_save_stack+0x1e/0x40 mm/kasan/common.c:38
 kasan_set_track mm/kasan/common.c:45 [inline]
 set_alloc_info mm/kasan/common.c:437 [inline]
 __kasan_slab_alloc+0x85/0xb0 mm/kasan/common.c:470
 kasan_slab_alloc include/linux/kasan.h:224 [inline]
 slab_post_alloc_hook mm/slab.h:727 [inline]
 slab_alloc mm/slab.c:3294 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
 kmem_cache_alloc_lru+0x23d/0x860 mm/slab.c:3498
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 jfs_alloc_inode+0x23/0x60 fs/jfs/super.c:105
 alloc_inode+0x61/0x230 fs/inode.c:260
 iget_locked+0x1b7/0x6f0 fs/inode.c:1287
 jfs_iget+0x1a/0x4d0 fs/jfs/inode.c:29
 jfs_lookup+0x246/0x2f0 fs/jfs/namei.c:1462
 lookup_open.isra.0+0x76a/0x12a0 fs/namei.c:3391
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The buggy address belongs to the object at ffff88806c856180
 which belongs to the cache jfs_ip of size 2240
The buggy address is located 0 bytes to the right of
 2240-byte region [ffff88806c856180, ffff88806c856a40)

The buggy address belongs to the physical page:
page:ffffea0001b21580 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff88806c856fff pfn:0x6c856
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffffea0001b21488 ffff88801ba2b150 ffff88801ba26a00
raw: ffff88806c856fff ffff88806c856180 0000000100000001 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Reclaimable, gfp_mask 0x242050(__GFP_IO|__GFP_NOWARN|__GFP_COMP|__GFP_THISNODE|__GFP_RECLAIMABLE), pid 3608, tgid 3608 (syz-executor371), ts 53583161798, free_ts 12386078992
 prep_new_page mm/page_alloc.c:2532 [inline]
 get_page_from_freelist+0x109b/0x2ce0 mm/page_alloc.c:4283
 __alloc_pages+0x1c7/0x510 mm/page_alloc.c:5549
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 __do_cache_alloc mm/slab.c:3246 [inline]
 slab_alloc mm/slab.c:3287 [inline]
 __kmem_cache_alloc_lru mm/slab.c:3471 [inline]
 kmem_cache_alloc_lru+0x727/0x860 mm/slab.c:3498
 alloc_inode_sb include/linux/fs.h:3103 [inline]
 jfs_alloc_inode+0x23/0x60 fs/jfs/super.c:105
 alloc_inode+0x61/0x230 fs/inode.c:260
 iget_locked+0x1b7/0x6f0 fs/inode.c:1287
 jfs_iget+0x1a/0x4d0 fs/jfs/inode.c:29
 jfs_lookup+0x246/0x2f0 fs/jfs/namei.c:1462
 lookup_open.isra.0+0x76a/0x12a0 fs/namei.c:3391
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x996/0x28f0 fs/namei.c:3688
 do_filp_open+0x1b6/0x400 fs/namei.c:3718
 do_sys_openat2+0x16d/0x4c0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x119/0x1c0 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1449 [inline]
 free_pcp_prepare+0x5e4/0xd20 mm/page_alloc.c:1499
 free_unref_page_prepare mm/page_alloc.c:3380 [inline]
 free_unref_page+0x19/0x4d0 mm/page_alloc.c:3476
 free_contig_range+0xb1/0x180 mm/page_alloc.c:9453
 destroy_args+0xa8/0x646 mm/debug_vm_pgtable.c:1031
 debug_vm_pgtable+0x2945/0x29d6 mm/debug_vm_pgtable.c:1354
 do_one_initcall+0xfe/0x650 init/main.c:1296
 do_initcall_level init/main.c:1369 [inline]
 do_initcalls init/main.c:1385 [inline]
 do_basic_setup init/main.c:1404 [inline]
 kernel_init_freeable+0x6b1/0x73a init/main.c:1623
 kernel_init+0x1a/0x1d0 init/main.c:1512
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306

Memory state around the buggy address:
 ffff88806c856900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88806c856980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88806c856a00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
                                           ^
 ffff88806c856a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88806c856b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

