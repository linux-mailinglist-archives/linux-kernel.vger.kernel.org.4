Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F3369017B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 08:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjBIHo6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 02:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBIHox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 02:44:53 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D329E33
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 23:44:41 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id r8-20020a92cd88000000b00313f4759a73so1107920ilb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 23:44:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7TQjimL8KUZMscO4m3fC34iqwHwmpZuK4STzqhRFKQI=;
        b=fJtmVp/a/rAU9ooA5A6HgG6M+ZkoHOrRqUF0DWcHIteRC2i4qcNJWiSXqyZvAl96K5
         aPJ1IsqpZmSdkeFFwNSXgVAns3kaKja+u3aVDq4cd7okQE3BxyvAOT3UlWcXew7vXrVF
         l+YjRXviOTdRLWhx8V06x/UCKrmjWMyYsHeupzo55j125VeMKLXh4fhbJIzJRjfFsoWn
         gv0A/Meiww9nNTtELdYMmiea/PWPcnYgY352UQfuqcfPEnU+t1ACIOUv0OohYkSt7bDV
         +o079gddBpp8DEBEOANqsLHdSG3YL5gDvkaO/opyRgNGrWYbzt4ShOAiGAT1eWvXpJ2t
         7DeA==
X-Gm-Message-State: AO0yUKVnLbW3JG4OMGesV3wmlq/xNAjrwwu0c72ZCceI5VJLQe98H2gA
        WcHNqxiGohVfuh4FwLtKpo+tqPGUJxAOmoAXodMLciMzx67O
X-Google-Smtp-Source: AK7set9ZXVyppZbO8Sgw+FCYj/LazGWYRyFYmdeWkOBKOKzYPN5q9nFzNPMPBucxVHPVz1CYYkd1kT1Eq1M7TrNiK1wK75EBP8YP
MIME-Version: 1.0
X-Received: by 2002:a02:b88c:0:b0:3a9:67b6:18bd with SMTP id
 p12-20020a02b88c000000b003a967b618bdmr6763867jam.46.1675928673314; Wed, 08
 Feb 2023 23:44:33 -0800 (PST)
Date:   Wed, 08 Feb 2023 23:44:33 -0800
In-Reply-To: <000000000000f2b07b05d5dc87cc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003deeef05f43f8d47@google.com>
Subject: Re: [syzbot] general protection fault in fscache_free_cookie
From:   syzbot <syzbot+5b129e8586277719bab3@syzkaller.appspotmail.com>
To:     dhowells@redhat.com, dvyukov@google.com,
        linux-cachefs-bounces@redhat.com, linux-cachefs-owner@redhat.com,
        linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        mudongliangabcd@gmail.com, nogikh@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
fscache: fix GPF in fscache_free_cookie

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=5b129e8586277719bab3

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
