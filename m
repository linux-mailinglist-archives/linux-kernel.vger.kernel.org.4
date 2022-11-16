Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDFC62BB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 12:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiKPLMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 06:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbiKPLLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 06:11:52 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825320F55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:59:33 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id w16-20020a6b4a10000000b006a5454c789eso8576718iob.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:59:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nuts0lcwPyxvF4DAGG7Mgpx+hVNgtwsa5HVMxORklmg=;
        b=igxNyJ6PeTLbkK8RN5A9174k/GiCxTMQkU2DoUK5rdfYxkU30AdYMNhF3yEIzodX7h
         pvgHWNFJ1fvFGcAkXMCZ3cwgo51Xc3PsDTrOHivkgIp7eBu7G4l++R23qjTn1wQCIJWB
         CczWXqt6pSEsUjnexf2dAfgN7rbOiu/DyyZHFdGPzmlzfKmifb50ZfXejASfltMc6nhV
         8K0J4mtFZsbM5eDmlHwZ3swVu48F25GarSU5aNn6Gj1Go34VZ3hTnRd53i1RmfgDqOAl
         vyJhL+s7DaJ65ejF1hL6yCMMMGoG1cJeYqPtcSVmuUrv1CSMFgide9LUipgC7/TItM9y
         xq+Q==
X-Gm-Message-State: ANoB5pk5brIQDK5+YvdvdHogWD9qzBkyiYVBpzrxW9AyDncm4yTUEGKP
        XXHD29XKHanlQvg5F1phGd85pPBcuOYGWr9rkHypcGlVB1gG
X-Google-Smtp-Source: AA0mqf4kGc/wfmGwv5FZvEzO7K9yFXvWedfhW8LxIqXtKcK+ZYOpn/AqREfY3xWCqzQgFWnYLDbw10W03o0NDPY6JQJpHPaQy7qW
MIME-Version: 1.0
X-Received: by 2002:a6b:600d:0:b0:6de:18b2:1025 with SMTP id
 r13-20020a6b600d000000b006de18b21025mr5840702iog.102.1668596372959; Wed, 16
 Nov 2022 02:59:32 -0800 (PST)
Date:   Wed, 16 Nov 2022 02:59:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015791c05ed945e13@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in virtual_ncidev_close
From:   syzbot <syzbot+4bf62ccd820c794f1292@syzkaller.appspotmail.com>
To:     bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    81e7cfa3a9eb Merge tag 'erofs-for-6.1-rc6-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11d19759880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2318f9a4fc31ad
dashboard link: https://syzkaller.appspot.com/bug?extid=4bf62ccd820c794f1292
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/54f7533927a5/disk-81e7cfa3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3861072b476/vmlinux-81e7cfa3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c36747ab66fe/bzImage-81e7cfa3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4bf62ccd820c794f1292@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: free active (active state 0) object type: timer_list hint: nci_cmd_timer+0x0/0xb0 net/nfc/nci/core.c:624
WARNING: CPU: 1 PID: 8272 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 1 PID: 8272 Comm: syz-executor.4 Not tainted 6.1.0-rc5-syzkaller-00015-g81e7cfa3a9eb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 0f a8 8a 4c 89 ee 48 c7 c7 20 03 a8 8a e8 df 66 9c 05 <0f> 0b 83 05 15 f4 44 0a 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc9001655fc60 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000000
RDX: ffff888027c0ba80 RSI: ffffffff816574fc RDI: fffff52002cabf7e
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff8a4e9be0
R13: ffffffff8aa80800 R14: ffffffff816ec8f0 R15: dffffc0000000000
FS:  00005555562f3400(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555574a7708 CR3: 0000000071e8c000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 __debug_check_no_obj_freed lib/debugobjects.c:989 [inline]
 debug_check_no_obj_freed+0x305/0x420 lib/debugobjects.c:1020
 slab_free_hook mm/slub.c:1699 [inline]
 slab_free_freelist_hook+0xeb/0x1c0 mm/slub.c:1750
 slab_free mm/slub.c:3661 [inline]
 __kmem_cache_free+0xaf/0x3b0 mm/slub.c:3674
 virtual_ncidev_close+0x7d/0x90 drivers/nfc/virtual_ncidev.c:167
 __fput+0x27c/0xa90 fs/file_table.c:320
 task_work_run+0x16f/0x270 kernel/task_work.c:179
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
 exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
 do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc7e6a3d40b
Code: 0f 05 48 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8 63 fc ff ff 8b 7c 24 0c 41 89 c0 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 44 89 c7 89 44 24 0c e8 a1 fc ff ff 8b 44
RSP: 002b:00007ffd62541350 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 00007fc7e6a3d40b
RDX: 0000001b30720000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fc7e6bad980 R08: 0000000000000000 R09: 00007ffd62566080
R10: 00007ffd62566090 R11: 0000000000000293 R12: 00000000001c58e2
R13: 00007fc7e6600d80 R14: 00007fc7e6bac120 R15: 0000000000000002
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
