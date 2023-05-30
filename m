Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4403A715C57
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjE3K5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbjE3K46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:56:58 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A4FF7
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:56:56 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33826fb9d0fso22354705ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444216; x=1688036216;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2MXCgTNPKfxKRGLHYFjMw3S62/mrODmRY8sffg8JIM=;
        b=IhyTQF9DrjXFwTp948ct8Y4CRF5ojzGhkVsPEQCBKKbHQDVf4dYjioQPPnUgeBDSSw
         9TsBVpwxZrpJ0L//9lBcdon5r0rf+RP+w/T4C9m5tjtVHfFRyeBbs16dPtSuGrCyFRgv
         ub0q4yZg8yRJrihUTeH4VvNRPab0e8zm5ORFkgGrCPG6/gu1awM4p6h5jRbox7VjVhfZ
         mKsDtJcZx/MfCRw+04hIwNEtI+vtSBkVszrYyEWOu5VI+5P+WMgy57YrU0IKbHqFO22c
         pCne0EFIvgVNvDumkoSmhoah4VqH7yc2wuC8TVOdKf1wyXHdSX+c3n4J3GUtnYCl1iXj
         pHeg==
X-Gm-Message-State: AC+VfDzEZw7pvNTQMss4a4rCEm4gN8AP41z7M0SJxZIaLG5hrBqBsDzv
        gGlo00tHc3S4lj0/8hU9Epj0Qr2vsqcJDFlx2gYTsHO1EGDZBU0=
X-Google-Smtp-Source: ACHHUZ77XvY3N2+clQmovB0BYpuU6b6Mt4VnhEXOgMa9EA7Y4eFygYpSareAQxBLgDU7450lBoRAHKY6+p0bpaVoTvBZ3Eny92ZO
MIME-Version: 1.0
X-Received: by 2002:a92:cc43:0:b0:335:908b:8fb with SMTP id
 t3-20020a92cc43000000b00335908b08fbmr925354ilq.1.1685444216237; Tue, 30 May
 2023 03:56:56 -0700 (PDT)
Date:   Tue, 30 May 2023 03:56:56 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc339905fce70fee@google.com>
Subject: [syzbot] Monthly net report (May 2023)
From:   syzbot <syzbot+list0c78593482015785d68d@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 6 new issues were detected and 7 were fixed.
In total, 75 issues are still open and 1261 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6348    Yes   WARNING in dev_watchdog (2)
                   https://syzkaller.appspot.com/bug?extid=d55372214aff0faa1f1f
<2>  3665    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  820     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  442     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<5>  380     Yes   KMSAN: uninit-value in IP6_ECN_decapsulate
                   https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
<6>  322     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<7>  310     No    KMSAN: uninit-value in __hw_addr_add_ex
                   https://syzkaller.appspot.com/bug?extid=cec7816c907e0923fdcc
<8>  258     No    BUG: stack guard page was hit in rtnl_newlink
                   https://syzkaller.appspot.com/bug?extid=399cbcbb7917bd2f96ee
<9>  240     Yes   KASAN: slab-out-of-bounds Read in decode_session6
                   https://syzkaller.appspot.com/bug?extid=2bcc71839223ec82f056
<10> 215     Yes   KMSAN: uninit-value in xfrm_state_find
                   https://syzkaller.appspot.com/bug?extid=131cd4c6d21724b99a26

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
