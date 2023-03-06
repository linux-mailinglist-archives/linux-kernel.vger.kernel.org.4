Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166CD6ACBB4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 18:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjCFR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 12:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjCFR5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 12:57:45 -0500
Received: from mail-io1-xd48.google.com (mail-io1-xd48.google.com [IPv6:2607:f8b0:4864:20::d48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194213D93D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 09:57:11 -0800 (PST)
Received: by mail-io1-xd48.google.com with SMTP id g21-20020a6be615000000b0074cb292f57dso5639770ioh.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 09:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678125344;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ajIgrIXYqaFuV+qkrohkFZm/iyDUjE1JtksoL40Edr8=;
        b=eqRhe+u77A3/FXbQFnhtyIDItS1G5igOUTHE1/db/m1SCYWGR7Rbe2N3UfU6shmLyE
         rljST05Uiz7H69vN9DK6hxB7WxZH4C52NWxSVNDr4fWA5VpUfpPUNEXv59o5oIKxuIKZ
         +nQa2SS8i0klSUCMq3dJx6hlCVj+95mEr1tOw/pykRUz886Ex97SK08n3jFs9G7hhI/t
         aS/+ztqabZUiMyTM07/ba/Be831JEn2EIMn1zBJ8zIZujG0YjLqcdtl99sQTscLVAY8g
         GqdMg2BcsWNI7AziNqYKPOaloIFFFi7cUKAjbjn+7f92WEMr8bBAOfrn37UWopN5h7Yi
         Ibqw==
X-Gm-Message-State: AO0yUKXI2+BdFt7s1nb8SoIyfUsmTTuhq80pz0CftdeGdyN73FJfmhL8
        pzw9+Fkb8d9n1Yr5B4xcf9NP/8aC1OjKEue7lD+ADdignrfb
X-Google-Smtp-Source: AK7set/tVa2eFCnqZ7AxHXgrzSAqK70ywkfBJxDJ8r95AB8bn4c3lbG50ffdVmngxkFuRceyPo8k0mDKIlSb1o2k0s6VoHeOtt+a
MIME-Version: 1.0
X-Received: by 2002:a02:952e:0:b0:3c4:e84b:2a3a with SMTP id
 y43-20020a02952e000000b003c4e84b2a3amr5913375jah.4.1678125344581; Mon, 06 Mar
 2023 09:55:44 -0800 (PST)
Date:   Mon, 06 Mar 2023 09:55:44 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d710705f63f014c@google.com>
Subject: [syzbot] [nilfs?] KMSAN: uninit-value in nilfs_add_checksums_on_logs
From:   syzbot <syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com>
To:     glider@google.com, konishi.ryusuke@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    54b4a7d3d6c6 kmsan: add memsetXX tests
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=143f81e4c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=46c642641b9ef616
dashboard link: https://syzkaller.appspot.com/bug?extid=048585f3f4227bb2b49b
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b2a457fb4580/disk-54b4a7d3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1acddc397ddb/vmlinux-54b4a7d3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eceee3367163/bzImage-54b4a7d3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+048585f3f4227bb2b49b@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in crc32_le_base+0x446/0xd80 lib/crc32.c:197
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 crc32_le_base+0x446/0xd80 lib/crc32.c:197
 nilfs_segbuf_fill_in_segsum_crc fs/nilfs2/segbuf.c:182 [inline]
 nilfs_add_checksums_on_logs+0x2ce/0xe30 fs/nilfs2/segbuf.c:320
 nilfs_segctor_do_construct+0xa553/0xe900 fs/nilfs2/segment.c:2076
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2379
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
 nilfs_segctor_thread+0xc76/0x1240 fs/nilfs2/segment.c:2570
 kthread+0x31f/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Uninit was stored to memory at:
 nilfs_write_dat_node_binfo+0x12c/0x280 fs/nilfs2/segment.c:658
 nilfs_segctor_assign fs/nilfs2/segment.c:1629 [inline]
 nilfs_segctor_do_construct+0x753c/0xe900 fs/nilfs2/segment.c:2056
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2379
 nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
 nilfs_segctor_thread+0xc76/0x1240 fs/nilfs2/segment.c:2570
 kthread+0x31f/0x430 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

Local variable binfo.i.i created at:
 nilfs_segctor_update_payload_blocknr fs/nilfs2/segment.c:1562 [inline]
 nilfs_segctor_assign fs/nilfs2/segment.c:1629 [inline]
 nilfs_segctor_do_construct+0x6ac9/0xe900 fs/nilfs2/segment.c:2056
 nilfs_segctor_construct+0x1eb/0xe30 fs/nilfs2/segment.c:2379

CPU: 1 PID: 28393 Comm: segctord Not tainted 6.2.0-syzkaller-81157-g54b4a7d3d6c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/02/2023
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
