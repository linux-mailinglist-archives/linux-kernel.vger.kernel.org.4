Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D345FA206
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJJQco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJJQcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:32:42 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD7258B41
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:32:41 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id n14-20020a056e02100e00b002f9e283e850so9043752ilj.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uLK7T+2RhFoiZPqheR5mItBP4GaUAYYSQDjt1kuhSW8=;
        b=Mr0an/2143ZDbKZuHL5B75fDtw1GLWEJjwA3u1K6w0jZeW49tuco3vJ6nYtjXSvRNM
         qUti0PPk+IIjxVZzcqjFtojuqi1/b0AFp9CoVBVdfuB9ohm0buXpX3SBsljpQ9+LiULW
         O1PIy5N2JtGTpVk1By1TZb04wQYctygyObUifpRtXdoTKArVu8yIRsyjFDsDr1YrNwVy
         yc/2JL5VWHvNukt3mkSRl7bis33HZtr0il4H0MWgTpZn1wjMMBtORlEwcqJPA90okwoY
         Tn2aOt2o5ALgPGZmtbXpJBEWeCrTEJXwmT3Dp1E1x9OY4WFGv8QQmSjENjw47aiHx06U
         xerA==
X-Gm-Message-State: ACrzQf0gHF445TegdkwkPeVgPtNHlFqweh/O4qrToFpa/PbBkY6zxqbP
        CL8Rx4zkdcIN2Pi/i6fBDspKWwX1Trt1LVTG11WwUcI102dx
X-Google-Smtp-Source: AMsMyM6T+FHeFLqADvRIF8IBn7mKWaylUnOYFdfeBuasgnYz5JDvuRK65rOyTBX/+wcYolyZXo2eAOKqn/pE9cgDE1vuZlhVbUgI
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ea:b0:2fa:bf8:300a with SMTP id
 q10-20020a056e0220ea00b002fa0bf8300amr9386516ilv.309.1665419561228; Mon, 10
 Oct 2022 09:32:41 -0700 (PDT)
Date:   Mon, 10 Oct 2022 09:32:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005961c905eab0b5da@google.com>
Subject: [syzbot] WARNING in __udf_add_aext
From:   syzbot <syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com>
To:     jack@suse.com, linux-kernel@vger.kernel.org,
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16e609dc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=0eaad3590d65102b9391
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0eaad3590d65102b9391@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 6228 at fs/udf/inode.c:2017 __udf_add_aext+0x676/0x7d0 fs/udf/inode.c:2017
Modules linked in:
CPU: 0 PID: 6228 Comm: syz-executor.4 Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__udf_add_aext+0x676/0x7d0 fs/udf/inode.c:2017
Code: ef 0f 84 b3 fb ff ff e8 68 cc a7 fe 0f 0b e9 a7 fb ff ff e8 5c cc a7 fe 48 8b 44 24 20 48 05 b0 00 00 00 eb b7 e8 4a cc a7 fe <0f> 0b e9 27 fb ff ff e8 3e cc a7 fe 0f 0b e9 7d fb ff ff 41 bc fb
RSP: 0018:ffffc90012bff378 EFLAGS: 00010216
RAX: 000000000001e91e RBX: ffffc90012bff800 RCX: ffffc900060b1000
RDX: 0000000000040000 RSI: ffffffff82d4c7b6 RDI: 0000000000000006
RBP: ffff888090f987c0 R08: 0000000000000006 R09: 0000000000000000
R10: 00000000000001d0 R11: 0000000000000000 R12: 0000000000000000
R13: 00000000000001d0 R14: 0000000000000010 R15: 00000000000001e8
FS:  00007fec3be4a700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f85afad6000 CR3: 0000000016e68000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 udf_setup_indirect_aext+0x576/0x880 fs/udf/inode.c:1983
 udf_add_aext+0x208/0x2d0 fs/udf/inode.c:2070
 udf_insert_aext fs/udf/inode.c:2236 [inline]
 udf_update_extents fs/udf/inode.c:1190 [inline]
 inode_getblk+0x22db/0x4010 fs/udf/inode.c:894
 udf_get_block.part.0+0x1c7/0x4e0 fs/udf/inode.c:443
 udf_get_block+0x36/0x210 fs/udf/inode.c:425
 __block_write_begin_int+0x3b9/0x14b0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0xb5/0x4d0 fs/buffer.c:2102
 udf_write_begin+0x31/0xa0 fs/udf/inode.c:212
 generic_perform_write+0x252/0x570 mm/filemap.c:3753
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3881
 udf_file_write_iter+0x2cc/0x650 fs/udf/file.c:170
 call_write_iter include/linux/fs.h:2190 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:578
 ksys_write+0x127/0x250 fs/read_write.c:631
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fec3ac8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fec3be4a168 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fec3adabf80 RCX: 00007fec3ac8a5a9
RDX: 000000006db6e559 RSI: 0000000020000ec0 RDI: 0000000000000003
RBP: 00007fec3ace5580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fffc019edef R14: 00007fec3be4a300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
