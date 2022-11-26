Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4F8639760
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiKZRJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKZRJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:09:32 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8A119021
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:09:31 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so5002343ilv.16
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dK39n2LHUM6dTNpUPIXAiJVmWXxSWQm6JqTRK4z2qZE=;
        b=gh4hLIeanCc3A5pg2ugSfeIxl2cbzxIDXqTrIdVmgvZUG1DKm4r84L+dIAyhk3EekI
         nFCk4FGo1bLNlDahmmVb/HT6kzzJZPYDVayonNzwIfBjAAcAqMTnuoeGxVujkHeDUdP/
         VZ9zbvux+b3i94wNza/kDQLieAIYPUhehzLZX95vrxwqvpKUjRh5MgWdZgYR1IvAubGk
         oOk6h820qAh73+K1zkhLFnseoQMvXV2PyKyuMmbFzHvtLgDdlpikFZnsUriw43ifS5CY
         pO+9B8IXIbYDa9NTgr/TDqjL3oYqkvmJrCefA234nGg6102x+naAnGeRvWkfppBgmhHM
         uEQQ==
X-Gm-Message-State: ANoB5pm9x8DABW3TLGx01vDDfQpE0PWu9rkwdZA0er2Cqx3Xmu9K03CS
        bfXAlE8xzoW93H3xAxB/KnzP99OXMvAF9bChv4ThWOGE3yS1
X-Google-Smtp-Source: AA0mqf77h2cF/n4XILxIVVJgReGwedw+0fs1zOPsxdArt26KD+kmV/nKUdCprfZZLzIQV73E+kUwWr2uXto4pD4rov36jHvqC8PY
MIME-Version: 1.0
X-Received: by 2002:a92:ca8d:0:b0:302:de10:7ae1 with SMTP id
 t13-20020a92ca8d000000b00302de107ae1mr8923641ilo.15.1669482570940; Sat, 26
 Nov 2022 09:09:30 -0800 (PST)
Date:   Sat, 26 Nov 2022 09:09:30 -0800
In-Reply-To: <000000000000f841fb05eb364ce6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000999ad405ee62b30b@google.com>
Subject: Re: [syzbot] UBSAN: array-index-out-of-bounds in txCommit
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    644e9524388a Merge tag 'for-v6.1-rc' of git://git.kernel.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16788381880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d01b6e3197974dd
dashboard link: https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13591573880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10c2c7ab880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0968428e17b4/disk-644e9524.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fd4c3bfd0777/vmlinux-644e9524.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ee4571f27f1c/bzImage-644e9524.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/0fdce98f569c/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0558d19c373e44da3c18@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_txnmgr.c:1738:5
index 18 is out of range for type 'xad_t [18]'
CPU: 1 PID: 3636 Comm: syz-executor352 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
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
 __block_write_begin_int+0x54c/0x1a80 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0x93/0x1e0 fs/buffer.c:2102
 jfs_write_begin+0x2d/0x60 fs/jfs/inode.c:304
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3753
 __generic_file_write_iter+0x176/0x400 mm/filemap.c:3881
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
RIP: 0033:0x7f12751c65e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 71 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f12751512f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f12752517f0 RCX: 00007f12751c65e9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f127521e0e4 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 65732f636f72702f
R13: 0030656c69662f2e R14: 0031656c69662f2e R15: 00007f12752517f8
 </TASK>
================================================================================

