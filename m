Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6D865AF45
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjABKFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:05:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjABKFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:05:38 -0500
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD4910DD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 02:05:37 -0800 (PST)
Received: by mail-io1-f72.google.com with SMTP id h11-20020a6b7a0b000000b006e0004fc167so7516031iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 02:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHBorJxtb8OOdvReJ/cspDu7cb80E+hJP4zqgvf9eJU=;
        b=j/dnVHR2BdLu4BEMCO3eGoJRtKh8jsjubgvHkoQbhiDSv67sPXJyOlhmLN9cqWBHZE
         FA3MdQ1dQsc0MnDE4oJ4vMAMCqxP65XzVImo5oufK/CCur0kNE6TSGCQdJu1lcmS4kWJ
         dXKssXmR6AdBMh8pJtes1SuE3lBIgjn4oVd/ZgU/QTj305f+m1bjNkM+k339QLto2rQc
         FU9Y6TfGC7I9WEsYls2fXqXRykd9KMy/omtePF/jIhEL+pWuGo9JRED7l7zlsmIqY1YR
         DRMowNMyqkQOwkP1kqYFMXTw4bBoa/U16hLEhC+6Wn+Pn8E8x22Ld8jEGiqZ0D3fLhRl
         zzKw==
X-Gm-Message-State: AFqh2kp8699tmgyPF+b54QEoa/04846lWR9z6XsjSLT4+Ns3Ss++BOOr
        zhERQPuE29dCLJVv4jVtH6bhadbvhrkJhCKwwxm+HCvNI1i5
X-Google-Smtp-Source: AMrXdXtGyw3nbnlxQMy03Ht58G3Pnx4/xwyCQj9bpHFLTgL8L7Sl67FCdqX7wDWZHJGjdBj1jl1QzHd9obMxMiJCG0w0qALpLIrM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:30c:baf:6dee with SMTP id
 l14-20020a056e0212ee00b0030c0baf6deemr1846953iln.232.1672653936706; Mon, 02
 Jan 2023 02:05:36 -0800 (PST)
Date:   Mon, 02 Jan 2023 02:05:36 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000baca7d05f14517e5@google.com>
Subject: Re: KASAN: use-after-free Read in tc_chain_fill_node
From:   syzbot <syzbot+5f229e48cccc804062c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org, jiri@mellanox.com,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        stable-commits@vger.kernel.org, stable@vger.kernel.org,
        syzkaller-lts-bugs@googlegroups.com, vladbu@mellanox.com
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
