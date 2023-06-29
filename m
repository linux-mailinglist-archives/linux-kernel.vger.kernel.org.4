Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6C47426A1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 14:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjF2MjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjF2MjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 08:39:00 -0400
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2902D51
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:38:59 -0700 (PDT)
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1a9e48f8e71so799837fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 05:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688042338; x=1690634338;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ri2JYlOaYtHZafIZo32KQWGFk/pE2ILLD0nllNwVvcY=;
        b=cnHFa3c8ynTbHAUy9EoJ9O+IV7otu1EyC3ergL6cyFMkEUMBd0+1iaIuftiyEo8kQo
         iI3HkRWeT+VGkmtx9JuxH37aMGcf0aINROgKLaInipjIpJUoE0ZJzAW4d4I8pykSynNF
         PFctLaX/bG+8E48fNf0O5EX/1IyamnOrV33Ee6Wx8BZlPnxcBgu7acORFGCVMSgjEH8i
         RUtNN4GYfOpRR9NqMvQlZT7LrN0HvG4CmqnoJOkpvNNYCzrEnH/lPXsSDFP++iwI5BGi
         Hr3jyJx98lFRHkUOSsTCycZ2qIRPoAqJEMfwFn6kspnLkAdIZwyCHoEX39G88FbfABn9
         09WQ==
X-Gm-Message-State: AC+VfDxWwdKPTWGB6BT0GxsxOBlOuYgIgPz+LI6Zq57CF3LUqnbRuBcm
        l6dsDzbiWSjimvW+P7bOsAG+hoMIG3yyOU4nuQ2xv72+4yIdOik=
X-Google-Smtp-Source: ACHHUZ73ccHNHkmGrMMtxxSN3oXu2sgCguKlQYncB65UvJPrG+qPRGx7VoGLcr1d4BraqUGMopM6mznJ+zSjV7rFkTz1912DUf+B
MIME-Version: 1.0
X-Received: by 2002:a05:6870:ed8e:b0:1a9:85e9:9376 with SMTP id
 fz14-20020a056870ed8e00b001a985e99376mr4008056oab.0.1688042338607; Thu, 29
 Jun 2023 05:38:58 -0700 (PDT)
Date:   Thu, 29 Jun 2023 05:38:58 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f56b8d05ff43fb21@google.com>
Subject: [syzbot] Monthly net report (Jun 2023)
From:   syzbot <syzbot+list6f38086e094c5ae7bf42@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello net maintainers/developers,

This is a 31-day syzbot report for the net subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/net

During the period, 8 new issues were detected and 15 were fixed.
In total, 78 issues are still open and 1279 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6422    Yes   WARNING in dev_watchdog (2)
                   https://syzkaller.appspot.com/bug?extid=d55372214aff0faa1f1f
<2>  3717    Yes   KMSAN: uninit-value in eth_type_trans (2)
                   https://syzkaller.appspot.com/bug?extid=0901d0cc75c3d716a3a3
<3>  838     Yes   INFO: task hung in switchdev_deferred_process_work (2)
                   https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
<4>  516     Yes   INFO: task hung in rtnetlink_rcv_msg
                   https://syzkaller.appspot.com/bug?extid=8218a8a0ff60c19b8eae
<5>  431     Yes   KMSAN: uninit-value in IP6_ECN_decapsulate
                   https://syzkaller.appspot.com/bug?extid=bf7e6250c7ce248f3ec9
<6>  424     No    KMSAN: uninit-value in __hw_addr_add_ex
                   https://syzkaller.appspot.com/bug?extid=cec7816c907e0923fdcc
<7>  326     Yes   WARNING in kcm_write_msgs
                   https://syzkaller.appspot.com/bug?extid=52624bdfbf2746d37d70
<8>  249     Yes   KASAN: slab-out-of-bounds Read in decode_session6
                   https://syzkaller.appspot.com/bug?extid=2bcc71839223ec82f056
<9>  193     Yes   general protection fault in scatterwalk_copychunks (4)
                   https://syzkaller.appspot.com/bug?extid=66e3ea42c4b176748b9c
<10> 172     Yes   BUG: corrupted list in p9_fd_cancelled (2)
                   https://syzkaller.appspot.com/bug?extid=1d26c4ed77bc6c5ed5e6

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
