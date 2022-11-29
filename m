Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5363BBE5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbiK2Inn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiK2Inj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:43:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BD3209B6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:43:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i26-20020a056e021d1a00b003025434c04eso11394595ila.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zg5az6xrnSvzem2gwMfor+gDgHn0N57V8GOUL7tP8Vs=;
        b=WuaY8L34XtG4wQK5qyVKgRZItJN2j8uf0SiuQgAM12GZ5cmMEktj7NIIL96i5KbLof
         UWLvGdpuCqS/uXiin88IM6sBeWFbLZluwCQALx6bT23J7y3OiXW3HIO3SjIhRM06sk+2
         gQuzmnRfeMAW6zOp/zmVnVApZeAj+RBHWAOhJ4bpZM5hyFpk4HMrCg3FuQgxs2Ollh22
         u9EXov5VCR7NFRXRo61m7k/GNsasBzvRfJWXijT8gxUwVRNhGXFuzkvskYTvq2oNV0cc
         sTxGiCkticuO80zUytYEiJIMZBgjKk3TrXAE/uBUP09+uXpbxsi4VDHIYODm/6vJHpDn
         /XEw==
X-Gm-Message-State: ANoB5plK51OJyRzHtf1ZBOA5pNc9y1j9hrgAlMaQ7sgRaeTzlcrFPYIj
        /4519/8loEdXTPs4sMiTrEM9vVifviF1ZNUC/XFnoN4jY7Iw
X-Google-Smtp-Source: AA0mqf42d/jX0JIdrKgatOfuS0V1VVLRZ/xgvKBJO2A+0Zyg1bC4Sd5T3GZtgMUGAeIPdwxzOhTcwyeGsoyPqqDqiCEfCt8LS4Yz
MIME-Version: 1.0
X-Received: by 2002:a02:5146:0:b0:371:1431:d4f2 with SMTP id
 s67-20020a025146000000b003711431d4f2mr26840101jaa.184.1669711417600; Tue, 29
 Nov 2022 00:43:37 -0800 (PST)
Date:   Tue, 29 Nov 2022 00:43:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec75b005ee97fbaa@google.com>
Subject: [syzbot] WARNING in rmqueue
From:   syzbot <syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com>
To:     chao@kernel.org, huyue2@coolpad.com, jefflexu@linux.alibaba.com,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b7b275e60bcd Linux 6.1-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a70187880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2325e409a9a893e1
dashboard link: https://syzkaller.appspot.com/bug?extid=aafb3f37cfeb6534c4ac
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dde8a1880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15685e8d880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/525233126d34/disk-b7b275e6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e8299bf41400/vmlinux-b7b275e6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eebf691dbf6f/bzImage-b7b275e6.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d643567f551d/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+aafb3f37cfeb6534c4ac@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 __count_numa_events include/linux/vmstat.h:249 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 zone_statistics mm/page_alloc.c:3692 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue_buddy mm/page_alloc.c:3728 [inline]
WARNING: CPU: 0 PID: 48 at mm/page_alloc.c:3837 rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3853
Modules linked in:
CPU: 0 PID: 48 Comm: kworker/u5:0 Not tainted 6.1.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Workqueue: erofs_unzipd z_erofs_decompressqueue_work
RIP: 0010:rmqueue+0x1d6b/0x1ed0 mm/page_alloc.c:3837
Code: 48 8b 02 65 48 ff 40 20 49 83 f6 05 42 80 3c 2b 00 74 08 4c 89 e7 e8 a4 44 0b 00 49 8b 04 24 65 4a ff 44 f0 10 e9 2a fe ff ff <0f> 0b e9 29 e3 ff ff 48 89 df be 08 00 00 00 e8 31 46 0b 00 f0 41
RSP: 0018:ffffc90000b97260 EFLAGS: 00010202
RAX: f301f204f1f1f1f1 RBX: ffff88813fffae00 RCX: 000000000000adc2
RDX: 1ffff92000172e70 RSI: 1ffff92000172e70 RDI: ffff88813fffae00
RBP: ffffc90000b97420 R08: 0000000000000901 R09: 0000000000000009
R10: ffffed1027fff5b3 R11: 1ffff11027fff5b2 R12: ffff88813fffc310
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88813fffa700
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7bec722f10 CR3: 000000004a430000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_page_from_freelist+0x4b6/0x7c0 mm/page_alloc.c:4288
 __alloc_pages+0x259/0x560 mm/page_alloc.c:5558
 vm_area_alloc_pages mm/vmalloc.c:2975 [inline]
 __vmalloc_area_node mm/vmalloc.c:3043 [inline]
 __vmalloc_node_range+0x8f4/0x1290 mm/vmalloc.c:3213
 kvmalloc_node+0x13e/0x180 mm/util.c:606
 kvmalloc include/linux/slab.h:706 [inline]
 kvmalloc_array include/linux/slab.h:724 [inline]
 kvcalloc include/linux/slab.h:729 [inline]
 z_erofs_decompress_pcluster fs/erofs/zdata.c:1049 [inline]
 z_erofs_decompress_queue+0x693/0x2c30 fs/erofs/zdata.c:1155
 z_erofs_decompressqueue_work+0x95/0xe0 fs/erofs/zdata.c:1167
 process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
 worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
