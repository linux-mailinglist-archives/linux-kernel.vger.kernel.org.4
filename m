Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17B8649276
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 06:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLKFSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 00:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiLKFR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 00:17:58 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F097FF60
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:40 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id i14-20020a056e020d8e00b003034b93bd07so2839091ilj.14
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 21:17:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/ihziodggncmxIb1HA3GZJ7Z2yoxCndt5g6/ci9uyk=;
        b=pUTKBdJBqquoEp1Nk2oF02+gaHR45b/3jFGLSjUakI20EcWTidHsppElMZBOwIyx0S
         8YoAiHC/G4/DjT4TZdJLACtwQHIKc5KF+Xwg/l3WbNQJEZ09NfNNj4vxVV1szjTndJRd
         JbN+IAATM2/YhoKpnJkGtQgKYm/tDTcXV7IFnAhUQ1CZhXbSuJ+ZC6Q6v4JA+K3rpUVO
         YlxCjJl19AhPsqK54Ky7rsNCkMl1jIwX6hixhLhaP2DVgkU9Ot9+6+3H6H/WPAFJBg5m
         YAzu1YjAORzOZNkO+HlG9GUWjSyb0ugWFe1IvfLeYRXjfLM1BLgLY73p+ib5nC36KCqU
         dnFw==
X-Gm-Message-State: ANoB5pnptgMtWynMDiRfeCkklTI1vLoyPdrXKEmuu0MuZFyOx02ZUJ7F
        D9AKxqjcKKojMyUjjtPJOhe0QFUMKHeQdNuixIRRMAwfYnDz
X-Google-Smtp-Source: AA0mqf7itXoVg8+wudUIXFPyLwrkS4kg3JfDdxm5I7MLOX7NPd6jn3AfiIVbNigW6CQdapp+fCnbnmkm8zuZkFdeoaD4CTZrzf3k
MIME-Version: 1.0
X-Received: by 2002:a6b:6d0d:0:b0:6c4:ad4d:b23a with SMTP id
 a13-20020a6b6d0d000000b006c4ad4db23amr32397030iod.2.1670735859743; Sat, 10
 Dec 2022 21:17:39 -0800 (PST)
Date:   Sat, 10 Dec 2022 21:17:39 -0800
In-Reply-To: <0000000000000e082305eec34072@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006f049f05ef868103@google.com>
Subject: Re: [syzbot] kernel BUG in set_state_bits
From:   syzbot <syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    296a7b7eb792 Merge tag 'for-linus' of git://git.armlinux.o..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16a12ddb880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4edf421741552bc3
dashboard link: https://syzkaller.appspot.com/bug?extid=b9d2e54d2301324657ed
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ec2ab7880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14dc4613880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c19ef17ae288/disk-296a7b7e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/68d26e4d2868/vmlinux-296a7b7e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/06aad301e7dd/bzImage-296a7b7e.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/5660348a6b33/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b9d2e54d2301324657ed@syzkaller.appspotmail.com

RBP: 00007ffe8b0af640 R08: 0000000000000001 R09: 00007f4094fa0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
------------[ cut here ]------------
kernel BUG at fs/btrfs/extent-io-tree.c:381!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3627 Comm: syz-executor376 Not tainted 6.1.0-rc8-syzkaller-00154-g296a7b7eb792 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 0e cd fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f5 cc fb fd <0f> 0b 4c 89 ef e8 fb a6 48 fe e9 e6 fe ff ff 4c 89 ef e8 ee a6 48
RSP: 0018:ffffc90003baf860 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880790a2840 RCX: 0000000000000000
RDX: ffff888022638000 RSI: ffffffff8384510b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff8880790a28bc R14: 0000000000000fff R15: 0000000000000000
FS:  0000555555779300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff787f16e8 CR3: 0000000072e1e000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 insert_state_fast fs/btrfs/extent-io-tree.c:439 [inline]
 __set_extent_bit+0xd09/0x1430 fs/btrfs/extent-io-tree.c:997
 set_record_extent_bits+0x5e/0x70 fs/btrfs/extent-io-tree.c:1601
 qgroup_reserve_data+0x239/0xbc0 fs/btrfs/qgroup.c:3739
 btrfs_qgroup_reserve_data+0x2f/0xd0 fs/btrfs/qgroup.c:3782
 btrfs_check_data_free_space+0x111/0x280 fs/btrfs/delalloc-space.c:152
 btrfs_buffered_write+0x4f1/0x1330 fs/btrfs/file.c:1559
 btrfs_direct_write fs/btrfs/file.c:1899 [inline]
 btrfs_do_write_iter+0xece/0x1450 fs/btrfs/file.c:1980
 call_write_iter include/linux/fs.h:2199 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x9ed/0xdd0 fs/read_write.c:584
 ksys_write+0x12b/0x250 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4094fe1cf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe8b0af638 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f4094fe1cf9
RDX: 0000000000000049 RSI: 0000000020000180 RDI: 0000000000000005
RBP: 00007ffe8b0af640 R08: 0000000000000001 R09: 00007f4094fa0034
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:set_state_bits.isra.0+0x17b/0x1c0 fs/btrfs/extent-io-tree.c:381
Code: 38 d0 7c 04 84 d2 75 31 44 8b 73 7c e8 0e cd fb fd 44 89 e0 44 09 f0 89 43 7c 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 f5 cc fb fd <0f> 0b 4c 89 ef e8 fb a6 48 fe e9 e6 fe ff ff 4c 89 ef e8 ee a6 48
RSP: 0018:ffffc90003baf860 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880790a2840 RCX: 0000000000000000
RDX: ffff888022638000 RSI: ffffffff8384510b RDI: 0000000000000005
RBP: 00000000fffffff4 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000fffffff4 R11: 0000000000000000 R12: 0000000000001000
R13: ffff8880790a28bc R14: 0000000000000fff R15: 0000000000000000
FS:  0000555555779300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff787f16e8 CR3: 0000000072e1e000 CR4: 0000000000350ee0

