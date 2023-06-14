Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533DB7304A5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjFNQN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjFNQN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:13:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F71FFF
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:13:24 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-77b25d256aaso242398139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 09:13:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686759204; x=1689351204;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zeyhKQmQJgmGwX9czunjxyhPF6/Uyh0HJoA+1LIdqE8=;
        b=VpcGBnFvRXxCwlo76KXxvETevYtICDSijUQsDCt/Q8JwAkHCquICi84wg08Iv5wmMI
         zdtksy2u/OkhVHPXcrIgI4aobmEpPiDmyu3UoS7SIXq99z7fjwHTP1u191Atsx2vQIik
         WOkW+DnsCyu+exV2VqbyBjVQyqciBvbKCJPhPlQNRZVo6iPfrtt3u6vTh0ZnbSuZQO0c
         YwpzFxviRibXMb28gv5MpB0Qt31kpNeXMOommt2IxLrlcLoqV8CvldsHIClkMopOtfGk
         YxrwK1EwKk/h2wxOodU8cGLKKmRNZ+cRoKVKsfsVNoxVQa8d2ejeM7JPRLRg9WR/lgDu
         WqQA==
X-Gm-Message-State: AC+VfDxBIuHMmnYdjJK7MaC/X3aGzPdIVYqCM2WuCz53KjxUt1+7JN/Z
        DANlzvkHFoecc9HpF0sd35NYuyrYdD3dfJFaAgDA43uoGsPB
X-Google-Smtp-Source: ACHHUZ4r58bUvl9LoPAOXo+B6/ljIZcwyo9JK7UM90Yqibs/UTgX1tiUUXTcfd0jBjqB48XmrgyKXZl5c+T2EAc/pq3qX0C1IjMx
MIME-Version: 1.0
X-Received: by 2002:a5e:da05:0:b0:775:4f90:a4ce with SMTP id
 x5-20020a5eda05000000b007754f90a4cemr6194252ioj.0.1686759203788; Wed, 14 Jun
 2023 09:13:23 -0700 (PDT)
Date:   Wed, 14 Jun 2023 09:13:23 -0700
In-Reply-To: <1604533.1686754299@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029dd9c05fe193bf3@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in crypto_shash_final
From:   syzbot <syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+14234ccf6d0ef629ec1a@syzkaller.appspotmail.com

Tested on:

commit:         fa0e21fa rtnetlink: extend RTEXT_FILTER_SKIP_STATS to ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=13b86427280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=526f919910d4a671
dashboard link: https://syzkaller.appspot.com/bug?extid=14234ccf6d0ef629ec1a
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15bf213b280000

Note: testing is done by a robot and is best-effort only.
