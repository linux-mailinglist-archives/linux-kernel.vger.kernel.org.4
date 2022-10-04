Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BF5F3F0E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiJDJBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiJDJAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:00:51 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724372AC4A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:00:50 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id t21-20020a056602181500b006b3a8e8450eso111394ioh.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:00:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=WsrlFetaOvBbJzIoI+7wVQaiq4OvqdIyUFgG94TQ3jY=;
        b=0eBosUspSjrQ0fLOmYfx+GvyNdJE8T9R8wuCERWnHeQ05utR2rgLN1LYqpdmnadSxJ
         /su4PZCypkeG1zFfciEPkG/kQaFT6+Ko8DaxaIxMWhopx2TcQS2OOyavIH1kD/QjQJAg
         UZucZXlI+jdUQfbZqTByINvniynpsnV5OyBoi+57vMqSX6inqMdr2tA/PsKN4Jftb+e5
         yH6+4967KXiY6oYjUUQfMYxPUyIqK9Z84H7nvXtwecgdQAcsW1mbkgNxxA10Z4SbsR/2
         jEDfqIfAWWx9rfRjM6cpQNJ99RLv89tYYKyQWvcOwNWWVCz1LFSU2D2h2qX16fLDKm2l
         wEmQ==
X-Gm-Message-State: ACrzQf16wgzO118jPMDpHOV1umBTQuGYUZiLIEWQMe1AhGAmpXgIRtjj
        Au4yiXXkyPON7/yp0Zob0tvYiLy1YczgfOk03pfevIiwQ3kD
X-Google-Smtp-Source: AMsMyM5Q+eZ6BWWdAs87hFCMRIMcdkD1u5GMwovcCqFi69vMv/FAdDqBZ0jBBF8nJ1p3kbL44u8/WOjApjeqFY8oheF4gNFaLUmr
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3b4:b0:363:37b4:2cde with SMTP id
 z20-20020a05663803b400b0036337b42cdemr3606694jap.150.1664874049806; Tue, 04
 Oct 2022 02:00:49 -0700 (PDT)
Date:   Tue, 04 Oct 2022 02:00:49 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000055a5be05ea31b2af@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in dbAllocBits
From:   syzbot <syzbot+ae2f5a27a07ae44b0f17@syzkaller.appspotmail.com>
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

HEAD commit:    4fe89d07dcc2 Linux 6.0
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123b2034880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1c7bd9b9b7d4c47
dashboard link: https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122f6fc0880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12330ccc880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/90e404873893/disk-4fe89d07.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/010b08fa7faf/vmlinux-4fe89d07.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae2f5a27a07ae44b0f17@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 32768
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:2222:23
index 128 is out of range for type 's64 [128]'
CPU: 0 PID: 3605 Comm: syz-executor514 Not tainted 6.0.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x62/0x6c lib/ubsan.c:283
 dbAllocBits+0x50f/0x5f0 fs/jfs/jfs_dmap.c:2222
 dbAllocDmap+0x61/0x110 fs/jfs/jfs_dmap.c:1999
 dbAllocNext+0x34a/0x410 fs/jfs/jfs_dmap.c:1152
 dbAlloc+0x323/0xa70 fs/jfs/jfs_dmap.c:786
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4e7/0xeb0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x661/0xa90 fs/jfs/inode.c:248
 __block_write_begin_int+0x3ca/0x1520 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0xb5/0x4d0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0xd0 fs/jfs/inode.c:304
 generic_perform_write+0x246/0x560 mm/filemap.c:3738
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3866
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3898
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:584
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc695c29e59
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd7dbbb058 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc695c29e59
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000003
RBP: 00007fc695be9620 R08: 0000000000000000 R09: 00007fc695be9620
R10: 00005555574562c0 R11: 0000000000000246 R12: 0000000200000004
R13: 0000000000000000 R14: 00080000000000f8 R15: 0000000000000000
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
