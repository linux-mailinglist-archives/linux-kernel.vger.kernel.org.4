Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C746134F4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 12:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbiJaLyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 07:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbiJaLxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 07:53:54 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA025D6E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:53:53 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id i11-20020a056e02152b00b003007c106191so8735348ilu.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 04:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAFMAvxlxMoFnG+XfsZSIIGrHwoTQNmkec9dxETMnqg=;
        b=jDmjiZFaVcNpQHtdm6ea/p5ZsWJUmlBbf1QPMDM5rX3RAyLlPGVqguKpnZWBU0lHak
         bHLYm/Ex3kvaNCpPLBX6hcQIJ+n4cZguBacrAblgBg0WY6xvW5JE7Gib6yEQKShrhuN1
         lws8LGVdKTMnhykltYnJgWdyJAjiGmVStkvQ5IOdlc99GJXWmicfx3kcKDhYQaFUROsd
         k9PjArC+he9a9kd2+DfQqhLJVJDcJ0rLwiUxcpjtsAyCx8xoEpvz10oNwdlyjPPeNZLS
         sNJsVAQbZDb9RJ0xZn9i+CGmhVRClxJD4wy2BHbB7APR+y2uy2g2OGrWDAyAizL7Hkob
         wJeA==
X-Gm-Message-State: ACrzQf2ihNmgedYLpPPeMpc3iYnagu9xL2duitla95HnFQ3ybdhVVvtd
        ExfFi++m/XnBdRCBtVJZQrJzF+ofllnA+TCWhlirxhRiSf8j
X-Google-Smtp-Source: AMsMyM49tlFv28uXTo2fsgxAWnme+TK3gmDlYPlvAU8F9RaO83DOKQFXKH4yBGTt1MQ8KgsG/zYIpHxg7WUn5vIjASQhNFhXbu3C
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3795:b0:375:cca:7024 with SMTP id
 w21-20020a056638379500b003750cca7024mr7142594jal.103.1667217233315; Mon, 31
 Oct 2022 04:53:53 -0700 (PDT)
Date:   Mon, 31 Oct 2022 04:53:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f48ffe05ec534218@google.com>
Subject: [syzbot] INFO: task hung in f2fs_issue_checkpoint
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

Hello,

syzbot found the following issue on:

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=133b675a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=8c1c6ffb39e290968f8d
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c1c6ffb39e290968f8d@syzkaller.appspotmail.com

INFO: task syz-executor.0:4475 blocked for more than 143 seconds.
      Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.0  state:D stack:27384 pid:4475  ppid:3641   flags:0x00004004
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
RIP: 0033:0x7fc11668b5a9
RSP: 002b:00007fc1173be168 EFLAGS: 00000246 ORIG_RAX: 00000000000000a2
RAX: ffffffffffffffda RBX: 00007fc1167abf80 RCX: 00007fc11668b5a9
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fc1166e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd5b7e66ff R14: 00007fc1173be300 R15: 0000000000022000
 </TASK>
INFO: lockdep is turned off.
NMI backtrace for cpu 1
CPU: 1 PID: 27 Comm: khungtaskd Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 9 Comm: kworker/u4:0 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Workqueue: phy10 ieee80211_iface_work
RIP: 0010:_compound_head include/linux/page-flags.h:255 [inline]
RIP: 0010:virt_to_folio include/linux/mm.h:892 [inline]
RIP: 0010:kfree+0x61/0x1a0 mm/slab_common.c:999
Code: 0f 86 33 01 00 00 4c 89 e7 e8 ab 13 86 ff 48 bf 00 00 00 00 00 ea ff ff 48 c1 e8 0c 48 89 c5 48 c1 e5 06 48 01 fd 48 8b 45 08 <a8> 01 0f 85 19 01 00 00 66 90 48 89 ef e8 ad f2 ff ff 48 8b 00 f6
RSP: 0018:ffffc900000e7960 EFLAGS: 00000282
RAX: ffffea000073f401 RBX: ffff8880888af874 RCX: 0000000000000000
RDX: ffff888011a50000 RSI: ffffffff8136c4f4 RDI: ffffea0000000000
RBP: ffffea000073f480 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 000000000008c07e R12: ffff88801cfd2800
R13: 0000000000000028 R14: ffff88801d0b0de0 R15: ffff88801cfd2800
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f110a37f1b8 CR3: 000000002118d000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ieee80211_bss_info_update+0x49e/0xaf0 net/mac80211/scan.c:223
 ieee80211_rx_bss_info net/mac80211/ibss.c:1120 [inline]
 ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1609 [inline]
 ieee80211_ibss_rx_queued_mgmt+0x1a31/0x3190 net/mac80211/ibss.c:1638
 ieee80211_iface_process_skb net/mac80211/iface.c:1630 [inline]
 ieee80211_iface_work+0xa47/0xd30 net/mac80211/iface.c:1684
 process_one_work+0x9bf/0x1710 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
