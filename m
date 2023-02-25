Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F476A2BD1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 22:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjBYVKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 16:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBYVKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 16:10:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF41D50D
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 13:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79EA6B80B38
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 21:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 188C9C4339E;
        Sat, 25 Feb 2023 21:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677359402;
        bh=LUDbN0svNMNCkHYwoqmyKX3RTx5tteiNaNblPHTON8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=f/g/cfjaOzb8YqXELieii9S3BLu1M2fw4hnrqGQb53x3+YtqXaIbKZ5P+Sh5fCF0q
         /fPYc7Jn7E+MVhoxlnVGW27xEx1+F7BQl72+mFI8KXUW1S5GkvFnYPKUNPv4O0YZU+
         wU5zC8JwYvqAWk+qVayzgHjpZP5hzgCfe9FJweBJsrgVzpllNHBS+Aci+GmzSs3SkX
         G2lkf1QAxe9rP2qtftWCdmxyuCgGnI3ci97zcI3RfmT9yiAle1P8F3lQ4E3BujpTHO
         COf5msyfrW2lZLnc5dhJUGZ+rOUbBptvcQUoEdy5ylaj73BIf7qtxJq/NUd0uAgGzU
         ww/PkqWIPWCoA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F06DFE68D26;
        Sat, 25 Feb 2023 21:10:01 +0000 (UTC)
Subject: Re: [GIT PULL] KCSAN changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230224182703.GA635892@paulmck-ThinkPad-P17-Gen-1>
References: <20230224182703.GA635892@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230224182703.GA635892@paulmck-ThinkPad-P17-Gen-1>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.02.24a
X-PR-Tracked-Commit-Id: 6ba912f1c081448cf3d1fa9ada9115aae4594ac4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0447ed0d71251e8e67c9d15f8d9001a3ab621fcd
Message-Id: <167735940197.13638.17690529997684329457.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 21:10:01 +0000
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, kasan-dev@googlegroups.com, elver@google.com,
        arnd@arndb.de
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 10:27:03 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git tags/kcsan.2023.02.24a

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0447ed0d71251e8e67c9d15f8d9001a3ab621fcd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
