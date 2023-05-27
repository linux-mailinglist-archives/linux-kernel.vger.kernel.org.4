Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E45713274
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 06:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjE0EIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 00:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjE0EH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 00:07:59 -0400
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1A6116
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 21:07:57 -0700 (PDT)
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-763997ab8cdso229860039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 21:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685160477; x=1687752477;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=og6UtUeC+pLxUZgl9VzEH4M2+sg4+aBhsCxUjilFULM=;
        b=iZVZjoXC112iJ6FMEC9iezuzl5xfTOpMCuIcaQcrXsCbT9ogP5ZT+EngCnc9KK78J0
         KVTSZRGHklwZoE96SP3WmFz/y41d8cJRRJOgE0q0hhfhknBM25JhHJCLHqRPJESS79xT
         QX/ZIKZazkWEhFgl2U1h5vHL1iPtlHf62GP2g1ttRu4KqV8PCJ4k6l0bcQYq6u9BsZxF
         vPgp7sqNVmwbhO3ufGDkJH6nw0kcTbQakHOwZ3XisFeMiOQUlFvD5sp4UX6uJ84Vl9hp
         SX24zQX/9i8NpVcQSr19fsKZxIgZu+65yTOsphLz9NPcbwNwT/kWeS8gOT0tlxmyy+PQ
         cFxg==
X-Gm-Message-State: AC+VfDxoqf+p7fqLtk28wes1GgLiFhunTK4Zys9Qo4DyfNT63NMMvjB3
        YaYjExMEpxP/muXphj069TQwQtUX3lngtXkm7+klPlL7w7eZ
X-Google-Smtp-Source: ACHHUZ47yXG7WzTJ/1yLZfKlxpXNfyJzPF1wa9gbxlHYwnOYSeuoXgJ9LJIrtAotA+fA97FK9z48oDwVa6QIRuxQZ6rMsGIG6htg
MIME-Version: 1.0
X-Received: by 2002:a02:9584:0:b0:41c:feac:7a9c with SMTP id
 b4-20020a029584000000b0041cfeac7a9cmr604892jai.6.1685160477152; Fri, 26 May
 2023 21:07:57 -0700 (PDT)
Date:   Fri, 26 May 2023 21:07:57 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a15f4b05fca4ffa0@google.com>
Subject: [syzbot] [fbdev?] general protection fault in soft_cursor
From:   syzbot <syzbot+d910bd780e6efac35869@syzkaller.appspotmail.com>
To:     daniel@ffwll.ch, deller@gmx.de, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    eb0f1697d729 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=10e08bde280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8860074b9a9d6c45
dashboard link: https://syzkaller.appspot.com/bug?extid=d910bd780e6efac35869
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103d17a9280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1151bb19280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/034232da7cff/disk-eb0f1697.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b11411bec33e/vmlinux-eb0f1697.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a53c52e170dd/Image-eb0f1697.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d910bd780e6efac35869@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in soft_cursor+0x384/0x6b4 drivers/video/fbdev/core/softcursor.c:70
Read of size 16 at addr 0000000000000200 by task kworker/u4:1/12

CPU: 0 PID: 12 Comm: kworker/u4:1 Not tainted 6.4.0-rc3-syzkaller-geb0f1697d729 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/28/2023
Workqueue: events_power_efficient fb_flashcursor
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_report+0xe4/0x514 mm/kasan/report.c:465
 kasan_report+0xd4/0x130 mm/kasan/report.c:572
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:187
 __asan_memcpy+0x3c/0x84 mm/kasan/shadow.c:105
 soft_cursor+0x384/0x6b4 drivers/video/fbdev/core/softcursor.c:70
 bit_cursor+0x113c/0x1a64 drivers/video/fbdev/core/bitblit.c:377
 fb_flashcursor+0x35c/0x54c drivers/video/fbdev/core/fbcon.c:380
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2405
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2552
 kthread+0x288/0x310 kernel/kthread.c:379
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:853
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
