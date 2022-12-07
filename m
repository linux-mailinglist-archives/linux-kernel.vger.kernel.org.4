Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D735A6464E1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiLGXQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLGXQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:16:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100A988B67
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 15:16:21 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id a11-20020a92c54b000000b003034a80704fso11265429ilj.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 15:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPVql0dVm3BxrCwPiGc6AiQiIEcXU1yzGMmr3t8ps3c=;
        b=8B1n+RTAasccQw8EzdFfTt2dfURuorEDmNmsaRAdrMCSvP0tMfI0RLBp5FDBxXRlq+
         YdyYYlachFUtg+eHlzF12jA6FrMJKkOxppR4kXPYkzEKbIj0NhEk/MLILRNHUdBdcx9e
         mAM02WYIKaBBybTAlUfxjgeHhREs+YUwk1B1ZGFxf0oNNU3Zs+HzWsQ90AFoaJES3fh0
         /tOFbIauSIriGc1eQrvllL4SLmFo1slVftmQ4ZFEKvI11kbbCMi5EAXLRyISbERT22PS
         hBYoGFOjbga4MrdENX4y9eBAWKF50Ieeq4K+QkvK6vOs/NUTRohn6pKnu7tvM6CX90/l
         +XEw==
X-Gm-Message-State: ANoB5pllUvj6pDf/xhU0lKSEH2CccWwV8tdjqdjDtD0NUv5+fPf0DJ7U
        8d1OzLQp++qzAKWuuT9Rj9Brcpze4P0EPBaEx/D36SGR5S5O
X-Google-Smtp-Source: AA0mqf7XpmJgyIxWRVMPWgwtWEezWbR9GRv3RL9k8HNQHy9fV7ck5KOFth0hSntK8RYoaEdFbb/GC+pNQ3+OUacdSw02DJIyQxmC
MIME-Version: 1.0
X-Received: by 2002:a6b:cd8d:0:b0:6e0:d9a:2898 with SMTP id
 d135-20020a6bcd8d000000b006e00d9a2898mr6682695iog.99.1670454980453; Wed, 07
 Dec 2022 15:16:20 -0800 (PST)
Date:   Wed, 07 Dec 2022 15:16:20 -0800
In-Reply-To: <1543008.1670434984@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b92ca505ef451b46@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rxrpc_lookup_local
From:   syzbot <syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, marc.dionne@auristor.com,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3538a6a72efa8b059c38@syzkaller.appspotmail.com

Tested on:

commit:         a2220b54 Merge branch 'cn10kb-mac-block-support'
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1589fa4d880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c608c21151db14f2
dashboard link: https://syzkaller.appspot.com/bug?extid=3538a6a72efa8b059c38
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1473515b880000

Note: testing is done by a robot and is best-effort only.
