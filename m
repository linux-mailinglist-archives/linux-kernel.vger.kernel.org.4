Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D069FC90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjBVT47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBVT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350C443908
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:56:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F5D361591
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05E37C433EF;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095631;
        bh=KvCwXa1P60062im1F/SPAthz6HSv8ngp9+qgBhzHLqw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=R/RCKH+WssZuRAafRzGT2sS4mcO02HvEr5ckt0PqcPuVTZqAJA/bzU1BjOcbM0oyp
         ZIkBotoylgEKZLm7SbJgIiyhLCxBK58Cn7tldomlMypb5xPUlTSSr8Ueng3XeIeAY0
         RsawU9GKIp8xD7vayvR+7QVqaOL9mYEfXaRbQxlQDIW/F/ZYeVGrPZ/CC4PhDm++34
         He/N7rU1iRfnWQM+JRVELQ93f1hnVFHWqYUyBDqCnUauoJMGqCSf6gjxb6oB4UXmbW
         WMH+AFnlzDMuXMoKFyRr8UA6hVIjpJWEim/agBPzjTee4R2mzYrOGezU6jDAKMzMDP
         qPxprkpWLCK+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8B77C43157;
        Wed, 22 Feb 2023 19:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <875ybzgcz7.wl-tiwai@suse.de>
References: <875ybzgcz7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <875ybzgcz7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc1
X-PR-Tracked-Commit-Id: 7933b90b42896f5b6596e6a829bb31c5121fc2a9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 064d7dcf51a82b480e953a15cca47e5df0426502
Message-Id: <167709563094.30115.4509131988281272414.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:50 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Feb 2023 17:22:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/064d7dcf51a82b480e953a15cca47e5df0426502

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
