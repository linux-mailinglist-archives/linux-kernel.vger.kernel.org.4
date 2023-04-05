Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC566D768E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237355AbjDEINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237298AbjDEINB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:13:01 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E071BEA
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:12:44 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id j4-20020a6b5504000000b00758646159fbso21783003iob.20
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:12:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682363; x=1683274363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRpr/2enZpSN+Pqs5p0qwijporxRiSMR0agGaaar/U=;
        b=mKdB61kvvzZDpz19fCRdosNZP33xijBbtyDHuYgYuopsOHZnIdvd+k5FzYK6OjD8DI
         7e985xyhkClp3MMggS2Kuc3xJfsP9U4IHZdC/dw2UH5cLYDry4Hyj3wHjgW5KjdajDYs
         tvGhDI4tBkkvmKHOK8lLAfV3qNhkDzv7tCEEe5LE0QWIZ0OAxse9CVrjGzARaFb/hDXA
         a/bQ8vz7S/xSlZbBNfhfLIQNhjVkjQaid2K+Qyn0AajsAOB9LZb2EaUsYIz4oSI5X4wA
         YRU12bbN1j6wEk9xmmW50MQJpXNz5Lc/IVMFwFqsBS+RDPR20vNothoHas3DPDROMRTX
         IA5g==
X-Gm-Message-State: AAQBX9c+2MYid23NwDnfgFKi/QQSCaMMupiSQecpxa8yP91MGaQG0V47
        Aoj9B6tYvwNRXtTiuu9y6urVr7rWc3Mdd9oSQTV/jSHixng8
X-Google-Smtp-Source: AKy350ZyVVhmfk37CIGtaHVEI8ebtCHBWRXU7IGTuYY1ef3zGWS13ZFf/61/y86g7vr0rwkMISqHAld/pmURWrbxbO0dO3eRblY8
MIME-Version: 1.0
X-Received: by 2002:a5d:8881:0:b0:753:2ab8:aff7 with SMTP id
 d1-20020a5d8881000000b007532ab8aff7mr3011620ioo.1.1680682363776; Wed, 05 Apr
 2023 01:12:43 -0700 (PDT)
Date:   Wed, 05 Apr 2023 01:12:43 -0700
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045f34305f8925bd3@google.com>
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
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
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
