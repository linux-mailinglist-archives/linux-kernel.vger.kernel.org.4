Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D74D5FA195
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJJQHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbiJJQHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:07:39 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4566E27CE4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:07:38 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id y13-20020a056e021bed00b002faba3c4afbso6814861ilv.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JfzesporW3/wV2SjF9C/3yeWXgu8SD7CLNHBasWr2M=;
        b=zshwyktoMCMx2YLLKTzBU3BrM7nCAt4H+e8Gft1CecX8921ZUDiGoaA7bVgbcFO2q6
         AIzoYl9w9YTMIOfstKmIBDtGCTs0RXKOUp5nGTMy3l/slUwwkJvolmvThfye7teivbAw
         zSudCgh21smq3JZnSka9h3iDasnHfkiOAuEV7AkOYUDGg/Q++Sevc7GAX43n56g/2KFA
         GQBYK2SMRd22Z16i3TguDLlb+W4XZm2BSxXbIfDtNwyBW4tw3GINO/BT+P8I1I+sAoOv
         kaNU/YnKRJNFvcciv8oxrDomtIAe04GeQ4ckB/ld1D+Sx7F5pWUxhq/4VgKo83Y/nNJv
         ev8Q==
X-Gm-Message-State: ACrzQf34tjFM1o+/jCjlQIDbyiB//0ct9RSs0Ovg4Bh3FS6blrOcOQng
        CIK72bcIAagMX4sIMIpbUdl+vCa55sjQoKogdTgaPSK/zyMI
X-Google-Smtp-Source: AMsMyM7ssHdf16GamXtUfRxFDrf884xxM3HU/9YWBjJ/x6r4QH1Z7QtfrQOEPuVICc/Czt9Wc8UMHz1lvSddhJ48pY+0Tt61tJZJ
MIME-Version: 1.0
X-Received: by 2002:a05:6638:419c:b0:363:c0fb:3a64 with SMTP id
 az28-20020a056638419c00b00363c0fb3a64mr1720540jab.193.1665418057564; Mon, 10
 Oct 2022 09:07:37 -0700 (PDT)
Date:   Mon, 10 Oct 2022 09:07:37 -0700
In-Reply-To: <000000000000b9fad405b179289b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b94e9e05eab05b00@google.com>
Subject: Re: [syzbot] WARNING in udf_truncate_extents
From:   syzbot <syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, bvanassche@acm.org, chaitanya.kulkarni@wdc.com,
        jack@suse.com, linux-kernel@vger.kernel.org,
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    4899a36f91a9 Merge tag 'powerpc-6.1-1' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10260ea4880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e2021a61197ebe02
dashboard link: https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=154bdf0a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1548ca78880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a98722ff83f/disk-4899a36f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a31d6690395/vmlinux-4899a36f.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/a6d9d98c8bd8/mount_0.gz

The issue was bisected to:

commit 2004bfdef945fe55196db6b9cdf321fbc75bb0de
Author: Bart Van Assche <bvanassche@acm.org>
Date:   Tue Mar 10 04:26:21 2020 +0000

    null_blk: Fix the null_add_dev() error path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10110920500000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12110920500000
console output: https://syzkaller.appspot.com/x/log.txt?x=14110920500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+43fc5ba6dcb33e3261ca@syzkaller.appspotmail.com
Fixes: 2004bfdef945 ("null_blk: Fix the null_add_dev() error path")

loop0: detected capacity change from 0 to 2048
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3622 at fs/udf/truncate.c:226 udf_truncate_extents+0x844/0x930 fs/udf/truncate.c:226
Modules linked in:
CPU: 1 PID: 3622 Comm: syz-executor198 Not tainted 6.0.0-syzkaller-09413-g4899a36f91a9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:udf_truncate_extents+0x844/0x930 fs/udf/truncate.c:226
Code: 84 d2 74 05 e8 bd db f2 fe 8b 44 24 20 be 07 00 00 00 48 89 df 89 83 cc fe ff ff e8 56 ec 0d ff e9 a5 fd ff ff e8 0c c5 a5 fe <0f> 0b e9 1f fe ff ff e8 00 c5 a5 fe 0f 0b 48 8b 7c 24 18 e8 24 db
RSP: 0018:ffffc900040ef9d8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88806fc3d4a0 RCX: 0000000000000000
RDX: ffff88801dc10000 RSI: ffffffff82d58224 RDI: 0000000000000007
RBP: ffffc900040efac0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000200 R11: 000000000008c07c R12: ffffc900040efa80
R13: 0000000000000200 R14: 00000000000000ff R15: ffff88807e738000
FS:  000055555697f300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000e000 CR3: 000000001bebe000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 udf_write_failed.isra.0+0x173/0x1c0 fs/udf/inode.c:179
 udf_write_begin+0x7f/0xa0 fs/udf/inode.c:214
 generic_perform_write+0x246/0x560 mm/filemap.c:3745
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3873
 udf_file_write_iter+0x2cc/0x650 fs/udf/file.c:170
 call_write_iter include/linux/fs.h:2190 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9e9/0xdd0 fs/read_write.c:584
 ksys_write+0x127/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f305ad3c8f9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2d740688 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000200001c0 RCX: 00007f305ad3c8f9
RDX: 000000000208e24b RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff2d7406b0 R09: 00007fff2d7406b0
R10: 00007fff2d740560 R11: 0000000000000246 R12: 00007fff2d7406ac
R13: 00007fff2d7406e0 R14: 00007fff2d7406c0 R15: 0000000000000009
 </TASK>

