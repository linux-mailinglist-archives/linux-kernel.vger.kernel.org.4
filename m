Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD245FFBBC
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 21:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJOTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJOTVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 15:21:43 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8546621E38
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 12:21:41 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id k4-20020a056e02156400b002fcfa0da521so5378928ilu.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 12:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A4VjHpTY+k3KbZ6IrKXiwEgYAuIUAsSyXXWxa32DpOM=;
        b=Z4wLAOn3f98tzaKlNgOMhJCp95yJAWSwVui1bg4dGnywzGEU97bQv/+JINiLS62QMI
         C2mqzTKwd0VF1otL6wFB0vMovC8Q5i6CnVGsprQaWCSHcXSXz2LckIPMxhItpclsaBon
         YGLWrjttJEK/4LzcJHm6sYRuVEJ2rcv76XHSVfhf1WDfE4aW8tEOTcysnYY8iyRuB2YO
         PTPsZfUqUzF3VQyg1l+/UwIiGDuwDZEtBfuAdC5VVPn4DGJhWTFoZs8w4brWCw711/+v
         Lom8Yb3SNrM/OjRxcH0nFYiDCWzQyo7+Xb2JzchuCvbVkMC9lbq+7WuyBKdC3P0DeuW5
         60JA==
X-Gm-Message-State: ACrzQf278h6p48yeMnQ2y+1zu3uMp9pyhgeOPRNbNHLTueGhyPe+3mXw
        RThsk0HthQCw55vNiD9TLD4knRWfBYCj8bQ+diVb7hNjB2R8
X-Google-Smtp-Source: AMsMyM63ryNw2sUB2rN3e7uamk1XoQt957lB2LbtcBUByjXHx69Bihv5BaH782vQIWfBpQ2KB6A+ebnggfBiUoMXPrzChGEtSbpi
MIME-Version: 1.0
X-Received: by 2002:a05:6638:304c:b0:363:ff68:8ebc with SMTP id
 u12-20020a056638304c00b00363ff688ebcmr1986914jak.294.1665861700851; Sat, 15
 Oct 2022 12:21:40 -0700 (PDT)
Date:   Sat, 15 Oct 2022 12:21:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec9d6b05eb17a66f@google.com>
Subject: [syzbot] WARNING in jfs_symlink
From:   syzbot <syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=115bf294880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dba84f541f631c81
dashboard link: https://syzkaller.appspot.com/bug?extid=5fc38b2ddbbca7f5c680
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1150df3a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12eab444880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/608ce5a619e1/disk-55be6084.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/df10f9bb630d/vmlinux-55be6084.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d33a0105c419/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5fc38b2ddbbca7f5c680@syzkaller.appspotmail.com

------------[ cut here ]------------
memcpy: detected field-spanning write (size 132) of single field "ip->i_link" at fs/jfs/namei.c:950 (size 18446744073709551615)
WARNING: CPU: 1 PID: 3621 at fs/jfs/namei.c:950 jfs_symlink+0xd0f/0x1120 fs/jfs/namei.c:950
Modules linked in:
CPU: 1 PID: 3621 Comm: syz-executor125 Not tainted 6.0.0-syzkaller-09589-g55be6084c8e0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:jfs_symlink+0xd0f/0x1120 fs/jfs/namei.c:950
Code: ff e8 a5 7b a4 fe 48 c7 c1 ff ff ff ff 4c 89 e6 48 c7 c2 80 42 29 8a 48 c7 c7 e0 42 29 8a c6 05 2a 7d f4 0a 01 e8 70 fd 67 06 <0f> 0b 48 8b 95 b8 fd ff ff 48 b8 00 00 00 00 00 fc ff df 48 c1 ea
RSP: 0018:ffffc90003357b90 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff88806f5515b0 RCX: 0000000000000000
RDX: ffff88807e07e0c0 RSI: ffffffff81605668 RDI: fffff5200066af64
RBP: ffffc90003357e10 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: 0000000000000084
R13: ffff88806f6b05f0 R14: ffff88806f6b0470 R15: ffff888016d04ce0
FS:  0000555556a3e3c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200000c0 CR3: 0000000027bcd000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_symlink fs/namei.c:4378 [inline]
 vfs_symlink+0x365/0x5b0 fs/namei.c:4363
 do_symlinkat+0x261/0x2e0 fs/namei.c:4407
 __do_sys_symlink fs/namei.c:4429 [inline]
 __se_sys_symlink fs/namei.c:4427 [inline]
 __x64_sys_symlink+0x75/0x90 fs/namei.c:4427
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f5d8476b999
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffce4d88208 EFLAGS: 00000246 ORIG_RAX: 0000000000000058
RAX: ffffffffffffffda RBX: 00007ffce4d88218 RCX: 00007f5d8476b999
RDX: 0000000000fff340 RSI: 00000000200000c0 RDI: 0000000020000040
RBP: 00007ffce4d88210 R08: 00007ffce4d88210 R09: 00007f5d84729910
R10: 00007ffce4d88210 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
