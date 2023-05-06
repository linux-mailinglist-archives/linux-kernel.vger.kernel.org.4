Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6F36F9261
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjEFOC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjEFOCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:02:55 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC509EDB
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:02:54 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-33142b54417so41053115ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 07:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683381773; x=1685973773;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PjR+zB20hfPaM34wxDG6cz5i7+lLGlLgpjJu8mR5MAU=;
        b=Yki+bfxbn9wLPojRKxQJ1kYZ8VjVP1NvrBNTxfSxiHARLWOQTinwIfMa92AjvFRniX
         iaiEhIczYv3lbKUSKnhX8ugpBq7rDtb3hx07D2dfPqT5Dwp9nGsbExdVxr5OR9NAL0fe
         JKt80TM626lDTSdat1WpmHtwBEsuENNyPqNFrasKHuc+i6G9u5tLIO44k+N0sYiirMOY
         pvDFzDPTcq5T7ngLgIbdmQnOOQmymE3jAzM5qujNzuDJp7/9z8lEI7GHUC+mLH/KuHKY
         dxJ55uqQRXDgPx2MB0ncLyuwbZvldqKACiOZskN0sigEVNKXWYgi33d99DbjliijtkJ6
         J3XQ==
X-Gm-Message-State: AC+VfDy7wwWZJ/f+zTXtYp+c1kBsr0pv7apz3RBfHNjWXhgkkuAofcEo
        r7AfILNR81IuzeBqoLLJQWI59/+/f1WPNXtmEJEBSKk5FSYN
X-Google-Smtp-Source: ACHHUZ5jfxcWYqqQMHpfyqsPt9wwjskRJH7dSGTNTCJ4Hdd8e/52t9WxQ+iDLNmwvIatK5QsEXggl3CU/JNYhKV7ybj0whJDKfb1
MIME-Version: 1.0
X-Received: by 2002:a92:d7c5:0:b0:310:9fc1:a92b with SMTP id
 g5-20020a92d7c5000000b003109fc1a92bmr2382461ilq.0.1683381773594; Sat, 06 May
 2023 07:02:53 -0700 (PDT)
Date:   Sat, 06 May 2023 07:02:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2feae05fb06dcee@google.com>
Subject: [syzbot] Monthly fs report (May 2023)
From:   syzbot <syzbot+liste501264b47eec817042f@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 7 new issues were detected and 0 were fixed.
In total, 66 issues are still open and 321 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1895    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                  https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2> 1768    Yes   WARNING in firmware_fallback_sysfs
                  https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3> 179     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                  https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<4> 80      No    possible deadlock in quotactl_fd
                  https://syzkaller.appspot.com/bug?extid=cdcd444e4d3a256ada13
<5> 37      Yes   INFO: task hung in filename_create (4)
                  https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<6> 13      Yes   INFO: rcu detected stall in sys_clock_adjtime
                  https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<7> 5       No    BUG: unable to handle kernel NULL pointer dereference in filemap_read_folio (2)
                  https://syzkaller.appspot.com/bug?extid=41ee2d2dcc4fc2f2f60c
<8> 5       No    possible deadlock in evdev_pass_values (2)
                  https://syzkaller.appspot.com/bug?extid=13d3cb2a3dc61e6092f5
<9> 1       Yes   INFO: rcu detected stall in sys_newfstatat (4)
                  https://syzkaller.appspot.com/bug?extid=1c02a56102605204445c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
