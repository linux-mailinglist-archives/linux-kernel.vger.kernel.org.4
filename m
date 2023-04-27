Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6296F0463
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243622AbjD0KqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbjD0KqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:46:16 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8560A5586
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:45:56 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-32ab192a7b3so59069385ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:45:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592355; x=1685184355;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3KK2b0Uit7K5gftG0SKkRqRBmSCncAWQ6WB0lbgTGI=;
        b=L1eyiqFSXy8o3GtJ6i4x7NZiGa/vPtFqm7/fjSp+HFnfGXNftTs780FlJMjMbMBmRp
         Ay5twXebHh2zkp9GHta1N4PMSvFbSDvR2oaww75/SstHIR98T6MSo+HuUaSW9uSoEs1r
         j01VM1+dbenw+pn4kQ5o5EtI3jw6ApCujZJn+T3aYVuG2o22Ah3AdC53G/p83NUAe17A
         0TEAYWJAXB29dR1H47hc8bQuP0X+Js8vCBVliXK6s2FjkfwLdgyhfHum6H0I60DY+txJ
         rod6JeJD/i583sLB5BcJBRXKQbB2vWLUNUkkwYTGCQTKSFCMRu3fijHgntJf1Zf4FNJV
         y1ww==
X-Gm-Message-State: AC+VfDx8Ze+OUcpAocay4S4PTlYGZ+3k+hx78iUJhvHyYKuLJfORIJHJ
        qgVCsPe4TxvZo6skt7gao4cnQywjE1Xqs1AFOn2fJoZCuKIXvhU=
X-Google-Smtp-Source: ACHHUZ5IsR1lZsE9Oa7t/kcvjOIgrZEhiUBJf+S9CaFl3BWEjHg3z8ZW3HHZU9DrlipP6na2XrbEVmsYuM/5fDZTgUw6MWw5PRnA
MIME-Version: 1.0
X-Received: by 2002:a92:4b0b:0:b0:32b:a8bd:50f7 with SMTP id
 m11-20020a924b0b000000b0032ba8bd50f7mr1020954ilg.2.1682592355631; Thu, 27 Apr
 2023 03:45:55 -0700 (PDT)
Date:   Thu, 27 Apr 2023 03:45:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8ca8005fa4f0fcf@google.com>
Subject: [syzbot] Monthly net report (Apr 2023)
From:   syzbot <syzbot+listb31ed88c701752b673ce@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
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

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 4 new issues were detected and 10 were fixed.
In total, 77 issues are still open and 1247 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  43630   Yes   BUG: MAX_LOCKDEP_CHAINS too low! (3)
                   https://syzkaller.appspot.com/bug?extid=8a249628ae32ea7de3a2
<2>  6296    Yes   WARNING in dev_watchdog (2)
                   https://syzkaller.appspot.com/bug?extid=d55372214aff0faa1f1f
<3>  3632    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<4>  2604    No    BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low! (2)
                   https://syzkaller.appspot.com/bug?extid=9bbbacfbf1e04d5221f7
<5>  815     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<6>  431     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<7>  347     Yes   KMSAN: uninit-value in IP6_ECN_decapsulate
                   https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
<8>  318     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<9>  288     No    KMSAN: uninit-value in __hw_addr_add_ex
                   https://syzkaller.appspot.com/bug?extid=cec7816c907e0923fdcc
<10> 272     Yes   BUG: MAX_LOCKDEP_KEYS too low! (2)
                   https://syzkaller.appspot.com/bug?extid=a70a6358abd2c3f9550f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
