Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C2573BBA8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 17:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjFWP3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 11:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjFWP3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 11:29:23 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C35010D2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:29:22 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-76998d984b0so48917139f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 08:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687534162; x=1690126162;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBrsp/L8LBbY13kpCjVb8ARrn73n9NBhpEUWG/fTsCo=;
        b=CN4S9YI570ZeUu2miriWAuoDalrpw3vNfjtKA1tq5qSICwXVoTP6zrewFEVj8psJsz
         7rECKRGKkgZM6otuWEKomyHallsdCoqBWdaGp/CjpjknGSxaARrAo/be5fMYGT3khXSu
         tmswcko/JoRAwFjWwnFGneZdaljwTuZtMIvTtWnnbJn39834eA5vNLpyO33RE9/ZLILP
         5DIoUOGBVV8th38hZooGwAyB/35u9M7vr7NvDDwxQyjasCP14u63h0SUFv8Bi+6XUsiO
         0Ghu/c7zgnTqwHRUOtieteGLl21K7H8uYjXwvysB5Q4I0S5Jk4PkttfGIQBUJhSe5Zrr
         LfrA==
X-Gm-Message-State: AC+VfDx1fs/6g+1m8TRowFtNkKo6VJVs/0dcSGoT16K3Ypk6d5mcrUSh
        PDqkNNGT7NS/Y6FTq+v2urvBQeXqa2eCCX/dqsLv8HxQM2A1
X-Google-Smtp-Source: ACHHUZ5s4AxZGy5IkdfIF5CHenFw6Jv1FrcGeoKc+TSkvorT6RmNJB+KZsAlt7cYmNfsYhwRWXrGY0pg01T/p+aODwSow+udbhCe
MIME-Version: 1.0
X-Received: by 2002:a92:cd41:0:b0:341:d428:7bcd with SMTP id
 v1-20020a92cd41000000b00341d4287bcdmr8114863ilq.1.1687534161912; Fri, 23 Jun
 2023 08:29:21 -0700 (PDT)
Date:   Fri, 23 Jun 2023 08:29:21 -0700
In-Reply-To: <2370718.1687532181@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000446b0805fecdaaf4@google.com>
Subject: Re: [syzbot] [crypto?] general protection fault in shash_async_update
From:   syzbot <syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+0bc501b7bf9e1bc09958@syzkaller.appspotmail.com

Tested on:

commit:         faaa5fd3 dt-bindings: net: altr,tse: Fix error in "com..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main
console output: https://syzkaller.appspot.com/x/log.txt?x=14f7e723280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a78c5a35ccd7ceb0
dashboard link: https://syzkaller.appspot.com/bug?extid=0bc501b7bf9e1bc09958
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
