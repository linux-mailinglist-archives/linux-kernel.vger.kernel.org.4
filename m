Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E9C6E2ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 21:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjDNT4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 15:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjDNT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 15:56:44 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E067D4C39
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:56:41 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id t2-20020a6bc302000000b00760c588931aso932826iof.22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 12:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681502201; x=1684094201;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtNyJU7opl/X5r0f9B+P211YtBrbp1eSIxo/w5hCQrE=;
        b=QxnezJldfnrJbS1pgSOQnqEKrpbS+goaXLThvx4+DAbfdnZWg7xcTIfoUQxec5vYX7
         W9ok0PYr5NN4xmYWNpzCWbdDm69ksLSCuvrrjiAf0vYkJ8qSm5zUaafPX4R+BdlruT9P
         doIVXL0tqxu9atCElclo+Jlhw4sFzkvHkXFEtSaMQKTj/vZMnikVst/HFLyr/X8uX51b
         xIVW+CvSsJ3Z78aUykfP5Z4lHjF5rl8tFDCWTAn5ROx/ZJ9COUSZPSgGEKT3FhU/SXWz
         CSpzk+7/BN6iFtCC+5OlacvtJPxdPazCizFyXoG3zVfQLOguzrB7njI/PUQdGYEqQq9W
         L1sw==
X-Gm-Message-State: AAQBX9efxeIMGCnOPCzuRfcznftZvfN3JWLGCzQyCNKPCKAmciM+cHSs
        kPu6CFt8yRnw/JPMhKrx+qzdyzyxdYS6TPngEUMTZt01K9Yb
X-Google-Smtp-Source: AKy350b5V1+SPa2Y/FrYgxpYzFWnAdt31CYFlL1xMYpkYmmrGo9g/qrmO8OmB3Vuby3nb6lvWBaatOLJEPeJehyuAJ5i3FPYPCwu
MIME-Version: 1.0
X-Received: by 2002:a05:6638:380d:b0:40d:97fe:8399 with SMTP id
 i13-20020a056638380d00b0040d97fe8399mr5682505jav.0.1681502201177; Fri, 14 Apr
 2023 12:56:41 -0700 (PDT)
Date:   Fri, 14 Apr 2023 12:56:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063ec4705f9513d4f@google.com>
Subject: [syzbot] [mm?] WARNING in unmap_page_range
From:   syzbot <syzbot+78c74557d14e8d51e013@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    e134c93f788f Add linux-next specific files for 20230406
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13b57c17c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a0548c6ce6e9842
dashboard link: https://syzkaller.appspot.com/bug?extid=78c74557d14e8d51e013
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b617d686938d/disk-e134c93f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3ac3406cd427/vmlinux-e134c93f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b08a19acadb/bzImage-e134c93f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+78c74557d14e8d51e013@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 24899 at mm/memory.c:1491 zap_pte_range mm/memory.c:1491 [inline]
WARNING: CPU: 1 PID: 24899 at mm/memory.c:1491 zap_pmd_range mm/memory.c:1564 [inline]
WARNING: CPU: 1 PID: 24899 at mm/memory.c:1491 zap_pud_range mm/memory.c:1593 [inline]
WARNING: CPU: 1 PID: 24899 at mm/memory.c:1491 zap_p4d_range mm/memory.c:1614 [inline]
WARNING: CPU: 1 PID: 24899 at mm/memory.c:1491 unmap_page_range+0x1c07/0x39b0 mm/memory.c:1635
Modules linked in:
CPU: 1 PID: 24899 Comm: syz-executor.0 Not tainted 6.3.0-rc5-next-20230406-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
RIP: 0010:zap_pte_range mm/memory.c:1491 [inline]
RIP: 0010:zap_pmd_range mm/memory.c:1564 [inline]
RIP: 0010:zap_pud_range mm/memory.c:1593 [inline]
RIP: 0010:zap_p4d_range mm/memory.c:1614 [inline]
RIP: 0010:unmap_page_range+0x1c07/0x39b0 mm/memory.c:1635
Code: 83 fb 02 0f 86 ff 0c 00 00 e8 85 4b c2 ff 44 89 e6 bf 1f 00 00 00 e8 98 47 c2 ff 41 83 fc 1f 0f 84 38 0e 00 00 e8 69 4b c2 ff <0f> 0b e9 da ef ff ff e8 5d 4b c2 ff 4c 89 e5 31 ff 4c 89 e3 81 e5
RSP: 0018:ffffc90004ef76f8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000000
RDX: ffff8880829f0000 RSI: ffffffff81c10c67 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000001f
R13: 0000000020679000 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33523000 CR3: 000000007b6c6000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 unmap_single_vma+0x19a/0x2b0 mm/memory.c:1681
 unmap_vmas+0x234/0x380 mm/memory.c:1720
 exit_mmap+0x190/0x930 mm/mmap.c:3063
 __mmput+0x13a/0x540 kernel/fork.c:1344
 mmput+0x60/0x70 kernel/fork.c:1366
 exit_mm kernel/exit.c:564 [inline]
 do_exit+0x9d7/0x29f0 kernel/exit.c:858
 do_group_exit+0xd4/0x2a0 kernel/exit.c:1021
 get_signal+0x2315/0x25b0 kernel/signal.c:2859
 arch_do_signal_or_restart+0x79/0x5c0 arch/x86/kernel/signal.c:307
 exit_to_user_mode_loop kernel/entry/common.c:168 [inline]
 exit_to_user_mode_prepare+0x11f/0x240 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:297
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f80caa8c169
Code: Unable to access opcode bytes at 0x7f80caa8c13f.
RSP: 002b:00007f80c95fe218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f80cababf88 RCX: 00007f80caa8c169
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f80cababf88
RBP: 00007f80cababf80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f80cababf8c
R13: 00007ffc884fac6f R14: 00007f80c95fe300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
