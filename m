Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8585B84EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiINJZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiINJZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:25:02 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A29786EC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:14:57 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id b9-20020a92c569000000b002eb7fbf5ca1so10130898ilj.20
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=beK/RyAk6JMkokDhacR9sWsAak3KfcE5cJn8YM9YfXo=;
        b=us5LT+4qXz3Nt1byEdKPP63blc/uIYMogor7y5kiAyZNQVq8/hoUbtaLsn08u7pZPr
         JZSwng+pOV0ZUTxAQJscISh8Md5K2i10DSuUyV8TcK7/IK3cf6pW1SMGBC1JpJtz4ADV
         rfXePbq7za8PAjpiETT8q5Y1MBUcsA45rND/ixtdmEdyLP1ma5Mpx9F4/rje4pQ+d6Kn
         siiw1M0D4LAMBVbNYv0HQyG/ib8bwrnE4ApI9VwlSyfBwSM1nwYpuYvzYQT9zunZOxfI
         gsKIgtp5fp+/R2z5QPLIx042Z9Zx7dYE6fWDwgDjmocFHofJA99VYsttws8JdIj4LDGw
         CjSg==
X-Gm-Message-State: ACgBeo34bfs837S+Ec6AeJWDaC7PuzapxOXOQ+UopL/dehD3VNwIZLek
        W6UiSQ7wh0KTQxqCXmtufaNKvabH9nODFt/I4JmRV90M2r7l
X-Google-Smtp-Source: AA6agR4BRQZ9v+xAqQp9fF6gEOPwNPIxhbDfhFuSJ+t1B0A4HFpARmOh7n2fRvoiVl6/uF1rCG2iIIjphcYUjUZenyskQCJdBIZq
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4710:b0:35a:6372:3df0 with SMTP id
 cs16-20020a056638471000b0035a63723df0mr2213610jab.277.1663146870026; Wed, 14
 Sep 2022 02:14:30 -0700 (PDT)
Date:   Wed, 14 Sep 2022 02:14:30 -0700
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b65e05e89f8e72@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, linux-cachefs-bounces@redhat.com,
        linux-cachefs-owner@redhat.com, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, mudongliangabcd@gmail.com,
        nogikh@google.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
