Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888FE6C44AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 09:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCVIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjCVIMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 04:12:39 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED254CA5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:12:38 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id t16-20020a92c0d0000000b00319bb6f4282so9315797ilf.20
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 01:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679472758;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRpr/2enZpSN+Pqs5p0qwijporxRiSMR0agGaaar/U=;
        b=UC3yJBKDY5vhdGoM6ommm04j870+FOU4f0q4RyTaaI4VoEn2YuhRmvqjjCOet5NTzK
         xUu0eS/yFO0HR7h+Mp0kYxVaoiUA34y24ASXKRqzAFccrEftHi16Zy//CXh3qRtI1+BW
         AX1w+MwRdzXjWD7J/3FPiTXuG5UFa7gjtax2sLbmkLkAoWl/d47Wp4seu2WyYp2fSxsY
         5UBYBl2EARnSm8mbt3HimxJgNdw0+KDfKjiAWeNBZLoa4BgIcXWdLXeA7/L1E2d854BD
         h2YWrhlGsRXkdWsayRdmYI7J1Aw0akx92RWBLSILdGzdiYPr/4Sjs1Di5gZWgQbY4qM5
         M7NQ==
X-Gm-Message-State: AO0yUKXBiGYu+zM5MyxHihuzbOt4EWvQieUWpqiIeVtHNn76PE0ZNEUa
        HwYZb7eyUg32oUBtMvhjm+TPEb44YWY5bQzFu9tClKL1A/OZ
X-Google-Smtp-Source: AK7set+OeAVbohPc7fpUZXumhTbjxoLQEP7JyCfjRAlXeHVD1nz99SDwJbphcHiy2E96tJ+2fMwLwaeYs8l51/MGknUjMu6mQ3lk
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:128f:b0:313:fa72:d9aa with SMTP id
 y15-20020a056e02128f00b00313fa72d9aamr2273525ilq.0.1679472758036; Wed, 22 Mar
 2023 01:12:38 -0700 (PDT)
Date:   Wed, 22 Mar 2023 01:12:38 -0700
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000027262305f778b938@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_listxattr
From:   syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        zengheng4@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.1 required=5.0 tests=FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
ntfs: fix panic about slab-out-of-bounds caused by ntfs_listxattr()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=9fcea5ef6dc4dc72d334

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
