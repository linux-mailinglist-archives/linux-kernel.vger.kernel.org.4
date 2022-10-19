Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA52603951
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJSFkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiJSFkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:40:37 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D0149B42
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:40:36 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id y26-20020a5d9b1a000000b006bc71505e97so12144772ion.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 22:40:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E0euC444GphM3Ky4TUWZPtkQzv94eUiH/s9cx8crkmw=;
        b=FVQ0wPXc7LtvtnLGgRH4uu5+hh8bE9IvNbPaBsClD1lMXnyVIjROBcQE6Z+SDbkAVH
         BPmBQwO8olI/uc65ZmSyh6YYE2dgV/zRypgS25CR1BJvrP4ga/iIZOYYOIFb7DLMlSDc
         AFoNgz75KOkpy0bOCt2FNMBzm8geG0wWPSlkjIl4alSxH+KoE7jQ6aA7feSJdxdfSZXa
         rooo5m5t5LayTeffp9vWFC9BDdYHBebvYypRf07/MgDAvno9Ulu90ndSW2qWBCwbEv6A
         fqBdFOLbBAvR14iKntd9bB1t5V3GaEM06TXuzWgaGrUVLYS3KzJ/x5NWxtJkKHuRUnw+
         DVKA==
X-Gm-Message-State: ACrzQf3AbNt02Xakr8LyNO7RJfxAjVyC6Tf/egT7KTCsrpsLbwYYnxkB
        gBS/xRHOAfn8aYS+hdFwmXD2hzIZJJ0OuLqWneeO+f/2YKH3
X-Google-Smtp-Source: AMsMyM4T9m8BwUnklZGcyg4fPhOp61ep3xdcuuwcU0V15MBJ0+Ytg6eDL3CT853iggs8sc2Tx4hW9ZLuPxUIimV1de/Yuwo/mz8N
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e3:b0:2fa:3db:3585 with SMTP id
 q3-20020a056e0220e300b002fa03db3585mr4496787ilv.238.1666158035825; Tue, 18
 Oct 2022 22:40:35 -0700 (PDT)
Date:   Tue, 18 Oct 2022 22:40:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd7d5a05eb5ca523@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in dbDiscardAG
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

Hello,

syzbot found the following issue on:

HEAD commit:    493ffd6605b2 Merge tag 'ucount-rlimits-cleanups-for-v5.19'..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114e4eaa880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=f0e0fcf3cd1047ae60ad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0e0fcf3cd1047ae60ad@syzkaller.appspotmail.com

ERROR: (device loop2): dbAllocAG: allocation request is larger than the allocation group size
ERROR: (device loop2): dbDiscardAG: -EIO
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_dmap.c:1567:12
index 128 is out of range for type 's64 [128]'
CPU: 1 PID: 26571 Comm: syz-executor.2 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
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
RIP: 0033:0x7fa60c68b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa60d808168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa60c7abf80 RCX: 00007fa60c68b5a9
RDX: 0000000020000140 RSI: 00000000c0185879 RDI: 0000000000000003
RBP: 00007fa60c6e6580 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc54dd4dbf R14: 00007fa60d808300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
