Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052EF6EAD06
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjDUOeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjDUOeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:34:09 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140FE13849
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:33:52 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-76371bc5167so337159639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:33:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087631; x=1684679631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6UpMKB6cSp5ADz54ewE7MGwjSgv20brTCnPjBogVFTg=;
        b=eBlSzcvizGm73567kZS3N5sPIZU+i6XkGAmcyVsqLl+E4BNTZAhkd8WLRaaBJmK0qY
         BPkznDW/S67S6Ioo0UCOjcWxeTZZpBfba4+5XkzNvSEysjD53Mo6lVo7d5PVFUnlFAL6
         0Xia7p9eLZNErCbdOiSb13MdUvfJ1KjQ10CqEY8vCrGTONYCFbh9xxFSYx7F3p+g32Sn
         sbzeau6rj1NnQhJ13jE6eow6PKLSVwI76f/nSDPYS0ErWNrzf5Ny54deJNxXmqcx1s6X
         o+b2LD9vOsr+r2Nj29COmOnMXT9M4rFuIaS6klv1WvMSCHPRDrqx/Z/jiAc1cfLJ2wmJ
         nrpQ==
X-Gm-Message-State: AAQBX9e+vhhEeQsbGWZVQ9tsL6notkjKD/42NKwkd3qvENzGKektiorM
        D2Do0eKZI7umn15IIFYoYPYq+QClnXaOpTPnqjWwRZCIn6EN
X-Google-Smtp-Source: AKy350a+z19IQEWi6rHouQdIqKA2I97b4pxHM1+fdtm1o3WL25lQ6PYWYuPmjbii/vOzvB/m+8oeoIr144M5Pnudcm3p/dCVF/aZ
MIME-Version: 1.0
X-Received: by 2002:a02:b190:0:b0:40f:8242:448 with SMTP id
 t16-20020a02b190000000b0040f82420448mr2468979jah.3.1682087631296; Fri, 21 Apr
 2023 07:33:51 -0700 (PDT)
Date:   Fri, 21 Apr 2023 07:33:51 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be9fa205f9d98b5b@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in complete_signal /
 do_group_exit (7)
From:   syzbot <syzbot+0864692611e2ae4cc85f@syzkaller.appspotmail.com>
To:     brauner@kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a93e40326c8 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1769d1dec80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
dashboard link: https://syzkaller.appspot.com/bug?extid=0864692611e2ae4cc85f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2122926bc9fe/disk-3a93e403.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8392992358bc/vmlinux-3a93e403.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6398a2d19a7e/bzImage-3a93e403.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0864692611e2ae4cc85f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in complete_signal / do_group_exit

write to 0xffff88810491e534 of 4 bytes by task 13425 on cpu 0:
 complete_signal+0x541/0x6d0 kernel/signal.c:1053
 __send_signal_locked+0x5cc/0x700 kernel/signal.c:1190
 send_signal_locked+0x28d/0x3a0 kernel/signal.c:1253
 do_send_sig_info+0x9f/0xf0 kernel/signal.c:1296
 send_sig_info kernel/signal.c:1636 [inline]
 send_sig+0x53/0x60 kernel/signal.c:1646
 pipe_write+0x8b1/0xd70 fs/pipe.c:482
 call_write_iter include/linux/fs.h:1851 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x45a/0x750 fs/read_write.c:584
 ksys_write+0xeb/0x1a0 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __x64_sys_write+0x42/0x50 fs/read_write.c:646
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88810491e534 of 4 bytes by task 13410 on cpu 1:
 do_group_exit+0x3e/0x150 kernel/exit.c:998
 __do_sys_exit_group kernel/exit.c:1030 [inline]
 __se_sys_exit_group kernel/exit.c:1028 [inline]
 __x64_sys_exit_group+0x1f/0x20 kernel/exit.c:1028
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000002 -> 0x00000004

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 13410 Comm: syz-executor.0 Not tainted 6.3.0-rc4-syzkaller-00025-g3a93e40326c8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
