Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DFF5F15AF
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiI3WFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiI3WFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:05:42 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB5774CD5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:05:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i3-20020a056e020d8300b002f90e6fedcfso4385619ilj.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5Tw5tgGmHqL/OD5sY4O+9S2lqVNGSMSAJrWTqjspC9Y=;
        b=rondvuO5vBxt3kfVY2dSTTKf5vsNsCbfJwreI9mqVO+Exz/pSq7Roqy10XuUKcoszF
         fnpEyXGsTs1RVV/x2Xag5T2vVuBNWLlsNgT5MjKzeRWLmI+QRhSuCy5NUrkYLhp99lRo
         D7usrwlR4q3fqMydL5WmLuMTVRUGKed8nv0eiyI0gC8VGnGxlK+RTLPpYoqvXta3nEEL
         SAz/V42NTA3QKepJlIQXSqW9uNSSr6PV5u5u5mnGVR+t2MPsoYow9qkfKvH5MoJ9WSsY
         Je1cP8rfbSRX4VmJqlv6ECfTS9jcwgSQA6pd/kW+1mV1frBupwypRSJZd1+QVF5xQaYs
         3Iyw==
X-Gm-Message-State: ACrzQf0QfTFnpKsfq1UEzTvjQkLRWXIlXFtVwDgoIZc8nZePANr2kw8V
        v1y8vqV5hAfcBePhkdtbVMaMM3mZN0Alm50B1nELVxGi00Jz
X-Google-Smtp-Source: AMsMyM7OnC0nkz1g18IqQTugKs25GclYhQILH+cpYdFbVExYVxV7cK49YSbIzhWKU4dy60vf4gvtGDAVb2MMO0fYyUL7bojFpyYg
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:bef:b0:2f9:889b:6db6 with SMTP id
 d15-20020a056e020bef00b002f9889b6db6mr32924ilu.281.1664575538861; Fri, 30 Sep
 2022 15:05:38 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:05:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b21f0a05e9ec310d@google.com>
Subject: [syzbot] possible deadlock in tty_port_tty_get
From:   syzbot <syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com>
To:     andy.shevchenko@gmail.com, etremblay@distech-controls.com,
        gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
        jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        u.kleine-koenig@pengutronix.de, wander@redhat.com
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

HEAD commit:    5a77386984b5 Merge tag 'drm-fixes-2022-09-30-1' of git://a..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=132b8504880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=223c7461c58c58a4cb10
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-00162-g5a77386984b5 #0 Not tainted
------------------------------------------------------
syz-executor.0/4926 is trying to acquire lock:
ffffffff8c0be788 (zonelist_update_seq.seqcount){...-}-{0:0}, at: __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562

