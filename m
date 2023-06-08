Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56780728A67
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 23:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbjFHVts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 17:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFHVtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 17:49:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5460F2D7C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 14:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E473A65126
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B8EFC433EF;
        Thu,  8 Jun 2023 21:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686260984;
        bh=YwCUGdAB3A6Wr2FPudF6GQClPa650uFgNZRbYop55B4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EI8Nb47RsOm3K9/65LkUFxE3hTwnrp29sTFdxQKiIwUyLrhaGUUlERsTocoH4vEiw
         DrH5ex2xN6gwbusnVPxWEw2vtGWSTKAEIuGIwQj2gNu+UYDeFbWHSka5ROoQO4UpuF
         +ogaskz1roxb9w05EF2GhqBhAX176yJePpOGDVn8+Q4RaoHBYBJFLctI+RYHq5uxbM
         EqBQU4iWWSYBQBD+I+o+eBHmoqMWWNIJPTI87ZMZWYdfp5r6+bnvosqaH5X6RoNM4o
         QOL7FZadt4bMnpLa02Tyz5Eiui7ws7I7sWvwb65yjZfu4/+SVeaRv7ZkZagCFcnN37
         jtkjEdZcANnsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34AC3E87232;
        Thu,  8 Jun 2023 21:49:44 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230608205144.GA2470@willie-the-truck>
References: <20230608205144.GA2470@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230608205144.GA2470@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 0e2aba694866b451db0932a6706683c48379134c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d15d5e1851b1bbb9cd3289b84c7f32399e06ac5
Message-Id: <168626098420.8327.11995337522412191329.pr-tracker-bot@kernel.org>
Date:   Thu, 08 Jun 2023 21:49:44 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 8 Jun 2023 21:51:44 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d15d5e1851b1bbb9cd3289b84c7f32399e06ac5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
