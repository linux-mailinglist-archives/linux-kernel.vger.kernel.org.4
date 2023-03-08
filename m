Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BDF6B0095
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjCHIMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjCHILy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:11:54 -0500
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807D8A72AB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:11:40 -0800 (PST)
Received: by mail-io1-f69.google.com with SMTP id 9-20020a5ea509000000b0074ca36737d2so8217491iog.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678263099;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRpr/2enZpSN+Pqs5p0qwijporxRiSMR0agGaaar/U=;
        b=MCxZMxNLTEfy77ufr7zWO64MKOSHEEUKgGqE1HmW/o3W8J5PSXD+Z4kp+HY2p+8gE/
         YWKI2rk4EGlZCljKLuPbaLBcBnVIhPwMeR/ivUkv9O4t1sd5BuTaG+DUECtXdHUqPaJs
         WcD4JV5cDuvh44Ig0Z695xwaZofJ8AhbEwV+q1sdAVjzh6YI2l3CLixjJQANPL0NHczu
         Qa8BgWkOSUA4gz6UDU2KWNeEvuPzoqfTaCJpnoJEOrAIL2tKF17EJ0eWJ+b7+wCqWj/V
         eiGFieVUCBpEfrs4ICjcQlZWdVqjjjypHpL8jja7f9FNNQlRzVd9cMhOSu/t+/ljGY6s
         XuNQ==
X-Gm-Message-State: AO0yUKXriDugwFpIfCeJ0HK5zLBqh1lpREeelky2b9ElGwqsahFneOuy
        Bf+NNAcnwVg88c5G6NR7PgyG3++/a1bMqPL4tlAygUH6lY/N
X-Google-Smtp-Source: AK7set8ohvqpuNRL/JIS3vEqOiqVUfpwiOin574uHv80eNG3CnFwykdH8snjl4FxakBYbcLg+wDx8C0yoczKJ+W5O7OoK+osDiqq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13f4:b0:313:fa72:d9aa with SMTP id
 w20-20020a056e0213f400b00313fa72d9aamr8342532ilj.0.1678263099703; Wed, 08 Mar
 2023 00:11:39 -0800 (PST)
Date:   Wed, 08 Mar 2023 00:11:39 -0800
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5c94a05f65f130d@google.com>
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in ntfs_listxattr
From:   syzbot <syzbot+9fcea5ef6dc4dc72d334@syzkaller.appspotmail.com>
To:     almaz.alexandrovich@paragon-software.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        zengheng4@huawei.com
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
