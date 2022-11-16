Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9B62BA15
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbiKPKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbiKPKup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:50:45 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7356F4FF85
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:39:33 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id a15-20020a056e0208af00b00300806a52b6so13081747ilt.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:39:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yad13G0UwAIaOqBVnUuYOEoa8gOaOv0aP3aWsZxgrFQ=;
        b=nnmjVVkzjA3CX6Wem+sbnFSZZ6VMaDMh6LUCbqhlZIUVUdyduXyctk8h6ZWYfUxZry
         31+QEdnIkcEuxwH2BS4GyzO9ojto36od3kewkHm72UiPHfRSmlVAjsr1DYPu2q3/X5z7
         ZMLUQJSl85axQ4K1uP/GQp4EiW6gWO0kBQdnccLeEzyQy/vj79n2hO0gvpjfYaE8Xjkn
         Fz/ty77qaLISp+267aah/qsqHZjn72hsI2eVoB6yiTyrIa5l7kwXQ4UcJzhq4JsdKrr8
         EZ5j7S+KgQwrp/zUEB/jYij8lTF2EigjlFBV0whv38Pb58rt0IcB36ANc0f3WryoX8Tp
         kq8g==
X-Gm-Message-State: ANoB5pkCOCvtc7LkJPE/2fzsLC1pLWpJqOoT29ZVvT7UnNT2sXNa6P8m
        8We8ixgMu8Dq0EwLG3PVQ4X3D/9s4FI7tnsQhuINSmB/Y2ug
X-Google-Smtp-Source: AA0mqf7PGq8xeHitwffcE1R+01qDGwkc7YPc918oQ0R8lMpycxEx6snL3NypcT6K9ocShexmkb59SLZ/NeE6tXlPpTmsijwkvCyS
MIME-Version: 1.0
X-Received: by 2002:a02:6383:0:b0:358:34d6:8528 with SMTP id
 j125-20020a026383000000b0035834d68528mr10517461jac.304.1668595171956; Wed, 16
 Nov 2022 02:39:31 -0800 (PST)
Date:   Wed, 16 Nov 2022 02:39:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fa14705ed941607@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in nilfs_segctor_do_construct
From:   syzbot <syzbot+5afc832d6dbb2fd17538@syzkaller.appspotmail.com>
To:     konishi.ryusuke@gmail.com, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    1621b6eaebf7 Merge branch 'for-next/fixes' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12ed633e880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=606e57fd25c5c6cc
dashboard link: https://syzkaller.appspot.com/bug?extid=5afc832d6dbb2fd17538
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/82aa7741098d/disk-1621b6ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f6be08c4e4c2/vmlinux-1621b6ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/296b6946258a/Image-1621b6ea.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5afc832d6dbb2fd17538@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000006
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=000000015174f000
[0000000000000000] pgd=080000015c4bd003, p4d=080000015c4bd003, pud=080000015c4c1003, pmd=0000000000000000
Internal error: Oops: 0000000086000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 12611 Comm: syz-executor.4 Not tainted 6.1.0-rc4-syzkaller-31872-g1621b6eaebf7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : nilfs_segctor_update_payload_blocknr+0x27c/0x3c8
sp : ffff800014093840
x29: ffff8000140938a0 x28: ffff000110709128 x27: 0000000000000000
x26: ffff0000ca340a80 x25: 0000000000000000 x24: 0000000000000000
x23: 0000000000000106 x22: ffff0000ca37ec38 x21: ffff000117008440
x20: ffff0000ca340ac8 x19: 0000000000000106 x18: 00000000000000c0
x17: ffff80000dcdc198 x16: ffff80000db1a158 x15: ffff000128253480
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff000128253480
x11: ff80800008f8ace0 x10: 0000000000000000 x9 : ffff80000c188130
x8 : 0000000000000000 x7 : ffff8000095f3074 x6 : 0000000000000000
x5 : ffff000128253480 x4 : fffffbffeffe5720 x3 : 0000000000002491
x2 : ffff800014093878 x1 : ffff800014093888 x0 : ffff000110d6f000
Call trace:
 0x0
 nilfs_segctor_assign fs/nilfs2/segment.c:1629 [inline]
 nilfs_segctor_do_construct+0x750/0xefc fs/nilfs2/segment.c:2056
 nilfs_construct_dsync_segment+0x21c/0x2ec fs/nilfs2/segment.c:2310
 nilfs_writepages+0x6c/0xa8 fs/nilfs2/inode.c:170
 do_writepages+0x144/0x27c mm/page-writeback.c:2469
 filemap_fdatawrite_wbc+0xac/0xd0 mm/filemap.c:388
 __filemap_fdatawrite_range mm/filemap.c:421 [inline]
 filemap_write_and_wait_range+0x84/0x1e8 mm/filemap.c:674
 __generic_file_write_iter+0x188/0x21c mm/filemap.c:3867
 generic_file_write_iter+0x6c/0x168 mm/filemap.c:3913
 call_write_iter include/linux/fs.h:2191 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:584
 ksys_write+0xb4/0x160 fs/read_write.c:637
 __do_sys_write fs/read_write.c:649 [inline]
 __se_sys_write fs/read_write.c:646 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:646
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: bad PC value
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
