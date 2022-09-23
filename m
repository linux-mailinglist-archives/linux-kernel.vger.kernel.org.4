Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACD55E8616
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbiIWWx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiIWWx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:53:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FB13E7FD
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:53:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA4B361762
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 22:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10987C433D6;
        Fri, 23 Sep 2022 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663973635;
        bh=jsgHTL9ol7h4BOKe36BKQWAf0zE5dNcSZF4T43z735Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uv/nQu51EqFI+V+YV+q8c6bm+TkDHD1aYRD1e8XT8yK09ZVMUkajk/vjOPdQjI3Fl
         LmE0oYsZy8pd4z+eM5r9EXDTHk/OlNW3Bs9o4VbhSzgUDDgiP1WI4QljSK9lNIftdZ
         Ec8zYV0F80v7eWLy3hCadyj8pOqiTVfkMV3IPe1bkoY8NOOlTBjAnYDSU0t0rW1194
         yMVoLBzRvZlSfp6VRrRBeVw5kq3GgfYK/QlfSeIVfKFeD6OLH12zqTNiS1TPV/o5uN
         Ix/FZDmjnqnR5EaOpyLx80pjxWwlz9g4zhrG3Ogs/7DsJni9qRRre2uJJaZ51aEh4E
         CDysplNmCtu8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EF5CAC070C8;
        Fri, 23 Sep 2022 22:53:54 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220923182800.GA14450@willie-the-truck>
References: <20220923182800.GA14450@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220923182800.GA14450@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 13b0566962914e167cb3238fbe29ced618f07a27
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a63f2e7cb1107ab124f80407e5eb8579c04eb7a9
Message-Id: <166397363497.24410.13568527995590833712.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 22:53:54 +0000
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

The pull request you sent on Fri, 23 Sep 2022 19:28:00 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a63f2e7cb1107ab124f80407e5eb8579c04eb7a9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
