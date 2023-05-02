Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9816F4071
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbjEBJxV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 2 May 2023 05:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjEBJxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 05:53:02 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826763A90
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 02:52:57 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-763a89d850aso214524939f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 02:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021177; x=1685613177;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1vikVBvsLI5HDIVu840mMsYLutm2GK4CYpSss0kBN2A=;
        b=LZQVduUKBW3+FsZYGKp3A31DWO+MK09gDrEF9rGh9w/bbbsQwghnSplmI2SSTWOnKP
         uk86uPRIAM77IWVFkXWfT/yRrlLMLOxxit9nup8cGw94S0//vDBFYQvf4WgQWlAaoV0B
         TOHmj2oZE8ytRj7jEiy2XnJ3qxAMqdEXfVL6NsqPEqvlM6JploRtS2+X/qVnIlKFUGjA
         ZsWtRlJbaxnkyFgQ1fmio4il8Sx7v8vL1h3+3jWG3vR/z4ayDp6Vj0RbGWztVtLfO5ZB
         Wqs+URFbQ784NiuVN3a4V9OXZ4oKSnum/W6/2AZy3tvStE1f66nAKHHHQ+hCmNW+Zd4e
         TmuA==
X-Gm-Message-State: AC+VfDyEz6stmpBtjs7sbX9h8KlS6dE+Q3FAUn2dpzbaDqlVn7dRl1VK
        3u3UpKs+voS5VAD4bbnrHZCIdqEBuJLMl/R/qRIiBZT7sqSa
X-Google-Smtp-Source: ACHHUZ4k7ywFNbb5MbG4BhQg/EXw7m5QnIt7dRIRm6+gUMZjpe4m6NU4v8uF3THDQ/NrKrUvrMl/Mn8Tx9vh/osGI0b7lRUQRWrc
MIME-Version: 1.0
X-Received: by 2002:a02:8668:0:b0:40f:cf8b:7c74 with SMTP id
 e95-20020a028668000000b0040fcf8b7c74mr7557544jai.0.1683021176852; Tue, 02 May
 2023 02:52:56 -0700 (PDT)
Date:   Tue, 02 May 2023 02:52:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065594605fab2e72c@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in gpiod_set_value
From:   syzbot <syzbot+5e3c3df60302959ef641@syzkaller.appspotmail.com>
To:     brgl@bgdev.pl, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    865fdb08197e Merge tag 'input-for-v6.4-rc0' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16481bf8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d43eae746231feb3
dashboard link: https://syzkaller.appspot.com/bug?extid=5e3c3df60302959ef641
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e3c3df60302959ef641@syzkaller.appspotmail.com

Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x0000000080000000-0x00000000ffffffff]
Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 19 pages/cpu s47048 r8192 d22584 u77824
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
Built 1 zonelists, mobility grouping on.  Total pages: 520868
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a47000-0x00000000dda47000] (64MB)
Memory: 1952316K/2097152K available (24576K kernel code, 2364K rwdata, 8404K rodata, 2048K init, 868K bss, 128452K reserved, 16384K cma-reserved, 524288K highmem)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
trace event string verifier disabled
rcu: Preemptible hierarchical RCU implementation.
rcu: 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
rcu: 	RCU callback double-/use-after-free debug is enabled.
	All grace periods are expedited (rcu_expedited).
	Trampoline variant of Tasks RCU enabled.
	Tracing variant of Tasks RCU enabled.
rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=2
NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
GIC physical location is 0x2c001000
rcu: srcu_init: Setting srcu_struct sizes based on contention.
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
clocksource: arm,sp804: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
arch_timer: cp15 timer(s) running at 62.50MHz (virt).
clocksource: arch_sys_counter: mask: 0x1ffffffffffffff max_cycles: 0x1cd42e208c, max_idle_ns: 881590405314 ns
sched_clock: 57 bits at 63MHz, resolution 16ns, wraps every 4398046511096ns
Switching to timer-based delay loop, resolution 16ns
Console: colour dummy device 80x30
Calibrating delay loop (skipped), value calculated using timer frequency.. 125.00 BogoMIPS (lpj=625000)
pid_max: default: 32768 minimum: 301
LSM: initializing lsm=lockdown,capability,landlock,yama,safesetid,tomoyo,selinux,bpf,integrity
landlock: Up and running.
Yama: becoming mindful.
TOMOYO Linux initialized
SELinux:  Initializing.
LSM support for eBPF active
stackdepot: allocating hash table of 131072 entries via kvcalloc
Mount-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
Mountpoint-cache hash table entries: 4096 (order: 2, 16384 bytes, linear)
CPU: Testing write buffer coherency: ok
CPU0: Spectre BHB: enabling loop workaround for all CPUs
CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
8<--- cut here ---
Unable to handle kernel paging request at virtual address 000c01f3 when read
[000c01f3] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 206 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at gpiod_set_value+0x38/0xc0 drivers/gpio/gpiolib.c:3222
LR is at gpio_led_set+0x5c/0x60 drivers/leds/leds-gpio.c:54
pc : [<80891a24>]    lr : [<8107f408>]    psr: 20000113
sp : 82601e90  ip : 82601ea8  fp : 82601ea4
r10: 00000000  r9 : 827e16e6  r8 : 00000001
r7 : dddd1798  r6 : 000000ff  r5 : 00000001  r4 : 835c27a8
r3 : 000c0193  r2 : 8107f3ac  r1 : 00000001  r0 : 83194800
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd
Register r0 information: slab kmalloc-1k start 83194800 pointer offset 0 size 1024
Register r1 information: non-paged memory
Register r2 information: non-slab/vmalloc memory
Register r3 information: non-paged memory
Register r4 information: slab kmalloc-192 start 835c2780 pointer offset 40 size 192
Register r5 information: non-paged memory
Register r6 information: non-paged memory
Register r7 information:
8<--- cut here ---
Unable to handle kernel paging request at virtual address df943ff8 when read
[df943ff8] *pgd=80000080007003, *pmd=83093003, *pte=802160e880216664
Internal error: Oops: 207 [#2] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at __find_vmap_area mm/vmalloc.c:841 [inline]
PC is at find_vmap_area mm/vmalloc.c:1862 [inline]
PC is at find_vm_area mm/vmalloc.c:2623 [inline]
PC is at vmalloc_dump_obj+0x38/0xb4 mm/vmalloc.c:4221
LR is at __raw_spin_lock include/linux/spinlock_api_smp.h:132 [inline]
LR is at _raw_spin_lock+0x18/0x58 kernel/locking/spinlock.c:154
pc : [<8047a1f0>]    lr : [<818016fc>]    psr: a0000193
sp : 82601cf8  ip : 82601ce0  fp : 82601d0c
r10: 8261ae40  r9 : 8261c9a4  r8 : 8285041c
r7 : 60000113  r6 : 00000008  r5 : dddd2000  r4 : df944000
r3 : 00000000  r2 : 0000215b  r1 : 00000000  r0 : 00000001
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 80003000  DAC: fffffffd


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
