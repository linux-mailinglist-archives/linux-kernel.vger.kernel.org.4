Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952FE71800E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbjEaMi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjEaMiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:38:55 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50082123
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:38:54 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7749b49ce95so342015439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:38:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685536733; x=1688128733;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M56dqXczIU6urpVTidNU/2Z71eUaU2aQUWl7WsKSTRA=;
        b=FIstYQaIXqyqqQbBIZ0eRS6YiGT4OJ6pnI/v9lgtN2/DfvtpCQQqojuaKwGOUp8Fg3
         G1AhuPjaqi+ARCp9aCITRDyrQ328gRZrsqKXk99VBfc1S6pKo8WTcyge+jO2oob/EDPy
         hV3NOT7fenyoN5YmctNh1pwlpedCqDNU5+aCySpwgvgPgzdBenEeCHbA4EVSDG5tvKTc
         yR6XZzUWDO6wzWpg6TobgcgkFMRigBgJ2WFaDQ21P++BaQRjoWKXft8UUYktCJFQ3RhU
         paWYpfQWzPhuxu9zweePcrTZvoTLJnAV/Urh4KW37urZVrJO2CIA9RGpfBFPvGeM3BwD
         olrQ==
X-Gm-Message-State: AC+VfDyaiUzDvbJ+wIVqrX1iImYdxwo9LblTnSWVtJSQ0K17zZVEZ32p
        RZsJp1V7XqabMTj07SzeAw8xC94xblxcPznvvMB47CFDbLwD0d4=
X-Google-Smtp-Source: ACHHUZ74o2Cy7S+5TJut5f94vXmrF3Gr56M4P1NQwSf2gyDkdwYCHmqVaYYRYNCp366WKh4TDLkJKz8QZGSf4S6yOKYmyE3A1De+
MIME-Version: 1.0
X-Received: by 2002:a5e:8a4d:0:b0:776:fd59:f980 with SMTP id
 o13-20020a5e8a4d000000b00776fd59f980mr2056443iom.4.1685536733644; Wed, 31 May
 2023 05:38:53 -0700 (PDT)
Date:   Wed, 31 May 2023 05:38:53 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000043ce4705fcfc9a3f@google.com>
Subject: [syzbot] Monthly usb report (May 2023)
From:   syzbot <syzbot+list5ddc103e11539454fe04@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
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

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 4 new issues were detected and 4 were fixed.
In total, 64 issues are still open and 319 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  2373    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<2>  1818    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<3>  1751    Yes   KMSAN: uninit-value in mii_nway_restart
                   https://syzkaller.appspot.com/bug?extid=1f53a30781af65d2c955
<4>  778     Yes   INFO: task hung in usb_get_descriptor (2)
                   https://syzkaller.appspot.com/bug?extid=e8db9d9e65feff8fa471
<5>  653     Yes   WARNING in smsusb_term_device
                   https://syzkaller.appspot.com/bug?extid=40ac6e73326e79ee8ecb
<6>  293     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<7>  273     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<8>  237     Yes   INFO: task hung in netdev_run_todo (2)
                   https://syzkaller.appspot.com/bug?extid=9d77543f47951a63d5c1
<9>  180     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<10> 174     No    INFO: task hung in hub_port_init (3)
                   https://syzkaller.appspot.com/bug?extid=b6f11035e572f08bc20f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
