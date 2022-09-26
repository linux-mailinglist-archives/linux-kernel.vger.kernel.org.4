Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1575EAE2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiIZR1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIZR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:27:03 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A4888DF4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:44:20 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l84-20020a6b3e57000000b006a3fe90910cso4195250ioa.16
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=FumbOg+JcncIGCJQRNizH4tnnnZo6vkbC6rkl+XBVqE=;
        b=DLSbjbq9T7kEq503DFVCTbzDjgdXADGM5ZqZF5evmi5cSVbIPXl3gWqhMXvVysXTsg
         7xN6Gvgz1adef/Obo/fzCmrbpuJ9BZPB29ebpUHtrlmg2JONuYSQJi0r7yWJqkY3qeKB
         TadPpT2J9YB4jy51HHKLV00lEsZjx7mCcCaRD1DkSrh4Kb1E9Z50OkKoDOR+9O5WS5Z7
         00MtQJc04oqWxc4XRFXGxVnJ7eV0LYHTKfnVv52uywd3h0sVLwziS2f8mFwmaV49ZU37
         eYX27OBNrQRkMs6szSlZX5eeYELO0wRDexbZr4o5C35AXB1c/G3MtA+zs6FFIBvWxxI/
         VP+w==
X-Gm-Message-State: ACrzQf021KKfUtieS/jPyDDgSQQn7Rq0MC0OtEWDsWCCxxuQun1g0qyP
        JwJ7FI5Iud2koozZJAnM+LpZ+dWVO/DznAHC672HcroeudfG
X-Google-Smtp-Source: AMsMyM7WRtWPZvMG8IYjaC9SdYEugfg2Ng41Rt00zONGbxHQCU/0AEcSpSUVc4tJnkkfkUGwdIyj3Nz7urhr75w5E9vutZEDHQZp
MIME-Version: 1.0
X-Received: by 2002:a92:c08a:0:b0:2f8:402f:ee9 with SMTP id
 h10-20020a92c08a000000b002f8402f0ee9mr3710131ile.61.1664210622617; Mon, 26
 Sep 2022 09:43:42 -0700 (PDT)
Date:   Mon, 26 Sep 2022 09:43:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fe202005e9973a6b@google.com>
Subject: [syzbot] Unable to handle kernel write to read-only memory at virtual
 address ADDR
From:   syzbot <syzbot+9831d4affe35bb65b891@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, syzkaller-bugs@googlegroups.com
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
console output: https://syzkaller.appspot.com/x/log.txt?x=144f9ca8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=15a770deac0c935a
dashboard link: https://syzkaller.appspot.com/bug?extid=9831d4affe35bb65b891
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d8f5c4880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164dc2a8880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d8ae425e7fa/disk-c194837e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c540d501ebe7/vmlinux-c194837e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9831d4affe35bb65b891@syzkaller.appspotmail.com

Unable to handle kernel write to read-only memory at virtual address ffff80000cb9e7b5
Mem abort info:
  ESR = 0x000000009600004e
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x0e: level 2 permission fault
Data abort info:
  ISV = 0, ISS = 0x0000004e
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566a000
[ffff80000cb9e7b5] pgd=100000023ffff003, p4d=100000023ffff003, pud=100000023fffe003, pmd=00600001c5000781
Internal error: Oops: 000000009600004e [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 2561 Comm: udevd Not tainted 6.0.0-rc6-syzkaller-17742-gc194837ebb57 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __memset+0x50/0x188
lr : slab_post_alloc_hook mm/slab.h:729 [inline]
lr : slab_alloc_node mm/slub.c:3243 [inline]
lr : __kmalloc_node_track_caller+0x2bc/0x3bc mm/slub.c:4955
sp : ffff800016a33920
x29: ffff800016a33930 x28: ffff0000c9534f80 x27: 0000000000000000
x26: 000000000fffffff x25: ffff80000cb9e7b5 x24: 0000000000000000
x23: ffff0000c0001400 x22: ffff8000096b34f4 x21: 0000000000000200
x20: 0000000000082cc0 x19: 00000000ffffffff x18: 0000000000000000
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff0000c9534f80
x14: 0000000000000010 x13: 0000000000000000 x12: ffff0000c9534f80
x11: 0000000000000001 x10: ffff80000d309000 x9 : 0000000000080800
x8 : ffff80000cb9e7b5 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 000000000000000b x3 : 000000000002b678
x2 : 0000000000000200 x1 : 0000000000000000 x0 : ffff80000cb9e7b5
Call trace:
 __memset+0x50/0x188
 kmalloc_reserve net/core/skbuff.c:362 [inline]
 __alloc_skb+0x198/0x378 net/core/skbuff.c:434
 alloc_skb include/linux/skbuff.h:1257 [inline]
 alloc_uevent_skb+0x5c/0xd8 lib/kobject_uevent.c:290
 uevent_net_broadcast_untagged+0xa0/0x1cc lib/kobject_uevent.c:326
 kobject_uevent_net_broadcast+0x14c/0x1f8 lib/kobject_uevent.c:409
 kobject_uevent_env+0x428/0x5ec lib/kobject_uevent.c:593
 kobject_synth_uevent+0x354/0x6a4 lib/kobject_uevent.c:208
 uevent_store+0x34/0x80 drivers/base/core.c:2509
 dev_attr_store+0x4c/0x70 drivers/base/core.c:2211
 sysfs_kf_write+0xf4/0x11c fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x1e4/0x294 fs/kernfs/file.c:354
 call_write_iter include/linux/fs.h:2187 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x2dc/0x46c fs/read_write.c:578
 ksys_write+0xb4/0x160 fs/read_write.c:631
 __do_sys_write fs/read_write.c:643 [inline]
 __se_sys_write fs/read_write.c:640 [inline]
 __arm64_sys_write+0x24/0x34 fs/read_write.c:640
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190
Code: d65f03c0 cb0803e4 f2400c84 54000080 (a9001d07) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	d65f03c0 	ret
   4:	cb0803e4 	neg	x4, x8
   8:	f2400c84 	ands	x4, x4, #0xf
   c:	54000080 	b.eq	0x1c  // b.none
* 10:	a9001d07 	stp	x7, x7, [x8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
