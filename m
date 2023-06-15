Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0D732145
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjFOVCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjFOVCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 17:02:30 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228F3294D
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:02:26 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7773997237cso865629939f.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:02:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686862945; x=1689454945;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4hXMNSzNgX9qcNCtjmUZbMdzYOaYR79wSe3L4m7Iq0=;
        b=dpY3WUmlixGIQden3id2cBdoEzfRBtLJ+Q44+GzdcI4rEHhqrfgQ1UU/cjVYs/Fb3Q
         DtID4WbujEjA/kPdwR6wozr2AOE6+3Qhpviv+St6reeb/LyqY5Ev+GF0Ckt47fWT3zlg
         xp8HWuPHLTHQGxznFVuMwO5BLQDXPjYnFPIvvXwrMy2tqgjuG5eKjTcpCXpvDSyW9zkO
         MKL2srG2M9ZpoQmSb/LBSSe/WTR2LKUn7gRKqCzvlPnVM8xHnq09AIdT2CPhp5CEkxBz
         oj9XCSkQQdOEcolGcEzW1n6PRraKtX5RxiaFNo/mvoL5JJ+u2cJdZ1Z5L9iooTaU3aZW
         q1QA==
X-Gm-Message-State: AC+VfDwddxekwS9oSActO5FELgyToBF5gs0TXDQUfeC3fZY5C0ODNAKK
        nngLwUOVNZDFdxOrRCw265pZpsP4RBr1JlzuEjabmuuCMD9t
X-Google-Smtp-Source: ACHHUZ6USDC6PDWcEo+gfpDJs9g2SM4qwmGn+hEQt8nQOfRMl2i2RpbGbn/LJN2jsjD6+hkn/9TTEE0EoYZWM6rU7UkLMOgtbQUB
MIME-Version: 1.0
X-Received: by 2002:a02:a18f:0:b0:420:d53f:2821 with SMTP id
 n15-20020a02a18f000000b00420d53f2821mr90094jah.5.1686862945444; Thu, 15 Jun
 2023 14:02:25 -0700 (PDT)
Date:   Thu, 15 Jun 2023 14:02:25 -0700
In-Reply-To: <262282.1686860686@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a5e86b05fe316253@google.com>
Subject: Re: [syzbot] [crypto?] KASAN: slab-out-of-bounds Read in extract_iter_to_sg
From:   syzbot <syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, kuba@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+6efc50cc1f8d718d6cb7@syzkaller.appspotmail.com

Tested on:

commit:         97c5209b leds: trigger: netdev: uninitialized variable..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=13705753280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=6efc50cc1f8d718d6cb7
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10d19cbb280000

Note: testing is done by a robot and is best-effort only.
