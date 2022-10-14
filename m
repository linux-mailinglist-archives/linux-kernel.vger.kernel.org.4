Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524255FF51E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 23:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJNVQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 17:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJNVQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 17:16:44 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A36EC537
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:16:43 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id a17-20020a921a11000000b002fadf952565so4819823ila.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 14:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yuMrHSWTWXQslKIQUwFKq1dBL0dUZHTdCqUAVtEW1PY=;
        b=rJkQIFMYzlm+YJyCeyEm8bWA7G6aVzN0d1/sn2iJJl3kcVoATQBV59Fs0gjcJ8CDYG
         yhqPT3lMbw7uUY0xkOBy7QmnvYpHSkPh1AmSwgRxVPdJu+7+yalUzqyPW5WNE+A5Hz3Z
         uPAA2K3ISmX4PdKpbhnsjAdKByQw2mbtHbRUI1R70Bezoe9iBpvXXo2M/WAQ6ZuCYPBu
         zSt5WZDSmoS9FtFc09zLydAWAqqVP4ph84jPrpDbiifE3bjOuFLTYIdh2nVkSDuZtfM5
         zZewCvHDInH87LCm4pMfj5Yr63Zb6HueTbmQ6s73YYXrFG8PthKpxsWo/QfJj7R/TMq7
         l/fw==
X-Gm-Message-State: ACrzQf0Sgu5WCZ1iAx84Aq+8a9LOgQbE5Ut3o0dKifitnlfOq4euzRPk
        uSsjIb7tkD63Zaw45GbLWL052yyblu5D9BgSyqeaVx2FpzfP
X-Google-Smtp-Source: AMsMyM4SPGve5TmMYoSU83XKOhuiO47Ar5XjKLfzoWwSesFRmJ3pkLTLq6G7GaGQG0C+2aujn1v+4ahcrFeRgLXIDUc6GdcbR4A5
MIME-Version: 1.0
X-Received: by 2002:a05:6638:240e:b0:363:dbde:4176 with SMTP id
 z14-20020a056638240e00b00363dbde4176mr3699292jat.243.1665782202646; Fri, 14
 Oct 2022 14:16:42 -0700 (PDT)
Date:   Fri, 14 Oct 2022 14:16:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007647ec05eb05249c@google.com>
Subject: [syzbot] WARNING in c_start
From:   syzbot <syzbot+d0fd2bf0dd6da72496dd@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rafael.j.wysocki@intel.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
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

HEAD commit:    9c9155a3509a Merge tag 'drm-next-2022-10-14' of git://anon..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1030f562880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=557e715ffce7a200
dashboard link: https://syzkaller.appspot.com/bug?extid=d0fd2bf0dd6da72496dd
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0fd2bf0dd6da72496dd@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpumask_check include/linux/cpumask.h:117 [inline]
WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 cpumask_next include/linux/cpumask.h:178 [inline]
WARNING: CPU: 1 PID: 3671 at include/linux/cpumask.h:110 c_start+0x152/0x1b0 arch/x86/kernel/cpu/proc.c:156
Modules linked in:
CPU: 1 PID: 3671 Comm: syz-fuzzer Not tainted 6.0.0-syzkaller-11990-g9c9155a3509a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:110 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:117 [inline]
RIP: 0010:cpumask_next include/linux/cpumask.h:178 [inline]
RIP: 0010:c_start+0x152/0x1b0 arch/x86/kernel/cpu/proc.c:156
Code: a0 68 99 8b e8 3f 97 4b 00 5b 5d 4c 89 e0 41 5c 41 5d c3 e8 30 97 4b 00 45 31 e4 5b 4c 89 e0 5d 41 5c 41 5d c3 e8 1e 97 4b 00 <0f> 0b e9 1e ff ff ff 48 c7 c7 40 54 e1 8d e8 fb 19 97 00 e9 6b ff
RSP: 0018:ffffc90002f27c70 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff8de15440 RCX: 0000000000000000
RDX: ffff88801b3b6100 RSI: ffffffff812ffc02 RDI: 0000000000000004
RBP: 0000000000000008 R08: 0000000000000004 R09: 0000000000000008
R10: 0000000000000008 R11: 0000000000000001 R12: ffff88801c29c278
R13: 0000000000000008 R14: ffff888023b17b3c R15: 0000000000000000
FS:  000000c00004e890(0000) GS:ffff88802c800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe53b98da00 CR3: 000000001b4cb000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 seq_read_iter+0x2c6/0x1280 fs/seq_file.c:225
 proc_reg_read_iter+0x111/0x2d0 fs/proc/inode.c:301
 call_read_iter include/linux/fs.h:2185 [inline]
 new_sync_read fs/read_write.c:389 [inline]
 vfs_read+0x67d/0x930 fs/read_write.c:470
 ksys_read+0x127/0x250 fs/read_write.c:613
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4ae09b
Code: e8 ea 57 fb ff eb 88 cc cc cc cc cc cc cc cc e8 fb 9b fb ff 48 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
RSP: 002b:000000c0007233b8 EFLAGS: 00000212 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000000c00003e800 RCX: 00000000004ae09b
RDX: 0000000000000b49 RSI: 000000c0004fe4b7 RDI: 0000000000000003
RBP: 000000c000723408 R08: 0000000000000001 R09: 000000c000074480
R10: 0000000000000b49 R11: 0000000000000212 R12: 000000c000723570
R13: 0000000000000000 R14: 000000c0000001a0 R15: 00007fe53942c2f3
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
