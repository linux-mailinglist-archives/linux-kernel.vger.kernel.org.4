Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5ECA5EC1C8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiI0LqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiI0Lp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:45:58 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA1D870B0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:56 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id i13-20020a056e02152d00b002f58aea654fso7383593ilu.20
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=h+iHkPEp4LDNj1sNMEpHHrPze+HZAs8SDQcDer8eELE=;
        b=Yaf3WPg4szpXmBSNm2Gi4/17s4XwHK9VcdOHAgD1AeJFsoe1xcN5FBc81ARHRZtVet
         9xPkDIUa9eJtA9bPJsCxw3hk6kqqegVIWK5AUpasfpsHylKv4EZLrwX6Y6vflmv2RLmC
         8om4sPrxMvJ/GCWcsMQLpxDwPVEU9oyHQ7HolKmfs/cXAhvRpa34/q+bX7U6AGCwX1JR
         ibrP5ZoiPrkGuuoBit7JYJEN8O25x5IY4ixs28BddCF6LFy5vwHcU55lWm/zX+qi6bpZ
         ZzmhWhA3wV082LUFCfVHVibjLsz0mdXCFvtBZelJx1raoTiRw7qEwLi3ChA+BQFUWyR8
         QLkw==
X-Gm-Message-State: ACrzQf0loLzV/KoS3PxqYeKC/+1Asqpan4MfusWg/mtyAoSsw17QJe3x
        nGxuFH0ggBil93FCpckieV/tt/lXF8gfl3yXqo9KgyW7SrRj
X-Google-Smtp-Source: AMsMyM4T4WPi+R0+KzCVz6PRWCEJLTjr0gy8kdSIelisdHPpfOlqiE/pVmsODa650VtW+YVJogDgJHbZXKA+eBK1KQtbGMNOCDuS
MIME-Version: 1.0
X-Received: by 2002:a05:6602:26d2:b0:6a3:f044:a942 with SMTP id
 g18-20020a05660226d200b006a3f044a942mr11137420ioo.50.1664279156077; Tue, 27
 Sep 2022 04:45:56 -0700 (PDT)
Date:   Tue, 27 Sep 2022 04:45:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7bc4505e9a72fab@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in diAlloc
From:   syzbot <syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com>
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

HEAD commit:    f76349cf4145 Linux 6.0-rc7
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=11b538a8880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=79d792676d8ac050949f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15fcb718880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b6f84c880000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+79d792676d8ac050949f@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 65535
================================================================================
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:1359:19
index -1 is out of range for type 'atomic_t [128]'
CPU: 1 PID: 3614 Comm: syz-executor361 Not tainted 6.0.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x28e lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:151 [inline]
 __ubsan_handle_out_of_bounds+0xdb/0x130 lib/ubsan.c:283
 diAlloc+0x1434/0x1700 fs/jfs/jfs_imap.c:1359
 ialloc+0x8c/0xa80 fs/jfs/jfs_inode.c:56
 jfs_create+0x13a/0xb10 fs/jfs/namei.c:92
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12d0/0x2df0 fs/namei.c:3688
 do_filp_open+0x264/0x4f0 fs/namei.c:3718
 do_sys_openat2+0x124/0x4e0 fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_open fs/open.c:1337 [inline]
 __se_sys_open fs/open.c:1333 [inline]
 __x64_sys_open+0x221/0x270 fs/open.c:1333
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc66ba13fc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffda59a6f18 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc66ba13fc9
RDX: 0000000000000000 RSI: 00000000000000f0 RDI: 0000000020000140
RBP: 00007fc66b9d3790 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffda59a6de0 R11: 0000000000000246 R12: 00000000f8008000
R13: 0000000000000000 R14: 00083878000000f8 R15: 0000000000000000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
