Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F616D6283
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjDDNQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjDDNQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:16:15 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59630423C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:15:53 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id d11-20020a056e020c0b00b00326156e3a8bso15678938ile.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680614135; x=1683206135;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d1E/CPVb6H8VyxRsyGiJWxP2UWi3TCzv8QPJdKDcVdk=;
        b=ZxbTUJAnDgsWyNJ8yxZjK93EIMe2viuU1ScywLZ4I5ZOo9CmxkZgH1pNxbYSppGLxQ
         fRn2DtjSgJk5wVWxT41Wdr7w8QMAeqtAiKZhpNDjzeQfM8XqXfCj7wytK+PRfnRShoLH
         zd60us+fI9evfkUhT4L5lNSkwq2TSFIoJp+2FY1iSJWNV5HPkFOZi3cdZwzYtkXvxbSm
         DFiqTn+JF2SPFklW5w8OHwiwG3FmOTACGDfPJULj90ajXDLAei7xQB0jhqENWi+JqVZG
         4JpU63TH1KsLe1CC/4JSgvVjj5FpK+Pn2tlaYT38xKi48YpJ36isJmPqxP2A02+5zuYP
         YHdg==
X-Gm-Message-State: AAQBX9dRe1LUDwhav+TwSwIJnSwkcwY5fHzU+DlcrLNVJrhU9ZmdA6lw
        /W+Ydj0kCmpwwrSBxiwEOMiR+C1R0j4XlI+l6yeHRoZkRkb2
X-Google-Smtp-Source: AKy350a9HLTipr+raKImLD76mGe3Np9Ljig3Z9sLELiKdBwISbIN4VnWZyemyNCQ7gxBcZbQOpO+Wy2G6itx3Us7y2KbIi/Xr61s
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:325:f785:6a6 with SMTP id
 x13-20020a056e021cad00b00325f78506a6mr1608281ill.6.1680614135456; Tue, 04 Apr
 2023 06:15:35 -0700 (PDT)
Date:   Tue, 04 Apr 2023 06:15:35 -0700
In-Reply-To: <000000000000ea7a5c05f051fd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c6f3b05f88278c5@google.com>
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
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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
