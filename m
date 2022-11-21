Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDA516318A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 03:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKUCcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 21:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiKUCcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 21:32:22 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1162AC51
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:32:21 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id m11-20020a056e021c2b00b00302c7ea7e16so788905ilh.22
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGFDD6OEW+01reLRgn1g2iIMRYLzT0mTHgxFrX9fZNE=;
        b=PywOxePu+M3T2T6I9jLhFrHK6ZF+pmlzGcU8yHeEGvrUnU0u9M6vzWIzfffKErVJ4e
         DX6P/pCrxVukxJabZZK9WkJ3+jQsPpqd6M07/VFZ4Si8niehjaz+yekp15Q33+7+KBla
         tg1SK1aSNNnqgRhX3Cm2NeRMbATTr0da59Z6SngBVsIRoWm2Qo4Fk7zg7+UNOG5KoRTl
         d3elOYWCW7TGki0qg56s5GnXEApaq831MJHcfumU1JmYmHDW90kF+hYyhBxF7FgYG7Rd
         igPYOG/qGhlBcnNhJE3cd0ZZiDjAQ5qDJYQ9ZdlT1u4FEtwX/mtvzPD3yiRH6MYceMuf
         juWw==
X-Gm-Message-State: ANoB5pmb/JIjSarOh1H4L4wOOFisyqHQdnR6vM6vWP6TvtOrGoCgMEbd
        KL2Ha1dffFI70Te38inbRDI/13L8mTYsUQ7IbzBiB+JnaGwG
X-Google-Smtp-Source: AA0mqf4Xze5TMwhntRhBurYi8I4I64oynZOAH3UcU35g4d7GrLL7jSbmR4VzfNk+U+GAlyiBwHCUC/QwK71pEZzzDlyGbbySYwLM
MIME-Version: 1.0
X-Received: by 2002:a05:6602:8c3:b0:6c3:e5e4:bddc with SMTP id
 h3-20020a05660208c300b006c3e5e4bddcmr337560ioz.109.1668997941177; Sun, 20 Nov
 2022 18:32:21 -0800 (PST)
Date:   Sun, 20 Nov 2022 18:32:21 -0800
In-Reply-To: <20221121015757.4942-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a317c05edf1dd3b@google.com>
Subject: Re: [syzbot] memory leak in binder_transaction (2)
From:   syzbot <syzbot+7f10c1653e35933c0f1e@syzkaller.appspotmail.com>
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
no output from test machine



Tested on:

commit:         59d0d52c AMerge tag 'netfs-fixes-20221115' of git://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1759f9f9880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=435fb8cdd395f932
dashboard link: https://syzkaller.appspot.com/bug?extid=7f10c1653e35933c0f1e
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17dd366e880000

