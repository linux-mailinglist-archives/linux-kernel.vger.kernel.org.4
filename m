Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2DA71FF9E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbjFBKn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjFBKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:43:26 -0400
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34205E5A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:43:05 -0700 (PDT)
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-777683e803bso86380039f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685702556; x=1688294556;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9TOw2H2TDDn1VQzhH7iezPzkkf4u+p1oMfgUm2gH4s=;
        b=NcRsd6YYS2t/2CJ8US1O7vqTZaYNsLs+SKpueYE2w5eOdEnaVKn4z7fCU18EeH1mJC
         MsY2RqgzyOFPMbRawWXJ53624n47jOxcVvT+WlUz5DLN0OcWPltgatjhqe46V80bMI+8
         3Q0zv++X0EOxrb3j0EOtol9nB9y6dNFaxQrGAKdzPD52CIc69We4mo18MJt5lvUmk/5J
         qKKYoHeruhYVWtJgrmmbtX7tljkeAGTQcToi7TMJ+yWlTLtmqf5Yw73z0l+PMnMly4J/
         mRGbwWK6PSP5s7grjjCcTqsBAO5FbexYJmsPpfjmCOTK0bqvttUO3oRGZU1ZUoSJVwtA
         EB0w==
X-Gm-Message-State: AC+VfDyBTTEi9sXu6q3UwZ/8GmT7cu2lfk2WTWFr+YDHtVsEhoYsm5LD
        8Zy9p7UCrQYG3wJSIl7DJW7w5FaHognRCYOZDl33urHgtlzS
X-Google-Smtp-Source: ACHHUZ5g81UbT0rdYhiZsxkJQRZusYNFheAl9Q2G8/fz5X7oyogzCbJ3gEEO9e7RVn0nSDYkK4N6utNhjlOH6ehZj7UVEKz1AfvE
MIME-Version: 1.0
X-Received: by 2002:a5e:a814:0:b0:774:7cc5:6682 with SMTP id
 c20-20020a5ea814000000b007747cc56682mr799847ioa.3.1685702556762; Fri, 02 Jun
 2023 03:42:36 -0700 (PDT)
Date:   Fri, 02 Jun 2023 03:42:36 -0700
In-Reply-To: <00000000000015ac7905e97ebaed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000017cc6205fd233643@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in rdma_close
From:   syzbot <syzbot+67d13108d855f451cafc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, dan.carpenter@oracle.com,
        davem@davemloft.net, edumazet@google.com, ericvh@gmail.com,
        kuba@kernel.org, leon@kernel.org, linux-kernel@vger.kernel.org,
        linux_oss@crudebyte.com, lucho@ionkov.net, netdev@vger.kernel.org,
        pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
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
9p: client_create/destroy: only call trans_mod->close after create

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=67d13108d855f451cafc

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
