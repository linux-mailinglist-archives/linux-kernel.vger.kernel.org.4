Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E265ED2E1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiI1CDq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 27 Sep 2022 22:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiI1CDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:03:43 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF201D1A75
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:03:43 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id x3-20020a056e021ca300b002f855cd264cso6026798ill.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:03:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=oBCy6kzRsYubLyWzGyDCQWUmqeARuKauUsbqgDLRR1k=;
        b=Bu84WYj1aFI0GWAQKOUHr+OCKQTgWDjrh1UrGiMX+mpXZXKdkEWDtNGZG/KOVDp6OW
         eDewNg5kei6h4M1H2H/V/MX/K2BML1iPJquirirlpol4RFH0IofWCsY8qVWMreQWy3kk
         XhUPGYviwMmDjLZW0v4BMiNlCM7aPcr8LKRTp18eB9Dt4N+vxHrBcsmag2tnClekVTKs
         gYImprEIauyy1sCZZxPxf5IwJGWqHtOk+H6lGmElhHF053rkPymoWuz7z0/7y4/LvqKb
         WSPFX7qUOUqOZcaewMeHvjT8H2n1KJAPSMg89oQxOavMq75HEocB8pZJlwq6r79ih6Dp
         VMNA==
X-Gm-Message-State: ACrzQf128ITk4tcc9uNz/TUXyWfZo+bY6URt8eVVQzhBas2AX+th6+/l
        GraqcVRmDw7fFdVTOrfe65h0OMs9rRBaLiiNMoQ0QwAt+oPs
X-Google-Smtp-Source: AMsMyM5LYxJggCQUB6xCMuaSFNWXB2kdrWHbl3B1IzHoXEyWLmkV57QRsoxOW9lnAy/BVj9Sr47ZtM5X4t8P9w+R38YgFQRGAv+0
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c8d:b0:2f8:a6a4:9b12 with SMTP id
 w13-20020a056e021c8d00b002f8a6a49b12mr4228962ill.179.1664330622496; Tue, 27
 Sep 2022 19:03:42 -0700 (PDT)
Date:   Tue, 27 Sep 2022 19:03:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008af58705e9b32b1d@google.com>
Subject: [syzbot] unexpected kernel reboot (8)
From:   syzbot <syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
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

HEAD commit:    1707c39ae309 Merge tag 'driver-core-6.0-rc7' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17324288880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=122d7bd4fc8e0ecb
dashboard link: https://syzkaller.appspot.com/bug?extid=8346a1aeed52cb04c9ba
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ca1f54880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=155622df080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8346a1aeed52cb04c9ba@syzkaller.appspotmail.com

fuseblk: Unknown parameter '                                                                Decompressing Linux... Parsing ELF... done.                                                                                     Booting the kernel.                                                                                                                                                                                                                                                             Decompressing Linux... Parsing ELF... done.                                                                                     Booting the kernel.                                                                                                                                                                                                                                                                                                                                              


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
