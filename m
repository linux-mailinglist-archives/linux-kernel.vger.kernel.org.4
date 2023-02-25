Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DF6A2694
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 02:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjBYBiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 20:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjBYBh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 20:37:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDDAE389
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 17:37:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDCCE618F4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:37:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 407EFC433A7;
        Sat, 25 Feb 2023 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677289075;
        bh=LbDd8O0yZNex6xC9mqeOlAAgbVxN2+w3fa8zvWJnxVs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U/SDylnSgkT8gFarf1SEMW3J3hpKVZ0lLMkFR+fKl88rdLHvQe9Hd4BIZ93H9pT3T
         rY/MGfn4q/+E+l3rI+sg8U+5DDa7BBbzlnFQT4xoTm1TjdFZB9SOkZbXCJG48bcZ0M
         Ea99SxLDsZaiUOv0hL8fVVi6DgygAlxCGut6oFPz7a/GTcvIvgNK6sf3RYVVbjOsIk
         Pm9rTMtenFel7dZ6+FZ42W+kP3ndLrYGNPt0M80ON+xi/VPrEERoymUhZrzwLcF6ti
         8Xa77U5dLbw61cWiLaQd+g976PyUe3go0vtiBFrbFtL55Uo3sPLhY5wyVLKbQUJs3R
         nAoH5wfyyxouA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2FAE6C43151;
        Sat, 25 Feb 2023 01:37:55 +0000 (UTC)
Subject: Re: [GIT PULL]: Soundwire updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/jBQIZi8JJFSkaN@matsya>
References: <Y/jBQIZi8JJFSkaN@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/jBQIZi8JJFSkaN@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.3-rc1
X-PR-Tracked-Commit-Id: 66f95de7c13be5e442d8ed4cf00e13f8dbdc1315
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 595fa4e313fee3c0b69c10bbed6fffb803237306
Message-Id: <167728907519.28954.5294823718558668057.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 01:37:55 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 19:23:04 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/595fa4e313fee3c0b69c10bbed6fffb803237306

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
