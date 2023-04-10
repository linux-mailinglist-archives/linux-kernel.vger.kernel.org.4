Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0286DC598
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjDJKLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjDJKKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:10:54 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A355596
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:10:41 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i4-20020a056e020d8400b00325a80f683cso3807055ilj.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681121440; x=1683713440;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=m0MrlFol9FqoObkaX5ZJ9Y+QLRCVBhpXfu1d4B6vp7FXmz3i3/gtbwEiajSxXAwY2E
         qa3LtoJHcDegaq8lQv0WtzV4RFogKsSXyJMtGmozuRo0AHXoid8hGxo506Bttk1nwBYI
         tAIqnYqGTigUIu9tymI6nYAyBtUVHEW+CEwhM8vsCdk6FVfdk49tQbNXFI9TXnAdzaXb
         uB1+5RdBpVxa4R8xeOWoHlm3yeoDasOJA0bS7tz74Rg2ZAI9DqkDSg27jFb2HuNMJML7
         FM54skhISi4GzJvA57nI5vGUNjZZRvhr20Sj4r8z4R4uAqlmZ+/wgqi04zbeYgq4qqy9
         Rf2g==
X-Gm-Message-State: AAQBX9dmA+KOtPWXxXfzj0UWUbZ3+EiYnvNx4Bw8tE/c0Gk4J8LZnLNl
        dn2K5B0qQ3q3MmYnHD9QpzUrw0FlrW4GPLUJwB0pvUPhnOfV
X-Google-Smtp-Source: AKy350Zmp2aeEbwge0kATF5oNqo1FQmMX43uL8O6Y1RqmEKNvHCVH7mJqHmQw9HQHeNL8hzsOx+eKH+Ib/K2sXknju9i1pqOSmyh
MIME-Version: 1.0
X-Received: by 2002:a92:c7cf:0:b0:326:534c:9d47 with SMTP id
 g15-20020a92c7cf000000b00326534c9d47mr5418050ilk.0.1681121440676; Mon, 10 Apr
 2023 03:10:40 -0700 (PDT)
Date:   Mon, 10 Apr 2023 03:10:40 -0700
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004bc18c05f8f896be@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
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
net: core: netlink: add helper refcount dec and lock function
net: sched: add helper function to take reference to Qdisc
net: sched: extend Qdisc with rcu
net: sched: rename qdisc_destroy() to qdisc_put()
net: sched: use Qdisc rcu API instead of relying on rtnl lock

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux 4.19
Dashboard link: https://syzkaller.appspot.com/bug?extid=5f229e48cccc804062c0

---
[1] I expect the commit to be present in:

1. linux-4.19.y branch of
git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
