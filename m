Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E364C5EFEC8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiI2Ulv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 16:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiI2Uls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 16:41:48 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24869C9965
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:41:47 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id f4-20020a056e020b4400b002f6681cca5bso1996764ilu.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 13:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=iXQk2tj4dtqq9gxh1uWeljXov6YC8nHDVx/k2gzE7CU=;
        b=CXSSTqqICA2jwPN1xyTiJjsngptKPTXJI5IJdVYmfuzragFw+MOAa3DFC+1JXupUHH
         fHS5W0c3Y8pusKGExKkLtDMeEDSb5AzTjfC28IO07P6TNXmAXrmg7aN/q8zYxc278hxd
         Gs2/1GNKT8u+S53N6UYxKYRcrtIab8srg95T3M+qu8yuXY28GEzCH4dJRmgb0CXs7iAw
         pnRyFGPwtj2ueNGEl0VqocUtr+clKlueSFHlsugHUrHRLjrqZq1TY68zBdM9C7GbN06U
         hFW70JLS8Bzkh6dkdDYzSWibPNamY0W59Ldt573qJIkv9DGbv7crUmj6XLGUEXhrACXH
         eUGw==
X-Gm-Message-State: ACrzQf22wQaiq9H5ASb5vbI/v0rhA8gdaLwnLlH8Ic7UPprrPmHbiUko
        /oPHB3ZyCr0zOkgA9d1GwoVqMAnPS3QWGuo2qbkWsQvp4fun
X-Google-Smtp-Source: AMsMyM6iMY4PiMZ5C/1SXFdgfTnpnblnXD3Xt7uTmvzO0e+8i47Fh13NqejLuQPddeNYb+AdYrAGSPhvb4U5QqVpLzzNLENK7hhL
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1449:b0:35a:70ce:8a3f with SMTP id
 l9-20020a056638144900b0035a70ce8a3fmr2805455jad.42.1664484106514; Thu, 29 Sep
 2022 13:41:46 -0700 (PDT)
Date:   Thu, 29 Sep 2022 13:41:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7579c05e9d6e701@google.com>
Subject: [syzbot] WARNING in btrfs_fileattr_set
From:   syzbot <syzbot+5244d35be7f589cf093e@syzkaller.appspotmail.com>
To:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
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

HEAD commit:    49c13ed0316d Merge tag 'soc-fixes-6.0-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129847ff080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=5244d35be7f589cf093e
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/418654aab051/disk-49c13ed0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/49c501fc7ae3/vmlinux-49c13ed0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5244d35be7f589cf093e@syzkaller.appspotmail.com

WARNING: CPU: 0 PID: 29090 at fs/btrfs/ioctl.c:367 btrfs_fileattr_set+0xae4/0xbd0 fs/btrfs/ioctl.c:367
Modules linked in:
CPU: 0 PID: 29090 Comm: syz-executor.0 Not tainted 6.0.0-rc7-syzkaller-00068-g49c13ed0316d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:btrfs_fileattr_set+0xae4/0xbd0 fs/btrfs/ioctl.c:367
Code: 48 8b 3b 48 c7 c6 60 7c db 8a 89 ea 31 c0 e8 ea 4d 91 06 eb 17 e8 cc 14 f8 fd 48 c7 c7 60 7b db 8a 89 ee 31 c0 e8 9c a1 c0 fd <0f> 0b 48 8b 1c 24 48 89 df 48 c7 c6 e0 7b db 8a ba 6f 01 00 00 89
RSP: 0018:ffffc9000eea7928 EFLAGS: 00010246
RAX: 69a2f0c0e6d18a00 RBX: ffff888052ecdf68 RCX: 0000000000040000
RDX: ffffc90003b21000 RSI: 0000000000003915 RDI: 0000000000003916
RBP: 00000000fffffff4 R08: ffffffff816bd38d R09: ffffed1017344f14
R10: ffffed1017344f14 R11: 1ffff11017344f13 R12: 1ffff1100a5d9bed
R13: ffff88806b300001 R14: ffff88805581ac00 R15: 00000000fffffff4
FS:  00007fa5d5c51700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557a8f4c12f0 CR3: 000000007533c000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 vfs_fileattr_set+0x8be/0xd20 fs/ioctl.c:696
 ioctl_setflags fs/ioctl.c:728 [inline]
 do_vfs_ioctl+0x1d26/0x29a0 fs/ioctl.c:839
 __do_sys_ioctl fs/ioctl.c:868 [inline]
 __se_sys_ioctl+0x83/0x170 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa5d4a8a5a9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa5d5c51168 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa5d4babf80 RCX: 00007fa5d4a8a5a9
RDX: 0000000020000000 RSI: 0000000040086602 RDI: 0000000000000003
RBP: 00007fa5d5c511d0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff74cf8e8f R14: 00007fa5d5c51300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
