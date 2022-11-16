Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A9F62C719
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234852AbiKPSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:00:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233829AbiKPSAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:00:21 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909761BA4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:00:20 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id i8-20020a056e0212c800b00302578e6d78so7220517ilm.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 10:00:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ycgML46GVnsWZeJ4w7iB/iE60xPyJH5cRCy0usl0TcE=;
        b=HtfmrncxtTqiTn33MPLNCle5lotNZdi9AXlsCWwRb+LbWdet146buo032E25Axz70u
         TeLnCNzusXVh1FXlrQTySw5G8Qmtne15RKi2z06R4nR7Tbyuf2/xjXdYDW9UrXMg5mem
         jBCB20oMLNqMXyj6jTjzlvH4KSoS+yRC6taUb/3TCR+NDp4xJ+J4Etq7kGic3e/nMq9t
         NOLnIBSOh6IIX9psxO8rQ8GXUQKFlzIf7j8RaCNUcAxWbGYCF2lPi/YpnKb1SBpyCkw4
         GTz99OS1i+rs674BnbQVsDje48HNF5oLW7oY4fVq1p6j23pCtm45IlgkHWw++u02w8ce
         wVQw==
X-Gm-Message-State: ANoB5plini1Een0gz/3a1hCt5uDEZ5L2jAFgpDrNuIH3Fei6acg3NPtd
        /hwjrwYM66CTtSdTT7iyOHBrGFuQ+Ob+8Va/lND1I7FCdykm
X-Google-Smtp-Source: AA0mqf5NtoIlGoJ2s3JWmc44IFhUzxfdBe1A5rYNXkxFD59dySblOo06dnvl7e4yNEM1ogQwETU7n+4Oiku6UbAgzWxTktgKwZlb
MIME-Version: 1.0
X-Received: by 2002:a92:d8c8:0:b0:300:a79f:c8c8 with SMTP id
 l8-20020a92d8c8000000b00300a79fc8c8mr11819921ilo.206.1668621619981; Wed, 16
 Nov 2022 10:00:19 -0800 (PST)
Date:   Wed, 16 Nov 2022 10:00:19 -0800
In-Reply-To: <110c82d2.191982.18480907a32.Coremail.linma@zju.edu.cn>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec751205ed9a3ebb@google.com>
Subject: Re: [syzbot] BUG: unable to handle kernel NULL pointer dereference in nci_send_cmd
From:   syzbot <syzbot+4adf5ff0f6e6876c6a81@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com,
        krzysztof.kozlowski@linaro.org, kuba@kernel.org, linma@zju.edu.cn,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+4adf5ff0f6e6876c6a81@syzkaller.appspotmail.com

Tested on:

commit:         1c96c97c nfc/nci: fix race with opening and closing
git tree:       https://github.com/f0rm2l1n/linux-fix.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=12f48735880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a2318f9a4fc31ad
dashboard link: https://syzkaller.appspot.com/bug?extid=4adf5ff0f6e6876c6a81
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
