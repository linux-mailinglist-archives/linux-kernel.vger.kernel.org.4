Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B10730AFD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 00:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235452AbjFNWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjFNWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 18:51:34 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3772A1BF9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:51:33 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-34128d59c06so3068565ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686783092; x=1689375092;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvWGvGEYVDY0zHX9FKywaaz8rQNIa9z0Aga8elPLqso=;
        b=k3YyuyiH9vZrKIEb/CH7lP5bUAIoHtUChbe6wycrUMejETgyHMp4W5SDUxom83kD7Q
         DUrxorUVsbMI4YmsYs+z1ecSx/DU44VjcKfD4A8TymKYAl2swjCkRdu1mFBU3I4zer0C
         0sQWkMrQ7qnY42th3vx8GZN17KsJUuU+x0/6VPorLrkR8DE/yKBnbf0qcbeVPKq5vGcM
         /JlfnKnjYzao2BKdNtLfLJBM4H4mSZCyaYRMMjj8qJ96V3zcON6dmf3as+FfM7cBHe6J
         HMyG1Hk3ksVHYwsnm+OSxd09nghxSscPEs7MoDId1BjuEVDWaX/Ru8sAI94QNag9gzNv
         NYtg==
X-Gm-Message-State: AC+VfDxSmfw0tVfsvvUGuHjTOjPncpdAq4Fl0rfU2l43aPnch2snGoMS
        1/pH1w8zgVf0qU1N4v69Y6yTO6FNrtpOBwMGuVHx1/CUgrzc
X-Google-Smtp-Source: ACHHUZ5CrMxjJAzysjfmyxYmSDBMC3q+sumWtPMCJn5LhHxYTj4gZWD8HH/6ppLUpOaHirncbQikaPSGA+Jf2kxBMEr1Tlxy+AnU
MIME-Version: 1.0
X-Received: by 2002:a92:dc0e:0:b0:329:4c5e:15d8 with SMTP id
 t14-20020a92dc0e000000b003294c5e15d8mr7285347iln.2.1686783092577; Wed, 14 Jun
 2023 15:51:32 -0700 (PDT)
Date:   Wed, 14 Jun 2023 15:51:32 -0700
In-Reply-To: <1604551.1686754324@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000bdc3a05fe1ecb0a@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in crypto_shash_finup
From:   syzbot <syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+4e2e47f32607d0f72d43@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=129a0837280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=4e2e47f32607d0f72d43
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14cfedfd280000

Note: testing is done by a robot and is best-effort only.
