Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD0D6C3264
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjCUNOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjCUNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:14:40 -0400
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351AD20050
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:14:39 -0700 (PDT)
Received: by mail-il1-f198.google.com with SMTP id v14-20020a92c80e000000b0031faea6493cso7675544iln.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404478;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E/CPVb6H8VyxRsyGiJWxP2UWi3TCzv8QPJdKDcVdk=;
        b=UMvo08XUFzSx0gCDpg9lnbDliBP0QWIzkbfxbFhY0+Fx/Qb9elNrwtqfARNkvsPhir
         nj2uWR55nRRVEvblfj0oESJNDbDJFevZ7OTxycB1F3BPXeskd3iGYb1XAB2G6DQUKTER
         iLXBOO209qGroVe6uOoOW5EyAO8drJ+o9EF8xSZnxaiFuS2tJSPkq8NM6uEV70x/yLnQ
         klB7/5uC8iMupZOfcelyJB1cNC052ix3Y9gMqnO/YOveUU5EyF2UAWMorCRsaD7ptMN+
         iv6A9mQb4O5PnPMl5sZZPNm55IIOY80awIuEpw8m1K0UxfDX6nmzIu93bAwxVdIVGU1+
         fzhg==
X-Gm-Message-State: AO0yUKVNjG7FLBEOh42a0II65o/NkM7Mf6w8nSs0JbjLaeWlKLAgdjRJ
        +URYUjvZPXOqHu9dLbiJF/evsNmTB6zV5GdIRHgLCd58mm41
X-Google-Smtp-Source: AK7set/s6ej3JV3Xsl6KlLwe5mBRC4+3HQxIGvDZNFwhkHinh5peA+vo1p3wVHAfY3eJ5A7/xT9ehxiKPiehGXUDwIA3ROPqBwGS
MIME-Version: 1.0
X-Received: by 2002:a6b:8d46:0:b0:752:f038:6322 with SMTP id
 p67-20020a6b8d46000000b00752f0386322mr846819iod.0.1679404478524; Tue, 21 Mar
 2023 06:14:38 -0700 (PDT)
Date:   Tue, 21 Mar 2023 06:14:38 -0700
In-Reply-To: <000000000000ea7a5c05f051fd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006071aa05f768d333@google.com>
Subject: Re: [syzbot] riscv/fixes boot error: WARNING in __apply_to_page_range (2)
From:   syzbot <syzbot+5702f46b5b22bdb38b7e@syzkaller.appspotmail.com>
To:     alex@ghiti.fr, andrii@kernel.org, aou@eecs.berkeley.edu,
        ast@kernel.org, bjorn@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, dvyukov@google.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        luke.r.nels@gmail.com, martin.lau@linux.dev, palmer@dabbelt.com,
        paul.walmsley@sifive.com, sdf@google.com, song@kernel.org,
        syzkaller-bugs@googlegroups.com, xi.wang@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
riscv: Rework kasan population functions

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=5702f46b5b22bdb38b7e

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
