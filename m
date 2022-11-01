Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBB26150F2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiKARlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiKARlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:41:42 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D48A1C134
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:41:41 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id l9-20020a5d8f89000000b006bd33712128so11831573iol.17
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb5hKKxK653yOZqwzT+YH0r96wFUdTKykX4aSY0JyUY=;
        b=lnDWW19mFacCfz/8kL2HVCUSNqhc84pK3E224qGGS8w9J/9jLlHrvcLz0Gono50eK3
         SgCG1PVFHs2245q7BrF+fBX0U5fnL9MFGcta/21PuGaNAvIlONYWSoTY94TfyE1oCtfd
         AcLK68Px99AocQ8LS+hrw0/Eb3KThLvAamR4lcl2h4XvMyJePUs+k5iu+HeXmulN6hIP
         mWuywQr32WQr7I34TO/MpAz1x1YOGDsgexZyjMLta7+VI/JyrtOyQdivrBwwiehzRJ6K
         oAEPFdWln73132maPVsCEHmbQAY9p/xPEBw7xjNwB5I+bdYaIm/oFk9pGtEpMOfO2XTX
         +bPg==
X-Gm-Message-State: ACrzQf2myANA64yksFR5taAAn8XSNJDIdV2uRyMzRViarTpxbWHdhYx+
        Z/FR3riIB1PyCJSxz77uVhm+P8zJy2sQ/lsEh2ia8fmkmOjk
X-Google-Smtp-Source: AMsMyM7OVrbwHyBaS7Ew6Lna3GtUPcbQgUA3V+xXCAIu/cgeL7HcARym+7pOewWefZuZ12686GG5gByRTew46Qn4O0yMEkdcS7ak
MIME-Version: 1.0
X-Received: by 2002:a02:b383:0:b0:375:4fc8:586b with SMTP id
 p3-20020a02b383000000b003754fc8586bmr9713444jan.200.1667324500795; Tue, 01
 Nov 2022 10:41:40 -0700 (PDT)
Date:   Tue, 01 Nov 2022 10:41:40 -0700
In-Reply-To: <000000000000186e6c05eb2cd12e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000986a8e05ec6c3cfb@google.com>
Subject: Re: [syzbot] WARNING in btrfs_sync_log
From:   syzbot <syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com>
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

HEAD commit:    b229b6ca5abb Merge tag 'perf-tools-fixes-for-v6.1-2022-10-..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=168561a6880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1d3548a4365ba17d
dashboard link: https://syzkaller.appspot.com/bug?extid=4406ed3884d139266b67
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1157537a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17370ede880000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24728b72a896/disk-b229b6ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10a3c40c60e1/vmlinux-b229b6ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/69f963b02b7e/bzImage-b229b6ca.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/c6f695f68206/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4406ed3884d139266b67@syzkaller.appspotmail.com

------------[ cut here ]------------
BTRFS: Transaction aborted (error -12)
WARNING: CPU: 0 PID: 3653 at fs/btrfs/tree-log.c:3081 btrfs_sync_log+0x1ebd/0x2d40 fs/btrfs/tree-log.c:3081
Modules linked in:
CPU: 0 PID: 3653 Comm: syz-executor166 Not tainted 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/11/2022
RIP: 0010:btrfs_sync_log+0x1ebd/0x2d40 fs/btrfs/tree-log.c:3081
Code: bb 8d 99 06 49 be 00 00 00 00 00 fc ff df 4c 8b 64 24 40 eb 19 e8 c3 92 ef fd 48 c7 c7 e0 11 dc 8a 89 de 31 c0 e8 13 31 b7 fd <0f> 0b b3 01 44 0f b6 c3 4c 89 e7 48 c7 c6 60 12 dc 8a ba 09 0c 00
RSP: 0018:ffffc9000402ee80 EFLAGS: 00010246
RAX: 0c3fac46eef79b00 RBX: 00000000fffffff4 RCX: ffff88807ac10000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffffc9000402f310 R08: ffffffff816b8dfd R09: fffff52000805d89
R10: fffff52000805d89 R11: 1ffff92000805d88 R12: ffff8880736f05e8
R13: 00000000fffffff4 R14: dffffc0000000000 R15: ffff8880736f0638
FS:  00005555555c9300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561f344b24f0 CR3: 0000000075ec1000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_sync_file+0xdf4/0x1140 fs/btrfs/file.c:2242
 generic_write_sync include/linux/fs.h:2883 [inline]
 btrfs_do_write_iter+0xa6f/0x1370 fs/btrfs/file.c:1975
 do_iter_write+0x6c2/0xc20 fs/read_write.c:861
 iter_file_splice_write+0x7fc/0xfc0 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0xe6/0x1c0 fs/splice.c:931
 splice_direct_to_actor+0x4e4/0xc00 fs/splice.c:886
 do_splice_direct+0x279/0x3d0 fs/splice.c:974
 do_sendfile+0x5fb/0xf80 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64+0x14f/0x1b0 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4524cb5fe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdb426e408 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f4524cb5fe9
RDX: 0000000000000000 RSI: 0000000000000008 RDI: 0000000000000007
RBP: 00007ffdb426e430 R08: 0000000000000002 R09: 00007ffdb426e440
R10: 0000000080000009 R11: 0000000000000246 R12: 0000000000000009
R13: 00007f4524cfe6c0 R14: 00007ffdb426e450 R15: 0000000000000002
 </TASK>

