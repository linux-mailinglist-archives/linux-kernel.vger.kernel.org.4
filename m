Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9204A5EFECA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiI2Ulx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiI2Uls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:41:48 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EE1356ED
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:41:46 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id f11-20020a5d858b000000b006a17b75af65so1458357ioj.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=jEEoHwmh0z4dknk+NtlY2fx8RmUtjpmPjMMYb+1QyX4=;
        b=HHJXCGv/aBaQIBU5iuudFDVV3/jpTkdfmaH/RpEcwnhErLojckc2ammZvDSD2RCaol
         o3/Orvs4RMeS6QtwoDpFrQxXTtgqpFx9bTdWAcXceWFPh+/b/8lJtl4YdtsM8nHu80zJ
         KpQgN/DeWdv8E9lGaStjZxkcwcHgjKx5jregKlbpjFRtPF4v5EPXDAWMw41TIrKYU2cI
         4u7IDt1lVnLHsv+lixQJCRy9xlts1eHgxFLbxOpni6mCg50vO7Z4E5Y5FMwFcnJhnoNk
         mTHN42RW+hblp0HKGlgoBFULBFFQBRcLVlINZlRI7mAtWZfuPsbn0j6H87C6Xop9YwNx
         kDmg==
X-Gm-Message-State: ACrzQf1uoYuLtUmeEmaQdglBjAmlRftrvqfj13xkAJz1LpiT7JCSnKVa
        r04T2IaQtsNwi1tHCEEboLU+Ugy+ZZY6cmwlWgwJc9+z6GIL
X-Google-Smtp-Source: AMsMyM57Rx/9HOQeLnx36sU+MC2Dnlzw3YvcdQwUDDUpsd9XPIosdDxkQI3+Fd9rvxr330yek5itl9ut6GrodISexq74bBG9Og+g
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c89:b0:67b:7e8c:11c1 with SMTP id
 i9-20020a0566022c8900b0067b7e8c11c1mr2519326iow.101.1664484106273; Thu, 29
 Sep 2022 13:41:46 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:41:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e38e4105e9d6e741@google.com>
Subject: [syzbot] WARNING in ea_get
From:   syzbot <syzbot+5dd35da975e32d9df9ab@syzkaller.appspotmail.com>
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

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14407848880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd35da975e32d9df9ab
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1173d7ff080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2ea70880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/418654aab051/disk-49c13ed0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c501fc7ae3/vmlinux-49c13ed0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5dd35da975e32d9df9ab@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3608 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Modules linked in:
CPU: 1 PID: 3608 Comm: syz-executor264 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 73 17 29 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
RSP: 0018:ffffc900038cf000 EFLAGS: 00010246
RAX: ffffc900038cf060 RBX: 0000000000000013 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc900038cf088
RBP: ffffc900038cf110 R08: dffffc0000000000 R09: ffffc900038cf060
R10: fffff52000719e11 R11: 1ffff92000719e0c R12: 0000000000040cc0
R13: 1ffff92000719e08 R14: dffffc0000000000 R15: 1ffff92000719e04
FS:  0000555556726300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055bf5095f740 CR3: 0000000070cdb000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 kmalloc_order+0x41/0x140 mm/slab_common.c:933
 kmalloc_order_trace+0x15/0x70 mm/slab_common.c:949
 kmalloc_large include/linux/slab.h:529 [inline]
 __kmalloc+0x26e/0x370 mm/slub.c:4418
 kmalloc include/linux/slab.h:605 [inline]
 ea_get+0x408/0x1290 fs/jfs/xattr.c:487
 __jfs_getxattr+0xc4/0x400 fs/jfs/xattr.c:807
 vfs_getxattr_alloc+0x47f/0x5d0 fs/xattr.c:384
 ima_read_xattr+0x35/0x60 security/integrity/ima/ima_appraise.c:228
 process_measurement+0xd5d/0x1bd0 security/integrity/ima/ima_main.c:319
 ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3559 [inline]
 path_openat+0x2642/0x2df0 fs/namei.c:3691
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1340
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f40146ebf59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcbf7a6878 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f40146ebf59
RDX: 0000000000161842 RSI: 000000002000c380 RDI: 00000000ffffff9c
RBP: 00007f40146ab720 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 0000000a00030083 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
