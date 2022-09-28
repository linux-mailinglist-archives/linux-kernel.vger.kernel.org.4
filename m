Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A985ED5B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiI1HIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiI1HIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:08:40 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495F5E2351
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:08:39 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id a15-20020a6b660f000000b006a0d0794ad1so7165470ioc.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:08:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=hjrwsDmvZvaUNYt/+M9y9ilc+G7hCui8+Wd83doe0xA=;
        b=7UYnBBUPJF8QdsN/xhdqHKpd9GfnIGSo89GykBW27gpl0qvxFCQChrsq1lmdaTOudA
         EteY1Xu1n2GxnslDk/yBusNG5oCKFVt/vaoXDmNq/ZZ+FFEB9ERKJFDwCdyf4PyzRJyy
         egmWlj6Sco6+qLYfPPGQAZrbhauT0oIwX85k7i+HZhFUDsfy+cepuB61InXqe9xWaTSu
         RXZnM6Mbuhcnz2vo2x497ACt6FLKO/oUdlRefWIQ8vEQopt7gwt07wpquT4NOArDK0OH
         ly1D0fs8nRb8mmQwRBftOwUwUyK2x3Mv97Es9rrOsiUlAzL1RyW+4TEu04Ha5Vxd+N0f
         cShA==
X-Gm-Message-State: ACrzQf27+yvhBshF9Y2sXmvohQmGAONVYl/GMAin4690ghrb3j99fYMz
        3rFWfc/yDCi7e5OBGRP21EMpVPZ1ZDNTifqbMH7h1Ci7SxUT
X-Google-Smtp-Source: AMsMyM7XZq76rMH+jLZCc5YuaGUEVRF0vMrMWYGyl5DYE8KHSUe0dB/KublpC2jMPsH6L7n2a5dQaWI3yxrzehphia8XTcOfhX96
MIME-Version: 1.0
X-Received: by 2002:a05:6638:120b:b0:35a:98f1:7a22 with SMTP id
 n11-20020a056638120b00b0035a98f17a22mr16902678jas.271.1664348918672; Wed, 28
 Sep 2022 00:08:38 -0700 (PDT)
Date:   Wed, 28 Sep 2022 00:08:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000014712405e9b76e3b@google.com>
Subject: [syzbot] BUG: corrupted list in usb_hcd_unlink_urb_from_ep (2)
From:   syzbot <syzbot+4f71c3f6a96519a45bd4@syzkaller.appspotmail.com>
To:     WeitaoWang-oc@zhaoxin.com, gregkh@linuxfoundation.org,
        kishon@ti.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    d2cd2931d2fd Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=150038ef080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=4f71c3f6a96519a45bd4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4f71c3f6a96519a45bd4@syzkaller.appspotmail.com

list_del corruption, ffff0001002dea18->next is NULL
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:50!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 16370 Comm: syz-executor.5 Not tainted 6.0.0-rc6-syzkaller-17739-gd2cd2931d2fd #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
lr : __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
sp : ffff80000800bcc0
x29: ffff80000800bcc0 x28: ffff0000fde60700 x27: ffff0001002dea00
x26: ffff0000fde60708 x25: 0000000000000000 x24: ffff0000c526f440
x23: ffff0000c526f3c8 x22: ffff0000c526f440 x21: ffff0000c526f000
x20: ffff0001002dea18 x19: ffff0001002dea00 x18: 00000000000000c0
x17: ffff80000dd1b198 x16: ffff80000db59158 x15: ffff0000fdf28000
x14: 0000000000000000 x13: 0000000000002000 x12: ffff0000fdf28000
x11: ff808000081c30a4 x10: 0000000000000000 x9 : d6d49db26ddb9f00
x8 : d6d49db26ddb9f00 x7 : ffff8000081976e4 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000000000103 x0 : 0000000000000033
Call trace:
 __list_del_entry_valid+0x70/0xd0 lib/list_debug.c:49
 __list_del_entry include/linux/list.h:134 [inline]
 list_del_init include/linux/list.h:206 [inline]
 usb_hcd_unlink_urb_from_ep+0x30/0x70 drivers/usb/core/hcd.c:1248
 dummy_timer+0x388/0x111c drivers/block/aoe/aoedev.c:504
 call_timer_fn+0x90/0x144 kernel/time/timer.c:1474
 expire_timers kernel/time/timer.c:1519 [inline]
 __run_timers+0x280/0x374 kernel/time/timer.c:1790
 run_timer_softirq+0x34/0x5c kernel/time/timer.c:1803
 _stext+0x168/0x37c
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:79
 call_on_irq_stack+0x2c/0x54
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:84
 invoke_softirq+0x70/0xbc kernel/softirq.c:452
 __irq_exit_rcu+0xf0/0x140 kernel/softirq.c:650
 irq_exit_rcu+0x10/0x40 kernel/softirq.c:662
 __el1_irq arch/arm64/kernel/entry-common.c:471 [inline]
 el1_interrupt+0x38/0x68 arch/arm64/kernel/entry-common.c:485
 el1h_64_irq_handler+0x18/0x24 arch/arm64/kernel/entry-common.c:490
 el1h_64_irq+0x64/0x68
 arch_local_irq_restore+0x8/0x10 arch/arm64/include/asm/irqflags.h:122
 lock_is_held include/linux/lockdep.h:283 [inline]
 rcu_read_lock_held+0x34/0x50 kernel/rcu/update.c:311
 xa_entry include/linux/xarray.h:1198 [inline]
 xas_reload+0x98/0x270 include/linux/xarray.h:1577
 next_uptodate_page+0x154/0x778 mm/filemap.c:3283
 next_map_page mm/filemap.c:3318 [inline]
 filemap_map_pages+0x474/0x5d8 mm/filemap.c:3390
 do_fault_around mm/memory.c:4487 [inline]
 do_read_fault mm/memory.c:4513 [inline]
 do_fault+0x140/0x550 mm/memory.c:4647
 handle_pte_fault mm/memory.c:4911 [inline]
 __handle_mm_fault mm/memory.c:5053 [inline]
 handle_mm_fault+0x784/0xa40 mm/memory.c:5151
 __do_page_fault arch/arm64/mm/fault.c:502 [inline]
 do_page_fault+0x428/0x79c arch/arm64/mm/fault.c:602
 do_translation_fault+0x78/0x194 arch/arm64/mm/fault.c:685
 do_mem_abort+0x54/0x130 arch/arm64/mm/fault.c:821
 el0_ia+0x8c/0x1c8 arch/arm64/kernel/entry-common.c:532
 el0t_64_sync_handler+0xb4/0xf0 arch/arm64/kernel/entry-common.c:660
 el0t_64_sync+0x18c/0x190
Code: d65f03c0 9001b4c0 91279000 94a785f6 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
