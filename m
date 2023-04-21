Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28ACA6EAD07
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjDUOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjDUOfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 10:35:00 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56000B46C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:34:57 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7635a2dd490so336808439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 07:34:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682087696; x=1684679696;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lf8p0qjz5X15RhTmQkiDw+teegkKU0omwkgZ0vuOFc=;
        b=eiMIvCwP5iwRSmgCC9Pd+aA5Odlsshxn74lWIgSAXW2WDjlvyycQfQzYOA6zDepGnZ
         BA5RreSgzlNmpQbXKkqKN1YdAKCnRCTiMlPZnPzOeTRHi4Xb3PHkT4CkpauTHaKdvwQj
         MKiOEIigBaIo77ZXj0s4tip1Tfh5Cq+ZpaUdeS2nrAzBf3DGm740UazzzkKif1frKBKz
         Ew86ElEmPBkXzqpqlFGvgnIlXdIlUJKzjLSMyKdtcQxbdP3NGsuxXtGm7aXSUEzsPE41
         ZHfnx7Wmy+ABELPKM0Ruf7ZxmVujWBv3vGMNvLpejHq8nrSFliogmYxekdA/KhqkGEnO
         r3Lw==
X-Gm-Message-State: AAQBX9cG1hmq17lRx+D+Uhzucr1BTfVcVbdnrSIxTFDmz+iw4m12yQO+
        hWEQaY5EOkumHP5pVVleJ6Idqu3wPOtgmEpw3HZvxfZTtYyTi4/tJA==
X-Google-Smtp-Source: AKy350bjJwZF/1O0IY+n4sadp1O03RwKt/bNDPsCF15xYX4Bf6wbT2KQfSToB74ryXcQPKyKCdeP+H4SB4kPsflNAKMPbgrOxdlH
MIME-Version: 1.0
X-Received: by 2002:a02:9602:0:b0:40f:cf8d:86e6 with SMTP id
 c2-20020a029602000000b0040fcf8d86e6mr2484186jai.4.1682087696622; Fri, 21 Apr
 2023 07:34:56 -0700 (PDT)
Date:   Fri, 21 Apr 2023 07:34:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a3723305f9d98fc3@google.com>
Subject: [syzbot] [kernel?] KCSAN: data-race in do_timer_create /
 do_timer_create (8)
From:   syzbot <syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
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

HEAD commit:    6a8f57ae2eb0 Linux 6.3-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=154fe6c0280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa4baf7c6b35b5d5
dashboard link: https://syzkaller.appspot.com/bug?extid=5c54bd3eb218bb595aa9
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fd87c4c006cf/disk-6a8f57ae.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2ac4347e9165/vmlinux-6a8f57ae.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5844a1e58ba/bzImage-6a8f57ae.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in do_timer_create / do_timer_create

write to 0xffff888100ea9bc4 of 4 bytes by task 7660 on cpu 1:
 do_timer_create+0x2fd/0xa30 kernel/time/posix-timers.c:516
 __se_sys_timer_create kernel/time/posix-timers.c:577 [inline]
 __x64_sys_timer_create+0xbb/0xe0 kernel/time/posix-timers.c:577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

read to 0xffff888100ea9bc4 of 4 bytes by task 7659 on cpu 0:
 posix_timer_add kernel/time/posix-timers.c:143 [inline]
 do_timer_create+0x19f/0xa30 kernel/time/posix-timers.c:516
 __se_sys_timer_create kernel/time/posix-timers.c:577 [inline]
 __x64_sys_timer_create+0xbb/0xe0 kernel/time/posix-timers.c:577
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

value changed: 0x00000018 -> 0x00000026

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 7659 Comm: syz-executor.1 Not tainted 6.3.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
