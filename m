Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D643744871
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 12:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjGAKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGAKPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 06:15:09 -0400
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF88271F
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 03:15:01 -0700 (PDT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-262d296873aso3241903a91.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 03:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688206501; x=1690798501;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=diYwR8St8wT/i4D42MCVrfW4HzrpsotIwwPSjUegdyU=;
        b=HGFc664hBVLwinwrZGacXk/PGN8jgfo8ihKUw6zkhQ+pUYl3F2oTCnzwO3PP4yiVLM
         BoHRPUpgoR53elxwBVPNmx7/0FCaELJFdw6A+J0/sUvlRWw/UhDv90TElHeI0FbAYze8
         CbD/vBl08fniLKWF7gwd1SC46YZAlNQrDK26aiGZ4z76Fh8c5vvO5IhJ/OdvHOiIiL7F
         IdHJ4As0HvGanuyzfyanoYqX6TCwZFqm31BL2jIp8DHKrfK95BU++Mo54dBgSat7ixHe
         NcBSBQi9+zWOwxQka4E3EIRpzztrJpyol74TjjXzEv2BA/A+kkUfKkIHWIEEK1KLJxea
         3u5A==
X-Gm-Message-State: ABy/qLZ532BOPkwAbzbkzmu5E0UvCSjgcnXjIOAlEejKSG7Nd3m0mnyP
        /SBaurx8H8zbCuoq261pawGzOV2BZkrBbVgQvyx/B1T67i34
X-Google-Smtp-Source: APBJJlEF5a3l1q7Wnrn+Ygt2UYSCsqfnQ8ezPqLr8UHxZeYV97v5qZaRe7f38JRnFSGZ63a8P8cKE3iXGLlQaD1gk2cabNkj/en5
MIME-Version: 1.0
X-Received: by 2002:a17:90b:104d:b0:263:3437:a0b0 with SMTP id
 gq13-20020a17090b104d00b002633437a0b0mr3469094pjb.3.1688206500959; Sat, 01
 Jul 2023 03:15:00 -0700 (PDT)
Date:   Sat, 01 Jul 2023 03:15:00 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cc19d705ff6a34b0@google.com>
Subject: [syzbot] Monthly bluetooth report (Jun 2023)
From:   syzbot <syzbot+list7e4ace863c2ed3815e4c@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 53 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7085    Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  3793    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<3>  1152    Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<4>  1055    Yes   INFO: task can't die in __lock_sock
                   https://syzkaller.appspot.com/bug?extid=7d51f807c81b190a127d
<5>  95      Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<6>  42      Yes   WARNING: ODEBUG bug in put_device
                   https://syzkaller.appspot.com/bug?extid=a9290936c6e87b3dc3c2
<7>  4       Yes   general protection fault in hci_uart_tty_ioctl
                   https://syzkaller.appspot.com/bug?extid=c19afa60d78984711078
<8>  3       Yes   general protection fault in l2cap_chan_timeout (3)
                   https://syzkaller.appspot.com/bug?extid=f0908ddc8b64b86e81f2
<9>  2       No    KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 1       No    WARNING: refcount bug in sco_sock_timeout (2)
                   https://syzkaller.appspot.com/bug?extid=c689847e27e0fa3e7a5d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
