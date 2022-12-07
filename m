Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471B645290
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 04:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiLGDcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 22:32:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiLGDcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 22:32:47 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EC4DB0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 19:32:43 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i11-20020a056e02152b00b00303642498daso5615420ilu.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 19:32:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M7kwxX+hWVx9ugZTdzJAXzTf2e9v8Af3sYI1qOiOBZo=;
        b=3vMC6Td+yKwBQSgr9BeRtAmV8ukf1/JswbEGEmdZhxytObh0P8d42Am0wtDxK3iMX2
         z5OBm3dF5XPuqguTnGo8fgpwYJSy7kTKv+LkynfOoZxG3el47EEmH9CuN+U/CJOFMUgt
         qEkSmE2ndFz3lq+PPzL4wLeHZAjS9nrenkz57KUzPKPYw8gx9b9u0hSjkZmDWdbAEGKj
         lHmoXz4pEigWqRKiegWi9SBOE36cSsXacZqAsgcNceLy0V4xHNHBUQbSBbhcAyyyUjPv
         MKiZEBAdCqzReGH+ELptxao5iDNqWd+AYMG+zbhqZ8DjGXgt58Aif2Ahb2xGUG2kHz/0
         Kmfg==
X-Gm-Message-State: ANoB5plx1l6Ey0pIG1cZn0HubA2nltf4qTIq7Nbic4FtlZze8mfNd44X
        SXJOspOB2kZ0/Mc8S33ogfyWAbNub0hCjbPIqgxwzatTLvl0
X-Google-Smtp-Source: AA0mqf49ZkgqOY/RRjkYgFNPz2APw1vlp4DR2aBQ3QrW9s1dSziZLreYPpp1yCZutlaX6/WV6sgOumzpeogKLDq28dJ8aTYd3EqJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2245:b0:363:a232:f0d4 with SMTP id
 m5-20020a056638224500b00363a232f0d4mr32094389jas.213.1670383962906; Tue, 06
 Dec 2022 19:32:42 -0800 (PST)
Date:   Tue, 06 Dec 2022 19:32:42 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bf681e05ef3492ba@google.com>
Subject: [syzbot] INFO: trying to register non-static key in gsm_send
From:   syzbot <syzbot+52fe5933e61fb1f048ae@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
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

HEAD commit:    e3cb714fb489 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=124b06f5880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ec7118319bfb771e
dashboard link: https://syzkaller.appspot.com/bug?extid=52fe5933e61fb1f048ae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154acf4b880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c3ec29880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/832eb1866f2c/disk-e3cb714f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5fd572b7d96d/vmlinux-e3cb714f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/34c82908beda/Image-e3cb714f.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52fe5933e61fb1f048ae@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 6675 Comm: syz-executor912 Not tainted 6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 assign_lock_key+0x134/0x140 kernel/locking/lockdep.c:981
 register_lock_class+0xc4/0x2f8 kernel/locking/lockdep.c:1294
 __lock_acquire+0xa8/0x3084 kernel/locking/lockdep.c:4934
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5668
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0x6c/0xb4 kernel/locking/spinlock.c:162
 gsm_send+0x19c/0x264 drivers/tty/n_gsm.c:725
 gsm_command drivers/tty/n_gsm.c:789 [inline]
 gsm_dlci_begin_close drivers/tty/n_gsm.c:1933 [inline]
 gsm_cleanup_mux+0xd0/0x3c0 drivers/tty/n_gsm.c:2492
 gsm_config drivers/tty/n_gsm.c:2754 [inline]
 gsmld_ioctl+0x5fc/0x778 drivers/tty/n_gsm.c:3117
 tty_ioctl+0x694/0x9b0 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
list_add corruption. prev->next should be next (ffff0000ccd00390), but was 8000000100000000. (prev=ffff0000ccd00690).
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:32!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 6675 Comm: syz-executor912 Not tainted 6.1.0-rc7-syzkaller-33097-ge3cb714fb489 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
lr : __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
sp : ffff800015d3bba0
x29: ffff800015d3bba0 x28: 00000000000000d7 x27: 0000000000000000
x26: ffff0000c98651a5 x25: 0000000000000001 x24: ffff0000ccd00390
x23: ffff0000ccd00690 x22: 0000000000000000 x21: ffff0000ccd00348
x20: ffff0000c9865180 x19: ffff0000cccfff80 x18: 0000000000000106
x17: 3039333030646363 x16: 3030303066666666 x15: 28207478656e2065
x14: 6220646c756f6873 x13: 205d353736365420 x12: 5b5d363437333236
x11: ff808000081c4d64 x10: 0000000000000000 x9 : 349d594052031c00
x8 : 349d594052031c00 x7 : 205b5d3634373332 x6 : ffff80000c091044
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000001 x0 : 0000000000000075
Call trace:
 __list_add_valid+0xb4/0xb8 lib/list_debug.c:30
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 gsm_send+0x1b8/0x264 drivers/tty/n_gsm.c:726
 gsm_command drivers/tty/n_gsm.c:789 [inline]
 gsm_dlci_begin_close drivers/tty/n_gsm.c:1933 [inline]
 gsm_cleanup_mux+0xd0/0x3c0 drivers/tty/n_gsm.c:2492
 gsm_config drivers/tty/n_gsm.c:2754 [inline]
 gsmld_ioctl+0x5fc/0x778 drivers/tty/n_gsm.c:3117
 tty_ioctl+0x694/0x9b0 drivers/tty/tty_io.c:2780
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __arm64_sys_ioctl+0xd0/0x140 fs/ioctl.c:856
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 9139b400 aa0303e1 aa0803e3 94aa88ef (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
