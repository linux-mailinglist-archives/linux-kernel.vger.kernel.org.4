Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9057863B7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbiK2CTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiK2CTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:19:18 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919BF286EA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:19:17 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id n10-20020a056e02140a00b00302aa23f73fso10766755ilo.20
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:19:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvnDovLeDuInchJptBNgxNoEypnm0+Vt27KZxiRTKlQ=;
        b=hbBQ7o5mOmVjrIUyJRqs+mDJjKLKKImq6BMcqw7r/woekvOoljxTpNN0Pjj+yKaSH4
         AN0ihYvVcnr2/l5meCOzP1nrpFBGAiWGLCDc143sXt4RZv2blsesOjqdweXdtoVIwjOn
         rIg8EMd5hOy3F8a8c1HYxTIjT6YBbQLhI2b7MJHdEyY1+mYdsWwLZcJuFGRm28EGJhUM
         92aCws03U1mVNtC3BqCxbeb5H7R3hBxe6m9Qpz4h2WjzZk4is3NNKzzsTUljDK2d4qUI
         w1R9S5h81/BVK9sclBiO52ukro8ZJ9oGhguzJE58gFIs0gq+HICpIRwTqyd2dP1ChJZM
         c8xw==
X-Gm-Message-State: ANoB5pn5v5YkesaBWqIQwWrNK3eelV4eUkIUBz+UE3WFu0+Kbc+DPJyw
        uz9z+1RrJukPTwgJwm49mRLa+O74ycVi43hbli9SxSr91swN
X-Google-Smtp-Source: AA0mqf7SGcNIOjzFbnX0ZAiiodzMwRO1bVnC80lUilYmFfuYWeoxJc9aEAvs3ctvhF0KdeKge40ja2CFd0H+1Fka8DHmIPOj8DSl
MIME-Version: 1.0
X-Received: by 2002:a02:6a43:0:b0:375:4725:4b4f with SMTP id
 m3-20020a026a43000000b0037547254b4fmr25319788jaf.52.1669688356927; Mon, 28
 Nov 2022 18:19:16 -0800 (PST)
Date:   Mon, 28 Nov 2022 18:19:16 -0800
In-Reply-To: <20221129020406.6126-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000066824405ee929d2b@google.com>
Subject: Re: [syzbot] INFO: task hung in nfnetlink_rcv_msg (3)
From:   syzbot <syzbot+9204e7399656300bf271@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: rcu detected stall in corrupted

rcu: INFO: rcu_preempt detected expedited stalls on CPUs/tasks: { P4102 } 2679 jiffies s: 2805 root: 0x0/T
rcu: blocking rcu_node structures (internal RCU debug):


Tested on:

commit:         08e8a949 net: wwan: t7xx: Fix the ACPI memory leak
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14bd02ad880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60808f80d41c27e5
dashboard link: https://syzkaller.appspot.com/bug?extid=9204e7399656300bf271
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=173c8fed880000

