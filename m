Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD79656D19
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiL0Qun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiL0Quj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:50:39 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA533E6F
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:50:37 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id y11-20020a056e02178b00b0030c048d64a7so3199010ilu.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 08:50:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyo/IPd5AM9t6d6KV+9bi0NrFtplfGkrNjgHE/Ey/h4=;
        b=dmH4p7dvjI90Qrn3c5f3VeajaQTcf/f7C3kwAPsPr6TbYDhTrsXje7xqq2M4mxfY6w
         5VhoXpr6ver4cE8OGUZa1UDtqqxHfZFYXlBRlklLDP+evX+IBET+7ag2VMkvkf0oTuPt
         ufswttgNuX37xCKMWeuK2LAftblFN1A+aEALlfP0ToQTi7M+vHGyKaek+Ggu09YkkBNu
         y8uVcVs08cQDW7YtE20rDwiKZik9xMwy7nz20DixRybA07n/kaLXWLRm4XfGPO78Q8Xt
         7kHiwu2C5aUXrsS89d31EniBX4gnZaiDj2RIFfMA+UPTsPXhpqTYOfLqIkslfSuKntl0
         L69g==
X-Gm-Message-State: AFqh2kpYrAJxK+kUBGbRYOTF4TEsOeqAVFdO4Uf7E4vl66sT3KZM9MjZ
        DXrw7H+mAdn+wKIUlBqK9lCDYshKuxUhnjRiM2fsnUynKb+n
X-Google-Smtp-Source: AMrXdXu0g2UnVlhArNhkubCi2f7bWk6gGh/5xTHGOLcLZzoxHozkxeMJG/gTMd98vBPZeo374Gs8LtQivuH2j2JcbUdKq2CBx7QJ
MIME-Version: 1.0
X-Received: by 2002:a92:dc88:0:b0:304:ae5d:aa75 with SMTP id
 c8-20020a92dc88000000b00304ae5daa75mr1882476iln.261.1672159837070; Tue, 27
 Dec 2022 08:50:37 -0800 (PST)
Date:   Tue, 27 Dec 2022 08:50:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000018b0d605f0d20db2@google.com>
Subject: [syzbot] [ntfs3?] WARNING in wnd_add_free_ext
From:   syzbot <syzbot+d5376c82e21709c503f1@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev,
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

HEAD commit:    8395ae05cb5a Merge tag 'scsi-misc' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12903508480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b0e81c4eb13a67cd
dashboard link: https://syzkaller.appspot.com/bug?extid=d5376c82e21709c503f1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d5376c82e21709c503f1@syzkaller.appspotmail.com

R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8254656f R14: 00007fc9b9728300 R15: 0000000000022000
 </TASK>
------------[ cut here ]------------
WARNING: CPU: 0 PID: 8246 at fs/ntfs3/bitmap.c:216 rb_insert_start fs/ntfs3/bitmap.c:216 [inline]
WARNING: CPU: 0 PID: 8246 at fs/ntfs3/bitmap.c:216 wnd_add_free_ext+0xd29/0x10e0 fs/ntfs3/bitmap.c:351
Modules linked in:
CPU: 0 PID: 8246 Comm: syz-executor.2 Not tainted 6.1.0-syzkaller-14446-g8395ae05cb5a #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:rb_insert_start fs/ntfs3/bitmap.c:216 [inline]
RIP: 0010:wnd_add_free_ext+0xd29/0x10e0 fs/ntfs3/bitmap.c:351
Code: c1 ea 03 80 3c 02 00 0f 85 3b 02 00 00 49 8d 85 e0 00 00 00 4d 89 b5 00 01 00 00 48 89 44 24 10 e9 b9 f9 ff ff e8 77 b0 d3 fe <0f> 0b e9 40 fd ff ff e8 6b b0 d3 fe 48 8b 7c 24 10 e8 91 bb 0c 07
RSP: 0018:ffffc900041ef048 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000003 RCX: ffffc90004e13000
RDX: 0000000000040000 RSI: ffffffff82acc2b9 RDI: 0000000000000006
RBP: ffff88802900b960 R08: 0000000000000006 R09: 0000000000000003
R10: 0000000000000003 R11: 0000000000094001 R12: 0000000000000003
R13: ffff888025b521f0 R14: dffffc0000000000 R15: ffff88802900b180
FS:  00007fc9b9728700(0000) GS:ffff88802c600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f351e0be3e2 CR3: 0000000078412000 CR4: 0000000000150ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 wnd_zone_set+0x159/0x1b0 fs/ntfs3/bitmap.c:1418
 ntfs_look_for_free_space+0x18f/0x740 fs/ntfs3/fsntfs.c:382
 attr_allocate_clusters+0x3ee/0x6e0 fs/ntfs3/attrib.c:159
 attr_set_size+0x1452/0x2ac0 fs/ntfs3/attrib.c:573
 ntfs_set_size+0x13f/0x220 fs/ntfs3/inode.c:823
 ntfs_extend+0x4ac/0x5c0 fs/ntfs3/file.c:337
 ntfs_file_write_iter+0x34b/0x1d70 fs/ntfs3/file.c:1064
 call_write_iter include/linux/fs.h:2186 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fc9b8a8c0a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc9b9728168 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007fc9b8babf80 RCX: 00007fc9b8a8c0a9
RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000004
RBP: 00007fc9b97281d0 R08: 0000000000000000 R09: 0000000000000000
R10: 000080001d00c0d0 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd8254656f R14: 00007fc9b9728300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
