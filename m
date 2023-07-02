Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252A5744C52
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 07:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGBFWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 01:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGBFWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 01:22:50 -0400
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4851DE4D
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 22:22:48 -0700 (PDT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-53fa00ed93dso4316374a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 22:22:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688275367; x=1690867367;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5kS+epQmaaIeMaJpTN3AeDp9xO6+JvCmCnd1M7Xkrms=;
        b=gyhc/CNJdd+lIMtCgTPRtfSxiKxuywVUTsepWWhltTxJntJva/9yhvtG1rUag2qvJZ
         3ebtjMpHAFX0zB+X4n8fJmVgrX9ziCoV9gadqSfNMUGbgX8EqCLGMu4i2z82obUR5Cm+
         fLTQfqqh0E5/OeBFloGib+1dqTZ4qo/fJ/aEADyEdb4oEaI2QUwPjRrg7JyZDnZVVqIB
         ctU1Et333nZyfruNRb2fVTOkp8LdOENmZ/nGh2bTb/WX9cE982RoT9u2JtoNHlsudB+1
         FBwl+ZsD13D7Sbh3RznOoyFAa6agRk0f/jc0EXnl9YZAJauLK/r5z0VxSwytnxDdIkKN
         MnJw==
X-Gm-Message-State: ABy/qLYcTNE4ffCotbtc8pzWccJRcveZKXyjjkM5NpYQYmxlaoF7npj/
        3gg7FCAjCCUhW+pclCIe2Tz4Nlfg9wgWPAQZGbRsAd50O25a
X-Google-Smtp-Source: APBJJlFm3oWWgEc37UKNJQ/lBbB9nU9nWqQf2XZI3TBmh7pqyc484SxQm/JSo0pcF1dq2SMewv1dcs6oCeNNN0EuMzgr6UATiTZM
MIME-Version: 1.0
X-Received: by 2002:a63:d005:0:b0:52c:999a:fce2 with SMTP id
 z5-20020a63d005000000b0052c999afce2mr4237893pgf.10.1688275367618; Sat, 01 Jul
 2023 22:22:47 -0700 (PDT)
Date:   Sat, 01 Jul 2023 22:22:47 -0700
In-Reply-To: <00000000000055cd8405f84c5386@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091ecc005ff7a3d93@google.com>
Subject: Re: [syzbot] WARNING in class_register
From:   syzbot <syzbot+ca3d9f693dfa69f61371@syzkaller.appspotmail.com>
To:     dvyukov@google.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is marked as fixed by commit:
driver core: class : fix slab-use-after-free Read in class_register()

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=ca3d9f693dfa69f61371

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
