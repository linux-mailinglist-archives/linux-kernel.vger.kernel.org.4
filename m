Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9DA68AD5E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 00:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjBDXMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 18:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBDXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 18:12:44 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E23244AA
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 15:12:41 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id d22-20020a5d9656000000b00704d3bd8c07so5056838ios.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 15:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+6mESOELPBE4KjBYecBx9F1E975kY0cmhZncHtZjok=;
        b=f3Ryebq8kxvLhrV6CO4coiUGDkZiPU22mocToYp4WZUsXg8RQEfP2syyHp5rpy70Eo
         cBnToFl/f2AwjInHh9EGzyUOh0hrBZccnmYAyQxlzQeJiil7Cl3HTTrsrJUqnsNKdHLj
         BJTykeoiUG7NqgVvT+5dXGIvGaZEfKThKdZr4pcgIKQdURrAJd/6AuaL8A7aOTDHgD0y
         YnTIpeRBlSfaPhjWs+BGzVodCpNaQcg4omupieoSYTDGO8T0JAWYf1JnX7hDNRMZ1o8z
         kCRDeirsoIBUZoD6JnR/87KSzQOKxVnq0040lnJggWwtF/QlGdOz5lzVJ5XWDmth9hSk
         /Ofw==
X-Gm-Message-State: AO0yUKWzJxe+Uax1U74hz5UBv0vfD1oBuRHFncLx6qeI2eUlrZFEmKfN
        W6B1Ja3iaqi0IY2wCzPEggZRxbtTIUPRTAt+ek/bs857r9cy
X-Google-Smtp-Source: AK7set/4/aZrewC9UZBnmsQQDoRbvAtw3B+nCPQ/85f6F9T4idb3yhSulmRU7q1xz677WxxUC/LGUaGk4flI20AP6gP5gvDh6PTd
MIME-Version: 1.0
X-Received: by 2002:a92:2e13:0:b0:313:8923:a4ab with SMTP id
 v19-20020a922e13000000b003138923a4abmr2220183ile.1.1675552360302; Sat, 04 Feb
 2023 15:12:40 -0800 (PST)
Date:   Sat, 04 Feb 2023 15:12:40 -0800
In-Reply-To: <0000000000003b04d205f3e431d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d12fc05f3e7ef5f@google.com>
Subject: Re: [syzbot] general protection fault in __blk_rq_map_sg
From:   syzbot <syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    4fafd96910ad Add linux-next specific files for 20230203
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11d0585d480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d2fba7d42502ca4
dashboard link: https://syzkaller.appspot.com/bug?extid=0bbf896c8341c8e137c2
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124dabab480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166cc203480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/348cc2da441a/disk-4fafd969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e2dedc500f12/vmlinux-4fafd969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fae710d9ebd8/bzImage-4fafd969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0bbf896c8341c8e137c2@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in sg_assign_page include/linux/scatterlist.h:109 [inline]
BUG: KASAN: slab-use-after-free in sg_set_page include/linux/scatterlist.h:139 [inline]
BUG: KASAN: slab-use-after-free in __blk_bvec_map_sg block/blk-merge.c:501 [inline]
BUG: KASAN: slab-use-after-free in __blk_bios_map_sg block/blk-merge.c:548 [inline]
BUG: KASAN: slab-use-after-free in __blk_rq_map_sg+0xf74/0xfd0 block/blk-merge.c:575
Read of size 8 at addr ffff888078d1c640 by task syz-executor635/5472

CPU: 0 PID: 5472 Comm: syz-executor635 Not tainted 6.2.0-rc6-next-20230203-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_address_description.constprop.0+0x2c/0x3c0 mm/kasan/report.c:319
 print_report mm/kasan/report.c:430 [inline]
 kasan_report+0x11c/0x130 mm/kasan/report.c:536
 sg_assign_page include/linux/scatterlist.h:109 [inline]
 sg_set_page include/linux/scatterlist.h:139 [inline]
 __blk_bvec_map_sg block/blk-merge.c:501 [inline]
 __blk_bios_map_sg block/blk-merge.c:548 [inline]
 __blk_rq_map_sg+0xf74/0xfd0 block/blk-merge.c:575
 scsi_alloc_sgtables+0x236/0xf70 drivers/scsi/scsi_lib.c:1048
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1603 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1737
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x10a/0x190 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0x2b7/0x480 block/blk-mq.c:2174
 __blk_mq_delay_run_hw_queue+0x5f7/0x700 block/blk-mq.c:2250
 blk_mq_run_hw_queue+0x3b5/0x560 block/blk-mq.c:2298
 blk_mq_sched_insert_requests+0x1d9/0xb30 block/blk-mq-sched.c:493
 blk_mq_dispatch_plug_list block/blk-mq.c:2758 [inline]
 blk_mq_flush_plug_list+0x39c/0xe10 block/blk-mq.c:2800
 __blk_flush_plug block/blk-core.c:1150 [inline]
 blk_finish_plug block/blk-core.c:1174 [inline]
 blk_finish_plug+0xbb/0x170 block/blk-core.c:1171
 __iomap_dio_rw+0xf85/0x1d80 fs/iomap/direct-io.c:602
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f3aac0c4e09
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3aac076318 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f3aac14e428 RCX: 00007f3aac0c4e09
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f3aac14e420 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000010000 R11: 0000000000000246 R12: 00007f3aac11b1a4
R13: 00007ffe79ef5f4f R14: 00007f3aac076400 R15: 0000000000022000
 </TASK>

