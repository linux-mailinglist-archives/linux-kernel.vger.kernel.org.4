Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481E0627500
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 04:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiKNDer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 22:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiKNDep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 22:34:45 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C4515A0E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:34:44 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id q6-20020a056e020c2600b00302664fc72cso405082ilg.14
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 19:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kAMMFntmaYX8HHHcoBR1z0jYIUhesZs9GrMDen8+P0I=;
        b=14moN0B+T1AJ7bMTVR0zQsaBj97E7529j7H0wKIizg7bvijtOzPS5fBrCt4lKN+ZrK
         zTWL6AyXwvQsoYYD+AyqsDTv3C9zggkQJNZtbIYyRtuOoVXfGzJcdtzN1h5t7W5XS0zH
         DgHnS59rhzQsgBjAHX7jjmY2/GbJ7ERW/XQc0abPnMHinMI4o/R0/vwyX5uLCjO3LYQd
         c9OJI7W9BXCEk02iUUKs8+cmFP4Ch22FJAPtP1+JFonOVFruVr9ryXXtgOI3hze85V0/
         bYn4UCtY0x44xFFLiASHq/yA/nQo+QpAz/VUI48o/4gijLCBESS7C2RjPToqTCvFvCR1
         FL8w==
X-Gm-Message-State: ANoB5pmjiv5THXDRv+htuL2q59bK9d9ZYJPHWEsiv1I9nshd74zTTUsf
        IW8Stsm8qPqAegQ4rctxETuWwxFSQvyp530Mfz5C6+x2WH3J
X-Google-Smtp-Source: AA0mqf5ZNiwfE/qRoN4DEHPzmEsXTgglP5piaGa+wS3V+hQ7UOF8GnQWE+XvY52m4Q4ovF1VlXDu2dWE7tcgmaS4T02wmJWaLeQv
MIME-Version: 1.0
X-Received: by 2002:a6b:ef0e:0:b0:6c0:3ade:1c3e with SMTP id
 k14-20020a6bef0e000000b006c03ade1c3emr4723664ioh.63.1668396884194; Sun, 13
 Nov 2022 19:34:44 -0800 (PST)
Date:   Sun, 13 Nov 2022 19:34:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a078ac05ed65eb00@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in xtTruncate
From:   syzbot <syzbot+75c177aa1291e7fe423d@syzkaller.appspotmail.com>
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

HEAD commit:    f67dd6ce0723 Merge tag 'slab-for-6.1-rc4-fixes' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102b0615880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=771b06c41e08f95b
dashboard link: https://syzkaller.appspot.com/bug?extid=75c177aa1291e7fe423d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0ddcda4f997e/disk-f67dd6ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ced709971cf5/vmlinux-f67dd6ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d35fb69a1976/bzImage-f67dd6ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+75c177aa1291e7fe423d@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:2304:9
index 19 is out of range for type 'xad_t [18]'
CPU: 0 PID: 4605 Comm: syz-executor.4 Not tainted 6.1.0-rc4-syzkaller-00020-gf67dd6ce0723 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 xtTruncate+0x2778/0x32d0 fs/jfs/jfs_xtree.c:2304
 jfs_truncate_nolock+0x192/0x390 fs/jfs/inode.c:393
 jfs_truncate+0xc6/0x140 fs/jfs/inode.c:417
 jfs_direct_IO+0x1b0/0x1e0 fs/jfs/inode.c:347
 generic_file_direct_write+0x294/0x610 mm/filemap.c:3677
 __generic_file_write_iter+0x1c4/0x400 mm/filemap.c:3837
 generic_file_write_iter+0xab/0x310 mm/filemap.c:3913
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
RIP: 0033:0x7f22df88b639
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f22e0602168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f22df9abf80 RCX: 00007f22df88b639
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000003
RBP: 00007f22df8e67e1 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffc01280fbf R14: 00007f22e0602300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
