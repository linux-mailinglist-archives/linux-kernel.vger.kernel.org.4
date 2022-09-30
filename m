Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342BB5F045C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 07:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiI3F4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 01:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiI3F4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 01:56:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6616DDCB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:56:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id x3-20020a056e021ca300b002f855cd264cso2736857ill.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 22:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=3bL4sMwFzWH34L2V3hcN7g1wUdkE8BwX3ojYbCKbtkM=;
        b=YOOASCyfXIjg5bc3Z643pYlknkeUEsb4rwcgteAiDb1Qqw23m/R8R6ibcj3RcHWVZD
         CvbtRrHHjicsjq6THrPCIGl0w3zsvia6SJ6GR4yDv0kklYMm18JfXq+pDG40qzFDK7RX
         zfLZxhTP3UiviS7NHBP+gQy0+cD0l1fRd0Fa2MDZdoMKE/tcrklDLXbiGMcuzB2518UT
         lP+pkI2qeCKZ19K+vIY+x8TonAAoAL1pxPeuGAxMFkkuZonwwTdKUv0pbQBhCSrDwYVP
         n/1Rc/uv6/u2iZilP9g+l/91TY50KoXVG6IZMtBcYnkrZhRA2grcNG0sHjJWdHVn7Hxs
         p86Q==
X-Gm-Message-State: ACrzQf2/bvQBkIfmLLmuKmMTFfCObVpsk8oE6yTJEE83B81ECng499pr
        BDva5iqL7ENSFvLmfvJZYvEGAOM6jDkh/6+6Lnr7ABXAG8LF
X-Google-Smtp-Source: AMsMyM4AKQ6Kqc26ymgGjtLa5ajJxOclKXawxDvwkyRa3eC5jxTewyeqREUyHBEpgGQcaoHxPUVmB6+vu+5FyOvPSMr8hFT475iG
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a6e:b0:2f5:9aad:1e97 with SMTP id
 w14-20020a056e021a6e00b002f59aad1e97mr3777053ilv.37.1664517398744; Thu, 29
 Sep 2022 22:56:38 -0700 (PDT)
Date:   Thu, 29 Sep 2022 22:56:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046580505e9dea8e4@google.com>
Subject: [syzbot] WARNING in change_protection
From:   syzbot <syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    511cce163b75 Merge tag 'net-6.0-rc8' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=135cf5c4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1992c90769e07
dashboard link: https://syzkaller.appspot.com/bug?extid=2b9b4f0895be09a6dec3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1164d0ec880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c3c2e0880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2b9b4f0895be09a6dec3@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker_entry include/linux/swapops.h:323 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 make_pte_marker include/linux/swapops.h:346 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pte_range mm/mprotect.c:270 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pmd_range mm/mprotect.c:409 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_pud_range mm/mprotect.c:438 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_p4d_range mm/mprotect.c:459 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection_range mm/mprotect.c:483 [inline]
WARNING: CPU: 1 PID: 3612 at include/linux/swapops.h:323 change_protection+0x16e9/0x4280 mm/mprotect.c:505
Modules linked in:
CPU: 1 PID: 3612 Comm: syz-executor181 Not tainted 6.0.0-rc7-syzkaller-00130-g511cce163b75 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:make_pte_marker_entry include/linux/swapops.h:323 [inline]
RIP: 0010:make_pte_marker include/linux/swapops.h:346 [inline]
RIP: 0010:change_pte_range mm/mprotect.c:270 [inline]
RIP: 0010:change_pmd_range mm/mprotect.c:409 [inline]
RIP: 0010:change_pud_range mm/mprotect.c:438 [inline]
RIP: 0010:change_p4d_range mm/mprotect.c:459 [inline]
RIP: 0010:change_protection_range mm/mprotect.c:483 [inline]
RIP: 0010:change_protection+0x16e9/0x4280 mm/mprotect.c:505
Code: ff 48 8b 84 24 90 00 00 00 80 38 00 0f 85 25 29 00 00 48 8b 44 24 10 48 83 b8 90 00 00 00 00 0f 84 8f f9 ff ff e8 a7 d6 c3 ff <0f> 0b 48 ba 00 00 00 00 00 fc ff df 48 8b 04 24 48 c1 e8 03 80 3c
RSP: 0018:ffffc90002fbf968 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffff888073714180 RSI: ffffffff81b76079 RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880000001e8 R14: 0000000000000000 R15: 000000002063e000
FS:  000055555624d300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005d84c8 CR3: 000000007c916000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 uffd_wp_range+0xf0/0x180 mm/userfaultfd.c:718
 mwriteprotect_range+0x2ea/0x420 mm/userfaultfd.c:768
 userfaultfd_writeprotect fs/userfaultfd.c:1827 [inline]
 userfaultfd_ioctl+0x438/0x43a0 fs/userfaultfd.c:1999
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl fs/ioctl.c:856 [inline]
 __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f77d7707bb9
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe74be7168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f77d7707bb9
RDX: 00000000200000c0 RSI: 00000000c018aa06 RDI: 0000000000000003
RBP: 00007f77d76cbd60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f77d76cbdf0
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
