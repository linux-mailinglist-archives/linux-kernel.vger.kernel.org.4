Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA67715834
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjE3ITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjE3ITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:19:01 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF86AD
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:19:00 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-763da06540aso596442339f.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:19:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685434739; x=1688026739;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9VFbEdwESq3AAXEqLMgm5rUgbu52wFONhvBqbsIgeuw=;
        b=YypLzgi+EAfaQbtuZHKmS41meospM1j+1ZqJ1ai3X9k7phTEmSTzZazU9j9QeXClWP
         MKOwEDfYUs+SAVufNpRzqnALMiU2skCXFJG3yVz9mtoTJxhoAza73Sh3p7NMlrSFMueP
         UI3T/d1jz1AZBzXpglRlNE3PvCXkDoiRIcnquhito6RlQEnCPCP2MY/Q9vOtfQnjpURJ
         cRwYKvWxyAgZpXUEAAYdXKPcred3BDHB67wHpGJK62YrhkQjtOSob0+ekBvLWPRs+QfJ
         Mt4zHZH4x4BkYUDPX2bl8Fy9JTQ9w8Ko8QUoBqU7o9SWqHWWBLeyXANlrrbLj4UDTBrK
         /Tvw==
X-Gm-Message-State: AC+VfDwCyElSNkm0JEL/vT7VyOJxTOvumYmh+LmX6q7gBXJ++oKVGXi5
        Nf5F8+2jlWYYe8FHm0EgmA7br7l7T29iNifkGKTZ8719KNvt
X-Google-Smtp-Source: ACHHUZ4ijF4g3pjtVkhQj+lrOrMmCbm0XMpt6i/skBPotrc56H/XE6eD3Csxcz81rWt5GXn452icWvqFQNiTXViDgMb/G9XzF68h
MIME-Version: 1.0
X-Received: by 2002:a05:6602:424f:b0:777:32fd:4f13 with SMTP id
 cc15-20020a056602424f00b0077732fd4f13mr739119iob.2.1685434739544; Tue, 30 May
 2023 01:18:59 -0700 (PDT)
Date:   Tue, 30 May 2023 01:18:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f15a5105fce4daea@google.com>
Subject: [syzbot] Monthly jfs report (May 2023)
From:   syzbot <syzbot+list89f2ba4cb4fbb749b50b@syzkaller.appspotmail.com>
To:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaggy@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 0 new issues were detected and 0 were fixed.
In total, 59 issues are still open and 9 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  4488    Yes   UBSAN: shift-out-of-bounds in extAlloc
                   https://syzkaller.appspot.com/bug?extid=5f088f29593e6b4c8db8
<2>  940     Yes   KASAN: slab-out-of-bounds Read in hex_dump_to_buffer
                   https://syzkaller.appspot.com/bug?extid=489783e0c22fbb27d8e9
<3>  923     Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<4>  726     Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<5>  523     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<6>  382     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<7>  256     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<8>  253     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<9>  223     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<10> 165     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
