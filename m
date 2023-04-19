Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007BA6E74BA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjDSINk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjDSINi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:13:38 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB30E100
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:13:37 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32addcf3a73so121727165ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:13:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681892017; x=1684484017;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RRpr/2enZpSN+Pqs5p0qwijporxRiSMR0agGaaar/U=;
        b=mAAEb26fDgpyZgubXmSFTbTJm98s+4xEiBh/a5CzRUsZqV/C5JF1euWwY3Mn7HPhvZ
         LH7Sg27DBAJoRwVeRvUajZjhToc8YHktXuRB2i9BDVn3to1ohsiSoDQCoPvnNxwC08k4
         17we7QH89SFytIMIiC0J7nsdEnqoJH207yOXzzziDW66hsmUNyvq6zVUwWs4qqnI+tGM
         +XQVv+R9MC5JplNrgWjiZ+nbAF19Wbfecd6uY9MnEDNJTwhbfxyDtmgPcNHhXxAOJXfq
         gmYy/9mi/u0w/LT4ZODp0bQnMKfBQFeBv4ohgxO8QP0qmQQuz3k1KkboKu1EGdM5M6AG
         BPhw==
X-Gm-Message-State: AAQBX9du1rSxA0pYIus7D1Oo9dHb7sEfo2rTVIs6HxU2XbxDomboTVa1
        xJ4irccau2KhS0Zs3pY9XCB822DmvsiDMc9CaMg2QM/I3A+a
X-Google-Smtp-Source: AKy350ZxM+Xb9GNBN83504bkL3uq/X7S37Mg6zCrCUERbs9vz+Iu5OHFeTeyO3L39/R+jUYeAVh6qHLpNsIhMXAdoXULMXlBIadJ
MIME-Version: 1.0
X-Received: by 2002:a6b:cd4c:0:b0:760:ea29:2594 with SMTP id
 d73-20020a6bcd4c000000b00760ea292594mr1190040iog.0.1681892017330; Wed, 19 Apr
 2023 01:13:37 -0700 (PDT)
Date:   Wed, 19 Apr 2023 01:13:37 -0700
In-Reply-To: <000000000000ea3c3105ef377a12@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e62ab05f9ac0071@google.com>
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
