Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D9734B43
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 07:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjFSFQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 01:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFSFQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 01:16:56 -0400
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCEBF1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:16:54 -0700 (PDT)
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-77de452f2a1so252030039f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 22:16:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687151814; x=1689743814;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMyLT01zqKPRiI1X/lV/7KH/QqoRQe0rS+m01dwVN7s=;
        b=DJV8dWaT9aWYefNnoFqWkjwy7hZh8GRPD5X7CviExSo1Kygzv0fdf15ds+miD3u7m1
         Yn5cn4SeXSKjF3OGl4nJYbbiMMI+KypzUX1YzJXFCvdcKLcU9AYjVLKsWZfciALHVbcM
         mwCu0s4C8DcQeSVkSf29cLzkKjV1dTCIM3TUjJvKZ9GCmyUoLzJFtl9ouyJgKoOmyZCe
         cp21TPmoieHfJVdpc9PoCC6bjaWbJjkesvGkxzuNlDZQ1LdV9ftXycHZ2CFE/l3IDGQm
         v/u/43segfbaRm3mgKx1YxvuTx1zj1OXGfco4GnMcxRa6QWx2MuAZyXHevBgfxJWhyhg
         5vQg==
X-Gm-Message-State: AC+VfDwJ97V539dAa9iUaHw34o5XECqcNVWO6CADDMShyyxDJHetASfT
        S3BNtlNJMLcX6LNSnn8c/Nzpaahh45La7I7cCJ77U6OxTQf3
X-Google-Smtp-Source: ACHHUZ5GYVs1CA2p6OFbtt3L3wCxopwlljQqI6CF8Vddx1qLPvu7A3FlhTsm90vdaOO9CPLWCfvWPmPJTIenMbVujgCBZSFsj14m
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2051:b0:77d:c2c3:4e39 with SMTP id
 z17-20020a056602205100b0077dc2c34e39mr2444681iod.1.1687151814083; Sun, 18 Jun
 2023 22:16:54 -0700 (PDT)
Date:   Sun, 18 Jun 2023 22:16:54 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008f885d05fe74a486@google.com>
Subject: [syzbot] [net?] KASAN: null-ptr-deref Read in nsim_dev_trap_report_work
From:   syzbot <syzbot+f9b37508c6a44a2b72b6@syzkaller.appspotmail.com>
To:     bpf@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a2cb45ca0cc net: mlxsw: i2c: Switch back to use struct i2..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=158b6207280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=f9b37508c6a44a2b72b6
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/5fa469ebaab3/disk-3a2cb45c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e92fd67e9282/vmlinux-3a2cb45c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5201fed94bfc/bzImage-3a2cb45c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9b37508c6a44a2b72b6@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
BUG: KASAN: null-ptr-deref in netif_running include/linux/netdevice.h:3619 [inline]
BUG: KASAN: null-ptr-deref in nsim_dev_trap_report_work+0x117/0xc80 drivers/net/netdevsim/dev.c:850
Read of size 8 at addr 0000000000000038 by task kworker/1:2/29478

CPU: 1 PID: 29478 Comm: kworker/1:2 Not tainted 6.4.0-rc5-syzkaller-01182-g3a2cb45ca0cc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
Workqueue: events nsim_dev_trap_report_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 print_report mm/kasan/report.c:465 [inline]
 kasan_report+0xec/0x130 mm/kasan/report.c:572
 check_region_inline mm/kasan/generic.c:181 [inline]
 kasan_check_range+0x141/0x190 mm/kasan/generic.c:187
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 netif_running include/linux/netdevice.h:3619 [inline]
 nsim_dev_trap_report_work+0x117/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x99a/0x15e0 kernel/workqueue.c:2405
 worker_thread+0x67d/0x10c0 kernel/workqueue.c:2552
 kthread+0x344/0x440 kernel/kthread.c:379
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>
==================================================================


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
