Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5726F5F00
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjECTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjECTPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:15:11 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEAE7AAF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:15:10 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-76978e7cd59so259741339f.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 12:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683141309; x=1685733309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hoixSgrRQjNG22JONFbya6qV97s6dKsxLycBj9co2c0=;
        b=CsPtWL+OFfG6Ij7ojYrHp2KWUGtYs2B1x3IXDWalqHPtWnveavGwsoBLpKQLSbRwS9
         OL9mKkm8G/euBDW42CN0JjtAsRg7WMVCJ4PLWLmYnh10+nxuv5fOCrWWjl359UdXy2E7
         /38tW6OjwS+gnFb4jZn/ftYgQYOtjKozn22rtJvOseIvXyU65Ucajkvd4UolurhFLyWG
         2EhqaU7alZh9qD2iADatqPAdy7+awNFLTb862AkIUhCOJWP4zsys5DarQelpajg2qtTr
         chsOSUvG6mi0OJKmM5uO0qJZQf5V7fYUwsoAp73S0pQS3FNPxrOI2rYgIwKPC9LXf2+Q
         AMHA==
X-Gm-Message-State: AC+VfDzgSohwFRkph7wpa28aeFYWAz63Nl/wOmXBCerY5A9k3A4zbKPJ
        QtbvzwgbrfzELcjzx4uEQpQrRbRyNIIrpp6eEUZwc5KecxbNICY=
X-Google-Smtp-Source: ACHHUZ7W0N0LqYyZ3J2ScXyAVyBHY0dHDp8G+fgwcsvPi5Gs2rBY/w+sqQZyhNSvinf2RHWHfhjhE/EYfxbqQLT9LUgHQKF1HTbG
MIME-Version: 1.0
X-Received: by 2002:a6b:dc05:0:b0:760:e9b6:e6de with SMTP id
 s5-20020a6bdc05000000b00760e9b6e6demr10548055ioc.0.1683141309499; Wed, 03 May
 2023 12:15:09 -0700 (PDT)
Date:   Wed, 03 May 2023 12:15:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dc2d3005facedfb7@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in __irq_resolve_mapping
From:   syzbot <syzbot+ed37e5e7af93ae8a08ba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, maz@kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
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

HEAD commit:    348551ddaf31 Merge tag 'pinctrl-v6.4-1' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14398ef8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=124f13edd5df0b0d
dashboard link: https://syzkaller.appspot.com/bug?extid=ed37e5e7af93ae8a08ba
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed37e5e7af93ae8a08ba@syzkaller.appspotmail.com

8<--- cut here ---
Unable to handle kernel NULL pointer dereference at virtual address 00000213 when read
[00000213] *pgd=80000080004003, *pmd=00000000
Internal error: Oops: 207 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.3.0-syzkaller #0
Hardware name: ARM-Versatile Express
PC is at irq_data_to_desc include/linux/irqdesc.h:124 [inline]
PC is at __irq_resolve_mapping+0x40/0x90 kernel/irq/irqdomain.c:968
LR is at rcu_read_lock include/linux/rcupdate.h:771 [inline]
LR is at __irq_resolve_mapping+0x20/0x90 kernel/irq/irqdomain.c:960
pc : [<802c0dec>]    lr : [<802c0dcc>]    psr: 20000193
sp : 82601e58  ip : 82601e58  fp : 82601e74
r10: 00000000  r9 : 8261ae40  r8 : 00000000
r7 : df80a00c  r6 : 00000000  r5 : 0000001b  r4 : 83094000
r3 : 83094060  r2 : 8261ae40  r1 : 0000001b  r0 : 00000207
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 30c5387d  Table: 848c1880  DAC: fffffffd
Register r0 information: non-paged memory
Register r1 information: non-paged memory
Register r2 information: non-slab/vmalloc memory
Register r3 information:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 0 at mm/slub.c:4649 __kmem_obj_info+0x1c4/0x21c mm/slub.c:4649
Modules linked in:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
