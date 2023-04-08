Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC75D6DBC83
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 21:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDHTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDHTBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 15:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A500872B6
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 12:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85F2960B35
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 19:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2FE5C433D2;
        Sat,  8 Apr 2023 19:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680980472;
        bh=tIJ8IsslV/kou3HWzrziKfMKT8s4B9XV2uAn1jxf/n4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qaRybGwp3X6K+waD+6c59/Y+i6gjuAdUY/9rePB81cBB/OHPZoAo2nsOloUjhG9/1
         plyex+gg27uKuKIej3xabtBebC7ajK+VmDAKd7XaQotGMxEDQeyWUvH4ouku+pR5GX
         Xf+0cvSwO6cjFbrOBh8nrYYySuzhTBB3HqSr3Ub7i2upYKXQxQtpZJiDe6ZNJs2xWR
         Us4Y5Jkx9mSUybOcuu/2FIenQ/+BvfKwAH2Bl3sF8ySKtZRvindDjxT9xteE5RTCae
         vP+sKjNf0u16fjdsuY8IXG7PCNat+8zDqqqoNA7Jw583BiAI7fo4dNcIx3Y99E5LjD
         ZkwsjON4xmGMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1DEDC4167B;
        Sat,  8 Apr 2023 19:01:12 +0000 (UTC)
Subject: Re: [GIT PULL] tracing: A couple more minor fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230407163343.2a8b780d@gandalf.local.home>
References: <20230407163343.2a8b780d@gandalf.local.home>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230407163343.2a8b780d@gandalf.local.home>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc5-2
X-PR-Tracked-Commit-Id: 31c683967174b487939efaf65e41f5ff1404e141
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1a8a804a4f5d6d0ec77831ca776b8db4a7a98306
Message-Id: <168098047285.1995.6172316164226260918.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Apr 2023 19:01:12 +0000
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zheng Yejian <zhengyejian1@huawei.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Apr 2023 16:33:43 -0400:

> git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git trace-v6.3-rc5-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1a8a804a4f5d6d0ec77831ca776b8db4a7a98306

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
