Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786FA6C5CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 03:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjCWCa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjCWCaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 22:30:25 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ABA2823A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:30:23 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id r25-20020a056602235900b0074d472df653so10740168iot.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 19:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679538623;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OYMvRLD2NpUAW3woXFYIOhYNOpa7z27tVJFgyzUeP7I=;
        b=AdGorpFGltzotkD6qbw1EjMbuDV3JEmvo7PHsFLvMD/p/plCDA9a6T4R+Uax88Z6CB
         tSkWJ5rb0ln7qUZdlJAuUR0PG0Dl8vQcmTR/e9CNhB9UDZNMNcDaUWrHpPIr0r5MpmTq
         8u8wCpII8VjitQhT0X8tst35a5f6W7y/F7KJ8v0MOj8obMWhkrC1QLSV3n6RRIYZMK07
         bHWlA9gnjkoomUN5GUn+Id0RF8wZpt31t0eKJGqbPfTUJUgbUL1NlHLCJPZQ1aceYh1w
         GnsayM+uTQx+4TwHXeWW4vcnWgpa8VBJN/neZNM3GI3dUJ9F2rnPLLsMf166PDjFjQ3V
         9+2A==
X-Gm-Message-State: AO0yUKVqwislE3nMf7hGLd1N7I4F1pMYFENu36t7BjKn/IdG7vGZk0o4
        Oi4g/YO9AIX/e4ewKb2pQZ6aU/hj1SXndWNPG6zx4Cd1cfjO
X-Google-Smtp-Source: AK7set9fRXsxbEMt/tmSHgEJGyIE/SzIUGrTyM3O0QBd16Sh3l7iLnmBqC2mdtflQQtJzGWa79f8HgdAFj9rp305Qi7OPe19j+7F
MIME-Version: 1.0
X-Received: by 2002:a02:93a2:0:b0:3fc:e1f5:9619 with SMTP id
 z31-20020a0293a2000000b003fce1f59619mr3689155jah.3.1679538623052; Wed, 22 Mar
 2023 19:30:23 -0700 (PDT)
Date:   Wed, 22 Mar 2023 19:30:23 -0700
In-Reply-To: <20230323020722.2574-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000038dfa05f7880f4d@google.com>
Subject: Re: [syzbot] [arm-msm?] [net?] WARNING: refcount bug in qrtr_recvmsg (2)
From:   syzbot <syzbot+a7492efaa5d61b51db23@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+a7492efaa5d61b51db23@syzkaller.appspotmail.com

Tested on:

commit:         9c1bec9c Merge tag 'linux-kselftest-fixes-6.3-rc3' of ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15f48da1c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c84f77790aba2eb
dashboard link: https://syzkaller.appspot.com/bug?extid=a7492efaa5d61b51db23
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
patch:          https://syzkaller.appspot.com/x/patch.diff?x=121b8109c80000

Note: testing is done by a robot and is best-effort only.
