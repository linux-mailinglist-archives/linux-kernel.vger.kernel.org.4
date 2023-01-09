Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196A1662A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 16:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237220AbjAIPs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 10:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjAIPrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 10:47:46 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3861A079
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 07:47:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id z8-20020a056e02088800b0030c247efc7dso6308572ils.15
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 07:47:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DUwZds0wjLkQnBIYbIWoN/PPnQGOvTGLK3WZZ9CM4pQ=;
        b=WMkYUXpO601w1C3S6jPW6sDVf6ligWpMbAD6IFjqkVXq8gWbi8WcuA6yUwRcHdfzbU
         C5vCNDRy3wEV+qtwC8xCbXBbPseDX4uWdWEEXLUNf8MRYcAiFuRsOC+gE/0K6xavo2h3
         5hFTmRmjg4OyO1ohcTscEBj5gtpw9AePPl80XTyyUdM1nnzKqCSZy6n3n4ITtQqcRcI2
         Xet9turyv/9SmWVDkn/VRXE2VIiHQja2aV6daS2E2I5W8J2LHhM4rZn24iivWMPqXL8B
         WmbMFQV6oft6pXLXw880Wlq9GudX37YM+Z4zEmGRnPX3qEOWiT0A1LVzxCmKapdmjIGS
         ikUg==
X-Gm-Message-State: AFqh2kr89ePSnUMIYZyq3cyZlyH3rLFiW7cWnCeOM0DkS1pE8jEiNP3I
        b+22hpifkhLEEDdSY8bdURH1bD/SKFVaSyKN4K+lSzfL6fAJ
X-Google-Smtp-Source: AMrXdXuBHqH78nVaV84wwbLsXQ7Y5s6G9Lb6PRlp7Xhzk5VFoOYq6TNp9zYUmoJldNh/EjXY5JXxqwyMujbzdzPa2h5p6rUHCc8+
MIME-Version: 1.0
X-Received: by 2002:a02:7352:0:b0:375:bc14:b202 with SMTP id
 a18-20020a027352000000b00375bc14b202mr4230956jae.244.1673279257349; Mon, 09
 Jan 2023 07:47:37 -0800 (PST)
Date:   Mon, 09 Jan 2023 07:47:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000be991505f1d6afb3@google.com>
Subject: [syzbot] [reiserfs?] BUG: unable to handle kernel paging request in reiserfs_lookup
From:   syzbot <syzbot+a99186f624245fd88b94@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org,
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

HEAD commit:    247f34f7b803 Linux 6.1-rc2
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1619246e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fa9bed8d6a8992a0
dashboard link: https://syzkaller.appspot.com/bug?extid=a99186f624245fd88b94
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/05f9a7fca332/disk-247f34f7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ec50c3ad7d48/vmlinux-247f34f7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1446f94b11ed/Image-247f34f7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a99186f624245fd88b94@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address ffff80000d2e2c80
Mem abort info:
  ESR = 0x0000000096000047
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x07: level 3 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000047
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c54db000
[ffff80000d2e2c80] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=100000023fffa003, pte=0000000000000000
Internal error: Oops: 0000000096000047 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 21788 Comm: syz-executor.3 Not tainted 6.1.0-rc2-syzkaller-154433-g247f34f7b803 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:474
lr : queued_spin_lock_slowpath+0x114/0x394 kernel/locking/qspinlock.c:405
sp : ffff80001400b850
x29: ffff80001400b850 x28: ffff80000eec9000 x27: ffff80000cbb6d47
x26: 0000000000000000 x25: 0000000000000000 x24: ffff0001fefefc80
x23: 0000000000000000 x22: ffff80000d37d050 x21: ffff80000d2e2c80
x20: 0000000000000001 x19: ffff00011e189430 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000001fb8 x12: 0000000000000000
x11: ffff80000d2e2c80 x10: 0000000000080000 x9 : ffff0001fefefc88
x8 : ffff0001fefefc80 x7 : 0000000000000000 x6 : ffff80000c08f3c8
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000001 x1 : ffff80000ce889e3 x0 : 0000000000000001
Call trace:
 decode_tail kernel/locking/qspinlock.c:131 [inline]
 queued_spin_lock_slowpath+0x198/0x394 kernel/locking/qspinlock.c:471
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x10c/0x110 kernel/locking/spinlock_debug.c:115
 __raw_spin_lock include/linux/spinlock_api_smp.h:134 [inline]
 _raw_spin_lock+0x5c/0x6c kernel/locking/spinlock.c:154
 __mutex_lock_common+0x2a4/0xca8 kernel/locking/mutex.c:617
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
 reiserfs_write_lock+0x3c/0x64 fs/reiserfs/lock.c:27
 reiserfs_lookup+0xa4/0x1c4 fs/reiserfs/namei.c:364
 lookup_open fs/namei.c:3391 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x738/0x11c4 fs/namei.c:3710
 do_filp_open+0xdc/0x1b8 fs/namei.c:3740
 do_sys_openat2+0xb8/0x22c fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1337
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
Code: 8b2c4ecc f85f818c 1200056b 8b2b52ab (f82b6988) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	8b2c4ecc 	add	x12, x22, w12, uxtw #3
   4:	f85f818c 	ldur	x12, [x12, #-8]
   8:	1200056b 	and	w11, w11, #0x3
   c:	8b2b52ab 	add	x11, x21, w11, uxtw #4
* 10:	f82b6988 	str	x8, [x12, x11] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
