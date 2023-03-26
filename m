Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEB66C9413
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 13:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCZL61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 07:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjCZL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 07:58:26 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1037383F1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 04:58:26 -0700 (PDT)
Received: by mail-io1-f71.google.com with SMTP id b26-20020a5d805a000000b0074cfe3a44aeso3898646ior.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 04:58:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679831905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/mI8ic1WO0QSXPTWXE9gG3FPt2IHtYEzGTcVZpkPLs=;
        b=A5vusm4QjvnYsjd4uGwc8X5raVuC1EF+cWJOU1KO2VnfTMWTx2RlqXOlhcEHkdUpXb
         1VhGZ3WD7qqVz44OfuGQ+LFp0M3v0POQOgWdGbG6VYzZyTDS3NU8GB0bqC7+JJ7x7AIh
         pz2zx3yDaLLjIPCweZ8zJ+4iKY9/tEHnfDqUFoht1JQVM4+ESqcQutiNI8Eb+g7EFJn2
         6QeGAZQqWAgG35G77ZUQ9jTLwmCXkspD/RGMnJPnOkwftRL6ne29lGL0/Z5i8OfOnafS
         dF7RLtoWKWkN39rSmUkibCP/wpEpqHOsrhNp12OeacaXF0p/RZKh7lHeCHkuzlr6nL0w
         cMNw==
X-Gm-Message-State: AO0yUKXWqlh8HS22XPYHvan2zEz7TgtdOCi9fO+ZMWq6jon3DtiDZ1aA
        anx2esGfvN4rTm80PXGsncnTyMO/E38W0XETLrynr88oxBGO
X-Google-Smtp-Source: AK7set/EeTCu+sJUAngY1O+n3LqEP6bZECgYYdOZMegQBraHb7/omXwMQbTegb8y7IR9PI4/NFAzuLbG1qgXTXaU7ItlGMcZ71g2
MIME-Version: 1.0
X-Received: by 2002:a02:a997:0:b0:3c9:562:1366 with SMTP id
 q23-20020a02a997000000b003c905621366mr3488620jam.3.1679831905452; Sun, 26 Mar
 2023 04:58:25 -0700 (PDT)
Date:   Sun, 26 Mar 2023 04:58:25 -0700
In-Reply-To: <20230326113451.2287-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000001cedc05f7cc5847@google.com>
Subject: Re: [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
From:   syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To:     hdanton@sina.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com

Tested on:

commit:         4bdec23f Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1026f0c1c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1488a4b6c80000

Note: testing is done by a robot and is best-effort only.
