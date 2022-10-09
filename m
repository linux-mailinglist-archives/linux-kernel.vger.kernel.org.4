Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1255F8BAB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJIOPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 10:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJIOPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 10:15:43 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2246725E2
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 07:15:42 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id u11-20020a6b490b000000b006bbcc07d893so2480378iob.9
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 07:15:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=faTXIRropJugVTggYO/9etOH41t1DT94LEw64aOP+tU=;
        b=bVfLpQ38e+551rpr1V4jM2U7YXg/uyKspqSkhLIZbTtcT/0FAZndIX3/Nv0XVZSZwn
         zE8HP4suOumilI12dTQzhL1WtuqS4bcoRFxNWbMmKF82SV0Y/TMmBDUL0UFYj18ID2+p
         riWUAxjBHfZlUgfp9kFjJ9XEncts5bfYFLni2VG2NsC/6n0xjxZ3cV+POv/J9ghi5r7w
         OmE+dQssu9Ulq+CL50eWORumyHJdlmPLnt+gmVyr9gjDM+o0cblM15GTjUZEeZUK5ZDK
         wUnvuYakKmjDDQZjZD7dDUKMpChVpJ45Q05tXkxVyeR6t7xaXZIPIgf+18fKdVzA54AP
         C9xg==
X-Gm-Message-State: ACrzQf1WHN7PjhcoeyrDw9lKo3ebvH7x1C16kmP/+uP2LMSwsc2p5Jx/
        Vx5Wrqo4KTuZK9u/zeRnMGR6x5xRsdd4peWIwC+DwHyPRIIa
X-Google-Smtp-Source: AMsMyM7xthTrLipNJU/j0ql7ahPbDuKjaUviEQsaWmx81Aq8qU+lWmoVZd4z0nI1u/uGYBJ0wpz1WkqqNQTQGVqRG9RC9M1PvtFT
MIME-Version: 1.0
X-Received: by 2002:a92:cd83:0:b0:2f9:c29a:9107 with SMTP id
 r3-20020a92cd83000000b002f9c29a9107mr7128369ilb.271.1665324941508; Sun, 09
 Oct 2022 07:15:41 -0700 (PDT)
Date:   Sun, 09 Oct 2022 07:15:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000093079705ea9aada2@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbFindCtl
From:   syzbot <syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com>
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

HEAD commit:    62e6e5940c0c Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1767b062880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c13637ccca17699
dashboard link: https://syzkaller.appspot.com/bug?extid=7edb85bc97be9f350d90
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b4f4f04cf38f/disk-62e6e594.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dfb013b64867/vmlinux-62e6e594.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7edb85bc97be9f350d90@syzkaller.appspotmail.com

loop3: detected capacity change from 0 to 32768
================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1671:12
shift exponent 1635280253 is too large for 64-bit type 'long long'
CPU: 0 PID: 15905 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-07362-g62e6e5940c0c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_shift_out_of_bounds+0x33d/0x3b0 lib/ubsan.c:322
 dbFindCtl+0x426/0x590 fs/jfs/jfs_dmap.c:1671
 dbAllocAny fs/jfs/jfs_dmap.c:1502 [inline]
 dbAlloc+0x31b/0xc90 fs/jfs/jfs_dmap.c:732
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4b9/0xff0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x342/0xce0 fs/jfs/inode.c:248
 get_more_blocks fs/direct-io.c:665 [inline]
 do_direct_IO fs/direct-io.c:953 [inline]
 __blockdev_direct_IO+0x17e7/0x3c90 fs/direct-io.c:1266
 blockdev_direct_IO include/linux/fs.h:3204 [inline]
 jfs_direct_IO+0xf6/0x1e0 fs/jfs/inode.c:336
 generic_file_direct_write+0x294/0x610 mm/filemap.c:3669
 __generic_file_write_iter+0x1c4/0x400 mm/filemap.c:3829
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3905
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f7e2c68a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7e2d775168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f7e2c7abf80 RCX: 00007f7e2c68a5a9
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f7e2c6e5580 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffcebd1439f R14: 00007f7e2d775300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
