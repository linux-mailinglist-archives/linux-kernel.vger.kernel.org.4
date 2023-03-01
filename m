Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EA06A7281
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjCASC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCASCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825024A1E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:02:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DB106144E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82278C4339B;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693731;
        bh=tDN+5IpKWtNHzSmBkgmsAG4o5/GPUgjVuQidbDwoWFQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uGIAfYz56S5ng/rqlPnnkGY4e9C/fYpVZ9+bugwWlr5JMs9SQ5eVbBdiPNHNEWCT/
         803ihhurbwLrMEf2GGWo09w/++g+IoYsOPkfjpSWTG/HOSEsDmmPyGmss7fQ7maHYh
         aiiftnDvinvfsUutwfhPFU2+hWMNpNH8G4ICo2q+T/z4SVzN5KuSn6gjEwoUq8ahp7
         bNQs7XGsr9NLCJSbOyRnkRMHlrWv41SnyFMyE1sC3hcartLlpAB5L7k5PfNd3vAJTo
         mP9daJkB7oa9Z67SJaN0b6h1NS6qXYDCkL0Dz0nZU2prQYk1hSHF4w9Dh5077LDYH2
         8PVJD9XL/KaRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 66B18C41676;
        Wed,  1 Mar 2023 18:02:11 +0000 (UTC)
Subject: Re: [GIT PULL] exfat update for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd_kAWqDdDHo+eM1MiT5tJEtvfdkiAD=WBD3sP+AUR03tg@mail.gmail.com>
References: <CAKYAXd_kAWqDdDHo+eM1MiT5tJEtvfdkiAD=WBD3sP+AUR03tg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd_kAWqDdDHo+eM1MiT5tJEtvfdkiAD=WBD3sP+AUR03tg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.3-rc1
X-PR-Tracked-Commit-Id: d5c514b6a0c0b77ed7e5ef2484e8b20eb09c5f27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e103ecedceb37b565962a199c75dd4df57742d50
Message-Id: <167769373140.10213.18016826664743395771.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:11 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 22:38:17 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e103ecedceb37b565962a199c75dd4df57742d50

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
