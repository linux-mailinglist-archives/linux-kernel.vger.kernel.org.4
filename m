Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FEF6C8A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 02:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjCYBvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 21:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCYBvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 21:51:19 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA74C16A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:51:18 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h7-20020a5d9707000000b00752fe6c68d1so2146831iol.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 18:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679709078;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JT4ol3JHeQINL+/YKHpG5bjwK2jRO4hxRQmODF5OOzM=;
        b=nrXppRzqrVWYA9kvGwOrVOyx47yKAHhAqFpVUFgLyFjxNIErK7HQIBbHpV6IoQxQ4a
         eJL5QkqnsWjfs19yQPLbhQn0IJagHs01WFMyZDCEA0I2nh7IlvZ9Uj63jYltThQRInhj
         9bM4m6gQ8mAub9ZErRAwH9MIwgYkKafK+HXw3yF7smPaHATWdfMrdTftcS4fNt2peFDz
         Mxe23pa0LscSFP640qJY030X9uW35nQwjhRyyxqtJp7uw0WW20q8Q43bilAd/YxYBkrx
         9uB839/dvhqSKyOZVzwAXh095CqLUwdNeFEFT0DeUDgtGKpyPooRNsxvqFbDunJ66uCe
         GYDA==
X-Gm-Message-State: AAQBX9cfqmIMt8nFINVjI9sWY1DjFwCl9xFWCr3jknLTzxIQKdq7rMSe
        sLCbEqp9f064Y1uAdLBGiqg79YrDZoMAYaghZ3rNsFL8bdUN
X-Google-Smtp-Source: AKy350YntPKEsd3v8U4AWLgHNbuKjAALLo0fe0mlldwKRaWcy0ZZ/wP9SBE7J/wSAVAiTaz4EgIe8U0z+1vPxiBAP9kSxgRgY+Zr
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1be1:b0:325:e0bd:d1c7 with SMTP id
 y1-20020a056e021be100b00325e0bdd1c7mr1722798ilv.2.1679709077861; Fri, 24 Mar
 2023 18:51:17 -0700 (PDT)
Date:   Fri, 24 Mar 2023 18:51:17 -0700
In-Reply-To: <20230325013831.1826-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e97c0005f7afbe1e@google.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in switchdev_deferred_process_work
 (2)
From:   syzbot <syzbot+8ecc009e206a956ab317@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
SYZFAIL: initialize_wifi_devices: failed set up IBSS network

2023/03/25 01:50:35 result: hanged=false err=executor 0: failed to write control pipe: write |1: broken pipe
SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:50:35 result: hanged=false err=executor 1: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=1 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:50:35 result: hanged=false err=executor 5: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:50:35 result: hanged=false err=executor 4: failed to write control pipe: write |1: broken pipe

SYZFAIL: initialize_wifi_devices: failed set up IBSS network
device=0 (errno 132: Operation not possible due to RF-kill)
loop exited with status 67
2023/03/25 01:50:38 result: hanged=false err=executor 0: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:50:39 result: hanged=false err=executor 5: EOF
SYZFAIL: wrong response packet
 (errno 16: Device or resource busy)


2023/03/25 01:50:39 executed programs: 29
2023/03/25 01:50:44 executed programs: 34


Tested on:

commit:         65aca32e Merge tag 'mm-hotfixes-stable-2023-03-24-17-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12e930b6c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a2ca2de6ed94982
dashboard link: https://syzkaller.appspot.com/bug?extid=8ecc009e206a956ab317
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16379cfec80000

