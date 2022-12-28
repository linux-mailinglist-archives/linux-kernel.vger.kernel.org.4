Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F7F6585CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 19:38:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbiL1Sho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 13:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiL1Shk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 13:37:40 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382D013E0A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 10:37:39 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id z19-20020a921a53000000b0030b90211df1so10466477ill.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 10:37:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XSRc+nF+AEhFC85YkjgHL3uFPFrPyO+OC1LO63fk0ME=;
        b=pMJ1YCw+WZMdrAxBN+x4VptYI1nnJ+S3Idn2sV1fuTYbCFRi1D1MB6Az6Nk8W/bjvl
         DL9pr5wsVtUP9SrLGsFKQdfrNqHjse2DZZLuMPIcY+XPby85JySZRh2wtWDqIbXMS05p
         6/FTq15lg1CcPISluR+BDD5zMTH9ZwSs9HWw7oEOeaKArH/xi1oK8dfz/jRNyE/nupHR
         ReXYwe9euPo0nqZt16lufIwukCxRnVvdqf91m4R8UWlasUxrbEgHNfGgLYXT/SLM5rn7
         A4iyRQkUkuEgUXlLcWpARhxct3B4PkcDRthi9SzXMI+23anRac3MrTihlj+EfDG2P/T4
         RGAg==
X-Gm-Message-State: AFqh2krUymtFYlACJHzyyiKXnXl5lZQZHRJ7Gu0g4Lbf7deoZkq7GA8C
        /Umt6PSNskf/9AolFr4dQ6djlIEODej4QCdvhCQgKE+6t5QS
X-Google-Smtp-Source: AMrXdXuQpR7FAqb+v30kBh6Aavs6rN6pVdxeO+UmTzmvhFgTcm1zMILrNVx0F84y+1ZFTHyT5vo71QpyWah2RH9NGKiXEPQ352cM
MIME-Version: 1.0
X-Received: by 2002:a02:8586:0:b0:38a:979e:f584 with SMTP id
 d6-20020a028586000000b0038a979ef584mr2093302jai.261.1672252658507; Wed, 28
 Dec 2022 10:37:38 -0800 (PST)
Date:   Wed, 28 Dec 2022 10:37:38 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af650105f0e7a9e5@google.com>
Subject: [syzbot] [ntfs3?] INFO: trying to register non-static key in do_mpage_readpage
From:   syzbot <syzbot+0ede990fe8e46cb5711d@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com
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

HEAD commit:    72a85e2b0a1e Merge tag 'spi-fix-v6.2-rc1' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10be5ea8480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e2d7bfa2d6d5a76
dashboard link: https://syzkaller.appspot.com/bug?extid=0ede990fe8e46cb5711d
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170127f8480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10eadd74480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/510d16df06c8/disk-72a85e2b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/50ef5477a1d4/vmlinux-72a85e2b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2acd6f1189a/bzImage-72a85e2b.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/ec3614d3a811/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ede990fe8e46cb5711d@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 4096
ntfs3: loop0: Different NTFS' sector size (4096) and media sector size (512)
ntfs3: loop0: ino=0, ntfs_iget5
ntfs3: loop0: Mark volume as dirty due to NTFS errors
INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 0 PID: 5067 Comm: syz-executor292 Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 assign_lock_key+0x212/0x220 kernel/locking/lockdep.c:981
 register_lock_class+0x18d/0x930 kernel/locking/lockdep.c:1294
 __lock_acquire+0xe4/0x1f60 kernel/locking/lockdep.c:4934
 lock_acquire+0x182/0x3c0 kernel/locking/lockdep.c:5668
 down_read+0x39/0x50 kernel/locking/rwsem.c:1509
 attr_data_get_block+0x165/0x2d70 fs/ntfs3/attrib.c:903
 ntfs_get_block_vbo+0x31f/0xc40 fs/ntfs3/inode.c:573
 do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
 mpage_readahead+0x210/0x380 fs/mpage.c:361
 read_pages+0x169/0x9c0 mm/readahead.c:161
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
 filemap_read+0x3cf/0xea0 mm/filemap.c:2694
 __kernel_read+0x3fc/0x830 fs/read_write.c:428
 integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
 process_measurement+0xf41/0x1bc0 security/integrity/ima/ima_main.c:339
 ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:519
 do_open fs/namei.c:3559 [inline]
 path_openat+0x2600/0x2dd0 fs/namei.c:3714
 do_file_open_root+0x339/0x790 fs/namei.c:3766
 file_open_root+0x234/0x290 fs/open.c:1290
 do_handle_open+0x565/0x950 fs/fhandle.c:232
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f063f1ed849
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdae758908 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f063f1ed849
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f063f1ad0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f063f1ad170
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0x0, owner = 0xffff8880285d57c1, curr 0xffff8880285d57c0, list not empty
WARNING: CPU: 0 PID: 5067 at kernel/locking/rwsem.c:1335 __up_read+0x4f5/0x690 kernel/locking/rwsem.c:1335
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor292 Not tainted 6.1.0-syzkaller-14594-g72a85e2b0a1e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__up_read+0x4f5/0x690 kernel/locking/rwsem.c:1335
Code: c7 00 ac ed 8a 48 c7 c6 00 ae ed 8a 48 8b 54 24 20 48 8b 4c 24 28 4d 89 f8 4c 8b 4c 24 30 31 c0 53 e8 2f 60 e8 ff 48 83 c4 08 <0f> 0b 48 bb 00 00 00 00 00 fc ff df 4c 8b 6c 24 18 e9 ba fb ff ff
RSP: 0018:ffffc90003c9de80 EFLAGS: 00010292
RAX: f88922fb16b92700 RBX: ffffffff8aedad00 RCX: ffff8880285d57c0
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc90003c9df50 R08: ffffffff816f2c9d R09: fffff52000793b89
R10: fffff52000793b89 R11: 1ffff92000793b88 R12: ffff888073897048
R13: ffff888073897038 R14: 1ffff1100e712e09 R15: ffff8880285d57c1
FS:  00005555565b6300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056023bc34d28 CR3: 000000007da67000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_data_get_block+0x1c8/0x2d70 fs/ntfs3/attrib.c:906
 ntfs_get_block_vbo+0x31f/0xc40 fs/ntfs3/inode.c:573
 do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
 mpage_readahead+0x210/0x380 fs/mpage.c:361
 read_pages+0x169/0x9c0 mm/readahead.c:161
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1210 [inline]
 filemap_get_pages+0x465/0x10d0 mm/filemap.c:2600
 filemap_read+0x3cf/0xea0 mm/filemap.c:2694
 __kernel_read+0x3fc/0x830 fs/read_write.c:428
 integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
 process_measurement+0xf41/0x1bc0 security/integrity/ima/ima_main.c:339
 ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:519
 do_open fs/namei.c:3559 [inline]
 path_openat+0x2600/0x2dd0 fs/namei.c:3714
 do_file_open_root+0x339/0x790 fs/namei.c:3766
 file_open_root+0x234/0x290 fs/open.c:1290
 do_handle_open+0x565/0x950 fs/fhandle.c:232
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f063f1ed849
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdae758908 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f063f1ed849
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000004
RBP: 00007f063f1ad0e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f063f1ad170
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