Allocated by task 5438:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 __kasan_slab_alloc+0x7f/0x90 mm/kasan/common.c:328
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x175/0x320 mm/slub.c:3476
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 __sg_alloc_table+0x248/0x380 lib/scatterlist.c:318
 sg_alloc_table_chained+0x9f/0x1f0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1cd/0xf70 drivers/scsi/scsi_lib.c:1040
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1603 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1737
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
 blk_mq_sched_dispatch_requests+0x10a/0x190 block/blk-mq-sched.c:339
 __blk_mq_run_hw_queue+0x2b7/0x480 block/blk-mq.c:2174
 __blk_mq_delay_run_hw_queue+0x5f7/0x700 block/blk-mq.c:2250
 blk_mq_run_hw_queue+0x3b5/0x560 block/blk-mq.c:2298
 blk_mq_sched_insert_requests+0x1d9/0xb30 block/blk-mq-sched.c:493
 blk_mq_dispatch_plug_list block/blk-mq.c:2758 [inline]
 blk_mq_flush_plug_list+0x39c/0xe10 block/blk-mq.c:2800
 __blk_flush_plug block/blk-core.c:1150 [inline]
 blk_finish_plug block/blk-core.c:1174 [inline]
 blk_finish_plug+0xbb/0x170 block/blk-core.c:1171
 ext4_do_writepages+0x1fbf/0x30e0 fs/ext4/inode.c:2927
 ext4_writepages+0x27c/0x5e0 fs/ext4/inode.c:2964
 do_writepages+0x1a8/0x640 mm/page-writeback.c:2551
 filemap_fdatawrite_wbc mm/filemap.c:388 [inline]
 filemap_fdatawrite_wbc+0x147/0x1b0 mm/filemap.c:378
 __filemap_fdatawrite_range+0xb8/0xf0 mm/filemap.c:421
 filemap_write_and_wait_range mm/filemap.c:676 [inline]
 filemap_write_and_wait_range+0xa1/0x120 mm/filemap.c:667
 __iomap_dio_rw+0x5ea/0x1d80 fs/iomap/direct-io.c:565
 iomap_dio_rw+0x40/0xa0 fs/iomap/direct-io.c:682
 ext4_dio_read_iter fs/ext4/file.c:94 [inline]
 ext4_file_read_iter+0x4be/0x690 fs/ext4/file.c:145
 call_read_iter include/linux/fs.h:1845 [inline]
 generic_file_splice_read+0x182/0x4b0 fs/splice.c:309
 do_splice_to+0x1b9/0x240 fs/splice.c:793
 splice_direct_to_actor+0x2ab/0x8a0 fs/splice.c:865
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x12c0 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Freed by task 0:
 kasan_save_stack+0x22/0x40 mm/kasan/common.c:45
 kasan_set_track+0x25/0x30 mm/kasan/common.c:52
 kasan_save_free_info+0x2e/0x40 mm/kasan/generic.c:521
 ____kasan_slab_free mm/kasan/common.c:236 [inline]
 ____kasan_slab_free+0x160/0x1c0 mm/kasan/common.c:200
 kasan_slab_free include/linux/kasan.h:162 [inline]
 slab_free_hook mm/slub.c:1781 [inline]
 slab_free_freelist_hook+0x8b/0x1c0 mm/slub.c:1807
 slab_free mm/slub.c:3787 [inline]
 kmem_cache_free+0xec/0x4e0 mm/slub.c:3809
 mempool_free+0xe7/0x3b0 mm/mempool.c:507
 __sg_free_table+0x122/0x1a0 lib/scatterlist.c:227
 sg_free_table_chained+0x8d/0xa0 lib/sg_pool.c:93
 scsi_free_sgtables drivers/scsi/scsi_lib.c:489 [inline]
 scsi_mq_uninit_cmd drivers/scsi/scsi_lib.c:499 [inline]
 scsi_end_request+0x70b/0xa20 drivers/scsi/scsi_lib.c:564
 scsi_io_completion+0x177/0x1f80 drivers/scsi/scsi_lib.c:975
 scsi_complete+0x126/0x3b0 drivers/scsi/scsi_lib.c:1439
 blk_complete_reqs+0xad/0xe0 block/blk-mq.c:1131
 __do_softirq+0x2e3/0xae3 kernel/softirq.c:571

