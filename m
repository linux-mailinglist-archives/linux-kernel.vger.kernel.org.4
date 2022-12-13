Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7064BDE7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbiLMUZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238075AbiLMUYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:24:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85876594
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 12:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88534B815C9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 20:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BE9B0C43396;
        Tue, 13 Dec 2022 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670962822;
        bh=cvs+drubWzth30IoSC5MgAWiJnmrRPwCVrpxDVJVfUs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=clvJ6fq0mo8/YY1xsMLQSdAy7h6fxna/+u6slw2RTIf/fG/2gIUNbbFYxzk2bvmmh
         v2cBffZK+95v1ytDrTjMGe8GZ75y8HI6uwwLghOqRTyZmCtA44fqG+4aNx90CGzCYx
         gMZr1qK7DcvbUHiwbRLPFFUkm3N4W9F8G31jNOFqaqU4EiUy+AkRSTwK4po3aBU8pU
         DVSHtJW2S8yWJ1du7FOdF04wiVPOqwA+YYLRv+9ZbED96YPNJbBXpdZ7YWho9IhiaA
         70XKCiYKr8ygUPLvmusz12FV7zA5wmigsq3m0JWvCOh+c25MlWxJYHaD6otxHx93IQ
         G2bN5oAMDtg4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEB48C41612;
        Tue, 13 Dec 2022 20:20:22 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87fsdq80nm.wl-tiwai@suse.de>
References: <87fsdq80nm.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87fsdq80nm.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc1
X-PR-Tracked-Commit-Id: 8ec2d95f50c06f5cf2a2b94bcdf47f494f91ad55
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 102f9d3d455870844c47b82322c2dfc0a35eb745
Message-Id: <167096282271.13378.2742491851484027141.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 20:20:22 +0000
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

The pull request you sent on Thu, 08 Dec 2022 14:50:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/102f9d3d455870844c47b82322c2dfc0a35eb745

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
