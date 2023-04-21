Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36C26EA5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjDUISq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjDUISo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:18:44 -0400
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7D05B8F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:18:42 -0700 (PDT)
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-32b532ee15bso66109655ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065122; x=1684657122;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cNHaaL2wteXKqOq6fFI1R7yBNdGqHMxiJZSvBDXQeZg=;
        b=PemuZ8KNc6M1xu1TSmPJFaYdS6RJiE2NM+B5RdvW1/ja2CBA6dcFKFsqXFU9HKqmux
         mmsyDYBRW17Ii1Y9oOOjiSd/bVXEyxORyU3HpD/uQAqJaUrblBCWBshiefdlwlaz1upC
         VKnlgqetxuYglVYiWTFVMDAZ80ATPEMHGK48+N0Ga27yH0YDukHVM0Pqi+6M/4db7kbE
         e/iNaB4paVoxMlP2T8dLvX8L+nVL/RvvEs+MCp37HALx0hx8PAFpD1JxfI082gYjK2/9
         /KN07FUvLoWzOzHWlg/KxYyBMNbHUzLeRbfm4C2PzSS43CYWWDbGD/f8iY/jQBSCyL2C
         Mfkw==
X-Gm-Message-State: AAQBX9dJ+r9VrsnJAWif4NeLtSwEw1mBe8lqBhsHNwGbS443Y6KQtXtw
        IRly9Nme3NaqMKVzDNl9o1YY+argEX8rTpHC7pCJZqh7MOPq
X-Google-Smtp-Source: AKy350Ylf2SFjtkfmSasoThrRHsmxmztXdYjzONGesFMvSmkoIb+rZOG//dG5WNQ9GlCFQgtJqArXDOZoM9PQGpLjUW2WNmiUdIn
MIME-Version: 1.0
X-Received: by 2002:a5d:9282:0:b0:763:7dfb:27b2 with SMTP id
 s2-20020a5d9282000000b007637dfb27b2mr2040169iom.0.1682065121845; Fri, 21 Apr
 2023 01:18:41 -0700 (PDT)
Date:   Fri, 21 Apr 2023 01:18:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000013aaac05f9d44e7a@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in __fput / __tty_hangup (4)
From:   syzbot <syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    fcd476ea6a88 Merge tag 'urgent-rcu.2023.03.28a' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=146618b9c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f7350c77b8056a38
dashboard link: https://syzkaller.appspot.com/bug?extid=b7c3ba8cdc2f6cf83c21
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f3d8ce4faab0/disk-fcd476ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc53d9dee279/vmlinux-fcd476ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/22ad755d39b2/bzImage-fcd476ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b7c3ba8cdc2f6cf83c21@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __fput / __tty_hangup

write to 0xffff88813b31e828 of 8 bytes by task 17702 on cpu 0:
 __tty_hangup+0x1e2/0x510 drivers/tty/tty_io.c:622
 tty_vhangup+0x17/0x20 drivers/tty/tty_io.c:701
 pty_close+0x262/0x280 drivers/tty/pty.c:79
 tty_release+0x204/0x930 drivers/tty/tty_io.c:1753
 __fput+0x245/0x570 fs/file_table.c:321
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x123/0x160 kernel/task_work.c:179
 get_signal+0xe5c/0xfe0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x89/0x2b0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6d/0xe0 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff88813b31e828 of 8 bytes by task 17705 on cpu 1:
 __fput+0x21c/0x570 fs/file_table.c:320
 ____fput+0x15/0x20 fs/file_table.c:349
 task_work_run+0x123/0x160 kernel/task_work.c:179
 get_signal+0xe5c/0xfe0 kernel/signal.c:2635
 arch_do_signal_or_restart+0x89/0x2b0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6d/0xe0 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x6a/0xa0 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x26/0x140 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0xffffffff84e91ed0 -> 0xffffffff84e91dc0

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 17705 Comm: syz-executor.0 Not tainted 6.3.0-rc4-syzkaller-00034-gfcd476ea6a88 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/17/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
