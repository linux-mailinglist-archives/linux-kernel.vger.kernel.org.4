Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D45607566
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 12:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiJUKvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 06:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUKuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 06:50:54 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C042502BB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:50:47 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id m9-20020a056e021c2900b002fadb905ddcso3233231ilh.18
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7U1sqwK0qgiWwV3vBjnPUoEzYf+gnjLnDUe9Z5mNRg=;
        b=NBBERjswkgn/VBMjuM5v1+MZQ4SQ9kOhExMAINPEoIrSWTuFKdnWX2/wD05YLpErV+
         orNs72WniNs0mzWQU6b55n/WxbR0Xj5o80j5pY/543QcBimKVTnAcpWC19LDMzaQ69pU
         pBl4MZzr+qTkP+kCcpIk/3UGcnGDcSg2R1gL+U/oOa+GcuA07ap15MT6udHVj92vRTrp
         jwmQ4+azlTW1nbiC652NU7i1sasHHrc90gynr8VS/3dUOmCbpVcpYkw2RG6Hbp+Gckln
         +3J5iBPzDa5WNZsPlspkq9uN8g7d6TbsaFD+EuF2p734btUqy7dNOLQu6ASG6OszCjsg
         jWNQ==
X-Gm-Message-State: ACrzQf1XrfIcL0mQwPhp84ClM+Yef9Q00Q1ebwReOGX63X1vP1nNFO8Y
        GJAis2PWRp8+zbZHctqoBcyCXLtEF1tklhkUGFK32kEpn+pU
X-Google-Smtp-Source: AMsMyM6p++tCZH4Ww1eD/ap+IaTSlmeXAMQzK31J3Ua7ZpfRswm6unslYn+/fF8eIKwCQbAskQX6tRyXAILy7FgyYq3dYZYLoq4+
MIME-Version: 1.0
X-Received: by 2002:a05:6638:24d1:b0:363:fa8f:1e2a with SMTP id
 y17-20020a05663824d100b00363fa8f1e2amr15258088jat.99.1666349445843; Fri, 21
 Oct 2022 03:50:45 -0700 (PDT)
Date:   Fri, 21 Oct 2022 03:50:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca93e205eb893680@google.com>
Subject: [syzbot] UBSAN: shift-out-of-bounds in dbFreeBits
From:   syzbot <syzbot+cf96cd135c5e00252e3b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, paskripkin@gmail.com, r33s3n6@gmail.com,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d48f589d294 Add linux-next specific files for 20221021
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=173129e2880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c4b7d600a5739a6
dashboard link: https://syzkaller.appspot.com/bug?extid=cf96cd135c5e00252e3b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0c86bd0b39a0/disk-4d48f589.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/074059d37f1f/vmlinux-4d48f589.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cf96cd135c5e00252e3b@syzkaller.appspotmail.com

================================================================================
UBSAN: shift-out-of-bounds in fs/jfs/jfs_dmap.c:1681:12
shift exponent -256 is negative
CPU: 0 PID: 26587 Comm: syz-executor.3 Not tainted 6.1.0-rc1-next-20221021-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x50 lib/ubsan.c:151
 __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x187 lib/ubsan.c:322
 dbFreeBits.cold-0x5/0x72
 dbAllocAny+0xa4/0x1a0 fs/jfs/jfs_dmap.c:1512
 dbAlloc+0x46d/0xa70 fs/jfs/jfs_dmap.c:869
 extBalloc fs/jfs/jfs_extent.c:321 [inline]
 extAlloc+0x4e7/0xeb0 fs/jfs/jfs_extent.c:122
 jfs_get_block+0x661/0xa90 fs/jfs/inode.c:248
 __block_write_begin_int+0x3b9/0x14b0 fs/buffer.c:1991
 __block_write_begin fs/buffer.c:2041 [inline]
 block_write_begin+0xb5/0x440 fs/buffer.c:2102
 jfs_write_begin+0x2d/0xd0 fs/jfs/inode.c:304
 generic_perform_write+0x252/0x570 mm/filemap.c:3771
 __generic_file_write_iter+0x2aa/0x4d0 mm/filemap.c:3899
 generic_file_write_iter+0xdf/0x350 mm/filemap.c:3931
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_writev+0x1aa/0x630 fs/read_write.c:934
 do_pwritev+0x1b6/0x270 fs/read_write.c:1031
 __do_sys_pwritev2 fs/read_write.c:1090 [inline]
 __se_sys_pwritev2 fs/read_write.c:1081 [inline]
 __x64_sys_pwritev2+0xeb/0x150 fs/read_write.c:1081
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa59e48b5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa59f693168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: ffffffffffffffda RBX: 00007fa59e5abf80 RCX: 00007fa59e48b5a9
RDX: 0000000000000002 RSI: 0000000020003380 RDI: 0000000000000003
RBP: 00007fa59e4e6580 R08: 0000000002000000 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffccdcc3d2f R14: 00007fa59f693300 R15: 0000000000022000
 </TASK>
================================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
