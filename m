Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3EB62065E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233135AbiKHB73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKHB71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:59:27 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F42193D1;
        Mon,  7 Nov 2022 17:59:26 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id p4so12347200vsa.11;
        Mon, 07 Nov 2022 17:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=532CIFIkh46SKQPK1lhh3C9mnAHViQsajj+cGVkxhcI=;
        b=ForAbyRL45nS2PNkcTgtoJXQPWSjcrToqFAm9zjxpH+Tynt6CyZgrwrLlPLX6ITtPy
         pdfkQAY3mG7hd4QYBIcvZRTq5zbF/r90BL/wZoq9XAWWLEukRFyWm7FAd3YVlPcM2reW
         bIjpL9Anyfx40XJM4NGS8JxA/aKly3ONACXwu4Z/EfCIAZifN7bKEyMUqdyHlSQTRGth
         fArlWTHWpqCcTijaF/2gNDP+MmnQ9gDCC76b9+QmOZGw6dw7U/n5fUFK2w6IswcFQdT2
         TICTFXmvkE00Dg/5AG8avRoQSkBOvSw9Vt+N7xbk9ud+iWl7US05EORT65IvorKNwaXm
         JDFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=532CIFIkh46SKQPK1lhh3C9mnAHViQsajj+cGVkxhcI=;
        b=xyzfH1p/RtuXAydtpcpMQZr0UW+H8BNJ459DlwvuLV3eUYoekU26xin8KxXbTCJ/dx
         80SiQFznvPJkibIPGD9ucmePx5mMd0pcr9MLKp9PinbDpVJKii2gs+VfFpJ0pHlZZAfK
         x3LfVjyo/e0VDdunW9nfSbrz+8Jr6GJpOD6lCENuQFIvc2UAltAttPq2uNI4SnWG6ktX
         /slUtpVGpGH3/lcQXqxX8JLq7rsn9DgWfmybwjestdgEpziAPRN8X5PTI5YqQ4my7PE2
         qvV/faO1W4lDGC3JaCWOiq9CHj/0wBeCR1lTaNDS0LQqv+eEMlTBzeJX6XoCkjHCZv7f
         gVNA==
X-Gm-Message-State: ACrzQf0+FK0430ea+epWpa8vzidqRvoo6PfBv8jNp3LJ013CB5ooTv7z
        TQ6PcvP9a+LYcImwFNLQX16dVUUvmK30vp0JkZ4=
X-Google-Smtp-Source: AMsMyM6LKGRcXsNOtwFwU69C1b0ecnG+gy0xWQfc2aelhF/i38wNIbJZwhJ7+oYSqUysaJlcMT+Kq2QuvBEZG1NfdHw=
X-Received: by 2002:a05:6102:4420:b0:3ad:19b6:4ef9 with SMTP id
 df32-20020a056102442000b003ad19b64ef9mr18472370vsb.37.1667872765685; Mon, 07
 Nov 2022 17:59:25 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f4619905ece64a41@google.com>
In-Reply-To: <000000000000f4619905ece64a41@google.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 8 Nov 2022 10:59:09 +0900
Message-ID: <CAKFNMo=_FBBxWebFKjhBoZ0f_3OxiAdfFrVr0188XUJ2jpd-Ng@mail.gmail.com>
Subject: Re: [syzbot] BUG: unable to handle kernel paging request in nilfs_mdt_fetch_dirty
To:     syzbot <syzbot+b107db66f49c5e2a911f@syzkaller.appspotmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 8, 2022 at 4:18 AM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=106158fe880000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
> dashboard link: https://syzkaller.appspot.com/bug?extid=b107db66f49c5e2a911f
> compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
> userspace arch: arm64
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b107db66f49c5e2a911f@syzkaller.appspotmail.com
>
> Unable to handle kernel paging request at virtual address fffffffffffffeb8
> Mem abort info:
>   ESR = 0x0000000096000004
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x04: level 0 translation fault
> Data abort info:
>   ISV = 0, ISS = 0x00000004
>   CM = 0, WnR = 0
> swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000001c566b000
> [fffffffffffffeb8] pgd=0000000000000000, p4d=0000000000000000
> Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 7614 Comm: segctord Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : nilfs_mdt_fetch_dirty+0x1c/0x94 fs/nilfs2/mdt.c:394
> lr : nilfs_mdt_fetch_dirty+0x18/0x94 fs/nilfs2/mdt.c:391
> sp : ffff80001f553cc0
> x29: ffff80001f553cc0 x28: 0000000000000000 x27: 0000000000000000
> x26: 0000000000000001 x25: ffff00011b0cc800 x24: ffff00011b0cc800
> x23: 0000000000000001 x22: 0000000000000001 x21: ffff00011b0cc800
> x20: ffff00011b198900 x19: 0000000000000000 x18: 0000000000000107
> x17: ffff80000bffd6bc x16: ffff80000db49158 x15: ffff00012640cf80
> x14: 0000000000000008 x13: 00000000ffffffff x12: ffff00012640cf80
> x11: ff80800008f55b48 x10: 0000000000000000 x9 : ffff800008f55b48
> x8 : fffffffffffffeb8 x7 : ffff8000082160c0 x6 : 0000000000000000
> x5 : 0000000000000080 x4 : 0000000000000001 x3 : 0000000000000000
> x2 : 0000000000000006 x1 : ffff00011b198900 x0 : 0000000000000000
> Call trace:
>  nilfs_mdt_fetch_dirty+0x1c/0x94 fs/nilfs2/mdt.c:394
>  nilfs_test_metadata_dirty+0x2c/0x148 fs/nilfs2/segment.c:813
>  nilfs_segctor_confirm+0x30/0x1a8 fs/nilfs2/segment.c:837
>  nilfs_segctor_construct+0x78/0x380 fs/nilfs2/segment.c:2374
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2483 [inline]
>  nilfs_segctor_thread+0x180/0x660 fs/nilfs2/segment.c:2566
>  kthread+0x12c/0x158 kernel/kthread.c:376
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> Code: 910003fd aa0003f3 97cd2834 d1052268 (f9400100)
> ---[ end trace 0000000000000000 ]---
> ----------------
> Code disassembly (best guess):
>    0:   910003fd        mov     x29, sp
>    4:   aa0003f3        mov     x19, x0
>    8:   97cd2834        bl      0xffffffffff34a0d8
>    c:   d1052268        sub     x8, x19, #0x148
> * 10:   f9400100        ldr     x0, [x8] <-- trapping instruction
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

According to the stack trace, this looks like the same UAF bug as below:

#syz dup: KASAN: use-after-free Read in nilfs_segctor_confirm

The cause of the oops is that a corrupted inode pointer was passed to
nilfs_mdt_fetch_dirty().
That inode pointer is the pointer held in the nilfs_root structure
according to the stack trace.
So, it seems that a UAF read was done on an already freed nilfs_root,
which extracted the corrupted inode pointer and caused the oops.

The bugfix for this is the patch titled "nilfs2: fix use-after-free
bug of struct nilfs_root", which was merged in the mainline after the
tested commit.

Ryusuke Konishi
