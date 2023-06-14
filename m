Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40E97303F6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbjFNPgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbjFNPgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:36:39 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13C7C7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:36:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-33fddc27743so46696395ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 08:36:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686756998; x=1689348998;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=phQ7TSdnMlVGNbVCPYRQr4PU6UmUaw+34QpLb3+bJI4=;
        b=I80ffhCEYgP+jTAIOVoeUPSpdw4rtNKgTWhUlE07Z8F3YjacMbUJYmLqJnwQctbowj
         98wXUYsNEPboh4kFFEeyAYB6I2NSCFHNZ7ZZsy7tuoyS3MjJODxY0ub3HCHaZAWwOzyQ
         okdBKOg+DXlgVqNcnwkRDWYCEP0iSIhe7HUSG4SQx/MBRu0kggJJwON3iXuZdBqFcJuD
         VssCA4ydFfZxGwSXw/6xDLuTHLg9l/9F/wFirXt/ejlnQz13x7i9WMnMnT1dsXNrbEYL
         P8ZeXzlbzZRoh27Zoa/7rSne4rlGIqHoHjUBIWdhPPmyq5g4rNh6tomxxp32rYqGR9Q2
         paqg==
X-Gm-Message-State: AC+VfDxqni/F61L07K4CRqnRn2DEHaksfzWIKN2699LGQaJ3Pe9hqFez
        wvL+SUvIQeHyo4RpTHrI13KfkUwrYfc29S22NCWJjX/4P7SH
X-Google-Smtp-Source: ACHHUZ7Mkn9ZMRRLMYl80aZSQLcCbxjmQJ6yFASgFB/JtRpTXHcQNP4UiwWC3PuH4cNNqXMPQQRnYk8btGq1P2PL9D8qzqx2spm+
MIME-Version: 1.0
X-Received: by 2002:a92:d442:0:b0:340:9f52:a982 with SMTP id
 r2-20020a92d442000000b003409f52a982mr646147ilm.6.1686756997948; Wed, 14 Jun
 2023 08:36:37 -0700 (PDT)
Date:   Wed, 14 Jun 2023 08:36:37 -0700
In-Reply-To: <1602673.1686753912@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af6e4905fe18b762@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_final
From:   syzbot <syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+13a08c0bf4d212766c3c@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=17790627280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=13a08c0bf4d212766c3c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14c0019d280000

Note: testing is done by a robot and is best-effort only.
