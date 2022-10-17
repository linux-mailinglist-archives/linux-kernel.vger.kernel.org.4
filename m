Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0463160082B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJQHzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbiJQHzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:55:36 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408DE53D34
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:55:36 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso4049909ioo.22
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 00:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LybfEo/Roi1WEbT75rYrCV7d1BsMH3weiJW7j1IZqds=;
        b=s2NQUPhqBd99I2ROKPDHn2PXcXXWg+DATVT2FDWWOdzUjny0MzWMEGwnoSTqIngLNT
         hWMfBfLdgfwaPurqjf08InHXIS3xwbfd6rG3jlQneSBHlKBT1WhDs8bPYrMNH0E44KQy
         Q/pAElyasooMrfYZxCZYBsESK++eecF7KBiiQrVur/AYgv94xA7I84Jtn9EAD5oJu8CR
         mpk+yqAn0lDWmNWoIDwig8PT3y7O5p1LMQmH1wPLbCuy5F901yC34cNJ9n/xZy+iHQK9
         F4xm2i+pAuhVHwzrGK5e5mWYyZeQcQJLqZ1hS3Sm5OL3s8Pk7KC58OoR1P8gAvRLO4dh
         eTyg==
X-Gm-Message-State: ACrzQf0qJi1gS9snI4ZpFSWv8srXi4nf8W++MH2eCnbiTKaKj1ghT28Q
        csi/WubEfIrRTXK8bxmVI5JH4VXngIoJT3kkhdF10jOpWsK5
X-Google-Smtp-Source: AMsMyM5Z3edcvaaDmVKjK33q8v3PvwDh9SOWPTanWtmNPKIBRi99dPNR24Xb54YSZgjvrn6IjZQqPsKDwuUqSwR4fXvALZ2z1rQY
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4304:b0:343:5953:5fc8 with SMTP id
 bt4-20020a056638430400b0034359535fc8mr4711928jab.123.1665993335651; Mon, 17
 Oct 2022 00:55:35 -0700 (PDT)
Date:   Mon, 17 Oct 2022 00:55:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f841fb05eb364ce6@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in txCommit
From:   syzbot <syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=15d11444880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d19f5d16783f901
dashboard link: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1ff6481e26f/disk-493ffd66.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/101bd3c7ae47/vmlinux-493ffd66.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_txnmgr.c:1738:5
index 18 is out of range for type 'xad_t [18]'
CPU: 1 PID: 11903 Comm: syz-executor.3 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 xtLog fs/jfs/jfs_txnmgr.c:1738 [inline]
 txLog fs/jfs/jfs_txnmgr.c:1391 [inline]
 txCommit+0x3fb5/0x6d40 fs/jfs/jfs_txnmgr.c:1259
 jfs_commit_inode+0x342/0x5a0 fs/jfs/inode.c:108
 extAlloc+0xc93/0xff0 fs/jfs/jfs_extent.c:172
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
RIP: 0033:0x7fb2a168b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb2a05bc168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fb2a17ac120 RCX: 00007fb2a168b5a9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000003
RBP: 00007fb2a16e6580 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd4c0de95f R14: 00007fb2a05bc300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
