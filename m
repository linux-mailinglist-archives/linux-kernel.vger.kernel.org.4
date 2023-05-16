Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882477055A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjEPSIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjEPSIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:08:31 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F82A7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:08:29 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-331632be774so45523775ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684260509; x=1686852509;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7cfmVckDHddvRqZ8odcZBeCbYSIduTckoQySA1Yp2w=;
        b=gtIrTMlf3QZlLIOmrohzrE57CX/9DYhXhA+QKjRApxZ+V5jBOvRMQZWKjmRbu2OSrk
         3WQ7uc7HMs0wdWVuadTam05pWv8J4OSvijFRsmR/h7xeN16+oGTlS0dpN6KlJlotrmg4
         R7s9MUHDEdO9UiXqyqo7H0FUigdORP9/mevpL5xFkI7RT1g/U0EVYU5XvWIQXF0REE1o
         Abfm9bgCI1O8kWuDpOulP+VZsK638DJzlI0sgg2fqIEM7I5xFK8S85d/DdG6Lf71H8Tq
         YAHEuqsrS9bRrbRK5/IlhRxAYR/a2DHPpczF2uRR76sYiNIoIJEhYJ6tovTVgT1W6D4D
         Sv6g==
X-Gm-Message-State: AC+VfDwRQG4Q9E7A66dxY5lPowdWzBwQgzF7F71YzPZfb5b2XHgf5Lq4
        SwmKGxC2cDJIWO2L8S6PAtJ3W1MKBo8mB+xdlfrtdKtglU18
X-Google-Smtp-Source: ACHHUZ63BE9GYHrroUdVptFYUVNfxy+8tYlUHvBejzt2rUT9DhZdFrbd4+sq88RXmQVswjnq12HB6/+V+e7muZaqmwJn/Q3txz7K
MIME-Version: 1.0
X-Received: by 2002:a02:862b:0:b0:418:81f5:6f39 with SMTP id
 e40-20020a02862b000000b0041881f56f39mr6649927jai.3.1684260508921; Tue, 16 May
 2023 11:08:28 -0700 (PDT)
Date:   Tue, 16 May 2023 11:08:28 -0700
In-Reply-To: <CAMj1kXH8B6dmt0LVVyyorAzrKmkD2uFZ-5r4w0kMTYKbhqSPMA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057f58705fbd375a3@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in __aria_aesni_avx_gfni_crypt_16way
From:   syzbot <syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, ardb@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, davem@davemloft.net,
        herbert@gondor.apana.org.au, hpa@zytor.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a6abcf08bad8b18fd198@syzkaller.appspotmail.com

Tested on:

commit:         d5253ed2 crypto: x86/aria - Use 16 byte alignment for ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git crypto-aria-x86-fix
console output: https://syzkaller.appspot.com/x/log.txt?x=17fed781280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8bc832f563d8bf38
dashboard link: https://syzkaller.appspot.com/bug?extid=a6abcf08bad8b18fd198
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: i386

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
