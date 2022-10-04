Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2DE5F3ECC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiJDIuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 04:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbiJDIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 04:50:46 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8947124BDB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 01:50:45 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id e14-20020a6b500e000000b006a13488a320so8505500iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 01:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=mFwuOFYdWVs0cNRuvJd+SgtJheoVJ15OPAHtEUyzi/o=;
        b=wOeViffnH3DWkCrTiWja9jGJ05/3XC5pnJRXSp09EVvGm6Mrfx87VDWZGS8q6bp1KU
         h72IVxcrpOuhiK3/QHsOmagbeSosPZJbiNZRqSXNYwhzdUdns+Hf2o/fUAANzWY5IeI6
         BpUgkVstc1xwdHTcWr3LH70YjueWc52WG8H8rszIRiwOyfpRc/sEu3gTc+Bjd5hbWFmC
         ieYYUnJU42IJ54edHAXWTk1x37PiJbqs3tbxLCqZxpj2TO2kuc308lGN35knV2+DlD5s
         tMz/kKPnCHieGrQMR+1o9ddZTVT5Tc/8Vlz5XpdL/79ay0XxNvtSUt1xx4nnnvpQi0OQ
         3R8A==
X-Gm-Message-State: ACrzQf1vJh23fCIdj+AERPIRGLRq8A0g7LBH+7qTXBcdBa495OOc08Ms
        8m/gUdOYMp4B5J2RQ4wVjDLdR+7DpMpEY2E/ySC/8hIrc/F7
X-Google-Smtp-Source: AMsMyM5xVl8vJ+/ouhp0JVkPM87d8EPdtJhtIgeHpw12QfLqnV0M+pR/Xi4gcPH1Fwm4FH8NXmM5c0lPsOJd/oMJNRB8dBo9Tjcb
MIME-Version: 1.0
X-Received: by 2002:a6b:8e43:0:b0:6a2:a115:7f01 with SMTP id
 q64-20020a6b8e43000000b006a2a1157f01mr10204379iod.47.1664873444775; Tue, 04
 Oct 2022 01:50:44 -0700 (PDT)
Date:   Tue, 04 Oct 2022 01:50:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000459c6205ea318e35@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in xtSearch
From:   syzbot <syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com>
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

HEAD commit:    a962b54e162c Merge tag 'i2c-for-6.0-rc8' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1441fa0a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=76a072c2f8a60280bd70
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7cf7771c181a/disk-a962b54e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcd5516984d8/vmlinux-a962b54e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+76a072c2f8a60280bd70@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:360:4
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 1533 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-00250-ga962b54e162c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 xtSearch+0x709/0x1cb0 fs/jfs/jfs_xtree.c:360
 xtLookup+0x235/0x880 fs/jfs/jfs_xtree.c:152
 extHint+0x204/0x630 fs/jfs/jfs_extent.c:215
 jfs_get_block+0x2e3/0xce0 fs/jfs/inode.c:246
 __block_write_begin_int+0x5f6/0x1ba0 fs/buffer.c:2006
 __block_write_begin fs/buffer.c:2056 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2117
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x2a8/0x5b0 mm/filemap.c:3738
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3866
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3898
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
RIP: 0033:0x7efc6de8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007efc6cddd168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007efc6dfac050 RCX: 00007efc6de8a5a9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000003
RBP: 00007efc6dee5580 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffa R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe1677525f R14: 00007efc6cddd300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
