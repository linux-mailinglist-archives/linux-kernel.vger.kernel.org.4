Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94855730B26
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjFNXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjFNXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:04:39 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA5A2689
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:04:38 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-340c149231fso4948945ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:04:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686783877; x=1689375877;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FvgsNZbMshDfWtJb8Ii39l/0H93uFx36WrvlKiAiTY=;
        b=ilJfzU0RihieIUkgWM/WmYubN8ZPfH2Jq+YFXkOfT04TXjDc2sQgFRkoWSB25/+OXC
         m5EFy2U4lcBPtv5NFTLV5qfikRSdawqlFc1UifrIrqTvMFavnUcbS8Cqtt/x1tJKbqqi
         aYHZEr/5kw1c1Ejpmff1cIYre4e81KVKMnNhKpOQ/doyaGr4VbBtd0xDzRabZ7bWMD1M
         E0G9neNTmTssY7MF0nHUhwHlQrZl6vnU4G8r9/EO+ZoTL+2ccBeIbE9uXcLqBpwlfYXj
         +UBTC3xu5soryNcg8M2UIbAy4QW0UkhUFXbYyYLURdxeFpNEiYLvCHgHEKjP8zdZvh6F
         owCw==
X-Gm-Message-State: AC+VfDybdi2AawZnax0nuy2wonVaYl9TpSxZwqbc72IwXHLJ37f4f0DY
        kED3INZZueAmlLsf8tjmLfJGw0PY1xiLEMkFIbUbWriq/TKK
X-Google-Smtp-Source: ACHHUZ5ythZ0Axbf1hC7Gjy6i3ZBawNjy0uyb3Fi9JiOPPifmsSE16NxhTszqGRP/oFDB8ZLyVWcQMYnLmTHD3TUcqhitl24el+B
MIME-Version: 1.0
X-Received: by 2002:a92:d4d1:0:b0:33b:f9b5:d6c2 with SMTP id
 o17-20020a92d4d1000000b0033bf9b5d6c2mr7195369ilm.5.1686783877405; Wed, 14 Jun
 2023 16:04:37 -0700 (PDT)
Date:   Wed, 14 Jun 2023 16:04:37 -0700
In-Reply-To: <1634372.1686755343@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d3650205fe1ef98f@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_export
From:   syzbot <syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+472626bb5e7c59fb768f@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=149b6617280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=472626bb5e7c59fb768f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154a41fd280000

Note: testing is done by a robot and is best-effort only.
