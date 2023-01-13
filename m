Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A60C668992
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 03:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbjAMC0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 21:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239906AbjAMC0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 21:26:17 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323AB4828F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:26:17 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id u24-20020a6be918000000b006ed1e9ad302so12748742iof.22
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 18:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VG/EnzWcjyS1E2OxmqiZ3g8xz/ONnjgCtm/GvWPiyR4=;
        b=VfiIgQNZ8ukuXTCIrw91M4SDhxDE7ta8vyefBZJ7M0Wz8j5mDxqbnSw9Z4Zd4FJFXM
         i+6W88PoEFSDbaEQsMmQLXvqULtYpPEvwsKC7syCfrRIrLIvVfaZKXq96vWdYlyRKNF7
         /l2t4oOLLtOwdLFR8lkQI8TW3RpDWBOxZxSS5/G+t3juCyNn/6OHJ6aeyXhzrcWQvDqK
         qwOWM8HjJVAQGthvi0tLncmw4vIDFBsEeGP0En03N7UCasDvXEG1y6xKzlh74aWtakQy
         oFIGIeR576mMmQrMU0BY+hc4Zx9OaDvaDk5XK0waYYHGF45NpZmoPDBKilwhTbgVJVwb
         r/5g==
X-Gm-Message-State: AFqh2kpsjjtsNxsn3knNOpw50CrIwwQw2Ubt4G8kPaqyARCZToAt3gAq
        0E9uNMNBWg9/zRNcMl+UMtC3XcVJSQwJAEz/hqPoo5snAndx
X-Google-Smtp-Source: AMrXdXtWZ+la6wXBRTWigKSeNe6zgYs/x8PEN+h28h75ULclNCdvk33CL9ZttKdJ91XPawN9b+42BDhaWJmNGlLT6sPuBds8tcsE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:80c:b0:30d:860d:342a with SMTP id
 u12-20020a056e02080c00b0030d860d342amr2950134ilm.305.1673576776569; Thu, 12
 Jan 2023 18:26:16 -0800 (PST)
Date:   Thu, 12 Jan 2023 18:26:16 -0800
In-Reply-To: <0b47feda-b3b2-02e8-36bc-f55a3e27bc35@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045a2ae05f21bf5aa@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in io_fallback_req_func
From:   syzbot <syzbot+bc022c162e3b001bf607@syzkaller.appspotmail.com>
To:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

Reported-and-tested-by: syzbot+bc022c162e3b001bf607@syzkaller.appspotmail.com

Tested on:

commit:         73f41663 Merge branch 'for-6.3/iter-ubuf' into for-next
git tree:       git://git.kernel.dk/linux.git for-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15a52c5e480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b6ecad960fc703e
dashboard link: https://syzkaller.appspot.com/bug?extid=bc022c162e3b001bf607
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.
