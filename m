Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD318656143
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231586AbiLZIqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiLZIq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:46:26 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89EF5FFE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:46:25 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id y5-20020a056e021be500b0030bc4f23f0aso6883706ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:46:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cNyrehLnq3+z+ZAjpOuP26dXtFANruysUjeySBFA50w=;
        b=JlahH0yFjNVbBEH+sO1M3dOhmqLvEmpmVhpVDObhrqx/aHekD/6mLblI5+yKiJ5Vx0
         FBaYS3JKnE5St/VMLQYrGKMwa1MwB4pC+s2MwHdFJwm7PamXTe3zb3WPngK1kX87xvG7
         1ho27C3F/24FHNPnBnT/v4OWYtNYvizMjYAXBDF2fyHSXOSI0hdU6CQDyVpt2mPAvZE6
         mzjOLIR0xY+ARUGuBwAIIESvfBpQlWBNUEBKBwW5ZTWTaTKMDYKNszPXfdOtgcLmQvJc
         jw6PnMW9twzRAtTt37J5pgJBgVFiGon9zvUxo3jHrAzB63Pokdo9l9sDcI/ezhwQFsk4
         Mjvg==
X-Gm-Message-State: AFqh2kqPGrvn8vMVQQZVnWsuA9Nxfo9U9D1y/R4/0RMRTY4wNlSrgqMA
        Esru3Y7mRDP8tjLEDha7mNPo96Xk1XOLcqiSzP17pOdkwswI
X-Google-Smtp-Source: AMrXdXvGgmbcXalJmajK7tl9GkqC6JlmuOkyLnjwUj6uc5IqawY2BX/GZHQXKuKLUIab1CMGcHZjJzkVLXJJgVFYRIec2EnsBD5H
MIME-Version: 1.0
X-Received: by 2002:a02:9a0a:0:b0:397:cb64:9696 with SMTP id
 b10-20020a029a0a000000b00397cb649696mr1452811jal.102.1672044385306; Mon, 26
 Dec 2022 00:46:25 -0800 (PST)
Date:   Mon, 26 Dec 2022 00:46:25 -0800
In-Reply-To: <20221226034923.2384-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a2901305f0b72b60@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in list_lru_add
From:   syzbot <syzbot+ed5464bd00ae9d8b1995@syzkaller.appspotmail.com>
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ed5464bd00ae9d8b1995@syzkaller.appspotmail.com

Tested on:

commit:         1b929c02 Linux 6.2-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=114a2974480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c62abaa47d88ff0
dashboard link: https://syzkaller.appspot.com/bug?extid=ed5464bd00ae9d8b1995
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154cba38480000

Note: testing is done by a robot and is best-effort only.
