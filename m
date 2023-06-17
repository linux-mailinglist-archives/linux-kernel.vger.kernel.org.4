Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44981733FFD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 11:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235336AbjFQJui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 05:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbjFQJuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 05:50:35 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81F10CF
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:50:35 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-33fc2f90703so23006735ab.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 02:50:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686995434; x=1689587434;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z30B3iBy+vFYZtoAoWzQ/5830xtC1q1OQ1v2xTzj4Tc=;
        b=UTo0DtSqvRtiRPaOazIyZPNYWiPrYEwaXnAFv+ZG4+1VJEfdnMH9WEyEO72axO4EX4
         j7dmCg3pxcRfny6ypiBlX24nnt6ucXIfKH5S0WUCewGrK5pZCMKEBd18z6sse7RHCPta
         TOSSdo85sHpH6v/xtE4qLs0k0nfg/Qv5fMfNe7SUmU81YexfK9yqv/tz3Bi8QQNAYfJk
         nIAPSbleZFdRWDkz8ZwAh+mTA0EEB/LVJsQg4+De+kU8ctLdjOd8+41JKinzK5bRGJxE
         jHL2FpSSXW1vUeLAKMB2sXHt4FYMpXAjgrFTe2rDw3Pv56JTn3llENHY1If3qKFkyqgj
         KH8Q==
X-Gm-Message-State: AC+VfDz89Aa6AloXspNn1rV6GxUN+uWC3Z9kaq07IqhEd0k7mYLfdB9y
        zAJZw82cIN5XxufaI5mMOD3UJ2AfpF4X9P8I9+tVGpa5t6pn
X-Google-Smtp-Source: ACHHUZ56Z3AUM41aIl/Iz5X0Dvmx7mLD6cg0SNE338xMRW2rHAp9qJaMO/LBELZm+1Bj3nukuFlj3+B/e0B5GP0wjQECdFFXsHl7
MIME-Version: 1.0
X-Received: by 2002:a92:c264:0:b0:331:31d7:9816 with SMTP id
 h4-20020a92c264000000b0033131d79816mr1444924ild.1.1686995434087; Sat, 17 Jun
 2023 02:50:34 -0700 (PDT)
Date:   Sat, 17 Jun 2023 02:50:34 -0700
In-Reply-To: <20230617074659.4760-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000962f4d05fe503bfc@google.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in exit_itimers
From:   syzbot <syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+5fd924f4cd9dc1c7828c@syzkaller.appspotmail.com

Tested on:

commit:         f7efed9f Add linux-next specific files for 20230616
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bddabb280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=60b1a32485a77c16
dashboard link: https://syzkaller.appspot.com/bug?extid=5fd924f4cd9dc1c7828c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12be8d37280000

Note: testing is done by a robot and is best-effort only.
