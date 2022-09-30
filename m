Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D118E5F161D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiI3W1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbiI3W0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:26:47 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1282ED5FC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:45 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id u9-20020a5edd49000000b006a0f03934e9so3679227iop.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 15:26:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ufeonRo4zBtWkmJUhuRWXTQlF3ed18EhL4i+GiuA3/w=;
        b=2sSLKRqoKcB88uLhQUKIubOi3Q5hW14dfNNmbdqGQAvYb2PGvbYlwodoPBxc2M3B9q
         DqyHCgbD0CiaPfzyzjefN3Nq18oWsvC3kJsNxE/jBLxE6ZqoYNRvifl5KoMLCLDJQJIj
         d+1sCkJF9pCwinHku5P5h+ENCK3TJX0cnwiJtHLSG+bg0UD0WD5ETP8FM62rF7Z+Mgex
         V/sLrxBlgzx4tqUXJJA4zfAfTj/NpRTe4+CdkiAqoX3sd8O6khYwCOEDVyiaJVYos6AW
         QcrpZiYecybfH/Stz+Jv3LfxXD/UmOj7ENpfUkMmyqPBcb4fcW5xdEmAVl4UO9MZVFBy
         GCkg==
X-Gm-Message-State: ACrzQf13Jk/tS6h0r4wb8Tn34MvIB4YWcndYVC+EKA9MB6kzavaDuj1V
        DeoF6S/9MEWx5GUxXi3YlS104go+1+5lpXUiurTBRt6bOiCf
X-Google-Smtp-Source: AMsMyM4w4OeguFRwIiiQkoXKm1zyaMN3YbvjaNaMitCQLY0pzKWmIFmevSSqWC+HMiTulvIpc5ysLxVQrjQzJT4TSv6VDWNB38Pa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:194e:b0:2f8:fa94:9da1 with SMTP id
 x14-20020a056e02194e00b002f8fa949da1mr5241269ilu.102.1664576804374; Fri, 30
 Sep 2022 15:26:44 -0700 (PDT)
Date:   Fri, 30 Sep 2022 15:26:44 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002052a505e9ec7d41@google.com>
Subject: [syzbot] WARNING in nilfs_sufile_set_segment_usage
From:   syzbot <syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com>
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

HEAD commit:    987a926c1d8a Merge tag 'pull-fixes' of git://git.kernel.or..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10b2f7df080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba0d23aa7e1ffaf5
dashboard link: https://syzkaller.appspot.com/bug?extid=14e9f834f6ddecece094
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11369198880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14aec750880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f613b00c57b/disk-987a926c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/92e205364bcf/vmlinux-987a926c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+14e9f834f6ddecece094@syzkaller.appspotmail.com

NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP frequency < 30 seconds
------------[ cut here ]------------
WARNING: CPU: 0 PID: 3618 at fs/nilfs2/sufile.c:531 nilfs_sufile_set_segment_usage+0x4d8/0x5c0
Modules linked in:
CPU: 0 PID: 3618 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-00132-g987a926c1d8a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
RIP: 0010:nilfs_sufile_set_segment_usage+0x4d8/0x5c0 fs/nilfs2/sufile.c:531
Code: 25 28 00 00 00 48 3b 84 24 a0 00 00 00 0f 85 fa 00 00 00 44 89 f8 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 68 3b 3d fe <0f> 0b e9 1a fe ff ff e8 5c 3b 3d fe e8 57 38 b6 fd e9 ca fe ff ff
RSP: 0018:ffffc9000394f620 EFLAGS: 00010293
RAX: ffffffff834a4e18 RBX: 0000000000000004 RCX: ffff88802831bb00
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc9000394f710 R08: ffffffff834a4c21 R09: ffffffff83459693
R10: 0000000000000002 R11: ffff88802831bb00 R12: 0000000000000050
R13: ffff888021f86000 R14: 1ffff92000729ed0 R15: ffff888071d0a160
FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c6b8abb68 CR3: 0000000021cc6000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nilfs_segctor_update_segusage fs/nilfs2/segment.c:1441 [inline]
 nilfs_segctor_do_construct+0x4b4a/0x6fe0 fs/nilfs2/segment.c:2065
 nilfs_segctor_construct+0x143/0x8d0 fs/nilfs2/segment.c:2375
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
 nilfs_segctor_thread+0x534/0x1180 fs/nilfs2/segment.c:2566
 kthread+0x266/0x300 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
