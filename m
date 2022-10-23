Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCF609511
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 19:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiJWRS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 13:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJWRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 13:18:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660373339
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 10:18:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8FF860F18
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39E8CC43142;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666545525;
        bh=s1F9xVM1NNRajjroBi3qwKS0r6o7lYgx1HE2bAT9bKI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=llXjPPEvFndPQVtwJRg8O73wU0/XTkgzxMYlufSfUvt4QNRCXjuqYuUz7K1n9z5eH
         XDEW2PrRU2LSFlAak0ZpIxpBtahBnfJ1QkWs8J3XaKp/3sPxY/NtHcINEioMynMomG
         Fh0H6B3AFNj4mqNifUheGQZpS58UiI+CDtje3CkOc/s3rlm8GTTgZPmgHWm6eCIRah
         WipMGBgyEg2e0g88VsyveNuirQdxrJ2sV6IPk1tFu49+NO3hAV25P2D1n7AfX4KmpI
         AMECJoZfWM2Qyl3iLk+OvHycLXSH2U6+PI5finVHSnI4MmvrRH6UPL0LXjVXqDXA0W
         GRm9klpsZLpMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17CF6E270E7;
        Sun, 23 Oct 2022 17:18:45 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1URjLOJ+levWPkw@zn.tnic>
References: <Y1URjLOJ+levWPkw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1URjLOJ+levWPkw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc2
X-PR-Tracked-Commit-Id: 8e5bad7dccec2014f24497b57d8a8ee0b752c290
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c70055d8d9a0b2c500446065c1b80d9836789596
Message-Id: <166654552509.1521.14318405326438457475.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Oct 2022 17:18:45 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Oct 2022 12:03:56 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c70055d8d9a0b2c500446065c1b80d9836789596

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
