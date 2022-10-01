Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCEB5F1CC0
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiJAO1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 10:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJAO1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 10:27:44 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3C8474C1
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:27:41 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id 23-20020a5ea517000000b006a496fee582so4443844iog.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 07:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ddyCZwJ1xLS8fRq1A9rfvPXjQ5bkJN6QtLD9WKdESPg=;
        b=75pHFjc1u/Wopiv2B1DlhCrdo0NPMhJU8zRNgOUJGgdaa65mcwWskA8RWoc0k1j9Gd
         ezpLr8WxoeR3pbVoT+TQv+dw+LfvS5aS5NSyPt7CZ4l1NhNiFhKSZDNjyTgxCcNb8xfa
         NAj8KZROZJUXVItZJOsn8AQkciMlK9R72eBmc7iLnLgnDk3Do12fcUu+3FbUBfhHqQJc
         0H2Im0iPmntA8iewFCaioKTl/FxB8G96hoqZCUiyG7qrQrBegZ2sWu4EzAs8dWaASigo
         tLKH3oKl3AMv2tLvE9bnAPbOMLd92LVannaDpSf9AIoDKc1IFKU/mfSbSI5TgmkUVivS
         Nz2g==
X-Gm-Message-State: ACrzQf2fejEvOcsdPZvM1Y2bHTUwfAKtCd7VlZb04eEjeaKA59WJKyiG
        nRmP7AoNU0jVP86l0YsNnL3Zkif1DLNOJ33sRcFnFV3CjzAX
X-Google-Smtp-Source: AMsMyM5je81Hvri1UaRhPXMLRwfIRKA7+mprLc6gcu0qRp4kjoFqw5L9F6lV8ra9FKf9feq6aCIHB7BqSPvlGRJB+7QUZaHmgqie
MIME-Version: 1.0
X-Received: by 2002:a02:c047:0:b0:35a:5fdc:1793 with SMTP id
 u7-20020a02c047000000b0035a5fdc1793mr6820017jam.155.1664634460028; Sat, 01
 Oct 2022 07:27:40 -0700 (PDT)
Date:   Sat, 01 Oct 2022 07:27:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000abc46005e9f9e943@google.com>
Subject: [syzbot] kernel BUG in txUnlock
From:   syzbot <syzbot+a63afa301d1258d09267@syzkaller.appspotmail.com>
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

HEAD commit:    5911b92626df Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=161da2ec880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c50e57f66737/disk-5911b926.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f369b7b837e3/vmlinux-5911b926.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a63afa301d1258d09267@syzkaller.appspotmail.com

BUG at fs/jfs/jfs_txnmgr.c:926 assert(mp->nohomeok > 0)
------------[ cut here ]------------
kernel BUG at fs/jfs/jfs_txnmgr.c:926!
Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 88 Comm: jfsCommit Not tainted 6.0.0-rc7-syzkaller-18098-g5911b92626df #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
lr : txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
sp : ffff80000fb33d30
x29: ffff80000fb33d70 x28: ffff800012222000 x27: 0000000000000008
x26: ffff80000ef36fd0 x25: ffff80000ef37000 x24: ffff0000c289aac8
x23: ffff80000ef37000 x22: 0000000000000048 x21: ffff80000ef36f7c
x20: ffff80000ef36000 x19: 0000000000000000 x18: 0000000000000340
x17: 0000000000000000 x16: ffff80000db49158 x15: ffff0000c104cf80
x14: 0000000000000000 x13: 00000000ffffffff x12: ffff0000c104cf80
x11: ff808000081c0d5c x10: 0000000000000000 x9 : da27545727afe500
x8 : da27545727afe500 x7 : ffff800008161d1c x6 : 0000000000000000
x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
x2 : ffff0001fefddcd0 x1 : 0000000100000000 x0 : 0000000000000037
Call trace:
 txUnlock+0x6f4/0x738 fs/jfs/jfs_txnmgr.c:926
 txLazyCommit fs/jfs/jfs_txnmgr.c:2677 [inline]
 jfs_lazycommit+0x228/0x4c8 fs/jfs/jfs_txnmgr.c:2727
 kthread+0x12c/0x158 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
Code: 9114d021 912fec63 528073c2 94c92d60 (d4210000) 
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
