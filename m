Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AD76F933D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjEFRG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFRGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:06:24 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A616118174
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 10:06:22 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-763c3442563so183999539f.1
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 10:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683392782; x=1685984782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gRJfIq0LL7rz1ExA9vHxW5Oy5JLlTCLccW2WalIsMs4=;
        b=bzxGC7XbqqjYWtwyD0BkPf4U9ezY5a0A4dTfxHxZvwlpNQDcrw3qR5GjNW7qFWn4Sk
         qA2tp/fmBdKemfcGRNibSKPc8/O0IZIuY7F672FEpRNeLvH4TStS1faSEcMI0xpBAAxR
         ijduK4zng33S2xY+xZJMuiTW2zWPB6b2t+l0RGQojgw6QNHHbPc2Ss/cZUlvR7TbM9sf
         IYrKGtZhoN3LGijQQ5VhvSqblbfBVStGSsg8D83ymn7aguzctrQonYR2xRTCre2HhEIG
         B9pEreaT2uqad3nb8Rvjr4K/21YCHJQRWdKRXeEU7p/o+1QB5qRBJolA4DtXEUrawdQz
         XFSA==
X-Gm-Message-State: AC+VfDxIyPEbJ2EkPpo5QbBmsY3MXU9S3YmPDGaemdaM9LttiSIgadfq
        QqhdsDtpXcIcA77XCeDvyw1dxmJN67E5TWs+5Z0x/u7uudbr
X-Google-Smtp-Source: ACHHUZ41RGdYduBExQ1q0OGXQSgr20iU0qliCdlQ9lMG6MEJnDh+SFGk9SD3eiXGjWpz9ievd+gTfLJlUg+sMw2vZtKwerELa6oi
MIME-Version: 1.0
X-Received: by 2002:a05:6602:4298:b0:74c:8243:9290 with SMTP id
 cd24-20020a056602429800b0074c82439290mr2130191iob.4.1683392781985; Sat, 06
 May 2023 10:06:21 -0700 (PDT)
Date:   Sat, 06 May 2023 10:06:21 -0700
In-Reply-To: <CAMj1kXGTgx3aJP+KUDo=qer-wsv79ehVVLiCxzkYQ9D2j_-F9w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c9b00205fb096c09@google.com>
Subject: Re: [syzbot] upstream boot error: BUG: unable to handle kernel NULL
 pointer dereference in load_balance
From:   syzbot <syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com>
To:     andriy.shevchenko@linux.intel.com, ardb@kernel.org,
        dvyukov@google.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, nogikh@google.com,
        syzkaller-bugs@googlegroups.com, yury.norov@gmail.com
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

Reported-and-tested-by: syzbot+d4b00edc2d0c910d4bf4@syzkaller.appspotmail.com

Tested on:

commit:         f4fd69d8 ARM: vfp: avoid unbalanced stack on 'success'..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/ardb/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=c8dd4e2cced46f7e
dashboard link: https://syzkaller.appspot.com/bug?extid=d4b00edc2d0c910d4bf4
compiler:       arm-linux-gnueabi-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
