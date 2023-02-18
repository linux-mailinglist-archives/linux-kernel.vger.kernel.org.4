Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799F269BB95
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 20:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBRTPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 14:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBRTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 14:15:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B413166C2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:15:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF37A60B9F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 19:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46284C4339C;
        Sat, 18 Feb 2023 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676747750;
        bh=lW3gwUNBO6KXGOTnqw4LsRbqRdhS7z7yvrnb/JzWMg4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XIbSkNriigT3TkoSaYZ8w85mVg4MrHVODb2GcimuNLX3BjFGKaOfn65reiIsuBhhs
         8Vs4YyySgfTo2J1lRoQfVqmUAkNz6UmLvY+41ygQ6mg08X3GUwyEq3gn45CyoX9gk7
         4c/ViyxmPbH7CFq8sv/ltyeA6bGyHGj6bQB/ddbvPNR4k8LZKFU4Hdu2z+YofsuS+B
         m6KYDMohhRk1FLajqVcZlOTC5ZxB7CjSd6isS/A0UJNXlrovNG1suNQGbo6R2qNFFJ
         RE27yVIOUK+n/Q+iuCvhw8OzThtyx7ylcHqmzTVYbwfFatnXZWFa3OYafdZUf4grbA
         ceiD0XHmd9l6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 303BEC41676;
        Sat, 18 Feb 2023 19:15:50 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 perf/PMU regression fixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230218111100.GA23413@willie-the-truck>
References: <20230218111100.GA23413@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230218111100.GA23413@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 853e2dac25c15f7431dfe59805de1bada34c96e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0c2822b116e300ca6e3b7f98623deb760a93a1d2
Message-Id: <167674775018.30281.14418124274740192306.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Feb 2023 19:15:50 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 18 Feb 2023 11:11:22 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0c2822b116e300ca6e3b7f98623deb760a93a1d2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
