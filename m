Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A047123E5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243161AbjEZJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbjEZJj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 05:39:27 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B67170D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:38:56 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7748054f861so262010839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 02:38:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685093935; x=1687685935;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HZDBnsdsW0y73fGsliM6Bx8oo1s3VdarCwOTBqSzGCc=;
        b=QfMhOVs5AAsXEOq4dMM5/tpEG5DwXCOmJtfoVk76IJQRvDy9jOSV0cd5YYvdFBZwZi
         eqy/vCovUIix1+4YLHuaJ9tndnap86ong9c2hON9cf9O7hptfc/xYUR9jk9QlCqU5dua
         EtSV5WiX9LTKRSCOw/xEP7cmJVa510aQpZQ4hRxa3BEU5frhbIP4p3gPOucbZhBWfq6a
         T3Ekm7kZyszemJlIkn2QbRH2KwWmJhbiXJjqEiVpc2ySxLQTBN61lLedbZCj/R2meXb2
         7czEsyx9p98mPWjwhWHZeI3IDtCO0baHeRcs19sji4m6DvImKMbF68FW565TZiu0xvR7
         Ny5w==
X-Gm-Message-State: AC+VfDySyF1tLLzH3RtMNMe8QuhIvtuw3oPaFsjqVINxxw8hoHET7rEs
        YMP1egaCrXywsIHzcdk9ku1WTxIyzKGCh0XVMmkC+FARYVsaXFo=
X-Google-Smtp-Source: ACHHUZ6t1Y3iFCF2npLfihazO9ZT5NgGe7L9XEVUDso+2xdttDxLQyGeEKhxr8sGfwtCbfbidzc9r8MsAPP34lifzG+mi5e2N8+x
MIME-Version: 1.0
X-Received: by 2002:a02:2983:0:b0:411:b866:8345 with SMTP id
 p125-20020a022983000000b00411b8668345mr430480jap.0.1685093935718; Fri, 26 May
 2023 02:38:55 -0700 (PDT)
Date:   Fri, 26 May 2023 02:38:55 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073a88805fc95817f@google.com>
Subject: [syzbot] Monthly wireless report (May 2023)
From:   syzbot <syzbot+list132aa227160b7dc530f8@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 0 new issues were detected and 1 were fixed.
In total, 33 issues are still open and 105 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7256    Yes   KMSAN: uninit-value in hwsim_cloned_frame_received_nl
                   https://syzkaller.appspot.com/bug?extid=b2645b5bf1512b81fa22
<2>  5107    Yes   WARNING in ieee80211_bss_info_change_notify
                   https://syzkaller.appspot.com/bug?extid=09d1cd2f71e6dd3bfd2c
<3>  4172    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  3892    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<5>  905     No    WARNING in ieee80211_ibss_csa_beacon (2)
                   https://syzkaller.appspot.com/bug?extid=b10a54cb0355d83fd75c
<6>  802     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<7>  721     Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<8>  597     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<9>  362     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                   https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<10> 240     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
