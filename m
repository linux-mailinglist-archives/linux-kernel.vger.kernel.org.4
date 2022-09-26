Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C435EADFA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiIZRTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIZRSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:18:41 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8133DD70D6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:44 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id w2-20020a056e021c8200b002f5c95226e0so5525435ill.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=SnmW4R5j0gd8mDlttiP+7GRmDtgLcgBlixwqFWgdFuo=;
        b=EoQoVpiBj3qpewXU44dgE0SLYcFLsEvekbfkKgeBO2R/jg1KWzvLtgAiHb8UkqZtCy
         Z7Q1Ls2At+8HRhgg/KNP//y2t/QC5vjw6j+ptumWv9FOEaHxQydfZcMekn96SDLz2iun
         wx3U5aerl2t9Gz+CpYiw5nDNfo1h+gxvZdRO2cUrJZdWhAW6HNs5bp+TRFUxxcKbE/T9
         WEFWFaiCOqQGxLZ3Q1HrAL/0I0lufcGLPXBj+xEpN5ZDMbeJhqurMn3tYz7YqvydmkPk
         ZRDjoMzkduFSZ0g4UMpv+e27CIropSJixCBT+/aWkIqRifUJdtDCDEq50Z5kUFM2aVKv
         4LNg==
X-Gm-Message-State: ACrzQf1WfaPR861VkOJaHiWP5sKk4YeNxmXtPqKe5gFFIPJZSkYuWqia
        hO0gcKfeiO2wI0KH87IfXacbdHEgLYk+F4Ov5eQtVe9e+DWJ
X-Google-Smtp-Source: AMsMyM45BCWgmJLwCUgUzoIpmCD0GXT5eGPMW5Fuv+zn6H5Q7NNHFu6+D0SC0Y212eubAPAGx6KFr1s0n2JkIN3Y6v5ZHebxORlo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1612:b0:35a:3f48:f3a3 with SMTP id
 x18-20020a056638161200b0035a3f48f3a3mr11803361jas.43.1664209956261; Mon, 26
 Sep 2022 09:32:36 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:32:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000046566805e997132d@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in xtInsert
From:   syzbot <syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com>
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
console+strace: https://syzkaller.appspot.com/x/log.txt?x=13a64288880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b68d4454cd7c7d91
dashboard link: https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111be26c880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12c1deff080000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bef111412fd8/disk-105a36f3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4db9dc916db0/vmlinux-105a36f3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+55a7541cfd25df68109e@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 264192
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:622:9
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 3614 Comm: syz-executor388 Not tainted 6.0.0-rc6-syzkaller-00321-g105a36f3694e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e3/0x2cb lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0x107/0x150 lib/ubsan.c:283
 xtInsert+0xfbe/0x1020 fs/jfs/jfs_xtree.c:622
 extAlloc+0xaa4/0x1030 fs/jfs/jfs_extent.c:145
 jfs_get_block+0x410/0xe30 fs/jfs/inode.c:248
 __block_write_begin_int+0x6f6/0x1d70 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x314/0x610 mm/filemap.c:3738
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
 do_iter_write+0x6f0/0xc50 fs/read_write.c:855
 vfs_writev fs/read_write.c:928 [inline]
 do_writev+0x27a/0x470 fs/read_write.c:971
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0e179f7fb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffed4fe4448 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f0e179f7fb9
RDX: 0000000000000001 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f0e179b7780 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00080000000000f4 R15: 0000000000000000
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
