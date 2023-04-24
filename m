Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00B56EC6EE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 09:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjDXHVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjDXHVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 03:21:06 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C16035A7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7606d6b2fddso694771939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 00:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682320846; x=1684912846;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PemElVUZPDUlSEqORBOOBPYv/4pd8BGjx60bDqC5Fd0=;
        b=clNaWklJlCPt+HnIrcya5V5jPCb00qZoT6PucHz2FVrJtv6q06CctIE1KrchBK6yje
         02bVuTOUD8gxZmtBXPp438KdZKBU/o3Co2YgQY6mfFVKBmtL7lv4bNyTcAdpesXdtE6U
         YNWy3UKm/dp5SqHVGjE0QCgo6BA2bCw4N30OdrJ5aSh/shdT2ED96c2bg5rZGMCYRQDY
         QQ3gkhZkwKrl4WEETilAnQQlYurxVxniY4llLTEZBLAZUCPn+10lV3jLOSIlGuk0R7Rm
         LwxNSDa8NDdzhDFEfELi4ycosIiH8L09F3Dp89ZmXhFijbL4N0x3UqlARaqL9VspZR6K
         EtIA==
X-Gm-Message-State: AAQBX9eU8GJCTOZ8l44v8ToVMTZxeHTtEBX0swgi4oO6Ts2pcpj69xRP
        uRLmXXsr4t7PD7OihEtrAv8wQRBHXvYhtio3S4GhVztWX11d
X-Google-Smtp-Source: AKy350Zm6j/ODxfO39PwH9P/0e7nkeWgN5FOdVmKrARV+imtnemEVPFoovMLXBeUeF/QT1K23d7kXScRuWN/hmfGXRymDW/JANOh
MIME-Version: 1.0
X-Received: by 2002:a6b:c407:0:b0:760:efd4:9583 with SMTP id
 y7-20020a6bc407000000b00760efd49583mr4136641ioa.1.1682320846333; Mon, 24 Apr
 2023 00:20:46 -0700 (PDT)
Date:   Mon, 24 Apr 2023 00:20:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000071af7a05fa0fd8dc@google.com>
Subject: [syzbot] [block?] KCSAN: data-race in __get_task_ioprio / set_task_ioprio
From:   syzbot <syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    44149752e998 Merge tag 'cgroup-for-6.3-rc6-fixes' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147afc8fc80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=710057cbb8def08c
dashboard link: https://syzkaller.appspot.com/bug?extid=28ed267c18c614a9376f
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7bfa303f05cc/disk-44149752.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4e8ea8730409/vmlinux-44149752.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e584bce13ba7/bzImage-44149752.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+28ed267c18c614a9376f@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in __get_task_ioprio / set_task_ioprio

write to 0xffff888108c83888 of 8 bytes by task 15748 on cpu 0:
 set_task_ioprio+0x23b/0x260 block/blk-ioc.c:291
 __do_sys_ioprio_set block/ioprio.c:124 [inline]
 __se_sys_ioprio_set+0x272/0x5a0 block/ioprio.c:68
 __x64_sys_ioprio_set+0x43/0x50 block/ioprio.c:68
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888108c83888 of 8 bytes by task 15749 on cpu 1:
 __get_task_ioprio+0x1c/0x110 block/ioprio.c:150
 get_current_ioprio include/linux/ioprio.h:60 [inline]
 init_sync_kiocb include/linux/fs.h:2003 [inline]
 __kernel_write_iter+0xe2/0x380 fs/read_write.c:515
 dump_emit_page fs/coredump.c:885 [inline]
 dump_user_range+0x258/0x480 fs/coredump.c:912
 elf_core_dump+0x1a73/0x1b90 fs/binfmt_elf.c:2142
 do_coredump+0xfeb/0x1840 fs/coredump.c:762
 get_signal+0xd65/0xff0 kernel/signal.c:2845
 arch_do_signal_or_restart+0x89/0x2a0 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6f/0xe0 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0x6c/0xb0 kernel/entry/common.c:204
 irqentry_exit_to_user_mode+0x9/0x20 kernel/entry/common.c:310
 irqentry_exit+0x12/0x40 kernel/entry/common.c:413
 exc_general_protection+0x339/0x4c0 arch/x86/kernel/traps.c:728
 asm_exc_general_protection+0x26/0x30 arch/x86/include/asm/idtentry.h:564

value changed: 0x0000000000000000 -> 0xffff8881049b5c90

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 PID: 15749 Comm: syz-executor.5 Tainted: G        W          6.3.0-rc6-syzkaller-00138-g44149752e998 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
