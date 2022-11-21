Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812F3631DA1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKUKCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiKUKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:02:41 -0500
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46323205D1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:02:33 -0800 (PST)
Received: by mail-il1-f197.google.com with SMTP id i26-20020a056e021d1a00b003025434c04eso8263787ila.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:02:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVvRetvU66viZg03zt42J481swUWQOVgkFgrLPfYY/8=;
        b=r6a9cTP95hjdywlYe6lqK2COpgaj62zIPtTyhRzCnUvsglMNRMi8vzQ9rJ40u7Rf3I
         mUuaxBVvwSttTVNkQs+FUnf6meA2jb0/Yw7Nd0yLnzHZFGtVSY8koTMhTmRzL/FS4juk
         T40ONqDidi5xqkvHhmo/XwY3TENTPt/Dep3ZYTewYdinC3WBHVf5n6OsyPOCqIRqfwNy
         vwGjz8tvuxzWwIBEMvEQdLN6fn54JxAOymlJ5MjeZCz4IqSnTQ2L5XfNsNqTDz09xLsn
         ro3REvRAIhpdQNipE8NeqYh+kj/bByNe60PtkuOzGFmve6WTdcTRnzAB4ZPPA0sdL/gh
         ooWQ==
X-Gm-Message-State: ANoB5pllzYbsxg7ay4eARxIKPdsNVKTiHqMo9uaOEk89j/pUS1m7HhrR
        yduAPVTiVyUqVszyH0aBCBEjNd7zUpfhW6ezCW7132y8xIBF
X-Google-Smtp-Source: AA0mqf4DXRUTk1M2JEFw1hVVO6Pm/Mk0WsH+TOGiQM6G5JfdjVdUgYVOruJip3nXvQmtYRnvb9aGnLOqzpzDUaSvI0ItIaKgDNYY
MIME-Version: 1.0
X-Received: by 2002:a92:dd0e:0:b0:300:b9c4:8c1 with SMTP id
 n14-20020a92dd0e000000b00300b9c408c1mr1764432ilm.124.1669024953189; Mon, 21
 Nov 2022 02:02:33 -0800 (PST)
Date:   Mon, 21 Nov 2022 02:02:33 -0800
In-Reply-To: <000000000000b960c00594598949@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074cd1505edf82717@google.com>
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
