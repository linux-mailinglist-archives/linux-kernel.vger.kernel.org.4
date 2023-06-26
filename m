Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724D73EA77
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 20:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjFZSt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 14:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjFZSt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:49:57 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B1010E2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:53 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7836c6fb18dso28514139f.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:49:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687805392; x=1690397392;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IuXXxOMOQsKpH0IiTxt7W05d750a7OWAfC/BfXgyHFU=;
        b=f1/Zpe6GVhpjKDQyxl4LZZ7OwJ8aF8kLSBra50Ja6E4FiqE01mGf8P6WUcEGXop8gW
         r8LA8nHnTLaTxq/GsmQnhl6NJ/T5iu/8RSvNzUfu5ils0TIA3mtu1pjGI335nRBAEpup
         svjqklXILUIQ0EI+KOu2ccC92ygyFUkF0vlyEPrmzoAQskBtjvuHixZkrRWA68/X+XWo
         cxQmdWGiHZ73raozHdTuDMfQcYJTX7nn9EwP+/IX0Fu+rYtHtaXK6V/LEEcuOFWELpYL
         SBnXK4R4JNjxRTnv5PxASfxZFUifR1zrloMC9o2q9F4qJeeJ5foIs5F1nXLxpbTHEJzD
         YYpw==
X-Gm-Message-State: AC+VfDxVDO0E3qLUGeHaGAFok09RWOI5+0a4plkZ7Sgb36Y1YgtDC+MW
        +UC8+hl7/U5K0TpNdmvFsMfN+/LgVgdUZhjJqwt0QWFsfaqLCRw=
X-Google-Smtp-Source: ACHHUZ4jNMF2H4NMBFXcMoi3KjwvDlE7FzKi0KvJYnVZN7j0pe3t0HHmF8KlJKQ+186eCZmTGXCCgL0fL+geiRaEYiIdq8lPswZ4
MIME-Version: 1.0
X-Received: by 2002:a6b:7113:0:b0:780:d446:a209 with SMTP id
 q19-20020a6b7113000000b00780d446a209mr4307414iog.2.1687805392498; Mon, 26 Jun
 2023 11:49:52 -0700 (PDT)
Date:   Mon, 26 Jun 2023 11:49:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000deb56005ff0cd0cc@google.com>
Subject: [syzbot] Monthly wireless report (Jun 2023)
From:   syzbot <syzbot+list6f49fd7432bc9a1abef8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 0 were fixed.
In total, 33 issues are still open and 106 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7542    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
                   https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
<2>  5766    Yes   WARNING in ieee80211_bss_info_change_notify
                   https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
<3>  4308    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<4>  4188    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<5>  1163    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<6>  1136    No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<7>  806     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<8>  669     Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<9>  640     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<10> 416     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
