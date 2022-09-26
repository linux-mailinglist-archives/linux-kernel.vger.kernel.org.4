Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CA65E9E6D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiIZJzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiIZJzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:55:40 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB881903E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:55:38 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id y187-20020a6bc8c4000000b006a4014e192fso3538622iof.21
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:55:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=kmcmmaivHbaIHJR042367FsPPBjxGQAP3lEauQGzqw0=;
        b=78hTnBeyF4xg2QcS72zATyLjg93HWlTsazBMJ+c1uw3gtnn/m+J/Faw7A6eexhDDN8
         ir6ImhiMQ3bXwhVC9fv8BLvuik27ecVzT0/kg49RmkLR7IWbi6XA/s91aB0qkyRFiRVm
         FRy9p+zPffBJqwCvoFwoyau1k6zlf+TZPEIdr8uk+LAj3LhIr64BKv87oD2eHtzG1efp
         N9Nx9Mim6heFoozntslDDndHzh8GFr7yBM0q/6dDw+ATYogeYJ/Gu0YB38yRYtD0qqeF
         GzqVznh+pd+i9L8w8g6NmKof3+1aR/Gy+/wtQmXDQ1xW6DDYAKXXUjXbMOCk+2M5/bnS
         A1Gg==
X-Gm-Message-State: ACrzQf2MVaaT1Aw/GKuru2AA+necD4AwauLiT/JyAdKv/HhfjPR1HIhB
        WWLhCuiIr9gLmtpX5NMFuVgw/XMjJ2eYz/EUO4bN3ioCJLaw
X-Google-Smtp-Source: AMsMyM4AJPhEIgkVAlWkhFNIMTYULZyOuAi1bWBWKXmi9JwKRwcp2NvqSkWWfow2KLFc09/D/1NUdQqYVn/oY3dGqC0356It7tMA
MIME-Version: 1.0
X-Received: by 2002:a05:6602:48e:b0:6a4:1d07:bb18 with SMTP id
 y14-20020a056602048e00b006a41d07bb18mr7178789iov.115.1664186137717; Mon, 26
 Sep 2022 02:55:37 -0700 (PDT)
Date:   Mon, 26 Sep 2022 02:55:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000094338805e9918792@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in dbNextAG
From:   syzbot <syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com>
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

HEAD commit:    105a36f3694e Merge tag 'kbuild-fixes-v6.0-3' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=105311df080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c221af36f6d1d811
dashboard link: https://syzkaller.appspot.com/bug?extid=38e876a8aa44b7115c76
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100105c4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a5fcdf080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/858ea4fd6806/disk-105a36f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/76c66678f029/vmlinux-105a36f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38e876a8aa44b7115c76@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:617:20
index 1128417612 is out of range for type 'atomic_t [128]'
CPU: 0 PID: 3606 Comm: syz-executor376 Not tainted 6.0.0-rc6-syzkaller-00321-g105a36f3694e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dbNextAG+0x602/0x630 fs/jfs/jfs_dmap.c:617
 diAlloc+0x17a/0x1700 fs/jfs/jfs_imap.c:1342
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x141/0xb00 fs/jfs/namei.c:225
 vfs_mkdir+0x3b3/0x590 fs/namei.c:4013
 do_mkdirat+0x279/0x550 fs/namei.c:4038
 __do_sys_mkdir fs/namei.c:4058 [inline]
 __se_sys_mkdir fs/namei.c:4056 [inline]
 __x64_sys_mkdir+0x6a/0x80 fs/namei.c:4056
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fca2c28c2c7
Code: ff ff ff ff c3 66 0f 1f 44 00 00 48 c7 c0 c0 ff ff ff 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff8fb1d868 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00007fff8fb1d910 RCX: 00007fca2c28c2c7
RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00000000200001c0
RBP: 00000000ffffffff R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000ffffffff R14: 00000000200001c0 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
