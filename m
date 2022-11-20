Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9786315BE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiKTSxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiKTSw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:52:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BAF16588
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:52:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97F28B80B2F
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C279C4347C;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668970374;
        bh=tZqxJvssKEKMAkpuG81UvkM8dqMfs7sW2lkrufl0HjY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jLSkKdWyBnzUPk6XOKIp6nlLYXCO/FeGkI9EhxcYK9STmjgOfYVQTj6xSQeD7tVpj
         ivRblOjaZm8qohw/h3a247z2X5PwnnQOmWq1GwXh5N5dgJGBb7W/+GW3SpaCNneXUH
         1XxFaQAOq0SHSI/s+DbX8GKL9SCUlbviXujPGUuCnrwbtDKmaj4l75BPFKnKK/kwwQ
         dehrN5qe1m0msoqv0feExErzMp4EhTjz+md6FzemLPD82tKP4m6o/73rMnIGlQ2tnf
         R65ifhk/u3+3PUizOToPRspQWhSsjRhYhZ+ZgWs69Nrl0Orepd8oXLsnXgqPreQzgQ
         bEpz/aokJq0Kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 411B3E270C7;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3oU5cB9LOcBLfSS@zn.tnic>
References: <Y3oU5cB9LOcBLfSS@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3oU5cB9LOcBLfSS@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc6
X-PR-Tracked-Commit-Id: 91dabf33ae5df271da63e87ad7833e5fdb4a44b9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d4f754c3615c83df277018a98486db501f92b155
Message-Id: <166897037426.26274.18167296605549697872.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 18:52:54 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 12:52:05 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.1_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d4f754c3615c83df277018a98486db501f92b155

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
