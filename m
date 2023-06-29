Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986707422C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbjF2Iz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjF2Izt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:55:49 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B81B0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:55:48 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39ce91ab7ccso570014b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:55:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688028948; x=1690620948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IFRfgV9FisIWUl7+d9AYd8NESXmBs7XWpB1afHeKCsI=;
        b=NmFjt2Ol4Mir5ZnEo8PC49vcFrii8EjRqUyajWRGAiR17VpfQbqMcQCSHEDoUrzTye
         7sO372uHVqKO3bHtwqpnSTZg4sSWiVQIYUhFmP2bMPOVI4buzlp+LAwXlgGgdRji3XeH
         w0qMz0s4sZKTfG5BLG5NPlTeVhbOPnozilVT2mBwaYPnX7M0cL3erU6MaKC4/2c09q+I
         NmqLUS0dMAYoIifyVd0MrjdCRUKHvWuyCKXAzBbZxQS5rCfFqsB7yyOR2ytbIpfe1A2D
         wwMjEJb928qMPdHPxXDElTQn5FH4bezFwjfNlKIppuH872fGncR4ohWIyNR7bofICPH1
         xzfw==
X-Gm-Message-State: AC+VfDxcgMjtPufNVrj3OQCtBrGyBx33JztvXZm7qGfSGDOogxlFSttU
        NbOXsWZePKJR+28cKfJ5BxFp4NvkVaK0AgHgFDVmaQC0vu7r
X-Google-Smtp-Source: ACHHUZ7UqI34IuwLktFFUjL1PO0E8zJst0SnpIEa2xXPvk/Y8r4dXSfZCLUB/ipD4FcSmoCzRlpQTNL+AE0WakqLcnPp09PsWcml
MIME-Version: 1.0
X-Received: by 2002:a05:6808:178d:b0:3a1:e58d:aae0 with SMTP id
 bg13-20020a056808178d00b003a1e58daae0mr5380221oib.3.1688028948124; Thu, 29
 Jun 2023 01:55:48 -0700 (PDT)
Date:   Thu, 29 Jun 2023 01:55:48 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d2d99605ff40dd2d@google.com>
Subject: [syzbot] Monthly hfs report (Jun 2023)
From:   syzbot <syzbot+listbf50ec4bd2f0db86a64d@syzkaller.appspotmail.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
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

Hello hfs maintainers/developers,

This is a 31-day syzbot report for the hfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/hfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 47 issues are still open and 12 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3804    Yes   possible deadlock in hfsplus_file_extend
                   https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
<2>  3673    Yes   possible deadlock in hfsplus_file_truncate
                   https://syzkaller.appspot.com/bug?extid=6030b3b1b9bf70e538c4
<3>  3071    Yes   possible deadlock in hfsplus_get_block
                   https://syzkaller.appspot.com/bug?extid=b7ef7c0c8d8098686ae2
<4>  1536    Yes   KMSAN: uninit-value in hfs_revalidate_dentry
                   https://syzkaller.appspot.com/bug?extid=3ae6be33a50b5aae4dab
<5>  734     Yes   KASAN: slab-out-of-bounds Read in hfsplus_uni2asc
                   https://syzkaller.appspot.com/bug?extid=076d963e115823c4b9be
<6>  677     Yes   kernel BUG in __hfsplus_setxattr
                   https://syzkaller.appspot.com/bug?extid=1107451c16b9eb9d29e6
<7>  574     Yes   KMSAN: uninit-value in hfsplus_delete_cat
                   https://syzkaller.appspot.com/bug?extid=fdedff847a0e5e84c39f
<8>  500     Yes   kernel BUG in hfs_write_inode
                   https://syzkaller.appspot.com/bug?extid=97e301b4b82ae803d21b
<9>  334     Yes   WARNING in hfs_bnode_create
                   https://syzkaller.appspot.com/bug?extid=a19ca73b21fe8bc69101
<10> 283     Yes   general protection fault in hfs_find_init
                   https://syzkaller.appspot.com/bug?extid=7ca256d0da4af073b2e2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
