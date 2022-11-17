Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED962D790
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239327AbiKQJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239420AbiKQJ4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:56:54 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08538623B1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:38 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id g4-20020a92cda4000000b00301ff06da14so918938ild.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:55:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gnQLM+uf6EzDh8opNU8l71HS9owOO9Qy4dij00CPUug=;
        b=oU8lsj91caAO90cLkwzOpUjQi+OD/FmvMiO5jS5nTUhd2X34DJw4I+i0kAp7H310Xp
         1wGaF7cU6CsMirxwJcawqzc47mQjiMSetCt0MmAaLRbR8+jzMsPr84FCy1xJKmFryKvS
         NE8B4WMrb/uwPIPmFlkOtx04Y7xNG70g8hJD5+ETruqMbwiJllyIZ5wIZuKqy4ppdUr8
         SboY0Fc7GhY6jFeuGVTWoMopY4GTNa2IOM+ixIhVWaZjyqr4QjI5fPTSPMd4UHtDMr2T
         HJ50D9vaAqol4LYE7Q+KIV8hPiBXd1VxZV/sBihNMJ6uvOjt6PXhF2D60A/EZydvozNS
         85rQ==
X-Gm-Message-State: ANoB5pk9DWxvDTlwcTfldWdl6/bUASAomFdJgLI8IkfHD/htGyQ2CIbp
        rhiYNIMZhn05tATyaZ9SwC2f51p/iz7vSizBo0rySltU94di
X-Google-Smtp-Source: AA0mqf4OGqMmsF/lZaJKYoWoFuYKpYEVeb2ySk4w3mbbI1CfZLnx84ngDXwl4SlEUWqSx6tp+sbTKyMztxwOoDFiGzIxyQy/5DYm
MIME-Version: 1.0
X-Received: by 2002:a6b:c8cf:0:b0:688:2d29:95f0 with SMTP id
 y198-20020a6bc8cf000000b006882d2995f0mr940094iof.173.1668678937374; Thu, 17
 Nov 2022 01:55:37 -0800 (PST)
Date:   Thu, 17 Nov 2022 01:55:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004e78ec05eda79749@google.com>
Subject: [syzbot] BUG: sleeping function called from invalid context in static_key_slow_inc
From:   syzbot <syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com>
To:     Jason@zx2c4.com, frederic@kernel.org, juri.lelli@redhat.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, netdev@vger.kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, steven.price@arm.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    064bc7312bd0 netdevsim: Fix memory leak of nsim_dev->fa_co..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13d3204e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a33ac7bbc22a8c35
dashboard link: https://syzkaller.appspot.com/bug?extid=703d9e154b3b58277261
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0634e1c0e4cb/disk-064bc731.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fe1039d2de22/vmlinux-064bc731.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5a0d673875fa/bzImage-064bc731.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+703d9e154b3b58277261@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 9420, name: syz-executor.5
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 1 PID: 9420 Comm: syz-executor.5 Not tainted 6.1.0-rc4-syzkaller-00212-g064bc7312bd0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd1/0x138 lib/dump_stack.c:106
 __might_resched.cold+0x222/0x26b kernel/sched/core.c:9890
 percpu_down_read include/linux/percpu-rwsem.h:49 [inline]
 cpus_read_lock+0x1b/0x140 kernel/cpu.c:310
 static_key_slow_inc+0x12/0x20 kernel/jump_label.c:158
 udp_tunnel_encap_enable include/net/udp_tunnel.h:187 [inline]
 setup_udp_tunnel_sock+0x43d/0x550 net/ipv4/udp_tunnel_core.c:81
 l2tp_tunnel_register+0xc51/0x1210 net/l2tp/l2tp_core.c:1509
 pppol2tp_connect+0xcdc/0x1a10 net/l2tp/l2tp_ppp.c:723
 __sys_connect_file+0x153/0x1a0 net/socket.c:1976
 __sys_connect+0x165/0x1a0 net/socket.c:1993
 __do_sys_connect net/socket.c:2003 [inline]
 __se_sys_connect net/socket.c:2000 [inline]
 __x64_sys_connect+0x73/0xb0 net/socket.c:2000
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fd94d28b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd94e038168 EFLAGS: 00000246
 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fd94d3abf80 RCX: 00007fd94d28b639
RDX: 000000000000002e RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007fd94d2e6ae9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffde93128bf R14: 00007fd94e038300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
