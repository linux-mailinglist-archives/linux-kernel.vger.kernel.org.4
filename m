Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C39603974
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJSF7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:59:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiJSF7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:59:36 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040EC11A16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:59:33 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id b12-20020a5d804c000000b006b723722d4eso12040115ior.17
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzvk70GSoy8v6g/xMQR0hh15OGuFCcc8W8bi0WPq9/w=;
        b=H781Z7+ts//eTiBK9OaWKmVjegQ5kYewpVVdkNZpzXBbAYOPhGRVrabDyj7Iy1uG+g
         CQ7KipVnSBbx25mot0eir0D+Ao/58mLtiQkLE4FvymUDlbUrq0vmmmpVOuYpZmWt8h4R
         5NuU+C0/VJufQMQzeJpFgPHT54S9J/qXHIPPR7G6zmD/heHriIbLAyZY6ADrzeQvBwel
         cQHkveSadoXu6g6ZYH4NT/GliRbB6u4Rd1XgPLsYv4d3q3EF4ca+UaCkwDU1cVh8uBmo
         TWUNXskTnz5+5JqPtSY0IYTbO78hBGf5ccDuCP27KWCudOEuLEU15X9IAJcKInkv4fMM
         YIFg==
X-Gm-Message-State: ACrzQf3/V6rbqhMlv0FmPDXi8mvjVbXHz6+qmBTtJf0GEtw3l+1DcU+g
        FJaj3jOa6Dxe0PECmjuKqKMzj0WbPod23ympR3at156XVIkZ
X-Google-Smtp-Source: AMsMyM7YQxaymmcL7aiWLNJbM0Xf1OGkjfIPzAyP7stDCdYOt8Usgkk+hFkQy0pE6/4tv+C0hgeFG9StgwVJcFSJ51urxXvOCDrx
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184f:b0:2fc:ec3c:98ec with SMTP id
 b15-20020a056e02184f00b002fcec3c98ecmr4552277ilv.188.1666159173332; Tue, 18
 Oct 2022 22:59:33 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:59:33 -0700
In-Reply-To: <000000000000dd7d5a05eb5ca523@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aa768a05eb5ce9c2@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in dbDiscardAG
From:   syzbot <syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12410be6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=f0e0fcf3cd1047ae60ad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1408aae2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=123f717c880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3472d2d58c3a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com

ERROR: (device loop0): dbAllocAG: allocation request is larger than the allocation group size
ERROR: (device loop0): dbDiscardAG: -EIO
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1567:12
index 128 is out of range for type 's64 [128]'
CPU: 1 PID: 3614 Comm: syz-executor131 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 dbDiscardAG+0x9d6/0xa50 fs/jfs/jfs_dmap.c:1567
 jfs_ioc_trim+0x433/0x660 fs/jfs/jfs_discard.c:100
 jfs_ioctl+0x2bd/0x3d0 fs/jfs/ioctl.c:131
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xfb/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f0cc1ffdda9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd75ab778 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0cc1ffdda9
RDX: 0000000020000140 RSI: 00000000c0185879 RDI: 0000000000000003
RBP: 00007f0cc1fbd570 R08: 0000000000000000 R09: 00007f0cc1fbd570
R10: 00005555566902c0 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
================================================================================