but task is already holding lock:
ffff88802624c958 (&port->lock){-.-.}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x2b/0x160 drivers/tty/tty_buffer.c:628

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&port->lock){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       tty_port_tty_get+0x1f/0x100 drivers/tty/tty_port.c:327
       tty_port_default_wakeup+0x11/0x40 drivers/tty/tty_port.c:68
       serial8250_tx_chars+0x4f6/0xd90 drivers/tty/serial/8250/8250_port.c:1851
       serial8250_handle_irq.part.0+0x440/0x820 drivers/tty/serial/8250/8250_port.c:1938
       serial8250_handle_irq drivers/tty/serial/8250/8250_port.c:1911 [inline]
       serial8250_default_handle_irq+0xb2/0x220 drivers/tty/serial/8250/8250_port.c:1958
       serial8250_interrupt+0xf8/0x200 drivers/tty/serial/8250/8250_core.c:126
       __handle_irq_event_percpu+0x227/0x870 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0xa7/0x1e0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xd00 kernel/irq/chip.c:819
       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
       handle_irq arch/x86/kernel/irq.c:231 [inline]
       __common_interrupt+0x9d/0x210 arch/x86/kernel/irq.c:250
       common_interrupt+0xa4/0xc0 arch/x86/kernel/irq.c:240
       asm_common_interrupt+0x22/0x40 arch/x86/include/asm/idtentry.h:640
       native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
       default_idle+0xb/0x10 arch/x86/kernel/process.c:730
       default_idle_call+0x80/0xc0 kernel/sched/idle.c:109
       cpuidle_idle_call kernel/sched/idle.c:191 [inline]
       do_idle+0x401/0x590 kernel/sched/idle.c:303
       cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:400
       start_secondary+0x21d/0x2b0 arch/x86/kernel/smpboot.c:262
       secondary_startup_64_no_verify+0xce/0xdb

-> #2 (&port_lock_key){-.-.}-{2:2}:
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0x39/0x50 kernel/locking/spinlock.c:162
       serial8250_console_write+0x975/0xfe0 drivers/tty/serial/8250/8250_port.c:3380
       call_console_driver kernel/printk/printk.c:1945 [inline]
       console_emit_next_record.constprop.0+0x3de/0x840 kernel/printk/printk.c:2732
       console_flush_all kernel/printk/printk.c:2794 [inline]
       console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
       vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2292
       register_console kernel/printk/printk.c:3212 [inline]
       register_console+0x482/0x840 kernel/printk/printk.c:3104
       univ8250_console_init+0x3a/0x46 drivers/tty/serial/8250/8250_core.c:681
       console_init+0x3b7/0x57e kernel/printk/printk.c:3308
       start_kernel+0x2fa/0x48f init/main.c:1066
       secondary_startup_64_no_verify+0xce/0xdb

-> #1 (console_owner){-...}-{0:0}:
       console_lock_spinning_enable kernel/printk/printk.c:1808 [inline]
       console_emit_next_record.constprop.0+0x2dd/0x840 kernel/printk/printk.c:2729
       console_flush_all kernel/printk/printk.c:2794 [inline]
       console_unlock+0x37a/0x5a0 kernel/printk/printk.c:2861
       vprintk_emit+0x1b9/0x5f0 kernel/printk/printk.c:2271
       vprintk+0x80/0x90 kernel/printk/printk_safe.c:50
       _printk+0xba/0xed kernel/printk/printk.c:2292
       build_zonelists.cold+0xe5/0x11f mm/page_alloc.c:6471
       __build_all_zonelists+0x111/0x180 mm/page_alloc.c:6584
       build_all_zonelists_init+0x2f/0x104 mm/page_alloc.c:6609
       build_all_zonelists+0x11f/0x140 mm/page_alloc.c:6642
       start_kernel+0xb9/0x48f init/main.c:960
       secondary_startup_64_no_verify+0xce/0xdb

-> #0 (zonelist_update_seq.seqcount){...-}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
       lock_acquire kernel/locking/lockdep.c:5666 [inline]
       lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
       seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
       read_seqbegin include/linux/seqlock.h:836 [inline]
       zonelist_iter_begin mm/page_alloc.c:4722 [inline]
       __alloc_pages_slowpath.constprop.0+0x1a5/0x2300 mm/page_alloc.c:5044
       __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
       __alloc_pages_node include/linux/gfp.h:243 [inline]
       kmem_getpages mm/slab.c:1363 [inline]
       cache_grow_begin+0x75/0x360 mm/slab.c:2569
       cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
       ____cache_alloc mm/slab.c:3018 [inline]
       ____cache_alloc mm/slab.c:3001 [inline]
       __do_cache_alloc mm/slab.c:3246 [inline]
       slab_alloc mm/slab.c:3287 [inline]
       __do_kmalloc mm/slab.c:3684 [inline]
       __kmalloc+0x3a1/0x4a0 mm/slab.c:3695
       kmalloc include/linux/slab.h:605 [inline]
       tty_buffer_alloc+0x27b/0x2f0 drivers/tty/tty_buffer.c:180
       __tty_buffer_request_room+0x15f/0x2b0 drivers/tty/tty_buffer.c:278
       tty_insert_flip_string_fixed_flag+0x8c/0x250 drivers/tty/tty_buffer.c:327
       tty_insert_flip_string include/linux/tty_flip.h:41 [inline]
       tty_insert_flip_string_and_push_buffer+0x3e/0x160 drivers/tty/tty_buffer.c:629
       pty_write+0xd6/0x100 drivers/tty/pty.c:118
       process_output_block drivers/tty/n_tty.c:586 [inline]
       n_tty_write+0x4ca/0xfd0 drivers/tty/n_tty.c:2350
       do_tty_write drivers/tty/tty_io.c:1024 [inline]
       file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
       call_write_iter include/linux/fs.h:2187 [inline]
       new_sync_write fs/read_write.c:491 [inline]
       vfs_write+0x9e9/0xdd0 fs/read_write.c:584
       ksys_write+0x127/0x250 fs/read_write.c:637
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  zonelist_update_seq.seqcount --> &port_lock_key --> &port->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&port->lock);
                               lock(&port_lock_key);
                               lock(&port->lock);
  lock(zonelist_update_seq.seqcount);

 *** DEADLOCK ***

