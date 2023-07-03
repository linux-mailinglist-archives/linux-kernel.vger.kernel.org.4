Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00567460C2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGCQe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:34:57 -0400
Received: from mail-pj1-f79.google.com (mail-pj1-f79.google.com [209.85.216.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283CA114
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 09:34:56 -0700 (PDT)
Received: by mail-pj1-f79.google.com with SMTP id 98e67ed59e1d1-262ecb0c44fso6488213a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 09:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688402095; x=1690994095;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bCK3k3dHPOjc8yq2s8JJt6oDGC8LXPlBtmKOVr/+Y6U=;
        b=EFhirHNYTbMy4teVMi2F2tQM1Q1dm9oshUmJTd6nuAkARoK7uPS6cxFQ5CT7iFtKqg
         VQXQQCHW82hkUyxG7V4uxehNCjh/qQ/mUomBK3OvGWKZoWYuNe9uiBvs/pHN6tpDs/6/
         aYSzlk7U8zgTjAQJpZqEXXalXRAKykk9YgrLT99LXEuvd2VaQP54uSdMX1C4QgY9QeOO
         onfYQYlbO0amHTCmMPNaZ8J9DLsuhR+pK+KbMDg8Jc3c2K/FucgzPeFOembp6Xq+F3Ec
         TYeWsKMgHwBRHOtIADVMf95Az5yWqlZUChr7tks/ZsZd1z6acsJMVwKlxK43YbcW29//
         XXog==
X-Gm-Message-State: ABy/qLaBpS5cxPbSr79tTf+CWZesDV3MC2w5wAw16ppZ/Xllvc99c8pI
        lpMauhMPQwjem6enBthF+5jB/MsNMeoTAvHfF5diXndTLjfn
X-Google-Smtp-Source: APBJJlFTVmYmDBvNnd+0poL5TSsPd+pJOiMcse2/bkvwp98Y3Ed3181vEhTF0k/X2TKtZpCHxtn+8Be67mVD4E19lO8Fgp8f0W3W
MIME-Version: 1.0
X-Received: by 2002:a17:90a:f2d2:b0:263:2da2:fe9f with SMTP id
 gt18-20020a17090af2d200b002632da2fe9fmr8080626pjb.0.1688402095714; Mon, 03
 Jul 2023 09:34:55 -0700 (PDT)
Date:   Mon, 03 Jul 2023 09:34:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000273d0105ff97bf56@google.com>
Subject: [syzbot] [mm?] WARNING in try_grab_page
From:   syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    3a8a670eeeaa Merge tag 'net-next-6.5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12c1d408a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ce7f4ca96cdf82c7
dashboard link: https://syzkaller.appspot.com/bug?extid=9b82859567f2e50c123e
compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-3a8a670e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a940531a9b86/vmlinux-3a8a670e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4f3cbae5be61/Image-3a8a670e.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/gup.c:252
Modules linked in:
CPU: 1 PID: 20384 Comm: syz-executor.1 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
Hardware name: linux,dummy-virt (DT)
pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : try_grab_page+0x108/0x160 mm/gup.c:229
lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
sp : ffff800089bbb5e0
x29: ffff800089bbb5e0 x28: 0000000000200000 x27: ffff000004d23800
x26: 0120000042835fc3 x25: 0000000000000000 x24: 0000000000080000
x23: ffff800089bbb738 x22: fffffc00000a0d40 x21: ffff00001e541008
x20: fcff00001e5a7b40 x19: 0000000000290000 x18: 0000000000000000
x17: 0000000000000000 x16: ffff800081ccc7c0 x15: 0000ffff8b6e9fff
x14: 0000000000000000 x13: 1edfe00003cc9f01 x12: ffff800089bbb628
x11: f6ff00001e64f800 x10: f6ff00001e64f80c x9 : f6ff00001e64f808
x8 : 0000000020001000 x7 : 0000000020000000 x6 : 0000000000000000
x5 : 0000000000042835 x4 : 0000000020001000 x3 : fffffc00000a0d40
x2 : fffffc00000a0d40 x1 : 0000000000290000 x0 : 00000000fffffff3
Call trace:
 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
 try_grab_page+0x108/0x160 mm/gup.c:252
 follow_pmd_mask mm/gup.c:734 [inline]
 follow_pud_mask mm/gup.c:765 [inline]
 follow_p4d_mask mm/gup.c:782 [inline]
 follow_page_mask+0x12c/0x2e4 mm/gup.c:839
 __get_user_pages+0x174/0x30c mm/gup.c:1217
 __get_user_pages_locked mm/gup.c:1448 [inline]
 __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
 internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
 pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
 iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
 iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
 extract_user_to_sg lib/scatterlist.c:1123 [inline]
 extract_iter_to_sg lib/scatterlist.c:1349 [inline]
 extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
 hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
 sock_sendmsg_nosec net/socket.c:725 [inline]
 sock_sendmsg+0x54/0x60 net/socket.c:748
 ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
 ___sys_sendmsg+0x80/0xdc net/socket.c:2548
 __sys_sendmsg+0x68/0xc4 net/socket.c:2577
 __do_sys_sendmsg net/socket.c:2586 [inline]
 __se_sys_sendmsg net/socket.c:2584 [inline]
 __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
 el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
 el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
 el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
 el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
---[ end trace 0000000000000000 ]---


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
