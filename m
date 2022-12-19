Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADD8650912
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbiLSJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiLSJIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:08:36 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AC3AE72
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:08:35 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i21-20020a056e021d1500b003041b04e3ebso6217480ila.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 01:08:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0IFu5r4+F7D14UR9MEQvuAXQT7FSJIFLCsKF+v3qiU=;
        b=l3PQRLdz6BbHIACmg+sAfAACO6tzDlKgLymvA6enTAqdoTuq/hk5qE+Ayq6OocQYj4
         kShxW31fWPAXQVTCT3KyGvwvjGWE3/lwwF6D25+LxFTkhtjvcnndTXtc7R1SOpPBLitx
         UkIXfNMtjRwYk9+Vd5G2uNbcMAf8JvVNbpGRX2TSUxYXInTIM+EXoMyJQshISAmLbiEp
         GLOvG3lB3KBjOnA0EJusZfi/rNgtiN/Q9p/4RE7TS8yQXBKHOn7Dmtc/xnk0owrl0j3T
         e3OG8S+dIQ/O6ynYpaKqEbkSH3EzAi/qjIrIh1ueqbo3wMd5QsCSCyOXHNZX5RkHTFvs
         IL4g==
X-Gm-Message-State: ANoB5pl0ck1tw9Dvpa9a/MDjNFNeanz/br38JDrSwnW/pOISCgXEEjvn
        vsFIanWMR0NHp7KLDGl0xxEgElRKzsUxuPa3C9rJJ/+vV+/A
X-Google-Smtp-Source: AA0mqf4zQyrdIslyyVPl9xgpjBXtCORArAcwuxr9pUG5/cE1pjlzsjFG4U/vSwBBfhvgQyLFptCBy0/fwhZ6WECImxld57EZn+zR
MIME-Version: 1.0
X-Received: by 2002:a05:6638:345b:b0:38a:c192:48b2 with SMTP id
 q27-20020a056638345b00b0038ac19248b2mr2065099jav.203.1671440914688; Mon, 19
 Dec 2022 01:08:34 -0800 (PST)
Date:   Mon, 19 Dec 2022 01:08:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fbb00605f02aa99c@google.com>
Subject: [syzbot] [f2fs?] BUG: unable to handle kernel NULL pointer
 dereference in f2fs_release_folio
From:   syzbot <syzbot+00e671c059932a115ea4@syzkaller.appspotmail.com>
To:     chao@kernel.org, jaegeuk@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit:    a5541c0811a0 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14e39af7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd4e584773e9397
dashboard link: https://syzkaller.appspot.com/bug?extid=00e671c059932a115ea4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4b7702208fb9/disk-a5541c08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ec0153ec051/vmlinux-a5541c08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6f8725ad290a/Image-a5541c08.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00e671c059932a115ea4@syzkaller.appspotmail.com

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f4f
Mem abort info:
  ESR = 0x0000000096000006
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000006
  CM = 0, WnR = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000239c25000
[0000000000000f4f] pgd=0800000239ac9003, p4d=0800000239ac9003, pud=080000023986f003, pmd=0000000000000000
Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 25727 Comm: syz-executor.0 Not tainted 6.1.0-rc8-syzkaller-33330-ga5541c0811a0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : f2fs_release_folio+0x74/0x180 fs/f2fs/data.c:3698
lr : generic_test_bit include/asm-generic/bitops/generic-non-atomic.h:128 [inline]
lr : folio_test_dirty include/linux/page-flags.h:479 [inline]
lr : f2fs_release_folio+0x5c/0x180 fs/f2fs/data.c:3694
sp : ffff8000213cb580
x29: ffff8000213cb580 x28: 0000000000000001 x27: dead000000000100
x26: fffffc0004e8ed48 x25: ffff0000ca783468 x24: ffff8000213cba78
x23: 0000000000000001 x22: ffffffffffffffff x21: ffff0000ca783240
x20: 0000000000000000 x19: fffffc0004e8ed40 x18: 00000000000000c0
x17: ffff80000dda8198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000002 x13: 0000000000000003 x12: 0000000000040000
x11: ff8080000931aeec x10: 0000000000000002 x9 : ffff0001f9be4ec0
x8 : ffff000139c2b000 x7 : ffff80000841b904 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000213cb5c0
x2 : ffff000116d8d000 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 F2FS_SB fs/f2fs/f2fs.h:1995 [inline]
 F2FS_I_SB fs/f2fs/f2fs.h:2000 [inline]
 F2FS_M_SB fs/f2fs/f2fs.h:2005 [inline]
 f2fs_release_folio+0x74/0x180 fs/f2fs/data.c:3697
 filemap_release_folio+0xc0/0x238 mm/filemap.c:3948
 shrink_folio_list+0xdbc/0x337c mm/vmscan.c:1982
 shrink_inactive_list+0x30c/0x54c mm/vmscan.c:2489
 shrink_list mm/vmscan.c:2728 [inline]
 shrink_lruvec+0x218/0x5b4 mm/vmscan.c:5923
 shrink_node_memcgs+0x13c/0x2c4 mm/vmscan.c:6110
 shrink_node+0xb4/0x600 mm/vmscan.c:6141
 shrink_zones+0x1bc/0x408 mm/vmscan.c:6379
 do_try_to_free_pages+0xd0/0x42c mm/vmscan.c:6441
 try_to_free_mem_cgroup_pages+0x174/0x244 mm/vmscan.c:6756
 try_charge_memcg+0x1a8/0x650 mm/memcontrol.c:2681
 try_charge mm/memcontrol.c:2823 [inline]
 mem_cgroup_charge_skmem+0x50/0x150 mm/memcontrol.c:7209
 sock_reserve_memory+0x88/0x144 net/core/sock.c:1018
 sk_setsockopt+0xb54/0x1694 net/core/sock.c:1518
 sock_setsockopt+0x48/0x60 net/core/sock.c:1542
 __sys_setsockopt+0x21c/0x31c net/socket.c:2248
 __do_sys_setsockopt net/socket.c:2263 [inline]
 __se_sys_setsockopt net/socket.c:2260 [inline]
 __arm64_sys_setsockopt+0x30/0x44 net/socket.c:2260
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x140 arch/arm64/kernel/syscall.c:197
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:637
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:655
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:584
Code: 2a1f03e0 f9400115 f94016a8 f9433d16 (b94f52d7) 
---[ end trace 0000000000000000 ]---
pstore: crypto_comp_compress failed, ret = -22!
pstore: crypto_comp_compress failed, ret = -22!
pstore: crypto_comp_compress failed, ret = -22!
pstore: crypto_comp_compress failed, ret = -22!
pstore: crypto_comp_compress failed, ret = -22!
pstore: crypto_comp_compress failed, ret = -22!
----------------
Code disassembly (best guess):
   0:	2a1f03e0 	mov	w0, wzr
   4:	f9400115 	ldr	x21, [x8]
   8:	f94016a8 	ldr	x8, [x21, #40]
   c:	f9433d16 	ldr	x22, [x8, #1656]
* 10:	b94f52d7 	ldr	w23, [x22, #3920] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
