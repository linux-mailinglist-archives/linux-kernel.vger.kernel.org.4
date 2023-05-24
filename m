Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B270FA4D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235591AbjEXPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjEXPey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:34:54 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F26119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:38 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7606e3c6c8aso73366639f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:34:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942467; x=1687534467;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/Qb95V1iOyhOuQYWTFvMei40qKXu9p08DPhqv0BihA=;
        b=YcUL4kryterEQJPaRvj8YVD+QrIc8HEqHelJ+vAxS1gvMrxWkk6mRZOJgj6DAt0a84
         ZTgWIlCUbBlWtr5ZGEgYLBWx+mdtOcGslKLQgvRImU4RRM7yCuF6s8RP6IkzFDjf9C6Z
         Ic7ACyb5+hJyk6QrGnxP7LZXBXrQbIZ99IYhRY1VXMzL2CmFkvmnrxCHgZIQHpl5kX2L
         pb2c+cFmz/SEtgQOh7xMmmq06xlR08aC9o4m3kp3qRowbJm26a9m1NBFrsGTFkOkZbGx
         gjAcOnhihMyCRDDkAnAqiFhXxvsXm8F1BYWc5h6MOIRsdgyvQE0ZIBqLrI9vXjWXzGOv
         /a/A==
X-Gm-Message-State: AC+VfDxGcZFlKyenjEEfT5YmlGpHywfycYd3unnP3pxj+gFGOuf9i/9g
        Sz0OlhkDyG87F2Fx2U8P2TZ9dLT0eZnarhLEUoNHBwK5hw9K
X-Google-Smtp-Source: ACHHUZ6q5mO1T8gb2eI3lddVojNyJnQ4DpkZF8v0v5RpIr3dT2WS/6KdBB0hkPjO44QtlWvJMFdZ7X51TbycGEQZ6z10SZfqpLAn
MIME-Version: 1.0
X-Received: by 2002:a5d:91ca:0:b0:772:aa31:db2d with SMTP id
 k10-20020a5d91ca000000b00772aa31db2dmr8623470ior.3.1684942467357; Wed, 24 May
 2023 08:34:27 -0700 (PDT)
Date:   Wed, 24 May 2023 08:34:27 -0700
In-Reply-To: <b811578d-bb53-f226-424c-7d2428ffd845@mojatatu.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003bdf7205fc723d47@google.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Write in mini_qdisc_pair_swap
From:   syzbot <syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
        jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com, pctammela@mojatatu.com,
        syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+b53a9c0d1ea4ad62da8b@syzkaller.appspotmail.com

Tested on:

commit:         6078d01d net/sched: qdisc_destroy() old ingress and cl..
git tree:       https://gitlab.com/tammela/net.git peilin-patches
console output: https://syzkaller.appspot.com/x/log.txt?x=111cf24d280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b22b5699e8595bcd
dashboard link: https://syzkaller.appspot.com/bug?extid=b53a9c0d1ea4ad62da8b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
