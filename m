Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE861E5DC
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiKFUVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:21:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFUVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:21:50 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3521117F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 12:21:49 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id c14-20020a5ea80e000000b006d6e9b05e58so5056819ioa.23
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 12:21:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iFxtpsBCdq9AcVN6nHrpSjVURQQ/Q55yiCvyBMA//bs=;
        b=Uotjov8W5bTzoBpjplbwf5tde4qZ9fbHk+OCSWEyE+myQzkRrLWrIPkhmjOB4WW4Yb
         4s3ws71G8Taskmo0QXXxOcJQl17jMiA0PUAdJ+H5BGmuphyej/w3HYE/XkZhKAsUla4Q
         l2QQnuFiuZWCbEYXDCtf03Timep3SPUToKZ2MLr6r4ODBGPflsm2+54h+gEbHBkVc07+
         fHvr1FULmgcJ545/z1mbegNAPVCJUhb6FqmL44fzMxclG61OjH3ohXrMF8mIN/13YBdo
         e6njAVDC3gFuM/0xkJp+4O7P6FErUyxPBx4qoeBd+djvSnU1jtvuN4PmPbsozlCK1GBQ
         oryQ==
X-Gm-Message-State: ACrzQf0v/i1dxV4Xfyn5CDlKTy3ikjpNYIngTUQV8H3C7AIg9GxzkBP9
        HWGbTU0KCZRO8jRUqEy+F1a/aSjNy/n68dkUZaXy+hrd6zRJ
X-Google-Smtp-Source: AMsMyM6EqIFLfRw3XsvZWos8WTIfz2nip/IxuKz8yIJJgbeT3yYSLrqxahtGADhLRG0BQFMiYtskWl4JRK2yFjpA0siEKTrQLKVO
MIME-Version: 1.0
X-Received: by 2002:a92:c5d4:0:b0:300:d9d7:fe2e with SMTP id
 s20-20020a92c5d4000000b00300d9d7fe2emr9682435ilt.212.1667766108744; Sun, 06
 Nov 2022 12:21:48 -0800 (PST)
Date:   Sun, 06 Nov 2022 12:21:48 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007af51d05ecd30ed9@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in xtLookup
From:   syzbot <syzbot+e526b0844b096abaa8c7@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144f6876880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=e526b0844b096abaa8c7
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e526b0844b096abaa8c7@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_xtree.c:179:9
index 19 is out of range for type 'xad_t [18]'
CPU: 1 PID: 8948 Comm: syz-executor.1 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 xtLookup+0x86c/0x880 fs/jfs/jfs_xtree.c:179
 jfs_get_block+0x24b/0xce0 fs/jfs/inode.c:218
 do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
 mpage_readahead+0x210/0x380 fs/mpage.c:361
 read_pages+0x169/0x9c0 mm/readahead.c:161
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 filemap_readahead mm/filemap.c:2557 [inline]
 filemap_get_pages+0x72f/0x10d0 mm/filemap.c:2597
 filemap_read+0x3cf/0xea0 mm/filemap.c:2675
 call_read_iter include/linux/fs.h:2185 [inline]
 generic_file_splice_read+0x1ff/0x5d0 fs/splice.c:309
 do_splice_to fs/splice.c:793 [inline]
 splice_direct_to_actor+0x41b/0xc00 fs/splice.c:865
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f59e548b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f59e6216168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f59e55abf80 RCX: 00007f59e548b5a9
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000008
RBP: 00007f59e54e67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0001000000201005 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fff7e17c23f R14: 00007f59e6216300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
