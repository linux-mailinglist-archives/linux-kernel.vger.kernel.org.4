Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792DD649801
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 03:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLLCnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 21:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiLLCnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 21:43:20 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830A455B1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:43:19 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso4298600ilj.17
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 18:43:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7BOL+ZTNbULcSjar0lySG+iFFzHm84g4wkN6XQPfCo=;
        b=XwStK1zMY0uoFUjmpDf+Ok6HF0CW+2Kayk2d1Z32xVlw5x0qWPke1N9nB7Ge7fGRp+
         KqTwvnzjrBr9GLl5fJFdNAchv5MLgmr4U0oNWG7vCu/vvv41yd7CdKZvlaTaTmuLIvIL
         iNEU8gmGoW6xLN4FA4/M9d7QBR6VjSM09g2KJZKp2M6MtAlqtHb61r3a0vO1hmsEuEZy
         L+0PU5XYAZHe92zB3k64GbG1nsgGCEY4yvv6e1I/WirE66lzULXtAFDOAeGBsguEBwIL
         xKx5FPyjQyE07w5fWf+OIEwc1tgLTGL0qhUVK19Ncp8QwyxNJp3wieXw8VZ6GSzK6Ory
         q4GA==
X-Gm-Message-State: ANoB5plK0+tFrpHzdvuNod8HMjjvjL7TRv6OR/9gyDLdSZ1YQFRI9uOk
        t0fIoo13coiBzOuAz9opE+b//Z2S4rBIVmUKCUG5Tg4h/fFC
X-Google-Smtp-Source: AA0mqf53mfHc7iZBRIwtaNcQbqKdtM7HjnyVtlY4gKC+fy21t01Xm/CgmK2/9W7gzKkU6NVD3i6Bxa+G+mw0U1wFngbRA9iHfHID
MIME-Version: 1.0
X-Received: by 2002:a92:d251:0:b0:302:fdb0:a1fc with SMTP id
 v17-20020a92d251000000b00302fdb0a1fcmr27108552ilg.283.1670812998913; Sun, 11
 Dec 2022 18:43:18 -0800 (PST)
Date:   Sun, 11 Dec 2022 18:43:18 -0800
In-Reply-To: <20221212020158.2902-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000049586705ef987729@google.com>
Subject: Re: [syzbot] kernel stack overflow in sock_close
From:   syzbot <syzbot+09329bd987ebca21bced@syzkaller.appspotmail.com>
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

Reported-and-tested-by: syzbot+09329bd987ebca21bced@syzkaller.appspotmail.com

Tested on:

commit:         830b3c68 Linux 6.1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=140d36b7880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=738c28d3ea17d420
dashboard link: https://syzkaller.appspot.com/bug?extid=09329bd987ebca21bced
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=153c5f2f880000

Note: testing is done by a robot and is best-effort only.
