Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641A36F047C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbjD0Kt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243584AbjD0Ktz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:49:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABC3E7B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:49:53 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-763c3442563so371362339f.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592593; x=1685184593;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GiIfLQ6dLtU0hX1A5GYhyA80hhpYSI0OZdPLxA4mnvo=;
        b=WUOhpsyoy86X+bO74KUNYdsA9PcEeJXAKjSeuMux+qr2J7okfknItt7T/XY1XAyGbK
         S3lW9AFEto7ASmopnZVmt4YT5oQRTvtVL3kB/xJBt+eyNCDoVgyDNZ2XnFGzLDMSaSxi
         5+Dbx2QbEaol4JK8pli4bK0FaEbjbEgVxpiPHqEjWo7G71xNH+civgpsQ38gQhOGGlfz
         /gRHyS2Spu7l8PQIR8SqCh4breDb0JK7cOAVoYQPr5foZCRnrgGnhOqP/2Bz9Ggktcfy
         lK05rQ4FNumx9N5FkS7/IcPGgGZiaHOoNSlzdS6P33ZJ+cgtD5sRykELZS1M/1ih6w2f
         Ejqg==
X-Gm-Message-State: AC+VfDwu7GdMkflC3r0751GjYuWpbaPwmgg9GmgrNDJSpAn8cwu0ZkLV
        h00joIWblhT7LbokPRUU3Z/HSv4tCwvOebnf00d81XIBX3Un
X-Google-Smtp-Source: ACHHUZ4LAhd6QA4pZcumLe181rVz3axBOoF8fs4PeqElz7mCuFNDLCcK7qTBhYew+1ukf+8aMqEkLwiaLHyfBpzrNy6CUmGAg6jv
MIME-Version: 1.0
X-Received: by 2002:a02:b101:0:b0:40f:89f9:3ce7 with SMTP id
 r1-20020a02b101000000b0040f89f93ce7mr505836jah.3.1682592592853; Thu, 27 Apr
 2023 03:49:52 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:49:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc835005fa4f1dd6@google.com>
Subject: [syzbot] Monthly reiserfs report (Apr 2023)
From:   syzbot <syzbot+list516ba74fcec3023779ae@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello reiserfs maintainers/developers,

This is a 31-day syzbot report for the reiserfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/reiserfs

During the period, 3 new issues were detected and 0 were fixed.
In total, 72 issues are still open and 15 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1439    Yes   kernel BUG in do_journal_begin_r
                   https://syzkaller.appspot.com/bug?extid=2da5e132dd0268a9c0e4
<2>  1235    No    KASAN: slab-out-of-bounds Read in search_by_key (2)
                   https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
<3>  1191    Yes   kernel BUG at fs/reiserfs/journal.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
<4>  1172    Yes   WARNING in reiserfs_lookup
                   https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
<5>  439     Yes   possible deadlock in mnt_want_write_file
                   https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
<6>  210     Yes   possible deadlock in reiserfs_ioctl
                   https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
<7>  152     Yes   KASAN: out-of-bounds Read in leaf_paste_entries (2)
                   https://syzkaller.appspot.com/bug?extid=38b79774b6c990637f95
<8>  124     Yes   WARNING in reiserfs_readdir_inode
                   https://syzkaller.appspot.com/bug?extid=798ffe5fe3e88235db59
<9>  96      No    KASAN: slab-out-of-bounds Read in reiserfs_xattr_get
                   https://syzkaller.appspot.com/bug?extid=72ba979b6681c3369db4
<10> 88      Yes   WARNING in journal_end
                   https://syzkaller.appspot.com/bug?extid=d43f346675e449548021

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