The buggy address belongs to the object at ffff888078d1c640
 which belongs to the cache sgpool-8 of size 256
The buggy address is located 0 bytes inside of
 freed 256-byte region [ffff888078d1c640, ffff888078d1c740)

The buggy address belongs to the physical page:
page:ffffea0001e34700 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x78d1c
flags: 0xfff00000000200(slab|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000000200 ffff8881451b3500 dead000000000122 0000000000000000
raw: 0000000000000000 00000000800c000c 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 0, migratetype Unmovable, gfp_mask 0x92820(GFP_ATOMIC|__GFP_NOWARN|__GFP_NORETRY|__GFP_NOMEMALLOC), pid 5400, tgid 5396 (syz-executor635), ts 61781478648, free_ts 51720251001
 prep_new_page mm/page_alloc.c:2552 [inline]
 get_page_from_freelist+0x11bb/0x2d50 mm/page_alloc.c:4328
 __alloc_pages+0x1cb/0x5c0 mm/page_alloc.c:5594
 alloc_pages+0x1aa/0x270 mm/mempolicy.c:2283
 alloc_slab_page mm/slub.c:1851 [inline]
 allocate_slab+0x28e/0x380 mm/slub.c:1998
 new_slab mm/slub.c:2051 [inline]
 ___slab_alloc+0xa91/0x1400 mm/slub.c:3193
 __slab_alloc.constprop.0+0x56/0xa0 mm/slub.c:3292
 __slab_alloc_node mm/slub.c:3345 [inline]
 slab_alloc_node mm/slub.c:3442 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x30a/0x320 mm/slub.c:3476
 mempool_alloc+0x158/0x360 mm/mempool.c:398
 __sg_alloc_table+0x248/0x380 lib/scatterlist.c:318
 sg_alloc_table_chained+0x9f/0x1f0 lib/sg_pool.c:133
 scsi_alloc_sgtables+0x1cd/0xf70 drivers/scsi/scsi_lib.c:1040
 sd_setup_read_write_cmnd drivers/scsi/sd.c:1136 [inline]
 sd_init_command+0x67a/0x32a0 drivers/scsi/sd.c:1260
 scsi_prepare_cmd drivers/scsi/scsi_lib.c:1603 [inline]
 scsi_queue_rq+0x1e7b/0x3a40 drivers/scsi/scsi_lib.c:1737
 blk_mq_dispatch_rq_list+0x710/0x23f0 block/blk-mq.c:2056
 __blk_mq_do_dispatch_sched block/blk-mq-sched.c:173 [inline]
 blk_mq_do_dispatch_sched+0x95e/0xc20 block/blk-mq-sched.c:187
 __blk_mq_sched_dispatch_requests+0x26d/0x3e0 block/blk-mq-sched.c:313
page last free stack trace:
 reset_page_owner include/linux/page_owner.h:24 [inline]
 free_pages_prepare mm/page_alloc.c:1453 [inline]
 free_pcp_prepare+0x4d0/0x910 mm/page_alloc.c:1503
 free_unref_page_prepare mm/page_alloc.c:3390 [inline]
 free_unref_page+0x1d/0x490 mm/page_alloc.c:3485
 __unfreeze_partials+0x17c/0x1a0 mm/slub.c:2637
 qlink_free mm/kasan/quarantine.c:168 [inline]
 qlist_free_all+0x6a/0x170 mm/kasan/quarantine.c:187
 kasan_quarantine_reduce+0x195/0x220 mm/kasan/quarantine.c:294
 __kasan_slab_alloc+0x63/0x90 mm/kasan/common.c:305
 kasan_slab_alloc include/linux/kasan.h:186 [inline]
 slab_post_alloc_hook mm/slab.h:769 [inline]
 slab_alloc_node mm/slub.c:3452 [inline]
 slab_alloc mm/slub.c:3460 [inline]
 __kmem_cache_alloc_lru mm/slub.c:3467 [inline]
 kmem_cache_alloc+0x175/0x320 mm/slub.c:3476
 vm_area_dup+0x21/0x1f0 kernel/fork.c:466
 __split_vma+0x199/0x810 mm/mmap.c:2172
 do_vmi_align_munmap+0x34a/0xf60 mm/mmap.c:2320
 do_vmi_munmap+0x26e/0x2c0 mm/mmap.c:2452
 mmap_region+0x1ee/0x2690 mm/mmap.c:2500
 do_mmap+0x831/0xf60 mm/mmap.c:1364
 vm_mmap_pgoff+0x1af/0x280 mm/util.c:542
 ksys_mmap_pgoff+0x41f/0x5a0 mm/mmap.c:1410
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80

Memory state around the buggy address:
 ffff888078d1c500: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078d1c580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888078d1c600: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                           ^
 ffff888078d1c680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff888078d1c700: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================

