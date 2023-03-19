Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBF6C036A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 18:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCSRQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 13:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjCSRPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 13:15:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF63149A0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 10:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DDB7B80C98
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 17:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBE3AC4339E;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679246146;
        bh=/tRZMYj27Ai6X4eZtYs/W8RB0D+PFNkYVHa6R8SlYuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=B0EOt1x+jiVm/dLPfTWA/rSekAxn6/aaa+qUGXMZbwu5OsrWsLwA7jUoNUezIHtWl
         Ts4Nrp78uxr2TueAqoVqVZk2PPNSaP6wu9MK2z3oalZS6uFD2lC/5/gS1zQ5rePxKy
         dZzyFNFlT69fEfrZCQiS2bSFoV9W/hDCi0O0ayg1FC7UbLxxkmUyDRhF89JmJaM0/I
         r/G60rAD5EGL7jKjH8WpG2yyi0MVGkkXYuaocbinC/a9oHAEeuNCjFQDM2KgtEmisY
         mS6IoRamP3fbAdjdmUc+fmnEeZ5y7Sce0DGirxJeXF8X/nYvlpvfMm/mAV3L5T5ih5
         OcLqAelKh9gtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1879E2A03D;
        Sun, 19 Mar 2023 17:15:46 +0000 (UTC)
Subject: Re: [GIT PULL] RAS/urgent for v6.3-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230319130408.GCZBcISGmEgDSRM50y@fat_crate.local>
References: <20230319130408.GCZBcISGmEgDSRM50y@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230319130408.GCZBcISGmEgDSRM50y@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_urgent_for_v6.3_rc3
X-PR-Tracked-Commit-Id: 4783b9cb374af02d49740e00e2da19fd4ed6dec4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c46a7d047369bb175bc689249c484a86616ee018
Message-Id: <167924614665.22094.5215474431874067721.pr-tracker-bot@kernel.org>
Date:   Sun, 19 Mar 2023 17:15:46 +0000
To:     Borislav Petkov <bp@alien8.de>
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

The pull request you sent on Sun, 19 Mar 2023 14:04:08 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_urgent_for_v6.3_rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c46a7d047369bb175bc689249c484a86616ee018

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
