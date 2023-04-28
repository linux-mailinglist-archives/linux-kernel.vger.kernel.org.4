Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1486F1377
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 10:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345529AbjD1Iry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 04:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjD1Iru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 04:47:50 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967462D5B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:47:47 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32cb1ba941fso68468145ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 01:47:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682671667; x=1685263667;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QeuIWsyfE8QRzGIA3wUsHQCHj888JIoXAHIN3OdB9K0=;
        b=C3gGJ5wMk1fp3PKCy3t94KIpAU0nSKXMys/7ebJhmwrRG8m0AZ02iyLElv4IENwEt/
         fy9R3zcfiVwnck+J3AejJvRdVfxs7aYk6ho7y4A4c+x/aEZoVduTJ6ARTK4wUnST4O+D
         Jgq/XYVis0f+dHr4GRMGTsA+VIvWCE+qZEZ4hzw7HPA3nsp7KqZesSHHg9a1N6M4pN6L
         7wKp2uKf+HAQHhp4Va3vcM1CPZ4Xjlw5mIgInbNFPkRCAw88Jdg8Tb7SJ+uPjYM0phiM
         u7meummsq6TJFusGd6NV3gd8u+wIqY6ZzakgCSjCGeAGdTVScwLfnZoEGbK0Ytlx5JeD
         SJHw==
X-Gm-Message-State: AC+VfDzt9g78m2JBUYRJf2KTJnS9QFdh1j6U11rB+b6b2L8oG+UOyc6L
        6AZDu11wC66FroWaRnULH1gf1DDiyBvKAF6Yddq2cq4oB5y4
X-Google-Smtp-Source: ACHHUZ7s6abN+81ptcOqufkCU1xVEq3ObpiyN0LRdnzVgEL2H0zSA9O8g1YLLv6Cedw91IRSkN+kBZoArcjC7p3MXSArJEzW8smo
MIME-Version: 1.0
X-Received: by 2002:a02:a14a:0:b0:3c5:1971:1b7f with SMTP id
 m10-20020a02a14a000000b003c519711b7fmr2433851jah.6.1682671666917; Fri, 28 Apr
 2023 01:47:46 -0700 (PDT)
Date:   Fri, 28 Apr 2023 01:47:46 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000faf54f05fa6186db@google.com>
Subject: [syzbot] Monthly ntfs3 report (Apr 2023)
From:   syzbot <syzbot+list1d8e27291d051da3b6be@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com
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

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 8 new issues were detected and 0 were fixed.
In total, 62 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3546    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<2>  1835    Yes   UBSAN: shift-out-of-bounds in ntfs_fill_super (2)
                   https://syzkaller.appspot.com/bug?extid=478c1bf0e6bf4a8f3a04
<3>  1013    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<4>  843     Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<5>  388     Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<6>  352     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<7>  242     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  65      Yes   WARNING in do_symlinkat
                   https://syzkaller.appspot.com/bug?extid=e78eab0c1cf4649256ed
<9>  58      Yes   KASAN: vmalloc-out-of-bounds Write in find_lock_entries
                   https://syzkaller.appspot.com/bug?extid=e498ebacfd2fd78cf7b2
<10> 51      Yes   WARNING in do_mkdirat
                   https://syzkaller.appspot.com/bug?extid=919c5a9be8433b8bf201

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
