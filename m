Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D770A64264F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbiLEKDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiLEKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:03:39 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1603D5A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 02:03:38 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id l13-20020a056e021c0d00b003034e24b866so4605923ilh.22
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 02:03:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=Bk7RiSr9QeanYRkOK/cb2uFrAJpjBJVkrVwYhE+t7iZ6ggTdushbsb39ot3XZfnHTQ
         jgdqlJAzsQVQvCvOLQ/USd0r7+gJz2krTA7gi3doArWkcOm4bZemZAM3KEr/PA09hZfg
         FMBBz1EuZR8K4Wm5dMDTCdMakWsiot7xUY01CQ/XLwSilU98TWst5uoEEoFnucjnnwIa
         b6dR/StWhywC+W5DtkL0F5o7vQUsLknQsXkB44VWt046AJSoctlhu/qE8+xJKlmWIPcI
         7+qGMoUia4C3lmYMzlMc06T3my5KcN7ahdSDkjPwPmiRuE0littrQf31q0lWv43Ixkp5
         Ev0Q==
X-Gm-Message-State: ANoB5pkfW9B71QPFtvKW53g5ku4JZJ5ZTnwbZCG14IIZz2/k1L9Yezrj
        qDuUndLlg5fB6mWiNev6TxnO1oLw86MQNP6QnwJ06QATzSIm
X-Google-Smtp-Source: AA0mqf6A9nhl03BO/uU380Ihl2+zu7W4+sPhFjI9s4qoei5e3boHFr9wue4FtJCqu+xvEjayVYISuxBkecYYw099cK+iDcEU+dyN
MIME-Version: 1.0
X-Received: by 2002:a02:ac92:0:b0:38a:219a:d627 with SMTP id
 x18-20020a02ac92000000b0038a219ad627mr5844842jan.174.1670234618187; Mon, 05
 Dec 2022 02:03:38 -0800 (PST)
Date:   Mon, 05 Dec 2022 02:03:38 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001bd6ea05ef11cd1c@google.com>
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
But I can't find it in any tested tree for more than 90 days.
Is it a correct commit? Please update it by replying:
#syz fix: exact-commit-title
Until then the bug is still considered open and
new crashes with the same signature are ignored.
