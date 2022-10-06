Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123E85F61AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 09:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiJFHc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiJFHcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 03:32:45 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F6B8E45A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 00:32:44 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id s2-20020a056e02216200b002f9de38e484so970768ilv.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 00:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ue70F11wAGPUl1Dsp6FlKr49CaW5BYtIv0em9n50HI=;
        b=19dXLPDPV+bB3WFiABxYeH51A0AecIvyCgL/pbxyOCy6JqZtUQgVB4isH90kc6Bnd2
         v/UoT5qANej1dtTAsPplt/UBo97M2vo/5srBX09TNTZ3a92Wz9M7kK9AlbI8wiS+0KHF
         TF0yW1yjeo3obNeCXTm0qzDbVauvG79knuBV5Qkr7tqbvphm5E+RPQPrSE5OWgkEYDeY
         tp2CpmFTQ2bMMaIpo5jLBemTzbVBqPC28S/f33AaiapmLoGwBiNym1EEp+ssi9vPdrgv
         BCnjM/Uv5LLsiStHL/QwYaRbe9GnwIDvNSqyan2DH6WKtgwsa5usBKWmKmanYFoaPeGJ
         almw==
X-Gm-Message-State: ACrzQf1y7hP1S1BBuSHCPNfxJg09auhnf9Xev4YJLmwfjWjYvN9CrzQm
        uYJKipI0mxYLCeBN/W7aJUczdCPIjBajkf89Of3Sujrfr6Nj
X-Google-Smtp-Source: AMsMyM5x/t6VWyCAcq5BHiPpXXv09wTCS5oXunFhdjn5XpR5ci5qliHc1iq37hGuq3dGpaLpgcLAaqDqbtci8L4fPOoU9/Xh+HAc
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b84:b0:2f9:2adf:c6b9 with SMTP id
 h4-20020a056e021b8400b002f92adfc6b9mr1773515ili.33.1665041563989; Thu, 06 Oct
 2022 00:32:43 -0700 (PDT)
Date:   Thu, 06 Oct 2022 00:32:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f53bd605ea58b20d@google.com>
Subject: [syzbot] WARNING in udf_free_inode
From:   syzbot <syzbot+38695a20b8addcbc1084@syzkaller.appspotmail.com>
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

HEAD commit:    2bca25eaeba6 Merge tag 'spi-v6.1' of git://git.kernel.org/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11ba75f4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9df203be43a870b5
dashboard link: https://syzkaller.appspot.com/bug?extid=38695a20b8addcbc1084
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14797f98880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16c19d82880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9885e6765755/disk-2bca25ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6e78c91286aa/vmlinux-2bca25ea.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/2cf327de2a73/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+38695a20b8addcbc1084@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 2048
UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2022/09/12 12:00 (1000)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3615 at fs/udf/udfdecl.h:116 udf_free_inode+0x22b/0x2d0 fs/udf/ialloc.c:41
Modules linked in:
CPU: 0 PID: 3615 Comm: syz-executor180 Not tainted 6.0.0-syzkaller-03015-g2bca25eaeba6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:udf_updated_lvid fs/udf/udfdecl.h:114 [inline]
RIP: 0010:udf_free_inode+0x22b/0x2d0 fs/udf/ialloc.c:41
Code: ff ff 4c 89 f7 31 f6 4c 89 ea 31 c9 41 b8 01 00 00 00 48 83 c4 20 5b 41 5c 41 5d 41 5e 41 5f 5d e9 ca 58 ff ff e8 a5 23 92 fe <0f> 0b eb 80 44 89 e9 80 e1 07 fe c1 38 c1 0f 8c 65 fe ff ff 4c 89
RSP: 0018:ffffc90003c4faf8 EFLAGS: 00010293
RAX: ffffffff82f4a92b RBX: 0000000000000001 RCX: ffff8880270b3b00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88807366c01f R08: ffffffff82f4a8a1 R09: fffffbfff1c188fe
R10: fffffbfff1c188fe R11: 1ffffffff1c188fd R12: 1ffff1100e2cc8cf
R13: ffff888073d80158 R14: ffff888071664000 R15: ffff888071664678
FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b0cb914a08 CR3: 000000007f262000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 evict+0x2a4/0x620 fs/inode.c:665
 udf_free_partition fs/udf/super.c:279 [inline]
 udf_sb_free_partitions+0x134/0x570 fs/udf/super.c:306
 udf_put_super+0x10f/0x160 fs/udf/super.c:2361
 generic_shutdown_super+0x130/0x310 fs/super.c:491
 kill_block_super+0x79/0xd0 fs/super.c:1427
 deactivate_locked_super+0xa7/0xf0 fs/super.c:331
 cleanup_mnt+0x4ce/0x560 fs/namespace.c:1186
 task_work_run+0x146/0x1c0 kernel/task_work.c:177
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0x55e/0x20a0 kernel/exit.c:795
 do_group_exit+0x23b/0x2f0 kernel/exit.c:925
 __do_sys_exit_group kernel/exit.c:936 [inline]
 __se_sys_exit_group kernel/exit.c:934 [inline]
 __x64_sys_exit_group+0x3b/0x40 kernel/exit.c:934
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f56eec1ac49
Code: Unable to access opcode bytes at 0x7f56eec1ac1f.
RSP: 002b:00007ffe2d884048 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f56eec913f0 RCX: 00007f56eec1ac49
RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000001
RBP: 0000000000000001 R08: ffffffffffffffc0 R09: 00007f56eec8be40
R10: 00007f56eec8be40 R11: 0000000000000246 R12: 00007f56eec913f0
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000001
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
