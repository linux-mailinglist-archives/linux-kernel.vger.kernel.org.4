Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915F615989
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 04:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbiKBDNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 23:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKBDMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 23:12:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC60248C5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 20:12:40 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id bx19-20020a056602419300b006bcbf3b91fdso13124918iob.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 20:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=loDCBxhW8nfOBxRigXju8ECAHUU0s3sQgs+KQ5Jx9ac=;
        b=alqb5JjjYmipYDCiWRKxxc85a+uUQcYkIEX409TAyjBKmwvTq+cLMmvff8ZqAe23Tl
         xThVd0+tLVSSbsxSCxU+GBcHq2Hj+rsekumiXDQRlYNPm8uHh+0rE0PcOF+Zyy/CDNVC
         GFgKsrE9o/rCipKwo+U6h1e+ggb7D0/v2To64RNHheKTWsM3KMkcRuNfMasl3woUVRQV
         /b5lMlEJDRgfWyZMqYPBa35yJ3kHyhafy2EPK9QuQyu9PTAsizuMFlXufqfRTnIg/3AX
         oMUCsQOpFvkKu46WetA33UG+wXHFsOx62WUdghkHLVTbM0stVXQ0NLOV1UYmnMEGA1TM
         Q+JQ==
X-Gm-Message-State: ACrzQf1jPqLCMzru4rMPulN3GfxvKv4aJir+ZdJzmXSq5NWZhPijC8gJ
        IHl/sHBjxxfPuBxieXjnuGybro61Bp9p2rD9V9WheWhO6P9k
X-Google-Smtp-Source: AMsMyM4FWUFn2gUJUy/c9Ed7RcOX5BhfGlQHvi6AQyy32RMNxsBhf+r8JeU616o57TxtUZzsK3HUNpv4V3ZJe2N6OqeaEkVr1dUn
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:606:b0:300:c570:74d6 with SMTP id
 t6-20020a056e02060600b00300c57074d6mr3754548ils.152.1667358759824; Tue, 01
 Nov 2022 20:12:39 -0700 (PDT)
Date:   Tue, 01 Nov 2022 20:12:39 -0700
In-Reply-To: <000000000000f48ffe05ec534218@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097b4b005ec743600@google.com>
Subject: Re: [syzbot] INFO: task hung in f2fs_issue_checkpoint
From:   syzbot <syzbot+8c1c6ffb39e290968f8d@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12e47046880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=8c1c6ffb39e290968f8d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1585b5ea880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1551f6da880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f95889b8a293/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c1c6ffb39e290968f8d@syzkaller.appspotmail.com

INFO: task syz-executor969:3642 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D stack:28520 pid:3642  ppid:3605   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: task syz-executor969:3643 blocked for more than 144 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D
 stack:28848 pid:3643  ppid:3603   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: task syz-executor969:3644 blocked for more than 145 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D stack:28544 pid:3644  ppid:3602   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: task syz-executor969:3645 blocked for more than 146 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D
 stack:28400 pid:3645  ppid:3608   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: task syz-executor969:3646 blocked for more than 147 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D
 stack:28520 pid:3646  ppid:3607   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: task syz-executor969:3647 blocked for more than 148 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor969 state:D
 stack:25760 pid:3647  ppid:3606   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5191 [inline]
 __schedule+0xae9/0x53f0 kernel/sched/core.c:6503
 schedule+0xda/0x1b0 kernel/sched/core.c:6579
 schedule_timeout+0x1db/0x2a0 kernel/time/timer.c:1911
 do_wait_for_common kernel/sched/completion.c:85 [inline]
 __wait_for_common+0x1ca/0x5c0 kernel/sched/completion.c:106
 f2fs_issue_checkpoint+0x358/0x460 fs/f2fs/checkpoint.c:1882
 f2fs_sync_fs+0x240/0x4c0 fs/f2fs/super.c:1656
 sync_fs_one_sb fs/sync.c:84 [inline]
 sync_fs_one_sb+0x107/0x140 fs/sync.c:80
 iterate_supers+0x13c/0x290 fs/super.c:723
 ksys_sync+0xa8/0x150 fs/sync.c:104
 __do_sys_sync+0xa/0x10 fs/sync.c:113
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa42b72e519
RSP: 002b:00007ffc2d6fae78 EFLAGS: 00000246
 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 0000000020010ba0 RCX: 00007fa42b72e519
RDX: 00007fa42b6ec363 RSI: 0000000000000003 RDI: 0000000000004c00
RBP: 0000000000000000 R08: 0000555556fc22c0 R09: 0000000000000000
R10: 00007ffc2d6fab80 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc2d6faea0 R14: 00007ffc2d6fae8c R15: 00007ffc2d6fae90
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x24/0x18a lib/nmi_backtrace.c:111
 nmi_trigger_cpumask_backtrace+0x32f/0x3c0 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:148 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:220 [inline]
 watchdog+0xc71/0xfc0 kernel/hung_task.c:377
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 PID: 9 Comm: kworker/u4:0 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:native_apic_mem_read arch/x86/include/asm/apic.h:112 [inline]
RIP: 0010:__xapic_wait_icr_idle arch/x86/kernel/apic/ipi.c:107 [inline]
RIP: 0010:__default_send_IPI_dest_field+0x2e/0x130 arch/x86/kernel/apic/ipi.c:156
Code: fc 55 53 89 d3 48 83 ec 08 83 fe 02 74 73 a0 60 f8 eb ff ff fb ff ff 84 c0 74 08 3c 03 0f 8e a8 00 00 00 8b 04 25 00 c3 5f ff <48> bd 60 f8 eb ff ff fb ff ff f6 c4 10 74 1e f3 90 0f b6 45 00 84
RSP: 0018:ffffc900000e78a0 EFLAGS: 00000046
RAX: 00000000000008fb RBX: 0000000000000800 RCX: 0000000000000000
RDX: 0000000000000800 RSI: 00000000000000fb RDI: 0000000000000001
RBP: 1ffff9200001cf1d R08: 0000000000000005 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: ffffc900000e7908 R14: 0000000000000002 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562976970990 CR3: 000000000bc8e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 _flat_send_IPI_mask+0x4e/0x60 arch/x86/kernel/apic/apic_flat_64.c:56
 arch_send_call_function_single_ipi arch/x86/include/asm/smp.h:109 [inline]
 send_call_function_single_ipi+0x1e9/0x3b0 kernel/sched/core.c:3750
 smp_call_function_many_cond+0xe64/0x10a0 kernel/smp.c:967
 on_each_cpu_cond_mask+0x56/0xa0 kernel/smp.c:1155
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:1311 [inline]
 text_poke_bp_batch+0x3f1/0x6b0 arch/x86/kernel/alternative.c:1555
 text_poke_flush arch/x86/kernel/alternative.c:1670 [inline]
 text_poke_flush arch/x86/kernel/alternative.c:1667 [inline]
 text_poke_finish+0x16/0x30 arch/x86/kernel/alternative.c:1677
 arch_jump_label_transform_apply+0x13/0x20 arch/x86/kernel/jump_label.c:146
 jump_label_update+0x32f/0x410 kernel/jump_label.c:801
 static_key_disable_cpuslocked+0x152/0x1b0 kernel/jump_label.c:207
 static_key_disable+0x16/0x20 kernel/jump_label.c:215
 toggle_allocation_gate mm/kfence/core.c:814 [inline]
 toggle_allocation_gate+0x183/0x390 mm/kfence/core.c:792
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

