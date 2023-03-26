Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33D96C95B8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjCZOf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCZOfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:35:55 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875B010D8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:35:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id h136-20020a6bb78e000000b00758b105cdd3so4102587iof.23
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:35:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679841323;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/x7cWDm3FjiX1M5IY5Hux/wGs8/mVsGCVwGkdGSq4fo=;
        b=OLEHv7ocdBKLBy9Pgr9vGjEekcwEDZEvhUSLeIw+qncoghaIYHwUcozGkZoCPb026K
         eNlQtcfM5FANlkmhFzTaC04tOyFXs7V29zHakk9i/6/bnURetD8w89vBhh6URyJnmii/
         Deb0V+dYEAzsByUdPMcx+M8PVfrRQrpJ2ZJtssxIHm4B/3oWgwNxx+wVEAnNgO+yo09L
         7DU1I1S355UXOWaNUaP4BoIK6J/5da16IwpmSy/kj0JIibw1hl9QXXooyrEA1p2+sJ5R
         ZVsSNyM5t5wvM/lv6Abst0ksdj6JrZb1xCGe+rZ3LbKxZOseJLoe9SCwfSmuCJCBSWKi
         0NDA==
X-Gm-Message-State: AO0yUKXFcPZyszhBJ2oJ8yTZQ3dEz2Wst5q5mJpyEsme4A34nXU6JnL1
        oTwPyFKqW52ZNcVaQU6KSw8x9FNTt6eTsmGzNOpJYKz4gR2C
X-Google-Smtp-Source: AK7set+I0bR+j6jKup1JDKEdp5gm35BxHX1alT381HS4L+SRirsWoSl3gt9bA2RlEFm/XOqKM2HjxNSim4PxzSV+WwSPjb6TCscx
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4984:b0:406:37fb:43eb with SMTP id
 cv4-20020a056638498400b0040637fb43ebmr9463163jab.1.1679841322818; Sun, 26 Mar
 2023 07:35:22 -0700 (PDT)
Date:   Sun, 26 Mar 2023 07:35:22 -0700
In-Reply-To: <20230326135941.2354-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000053656305f7ce896d@google.com>
Subject: Re: [syzbot] [serial?] possible deadlock in tty_port_tty_get
From:   syzbot <syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+223c7461c58c58a4cb10@syzkaller.appspotmail.com

Tested on:

commit:         65aca32e Merge tag 'mm-hotfixes-stable-2023-03-24-17-0..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12790be5c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8ef27c4ff127cda5
dashboard link: https://syzkaller.appspot.com/bug?extid=223c7461c58c58a4cb10
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11270cd5c80000

Note: testing is done by a robot and is best-effort only.