5 locks held by syz-executor.0/4926:
 #0: ffff88806b3c3098 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x22/0x80 drivers/tty/tty_ldisc.c:244
 #1: ffff88806b3c3130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: tty_write_lock drivers/tty/tty_io.c:950 [inline]
 #1: ffff88806b3c3130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: do_tty_write drivers/tty/tty_io.c:973 [inline]
 #1: ffff88806b3c3130 (&tty->atomic_write_lock){+.+.}-{3:3}, at: file_tty_write.constprop.0+0x296/0x8f0 drivers/tty/tty_io.c:1095
 #2: ffff88806b3c32e8 (&o_tty->termios_rwsem/1){++++}-{3:3}, at: n_tty_write+0x1bf/0xfd0 drivers/tty/n_tty.c:2333
 #3: ffffc90000cf4380 (&ldata->output_lock){+.+.}-{3:3}, at: process_output_block drivers/tty/n_tty.c:541 [inline]
 #3: ffffc90000cf4380 (&ldata->output_lock){+.+.}-{3:3}, at: n_tty_write+0x5f6/0xfd0 drivers/tty/n_tty.c:2350
 #4: ffff88802624c958 (&port->lock){-.-.}-{2:2}, at: tty_insert_flip_string_and_push_buffer+0x2b/0x160 drivers/tty/tty_buffer.c:628

stack backtrace:
CPU: 1 PID: 4926 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-00162-g5a77386984b5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 check_noncircular+0x25f/0x2e0 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x2a43/0x56d0 kernel/locking/lockdep.c:5053
 lock_acquire kernel/locking/lockdep.c:5666 [inline]
 lock_acquire+0x1ab/0x570 kernel/locking/lockdep.c:5631
 seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
 read_seqbegin include/linux/seqlock.h:836 [inline]
 zonelist_iter_begin mm/page_alloc.c:4722 [inline]
 __alloc_pages_slowpath.constprop.0+0x1a5/0x2300 mm/page_alloc.c:5044
 __alloc_pages+0x43d/0x510 mm/page_alloc.c:5562
 __alloc_pages_node include/linux/gfp.h:243 [inline]
 kmem_getpages mm/slab.c:1363 [inline]
 cache_grow_begin+0x75/0x360 mm/slab.c:2569
 cache_alloc_refill+0x27f/0x380 mm/slab.c:2942
 ____cache_alloc mm/slab.c:3018 [inline]
 ____cache_alloc mm/slab.c:3001 [inline]
 __do_cache_alloc mm/slab.c:3246 [inline]
 slab_alloc mm/slab.c:3287 [inline]
 __do_kmalloc mm/slab.c:3684 [inline]
 __kmalloc+0x3a1/0x4a0 mm/slab.c:3695
 kmalloc include/linux/slab.h:605 [inline]
 tty_buffer_alloc+0x27b/0x2f0 drivers/tty/tty_buffer.c:180
 __tty_buffer_request_room+0x15f/0x2b0 drivers/tty/tty_buffer.c:278
 tty_insert_flip_string_fixed_flag+0x8c/0x250 drivers/tty/tty_buffer.c:327
 tty_insert_flip_string include/linux/tty_flip.h:41 [inline]
 tty_insert_flip_string_and_push_buffer+0x3e/0x160 drivers/tty/tty_buffer.c:629
 pty_write+0xd6/0x100 drivers/tty/pty.c:118
 process_output_block drivers/tty/n_tty.c:586 [inline]
 n_tty_write+0x4ca/0xfd0 drivers/tty/n_tty.c:2350
 do_tty_write drivers/tty/tty_io.c:1024 [inline]
 file_tty_write.constprop.0+0x499/0x8f0 drivers/tty/tty_io.c:1095
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:584
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7feffde8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007feffcdfe168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007feffdfabf80 RCX: 00007feffde8a5a9
RDX: 00000000fffffedf RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007feffdee5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc3837d3f R14: 00007feffcdfe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
