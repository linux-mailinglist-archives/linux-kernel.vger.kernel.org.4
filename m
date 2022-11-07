Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3464A61FE75
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 20:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiKGTSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 14:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiKGTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 14:18:49 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A2CBC35
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 11:18:48 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id a14-20020a921a0e000000b003016bfa7e50so5979357ila.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 11:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gg/UCarDh9+dRiRunfPkWuPjPS/0+We/i/fm43kZUC8=;
        b=I6p3U23/meen9lllETOaFh+A6akXmKX9JSaxygfMDvho0KB0OShf4qFuOQSMx3QHo5
         POAnWUmZRpGIOjdwTUtuJMDvkJvXoDw2pczGmniizkp5cZC+Fje94TCvy9kPAdB3HvgX
         urzbzBCBJv76DvIFaWyeIHv1vwJyeYXDhG1rPmYk1eThkIh+Vjk6yh/sK+7kFmznEOwe
         bReWxl1CF8bpveWg9dCIjYZNBQjrnVaPhPfzwm4Wc5jLYC3s8XV/zsCi/INMi9sN1+n0
         z1HRqmmDH2lQWddzO9B2V38O2ECBg+qGN9ZXtvSB0yf/RoE3jw9kgICwE4FBCzaGc4c5
         apEw==
X-Gm-Message-State: ACrzQf3/LpwZ6vARjRxw/+MssI4TSfSmWSYmZX3b7Qiy26NGAjPoFrY9
        X92V2st3Qq/z/rMvcIbuWgyYw8FCGJL5prdCfchQnDsV/i7C
X-Google-Smtp-Source: AMsMyM5gNrWYK/a3oU9CFNb2l9gTCkObqjT46AuxYQipKgwSseallttSfgtuls966YkBAU9+JRgDBbdmoS31OnzffrUi8ehAKloh
MIME-Version: 1.0
X-Received: by 2002:a6b:be85:0:b0:6bc:f0aa:3a13 with SMTP id
 o127-20020a6bbe85000000b006bcf0aa3a13mr617546iof.177.1667848727713; Mon, 07
 Nov 2022 11:18:47 -0800 (PST)
Date:   Mon, 07 Nov 2022 11:18:47 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4619905ece64a41@google.com>
Subject: [syzbot] BUG: unable to handle kernel paging request in nilfs_mdt_fetch_dirty
From:   syzbot <syzbot+b107db66f49c5e2a911f@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=106158fe880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=b107db66f49c5e2a911f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b107db66f49c5e2a911f@syzkaller.appspotmail.com

Unable to handle kernel paging request at virtual address fffffffffffffeb8
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004
  CM = 0, WnR = 0
swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566b000
[fffffffffffffeb8] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 7614 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : nilfs_mdt_fetch_dirty+0x1c/0x94 fs/nilfs2/mdt.c:394
lr : nilfs_mdt_fetch_dirty+0x18/0x94 fs/nilfs2/mdt.c:391
sp : ffff80001f553cc0
x29: ffff80001f553cc0 x28: 0000000000000000 x27: 0000000000000000
x26: 0000000000000001 x25: ffff00011b0cc800 x24: ffff00011b0cc800
x23: 0000000000000001 x22: 0000000000000001 x21: ffff00011b0cc800
x20: ffff00011b198900 x19: 0000000000000000 x18: 0000000000000107
x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff00012640cf80
x14: 0000000000000008 x13: 00000000ffffffff x12: ffff00012640cf80
x11: ff80800008f55b48 x10: 0000000000000000 x9 : ffff800008f55b48
x8 : fffffffffffffeb8 x7 : ffff8000082160c0 x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000006 x1 : ffff00011b198900 x0 : 0000000000000000
Call trace:
 nilfs_mdt_fetch_dirty+0x1c/0x94 fs/nilfs2/mdt.c:394
 nilfs_test_metadata_dirty+0x2c/0x148 fs/nilfs2/segment.c:813
 nilfs_segctor_confirm+0x30/0x1a8 fs/nilfs2/segment.c:837
 nilfs_segctor_construct+0x78/0x380 fs/nilfs2/segment.c:2374
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 910003fd aa0003f3 97cd2834 d1052268 (f9400100) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	910003fd 	mov	x29, sp
   4:	aa0003f3 	mov	x19, x0
   8:	97cd2834 	bl	0xffffffffff34a0d8
   c:	d1052268 	sub	x8, x19, #0x148
* 10:	f9400100 	ldr	x0, [x8] <-- trapping instruction


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
