Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E88E615135
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 19:01:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKASB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 14:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiKASBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 14:01:50 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC0813CFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 11:01:46 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id d19-20020a056e020c1300b00300b5a12c44so5738269ile.15
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 11:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Se9qSNnHuLVh7I+jU6VGt/2+DvcgL2MeEAmjO73fbhc=;
        b=X6wCgkMd6pOhpr5KKRdgn1omfsXcJq+Lf8rHBOA+Tk14m2TNEpMZj4/CiyHO8yrdKr
         l3dH01avBt1ytTNVykgsaS6XB/LYlT2QNONj2wMeokqEceXNUHfoGAeew/Zd9I4JNNrd
         21kf5pBknl22R7a+Xu+BghkqW82Aab2aUtvLD4LSHzuxldODOFkDxLseLdH9ttcgETXj
         AEtwL4SFalKUJgIczXhOZqliOeZTDq93O9O4p0jSFNzrdbU6qxdB2oNU1ffyAppaHnm8
         cP0E8LGr4qFUyjJJPC1k668G2B9mRpDcm+PpVLzuk/jKAS50jCra1ZanR0tz+Lt0O4jD
         KYZg==
X-Gm-Message-State: ACrzQf2cjMM02Ldho/xqLyxxu27zR7suWsBPMD/+0pZBhdRhobnLLuE3
        +o5Shz6LtUUX/dYXkuacOQMNayV1q4MBsSH8xSBXB4haOo3A
X-Google-Smtp-Source: AMsMyM74oltutcYOaT45sp5+43cX+untWCqTyBlIpfIvsx0684iGqWWhnSN3zA2IN5YlwVivD5FodzVp3rzKGOE84Oi0ifahNBhN
MIME-Version: 1.0
X-Received: by 2002:a02:7a19:0:b0:375:41a7:4fb with SMTP id
 a25-20020a027a19000000b0037541a704fbmr11933892jac.235.1667325705866; Tue, 01
 Nov 2022 11:01:45 -0700 (PDT)
Date:   Tue, 01 Nov 2022 11:01:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006c563205ec6c8442@google.com>
Subject: [syzbot] WARNING in attr_data_get_block
From:   syzbot <syzbot+02b932550da4a4ee1dae@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109f875a880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=02b932550da4a4ee1dae
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+02b932550da4a4ee1dae@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_RWSEMS_WARN_ON(sem->magic != sem): count = 0x100, magic = 0x0, owner = 0xffff88802168d7c1, curr 0xffff88802168d7c0, list not empty
WARNING: CPU: 0 PID: 32351 at kernel/locking/rwsem.c:1335 __up_read+0x4f5/0x690 kernel/locking/rwsem.c:1335
Modules linked in:
CPU: 0 PID: 32351 Comm: syz-executor.1 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:__up_read+0x4f5/0x690 kernel/locking/rwsem.c:1335
Code: c7 e0 78 8d 8a 48 c7 c6 e0 7a 8d 8a 48 8b 54 24 20 48 8b 4c 24 28 4d 89 f8 4c 8b 4c 24 30 31 c0 53 e8 0f 89 e8 ff 48 83 c4 08 <0f> 0b 48 bb 00 00 00 00 00 fc ff df 4c 8b 6c 24 18 e9 ba fb ff ff
RSP: 0018:ffffc90015c15e80 EFLAGS: 00010292
RAX: 3a348d4940a5a400 RBX: ffffffff8a8d79e0 RCX: 0000000000040000
RDX: ffffc90005131000 RSI: 0000000000006bc0 RDI: 0000000000006bc1
RBP: ffffc90015c15f50 R08: ffffffff816b8dfd R09: fffff52002b82b89
R10: fffff52002b82b89 R11: 1ffff92002b82b88 R12: ffff8880840cd2c8
R13: ffff8880840cd2b8 R14: 1ffff11010819a59 R15: ffff88802168d7c1
FS:  00007f4c6bb8b700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110f338967 CR3: 00000000345bc000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 attr_data_get_block+0x198/0x2370 fs/ntfs3/attrib.c:901
 ntfs_get_block_vbo+0x310/0xe40 fs/ntfs3/inode.c:564
 do_mpage_readpage+0x970/0x1c50 fs/mpage.c:208
 mpage_readahead+0x210/0x380 fs/mpage.c:361
 read_pages+0x169/0x9c0 mm/readahead.c:161
 page_cache_ra_unbounded+0x703/0x820 mm/readahead.c:270
 page_cache_sync_readahead include/linux/pagemap.h:1213 [inline]
 filemap_get_pages+0x465/0x10d0 mm/filemap.c:2581
 filemap_read+0x3cf/0xea0 mm/filemap.c:2675
 __kernel_read+0x3fc/0x830 fs/read_write.c:428
 integrity_kernel_read+0xac/0xf0 security/integrity/iint.c:199
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
 ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
 ima_calc_file_hash+0x178f/0x1ca0 security/integrity/ima/ima_crypto.c:573
 ima_collect_measurement+0x444/0x8c0 security/integrity/ima/ima_api.c:292
 process_measurement+0xf4b/0x1bd0 security/integrity/ima/ima_main.c:337
 ima_file_check+0xd8/0x130 security/integrity/ima/ima_main.c:517
 do_open fs/namei.c:3559 [inline]
 path_openat+0x2642/0x2df0 fs/namei.c:3713
 do_file_open_root+0x339/0x790 fs/namei.c:3765
 file_open_root+0x234/0x290 fs/open.c:1290
 do_handle_open+0x565/0x950 fs/fhandle.c:232
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4c6ae8b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4c6bb8b168 EFLAGS: 00000246 ORIG_RAX: 0000000000000130
RAX: ffffffffffffffda RBX: 00007f4c6afabf80 RCX: 00007f4c6ae8b5a9
RDX: 0000000000020000 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 00007f4c6aee67b0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffddae2ed6f R14: 00007f4c6bb8b300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
