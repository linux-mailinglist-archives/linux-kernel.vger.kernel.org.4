Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88A3688A78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 00:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbjBBXGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 18:06:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbjBBXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 18:06:31 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3687164C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 15:06:30 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id d22-20020a5d9656000000b00704d3bd8c07so2012123ios.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 15:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS69ZluBz1g0tjn3hzPqjYm4xHf7bwIwQjBQ4SRSpG8=;
        b=uEBq4C7/6D18GvQDYLAESdK9DvvHoAxpMwLE0V4uJGS2HRorklftSYWcxL3BH/KVpI
         FA2OWka97/Vc8pmepWvuek2t5JBk47qoNt9PXRpzuRexgOV84ik5ZsJLo8MmmtKDKpvI
         wfpK0waoq4+R7VXazdZEtse4llBLxl1AgexJSbQkAoVJ1Nw864R4nW0Z+odbVBPZSCoU
         +2COVUKHNZgFKa37YTA+T8ypGge9GA5TBvX4UsrTrr9spz5+ynSdZtQNcZKao/Kq+7uP
         0msSfgqN07uNu4PTpcCmHwxKFKqrGAfAeRjLSUKt/ElE+J3THdUaUwIZDgEr36ffur4X
         7tKg==
X-Gm-Message-State: AO0yUKVeTcNdCKBN4GC5BcrHHtzjSEpjTChpXE9JUT2gq2PA27TDrgLL
        LAWe/siIajqv0GKIk8T5T9E03rm1i2TgtKFZPtyuZYKUK6ua
X-Google-Smtp-Source: AK7set/HcUh7jDIQP0/0+CxSz0TVrJgoNJNITN0WYAXolAanigKsaQ9gbYXZTh75VDzDWKeu3urX9D13aaYGsWIqDI3gZMUp3DGK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:22cf:b0:704:8263:b926 with SMTP id
 e15-20020a05660222cf00b007048263b926mr1835233ioe.53.1675379189876; Thu, 02
 Feb 2023 15:06:29 -0800 (PST)
Date:   Thu, 02 Feb 2023 15:06:29 -0800
In-Reply-To: <0000000000009da4c705dcb87735@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a0f9905f3bf9d9d@google.com>
Subject: Re: [syzbot] WARNING in check_map_prog_compatibility
From:   syzbot <syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, memxor@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        sdf@google.com, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com
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
bpf: Relax the requirement to use preallocated hash maps in

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=e3f8d4df1e1981a97abb

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
