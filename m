Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4B5F247C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiJBSIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 14:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJBSIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 14:08:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5E2399FA
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 11:08:44 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id n16-20020a6b5910000000b006a3570db9a5so5683847iob.23
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 11:08:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=0SaUqsDcZKozmWwBlE5zdA1339u9LhJ2gmtJd2haGuw=;
        b=FHwjv8R2WwY19ysKOUUAdDM0Gp/QKPq8Qso75ySXuT+5X8DFJtR2v3S5BlByoK7e8o
         BhCNOsGXINt+W8OmxNr7Xw4QPGODlwlB3fvhrqkrD2nhVyKIhyJZQRSKQy6Q5xJbiZ+R
         Z3sL6zPVFCmAMw/wutD5NWv98HJcXE2fvC4So5Pvdcs8SIB1kqljC+RwUg9ydNnoHwaH
         JlDCHQoWhY6bhoN9PhPTa/MZEP67yyJYtgZFBrqW3yzov1Yuj4KexKY/NNvNEAwqJS7d
         IRqHr/ckV20gcfSleIKL/W9AcYE+wUwbcrb4WeOLCMOvafehaClvQVX2ZONHiZpzmRhe
         geLg==
X-Gm-Message-State: ACrzQf3VnKuAHK2sw1uUv0G591ZvPz9nWeCRAFzQcT9ZcMVWYEMcfMNb
        bqKbvo751rIcPBeyZdwwRNuHYaTlavYZHi6h110NVAcvnYLl
X-Google-Smtp-Source: AMsMyM6MyFKS85AfyCFtnmN93TR/C6cvQPLpVOLmIGTYC/OiXxVOX8E8iUJRZmORgKmfsA8q+bFkHx1K5DrYVUbyXxPFd9sg00pK
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a3:b0:35a:3f2d:a21c with SMTP id
 m35-20020a05663840a300b0035a3f2da21cmr8626469jam.221.1664734123744; Sun, 02
 Oct 2022 11:08:43 -0700 (PDT)
Date:   Sun, 02 Oct 2022 11:08:43 -0700
In-Reply-To: <00000000000050314505d3429981@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017657505ea111e44@google.com>
Subject: Re: [syzbot] kernel BUG in lbmIODone
From:   syzbot <syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com>
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

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=17935e48880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=52ddb6c83a04ca55f975
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=111ad268880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+52ddb6c83a04ca55f975@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_logmgr.c:2298 assert(bp->l_flag & lbmRELEASE)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_logmgr.c:2298!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 14 Comm: ksoftirqd/0 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lbmIODone+0x2ec/0x340 fs/jfs/jfs_logmgr.c:2298
lr : lbmIODone+0x2ec/0x340 fs/jfs/jfs_logmgr.c:2298
sp : ffff80000f22bc20
x29: ffff80000f22bc20 x28: ffff80000d2609e0 x27: 000000000000000a
x26: 0000000000000001 x25: 0000000000000000 x24: 0000000000000020
x23: 0000000000000000 x22: ffff0000d0968c00 x21: 0000000000000020
x20: 0000000000000000 x19: ffff0000d0b7d600 x18: 00000000000000c0
x17: ffff80000dd0b198 x16: ffff80000db49158 x15: ffff0000c02d9a80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c02d9a80
x11: ff808000081c0d5c x10: 0000000000000000 x9 : f6a2b00d81307a00
x8 : f6a2b00d81307a00 x7 : ffff80000819545c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefbecd0 x1 : 0000000100000101 x0 : 000000000000003f
Call trace:
 lbmIODone+0x2ec/0x340 fs/jfs/jfs_logmgr.c:2298
 bio_endio+0x28c/0x2d8 block/bio.c:1564
 req_bio_endio block/blk-mq.c:695 [inline]
 blk_update_request+0x25c/0x570 block/blk-mq.c:825
 blk_mq_end_request+0x2c/0x58 block/blk-mq.c:951
 lo_complete_rq+0xb8/0x138 drivers/block/loop.c:370
 blk_complete_reqs block/blk-mq.c:1022 [inline]
 blk_done_softirq+0x70/0xa0 block/blk-mq.c:1027
 _stext+0x168/0x37c
 run_ksoftirqd+0x4c/0x21c kernel/softirq.c:934
 smpboot_thread_fn+0x248/0x3e4 kernel/smpboot.c:164
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 9137e821 91101063 52811f42 94c93ef6 (d4210000) 
---[ end trace 0000000000000000 ]---

