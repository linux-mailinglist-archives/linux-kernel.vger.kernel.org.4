Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3625E6A8D3D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjCBXuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCBXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405FB1E5C6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:50:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0FF8616A9
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37BB0C433D2;
        Thu,  2 Mar 2023 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677801002;
        bh=o6+RPttj+F7O8EuNRHIgAHSi4VFjzd+vvuWjOZdeD1s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+atFnSNS0gVrMqOwS6EvYm1ANGbrEYfzCvRboT4rgj79Si78kAKb+4tLn9dva1qb
         mBCo3irm5x/pGymVMYcbJUgs7Tzm9JXwbfkC2Ormf41t4SLz/PKCM1YR7broiQRCwy
         /l0JHnsT6+iUze8wvv0m6kjkKb7qGWOllOnzVDPtTWDYdoOhHiMikGDDYnqw7ecicR
         AILCf1KrOZCfZS/2HUf3HMBxLLyX3iV8rjAfNgSmemjI4ll7RVWbSJCyilXf9+iGAq
         tdIf+VwIdJlrpgPOr9xfwgHL6KIOZBxtaVIH570vpfynmuX1oJGbtJIaFI96P3PP89
         0/kTWKWktHipQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16FC2C43161;
        Thu,  2 Mar 2023 23:50:02 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZAEnlmDoISrqfWOU@arm.com>
References: <ZAEnlmDoISrqfWOU@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <ZAEnlmDoISrqfWOU@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 010338d729c1090036eb40d2a60b7b7bce2445b8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 39ce4395c3ba730341b067e1fb8abbdf9c47ca77
Message-Id: <167780100208.2106.17839220295730393780.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 23:50:02 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 2 Mar 2023 22:47:50 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/39ce4395c3ba730341b067e1fb8abbdf9c47ca77

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
