Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB966A2B7C
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjBYTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjBYTUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:20:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D8B14EBE
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 11:20:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC85460B88
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ED45C4339C;
        Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677352807;
        bh=EvctT7ujxPFVv/wfffyaw3ofefOwMbkNH9LWddsdjmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EdXbiol/7ILyXM0xNGFWZtiQzf5N4g3czR7L+1QQL5IYI0VjWdAfEGuai275iRGz7
         B+9xMMUJYPTuJZB8Rb9DkVvAxLGKMZIkCgIbze2G9mXRvD9ElKG7YnRWVpKhj7dpxD
         Z5UXxdtTtitQIg1P+NlMWj5dxn5ifR3ZGhYNWvGqabM1WWSN5BEVJlkiWCYTS3zpL/
         fVeXkT9hEbF1SuKtSonCQMc7x6sjxmF7O3DIZwiaHViqtooe0m6c+ZjRrkVp53ZImT
         eDYFN+DEwQ1EFDyNBQWtnWDe9CS/e/uxX/vS9YVJE5DBcvy1r6abA9fuXVeWBT6d61
         EoAF2/GCOipHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7C32CE68D34;
        Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.3 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-9df18be9-c02d-41f8-93ee-7e1e124a31ec@palmer-ri-x1c9>
References: <mhng-9df18be9-c02d-41f8-93ee-7e1e124a31ec@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-9df18be9-c02d-41f8-93ee-7e1e124a31ec@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-mw1
X-PR-Tracked-Commit-Id: eb9be8310c58c166f9fae3b71c0ad9d6741b4897
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01687e7c935ef70eca69ea2d468020bc93e898dc
Message-Id: <167735280750.23615.6463231729672618207.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 19:20:07 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 10:32:00 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01687e7c935ef70eca69ea2d468020bc93e898dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
