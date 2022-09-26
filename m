Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE4D5EAE07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiIZRUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIZRTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:19:48 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A6FF1D70
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:33:56 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id e9-20020a6b7309000000b006a27af93e45so4168662ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=sH/T/5nf2i+jeNlSqZiHLFAU4DhNiChsnk0LGWVzHxQ=;
        b=mlhvdjLuWU9GrbULD8aVFVtQubFwCK15cBLG2My6eeARHnOBLSnDXIgoBZpyUU28O/
         FX/72LI9EGU+mE+ptgGF0j8Ffqlnm9IYluLKkHz9ozl5yl/umtX+Ov6ReS4Yl9KXuvjQ
         Ir5vYwalePRnszU9FYY9s0c4wFz2tuLdQERf7WoopEbImTS7cGCCl8Hk6YZqldq3VTV0
         E/yHpS0FvPV6+qb1HNW5z8iFgsbQmnkElmZw61R+rQuqqSw+0mnad1eAd8DdsP3MnQh2
         DR9vOBUFfd+3Zw78WsFDAyBKH6cShFInV6n1dPsOHmnKMRSK89gOpy3nr8oBGL6E9LSF
         zEkw==
X-Gm-Message-State: ACrzQf3Oz823PVDsBxXKiQNF/Q7nRgVSe3/dpKD3ytwLm5gQwtUrgJU6
        CTAiJQUW4cxss0kASilvC3Nc3i+6Hk0KEVm6AVyeik76pF4R
X-Google-Smtp-Source: AMsMyM5yhMIxXjeRH2xGVyDxfsCSbKvYLZ0BJ6Tl2N7b8S8v/cZMzyoXx9f0UyI0beRfBt2N4wIibctCF2WQqcVageVxZOX4EulH
MIME-Version: 1.0
X-Received: by 2002:a92:c108:0:b0:2f6:b612:cbb5 with SMTP id
 p8-20020a92c108000000b002f6b612cbb5mr9896021ile.34.1664210026663; Mon, 26 Sep
 2022 09:33:46 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:33:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007898e505e9971783@google.com>
Subject: [syzbot] BUG: unable to handle kernel NULL pointer dereference in dtInsertEntry
From:   syzbot <syzbot+c853277dcbfa2182e9aa@syzkaller.appspotmail.com>
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

HEAD commit:    c194837ebb57 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1271d188880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=c853277dcbfa2182e9aa
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d2d470880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14717b18880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c853277dcbfa2182e9aa@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 65535
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
Mem abort info:
  ESR = 0x0000000096000046
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x06: level 2 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000046
  CM = 0, WnR = 1
user pgtable: 4k pages, 48-bit VAs, pgdp=000000010b4bb000
[0000000000000008] pgd=080000010b405003, p4d=080000010b405003, pud=0800000107ba1003, pmd=0000000000000000
Internal error: Oops: 0000000096000046 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 3064 Comm: syz-executor267 Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : dtInsertEntry+0x470/0x660 fs/jfs/jfs_dtree.c:3708
lr : dtInsertEntry+0x468/0x660 fs/jfs/jfs_dtree.c:3708
sp : ffff80000ff7b820
x29: ffff80000ff7b8a0 x28: ffff0000ca10aed8 x27: ffff0000ca10aef8
x26: 0000000000000000 x25: 000000000000000d x24: 0000000000000001
x23: 0000000000000000 x22: 0000000000000073 x21: 0000000000000006
x20: ffff80000ff7b908 x19: 0000000000000079 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000008000 x12: ffff80000d5335c0
x11: ff80800008d4c768 x10: 0000000000000000 x9 : 0000000000000000
x8 : 00000000000000ff x7 : ffff800008d5cfac x6 : 0000000000000000
x5 : 0000000000000000 x4 : ffff80000ff7b900 x3 : ffff80000ff7b908
x2 : ffff80000ff7b9b0 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 dtInsertEntry+0x470/0x660
 dtInsert+0x21c/0x378 fs/jfs/jfs_dtree.c:886
 jfs_create+0x390/0x488 fs/jfs/namei.c:137
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1311
 do_sys_open fs/open.c:1327 [inline]
 __do_sys_openat fs/open.c:1343 [inline]
 __se_sys_openat fs/open.c:1338 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1338
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: 370800d3 97d54f56 f9400fe9 52801fe8 (39002128) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	370800d3 	tbnz	w19, #1, 0x18
   4:	97d54f56 	bl	0xffffffffff553d5c
   8:	f9400fe9 	ldr	x9, [sp, #24]
   c:	52801fe8 	mov	w8, #0xff                  	// #255
* 10:	39002128 	strb	w8, [x9, #8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
