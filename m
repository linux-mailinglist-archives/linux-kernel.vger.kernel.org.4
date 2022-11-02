Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D2615B9D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiKBE5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBE5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:57:42 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018312408D
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 21:57:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id i6-20020a5d88c6000000b006d088a0e518so6580402iol.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 21:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIrJULyCcKOvinRg1r2QBsSeL9J+zEjVDIrjrZIw4GE=;
        b=usEbcyI0f5D6s/x1Js41f7fXp/4cstu+IwPKCQ96Ulxsi3NbhwNkhlkw+D9GY/frEI
         /8v1Qn1oqQiamO9wbYypcWOv1vKifBBeFqp7AeJjVXzuA9YS0bY2+v2q2/7Ve3A92SYX
         pwqmX4T0aurx+sL04SuLbyqmpr5aGxH2nG9o3KPnY4332yhEc+q7pezwIrQHLfRBctSH
         SPaoRvdM77GSizVI7rxu6UP5TXWQE+7nDThfJ3EPFljFme0epuJciLU5UOm7vUS/y+2G
         826Lpg7CJ8ZojxliyzpPu9GcS1ZU3hZix7G5YQ4XxjZaqalF7d/+bYzpSpboZQvHCRsw
         KwNA==
X-Gm-Message-State: ACrzQf3nAcSa7ymZI0KrBVmF04xTs6bYzZM+5xyzdBgDqmlCUFc7x2x+
        74QpviGNS7QSjY0u856oKeQm9OxRBayGuiHDh8TQfFJI5JAS
X-Google-Smtp-Source: AMsMyM6yTLH+FE1WBpO9/p4+7usG3/ua93YsWpm74Ea5iqnRQE0SxC2pSmEBI1KLlaUZH6LWBAoAHnhoxRgrXlkguk6Nn5PwMIGf
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3ca:b0:6a4:16a0:9862 with SMTP id
 g10-20020a05660203ca00b006a416a09862mr15279453iov.217.1667365061392; Tue, 01
 Nov 2022 21:57:41 -0700 (PDT)
Date:   Tue, 01 Nov 2022 21:57:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032020805ec75ae69@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in dbFindLeaf
From:   syzbot <syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=156d7cee880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a66c6c673fb555e8
dashboard link: https://syzkaller.appspot.com/bug?extid=aea1ad91e854d0a83e04
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ba5b49fa77de/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c061f2ae4dc/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bc45c1300e9b/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aea1ad91e854d0a83e04@syzkaller.appspotmail.com

loop5: detected capacity change from 0 to 96859
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2926:29
index 1365 is out of range for type 's8 [1365]'
CPU: 1 PID: 14172 Comm: syz-executor.5 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 dbFindLeaf+0x21d/0x260 fs/jfs/jfs_dmap.c:2926
 dbAllocDmapLev+0xa3/0x2c0 fs/jfs/jfs_dmap.c:1937
 dbAllocCtl+0x131/0x780 fs/jfs/jfs_dmap.c:1793
 dbAllocAG+0x8da/0xd20 fs/jfs/jfs_dmap.c:1334
 dbAlloc+0x40d/0xa70 fs/jfs/jfs_dmap.c:858
 dtSplitUp+0x365/0x5130 fs/jfs/jfs_dtree.c:974
 dtInsert+0x82b/0xa10 fs/jfs/jfs_dtree.c:863
 jfs_rename+0x1059/0x1a20 fs/jfs/namei.c:1219
 vfs_rename+0x115e/0x1a90 fs/namei.c:4778
 do_renameat2+0xb5e/0xc80 fs/namei.c:4929
 __do_sys_rename fs/namei.c:4975 [inline]
 __se_sys_rename fs/namei.c:4973 [inline]
 __x64_sys_rename+0x7d/0xa0 fs/namei.c:4973
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f734da8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f734e81d168 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
RAX: ffffffffffffffda RBX: 00007f734dbabf80 RCX: 00007f734da8b5a9
RDX: 0000000000000000 RSI: 0000000020005240 RDI: 00000000200001c0
RBP: 00007f734dae67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffdd3afd17f R14: 00007f734e81d300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
