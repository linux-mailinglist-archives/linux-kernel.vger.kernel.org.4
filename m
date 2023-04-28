Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFED46F2041
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 23:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbjD1Vqz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Apr 2023 17:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1Vqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 17:46:52 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89E26B9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:46:51 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-32b42b751bcso1222935ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 14:46:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682718411; x=1685310411;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxDzSGe/OZUcHBhIgkhiTXSpPQytn3EX7Llnqhrzb6E=;
        b=COii0DiKSem5JHvGZm79qCOR6x/H1u2ZPndhVYkNe1sSJvt/MC/9xqeN5em94W0Ag0
         bUkWGV12FBrpZc7qPWeGZjBuQZ3As2Bt6Fr3wCbIjFKX81gIuicohYXLWIyOkwNks5RL
         ZIy1ym+BHfIqTYLpUQEsD+PkGu3X3Izs5es2M0B5/sBiAFa/Qu0+GrUfldGr1AbldJnk
         CN9wtvkp2fnD6eBQ7ul8xfb7Q0+HbsbboFzOo89cxgp/Xb5im1YBbNQrM166XpTYG+lm
         xZl9QaX4hScolCX/tufSLkS2t4uu5jZuH3hJRxUQHFJI0M8l1NjYBSZKn5ntHwurod/c
         ZVKQ==
X-Gm-Message-State: AC+VfDzi9WkLaWmiigm/wP7AimAP0sUU+J+oZfEC8hAuDTYeCVFw1y1l
        7+T0B0UpYIjKjKT2jvtnFIL5oQBiKzNnexphJsZkJlR78QoJDuw=
X-Google-Smtp-Source: ACHHUZ6EVfVAu2WWUa1GKq2CqrKChZdD1FAv2vCQfZGAY5G+cHoucbkRb5Sw+bD1yIi2hRh3Zk0g2/+oso/nGmbHRRostITnd30w
MIME-Version: 1.0
X-Received: by 2002:a02:9505:0:b0:40f:b3a8:6e43 with SMTP id
 y5-20020a029505000000b0040fb3a86e43mr3035900jah.6.1682718411037; Fri, 28 Apr
 2023 14:46:51 -0700 (PDT)
Date:   Fri, 28 Apr 2023 14:46:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025a04405fa6c69a0@google.com>
Subject: [syzbot] upstream boot error: Internal error in corrupted
From:   syzbot <syzbot+b94704ab726aaea4a3a3@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    6e98b09da931 Merge tag 'net-next-6.4' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13053240280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d0e7ab221001b97
dashboard link: https://syzkaller.appspot.com/bug?extid=b94704ab726aaea4a3a3
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b94704ab726aaea4a3a3@syzkaller.appspotmail.com

Initmem setup node 0 [mem 0x0000000080000000-0x00000000ffffffff]
percpu: Embedded 18 pages/cpu s44168 r8192 d21368 u73728
Built 1 zonelists, mobility grouping on.  Total pages: 520868
Kernel command line: root=/dev/vda console=ttyAMA0  earlyprintk=serial net.ifnames=0 sysctl.kernel.hung_task_all_cpu_backtrace=1 ima_policy=tcb nf-conntrack-ftp.ports=20000 nf-conntrack-tftp.ports=20000 nf-conntrack-sip.ports=20000 nf-conntrack-irc.ports=20000 nf-conntrack-sane.ports=20000 binder.debug_mask=0 rcupdate.rcu_expedited=1 rcupdate.rcu_cpu_stall_cputime=1 no_hash_pointers page_owner=on sysctl.vm.nr_hugepages=4 sysctl.vm.nr_overcommit_hugepages=4 secretmem.enable=1 sysctl.max_rcu_stall_to_panic=1 msr.allow_writes=off coredump_filter=0xffff root=/dev/vda console=ttyAMA0 vmalloc=512M smp.csd_lock_timeout=300000 watchdog_thresh=165 workqueue.watchdog_thresh=420 sysctl.net.core.netdev_unregister_timeout_secs=420 dummy_hcd.num=2 panic_on_warn=1
Unknown kernel command line parameters "earlyprintk=serial page_owner=on", will be passed to user space.
Dentry cache hash table entries: 262144 (order: 8, 1048576 bytes, linear)
Inode-cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
allocated 2097152 bytes of page_ext
mem auto-init: stack:off, heap alloc:on, heap free:off
software IO TLB: area num 2.
software IO TLB: mapped [mem 0x00000000d9a49000-0x00000000dda49000] (64MB)
Memory: 1954376K/2097152K available (22528K kernel code, 2360K rwdata, 8380K rodata, 2048K init, 868K bss, 126392K reserved, 16384K cma-reserved, 524288K highmem)
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
Insufficient stack space to handle exception!
Task stack:     [0xdf85c000..0xdf85e000]
IRQ stack:      [0xdf804000..0xdf806000]
Overflow stack: [0x82a14000..0x82a15000]
Internal error: kernel stack overflow: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at 0x0
LR is at debug_smp_processor_id+0x20/0x24 lib/smp_processor_id.c:60
pc : [<00000000>]    lr : [<817ec4c8>]    psr: 20000193
sp : 00000000  ip : df805f80  fp : 00000000
r10: 825e0afd  r9 : 828fb980  r8 : 00000000
r7 : 00000000  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : 00000001  r2 : 817eb958  r1 : 81d982d4  r0 : 00000001
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 30c5387d  Table: 80003000  DAC: 00000000
Register r0 information: non-paged memory
Register r1 information: non-slab/vmalloc memory
Register r2 information: non-slab/vmalloc memory
Register r3 information: non-paged memory
Register r4 information: NULL pointer
Register r5 information: NULL pointer
Register r6 information: NULL pointer
Register r7 information: NULL pointer
Register r8 information: NULL pointer
Register r9 information:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 0 at mm/slub.c:4650 __kmem_obj_info+0x1c4/0x21c mm/slub.c:4650
Modules linked in:


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
