Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243805BBC04
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 07:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIRF3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 01:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIRF3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 01:29:35 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750F3A44D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 22:29:33 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id h5-20020a056e021d8500b002eb09a4f7e6so17376509ila.14
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 22:29:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=g48QcT/wkVC8ZD22fn8yiiIVvlcs3D7jSABH91P7O1k=;
        b=am3e5NCPa2R5p+l9LdYEl91b8Fgy5l1x3DKWc5VA5EX03e8UebJqZMrcdxWvLhu5++
         iXsv+NICWokgf59hif1RZgpEJpTYVVaTnS2eeVboZlPhymG6lGKwYT7YexLd2sDo7tJU
         /3dcsbsSafSRixUpL+jtFW+fGSHfeehaOYH7c7kvwoEcQU9Hg0mwp5cd3q6G/f9SmehN
         LDP2ZpfgTTTrN1ZTqvuIhmXujeJb/V0GqkLUxpiK22b2lzgFV2Z/PTGuZywCIhdfTPY+
         1vSkQCeGVgv2puzvvzReuI6IB6mlvY5VCA7cLbb8FMFgXdlh2MZh1Afx6NxUPVGrZU6T
         EBLg==
X-Gm-Message-State: ACrzQf2litwobdtg3LejFaU5EShvVj3Ai0rWNcbeIoOSTz9bv2u6ykXK
        lVhGu3xXtkq8HsWd5Ezl4cdLgNbmloe/HmGXAT/QoARrJbHk
X-Google-Smtp-Source: AMsMyM7IWLv9OqGwX7pIDCTBHiyQJf79YJDcincdyojx1AGAd1XSkthYNfFkx4TNJpdnKbHBUbCIaHnSmhZqvsNGxwNV2Os8zXGR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2145:b0:2f4:8c94:dcbc with SMTP id
 d5-20020a056e02214500b002f48c94dcbcmr5216605ilv.161.1663478972821; Sat, 17
 Sep 2022 22:29:32 -0700 (PDT)
Date:   Sat, 17 Sep 2022 22:29:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000443a7205e8ece1d9@google.com>
Subject: [syzbot] BUG: soft lockup in tx
From:   syzbot <syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
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

HEAD commit:    a6b443748715 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=176b1680880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=14bf9ec0df433b27
dashboard link: https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b22b10880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fce87f080000

Downloadable assets:
disk image: https://storage.googleapis.com/81b491dd5861/disk-a6b44374.raw.xz
vmlinux: https://storage.googleapis.com/69c979cdc99a/vmlinux-a6b44374.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5e87db90e68fbc4707c6@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [aoe_tx0:1378]
Modules linked in:
irq event stamp: 34814405
hardirqs last  enabled at (34814404): [<ffff80000bfd85d4>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
hardirqs last  enabled at (34814404): [<ffff80000bfd85d4>] _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
hardirqs last disabled at (34814405): [<ffff80000bfc5d58>] __el1_irq arch/arm64/kernel/entry-common.c:455 [inline]
hardirqs last disabled at (34814405): [<ffff80000bfc5d58>] el1_interrupt+0x24/0x68 arch/arm64/kernel/entry-common.c:473
softirqs last  enabled at (8188): [<ffff80000b20ab54>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (8192): [<ffff80000b20ab20>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
CPU: 0 PID: 1378 Comm: aoe_tx0 Not tainted 6.0.0-rc4-syzkaller-17255-ga6b443748715 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
pc : _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
lr : __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
lr : _raw_spin_unlock_irqrestore+0x48/0x8c kernel/locking/spinlock.c:194
sp : ffff800014a53b80
x29: ffff800014a53b80 x28: ffff0000c4ea0c30 x27: 0000000000000000
x26: ffff80000f0ed9b8 x25: 0000000000000002 x24: 0000000000000001
x23: ffff0000c8bf38b0 x22: 0000000000000020 x21: 0000000000000001
x20: ffff80000f0ed9b8 x19: 0000000000000000 x18: 00000000000000c0
x17: ffff80000dd3a698 x16: ffff80000db78658 x15: ffff0000c42b0000
x14: 0000000000000028 x13: 00000000ffffffff x12: ffff0000c42b0000
x11: ff808000095d7628 x10: 0000000000000000 x9 : 0000000000000080
x8 : 00000000000000c0 x7 : ffff8000098f58f0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000002 x1 : ffff80000ce5df15 x0 : ffff8001f1d2f000
Call trace:
 arch_local_irq_restore arch/arm64/include/asm/irqflags.h:122 [inline]
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x58/0x8c kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:404 [inline]
 uart_write+0x204/0x458 drivers/tty/serial/serial_core.c:589
 handle_tx+0x10c/0x34c drivers/net/caif/caif_serial.c:236
 caif_xmit+0xa4/0xe0 drivers/net/caif/caif_serial.c:282
 __netdev_start_xmit include/linux/netdevice.h:4819 [inline]
 netdev_start_xmit include/linux/netdevice.h:4833 [inline]
 xmit_one net/core/dev.c:3590 [inline]
 dev_hard_start_xmit+0xd4/0x1ec net/core/dev.c:3606
 __dev_queue_xmit+0x78c/0xc88 net/core/dev.c:4256
 dev_queue_xmit include/linux/netdevice.h:3008 [inline]
 tx+0x74/0x118 drivers/block/aoe/aoenet.c:63
 kthread+0x90/0x154 kernel/kthread.c:357
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
