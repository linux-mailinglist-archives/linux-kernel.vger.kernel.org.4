Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26F2D5FDAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiJMNbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJMNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:31:45 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EAC357FD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:31:44 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id f15-20020a056e020b4f00b002fa34db70f0so1474635ilu.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=05yTZzt7l+nsO6UN+9J4a/o+4SSnUtyqkvsF9nkb/gc=;
        b=h5aNivien4fbSMyjHMMyfiERuYp/LY7/838Psg51M3Sg+28ZFhVxTihaJDvcUtBjLj
         IcuIvMCCtp0zPjfaF74QNqiSR0ne+gsvZ+yo/4Y4vYKd4TXvG+61eB7FXV2PtFS3lg14
         wyGrRcI5iveXO9xoUeEeEi98JhcCNGynZtDH4yidzJSN4IRiBWgPx+AC78y5z+UdpbEE
         tbQ8LJyo+Kgjc6igyYrV8awUXiJvVoz3rz+M96LDCNNat5hxyTXWUmpJ7Ta6/HMGD0xj
         Pn/47IzJAnLxhFUWqHkn0kG8HzdiKi5vA7N1SZ+lTpEzUXph/aJITYXr3Qb3Ajcc9PXX
         u9XA==
X-Gm-Message-State: ACrzQf04NQHyplHoxpZ8iWJUbdWQo5ljdX2Sk9k3lvmr5tcI6dcOAiSN
        j9sAPmx5KcKrChcdsE+iSV/o7AJIwmf0JeoVyj5xNXIBkXIf
X-Google-Smtp-Source: AMsMyM4XaxRNNsRmTQWxF5QyVM6yJo9toIB6Bnk2r9GPyjBXzPWvYtqZ8qQakW1+jHGmNeGJe9Fe3rzblpg8L6ubn/I5Jizpgrnh
MIME-Version: 1.0
X-Received: by 2002:a92:c0c9:0:b0:2f9:ae60:164c with SMTP id
 t9-20020a92c0c9000000b002f9ae60164cmr19046ilf.28.1665667903520; Thu, 13 Oct
 2022 06:31:43 -0700 (PDT)
Date:   Thu, 13 Oct 2022 06:31:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b409e205eaea8714@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in gfs2_getbuf
From:   syzbot <syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com>
To:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, rpeterso@redhat.com,
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

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14620252880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=87a187973530ac822e3c
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+87a187973530ac822e3c@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/gfs2/meta_io.c:128:16
shift exponent 4294967293 is too large for 64-bit type 'u64' (aka 'unsigned long long')
CPU: 0 PID: 10195 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 gfs2_getbuf+0x759/0x7d0 fs/gfs2/meta_io.c:128
 gfs2_meta_read+0x153/0x910 fs/gfs2/meta_io.c:265
 gfs2_meta_buffer+0x153/0x3a0 fs/gfs2/meta_io.c:491
 gfs2_meta_inode_buffer fs/gfs2/meta_io.h:72 [inline]
 gfs2_inode_refresh+0xab/0xe90 fs/gfs2/glops.c:472
 gfs2_instantiate+0x15e/0x220 fs/gfs2/glock.c:515
 gfs2_glock_holder_ready fs/gfs2/glock.c:1303 [inline]
 gfs2_glock_wait+0x1d9/0x2a0 fs/gfs2/glock.c:1323
 gfs2_glock_nq_init fs/gfs2/glock.h:263 [inline]
 gfs2_lookupi+0x40c/0x650 fs/gfs2/inode.c:306
 gfs2_lookup_simple+0xec/0x170 fs/gfs2/inode.c:258
 init_journal+0x19b/0x22c0 fs/gfs2/ops_fstype.c:739
 init_inodes+0xdc/0x340 fs/gfs2/ops_fstype.c:882
 gfs2_fill_super+0x1ad8/0x2610 fs/gfs2/ops_fstype.c:1240
 get_tree_bdev+0x400/0x620 fs/super.c:1323
 gfs2_get_tree+0x50/0x210 fs/gfs2/ops_fstype.c:1323
 vfs_get_tree+0x88/0x270 fs/super.c:1530
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0eed68cada
Code: 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff eb d2 e8 b8 04 00 00 0f 1f 84 00 00 00 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0eee73cf88 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 0000000020000200 RCX: 00007f0eed68cada
RDX: 0000000020000000 RSI: 0000000020000100 RDI: 00007f0eee73cfe0
RBP: 00007f0eee73d020 R08: 00007f0eee73d020 R09: 0000000020000000
R10: 0000000000000008 R11: 0000000000000202 R12: 0000000020000000
R13: 0000000020000100 R14: 00007f0eee73cfe0 R15: 0000000020000080
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
