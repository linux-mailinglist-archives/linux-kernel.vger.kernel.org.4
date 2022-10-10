Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9565F9A23
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 09:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiJJHkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 03:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiJJHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 03:40:14 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB806715C
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:40 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id e15-20020a5d8acf000000b006a3ed059e49so6857528iot.14
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 00:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvGLK7BFZQXPO6UYsdQpXLwU9WtlibEyuFOmtYBinVY=;
        b=arFuJOIoGg/QiBaQpeRePf1m2r99Eh0HYb2zco1y7jdzg4BA14M7y5v8WM6AbNrsVh
         FUscnAb0YlXjc9iX+FvQugAMmg/j1iH+BSBiOsPOuhqzaje1xglRvUe8Pn/5k236qzL1
         XYOy6ubcAulc3fKg2BEMfrP0DXAv7K0+sbVGeS6Nz0iCIDSOiGdujAWBdrXD7wp/nCjt
         ly5WgE4FvHwvur91D9SlP348hXRe3CWma2hsau0lvbZ28XQwNXETwzY7ttr+3GTupYDA
         BdA346o3WzaC1GxilXHR169OKYgM5Z1bgK2JnMnIcnndfR86AGxlvhIu5ciX3JTEvL25
         +9MQ==
X-Gm-Message-State: ACrzQf1Cvy7vp5Sg0jvRetifNsQBXK0hmfzeQHkY1lMg0oqlHGGXqV8k
        uGK1lQ/Sip1Ax50EB81Hc0sFyvw7KR9Xe52MsfBSC3ObuTl2
X-Google-Smtp-Source: AMsMyM6hqCOvQYCJV54FsKZr5AJtxoj59WwbeeasWEouPpt1+Dodib9ZlQ/xn7sp7yH9p+I0hrDCERwWT9lVEE/MaPBCLGnpghEX
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:15c9:b0:2da:c33e:49c7 with SMTP id
 q9-20020a056e0215c900b002dac33e49c7mr8468301ilu.26.1665387339440; Mon, 10 Oct
 2022 00:35:39 -0700 (PDT)
Date:   Mon, 10 Oct 2022 00:35:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7e7be05eaa93401@google.com>
Subject: [syzbot] KASAN: use-after-free Read in dbJoin
From:   syzbot <syzbot+667a6d667592227b1452@syzkaller.appspotmail.com>
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

HEAD commit:    aaa11ce2ffc8 Add linux-next specific files for 20220923
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10a9b134880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=186d1ff305f10294
dashboard link: https://syzkaller.appspot.com/bug?extid=667a6d667592227b1452
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/95c7bf83c07e/disk-aaa11ce2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b161cd56a7a3/vmlinux-aaa11ce2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+667a6d667592227b1452@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in dbJoin+0x23b/0x240 fs/jfs/jfs_dmap.c:2772
Read of size 1 at addr ffff88817cbdfa4c by task jfsCommit/123

CPU: 0 PID: 123 Comm: jfsCommit Not tainted 6.0.0-rc6-next-20220923-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:284 [inline]
 print_report+0x15e/0x45d mm/kasan/report.c:395
 kasan_report+0xbb/0x1f0 mm/kasan/report.c:495
 dbJoin+0x23b/0x240 fs/jfs/jfs_dmap.c:2772
 dbFreeBits+0x15d/0x8c0 fs/jfs/jfs_dmap.c:2305
 dbFreeDmap+0x61/0x1a0 fs/jfs/jfs_dmap.c:2054
 dbFree+0x250/0x540 fs/jfs/jfs_dmap.c:379
 txFreeMap+0x8f1/0xd70 fs/jfs/jfs_txnmgr.c:2529
 txUpdateMap+0x3cd/0xc50 fs/jfs/jfs_txnmgr.c:2325
 txLazyCommit fs/jfs/jfs_txnmgr.c:2659 [inline]
 jfs_lazycommit+0x5bb/0xaa0 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>

The buggy address belongs to the physical page:
page:ffffea0005f2f7c0 refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x17cbdf
flags: 0x57ff00000000000(node=1|zone=2|lastcpupid=0x7ff)
raw: 057ff00000000000 ffffea0005f2f7c8 ffffea0005f2f7c8 0000000000000000
raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffff88817cbdf900: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88817cbdf980: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff88817cbdfa00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                              ^
 ffff88817cbdfa80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff88817cbdfb00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
