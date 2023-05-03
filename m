Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977A26F52E3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjECIOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 04:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjECIN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 04:13:57 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A371BEC
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 01:13:47 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3314c25ae45so11810395ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 01:13:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683101627; x=1685693627;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRpr/2enZpSN+Pqs5p0qwijporxRiSMR0agGaaar/U=;
        b=ZGAJa5cOVZI3yc5VCAF2XNi7ScxyGyE+vIuXKKwZJg5zzzLeoxvksqjl7e2RzclE13
         GvHoBI3MBjCkVy4vBUPMNzbUiJl23xc4OZr2rLSQANl/9cngOHLWqJVvzcrUZMeYSCQs
         wl00+b+NlnuNxWzOlZ1Exz+Gij4yY8vFY1SGihLrE5pDEbd9lhwiKqIkfLKv1r5iDl9e
         t9FQCDdwdQilYBXz7uZyV6cV/98N4RxPu10xm4sxOA6VR+QsTJZjMwfMO675isihghRD
         W214YMQWPlXq+NRoeUNrEHZ5OiJCjCdMYFQiE3x3fAz30ywhVYqC4x4qH77wyAfv4onX
         PqRg==
X-Gm-Message-State: AC+VfDys3vKWDbcCXhtya4B4Q0B3900u2WnfC8SmQyNRP+BofQ8LR7Zu
        BPBo4H7ZhWNCgSyzFPcaGqfYYnJHDuiexatPlJsYEokXetWn
X-Google-Smtp-Source: ACHHUZ4NVzKP5o5qLjz8lnTbsNdZPzLd+UgjpGHxihuqz06jFvkDRLvZe3mMdYN+wHv4ymgQ9efnXeYiDcMRaRtdZ2IP0Ji28Jka
MIME-Version: 1.0
X-Received: by 2002:a92:d484:0:b0:331:57f3:6af3 with SMTP id
 p4-20020a92d484000000b0033157f36af3mr1042879ilg.1.1683101627167; Wed, 03 May
 2023 01:13:47 -0700 (PDT)
Date:   Wed, 03 May 2023 01:13:47 -0700
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009bba0005fac5a2c6@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_listxattr
From:   syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        zengheng4@huawei.com
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
