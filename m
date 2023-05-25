Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A2711275
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241197AbjEYReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241256AbjEYRd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B88E4D
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:33:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E69EA619A0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 17:33:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57191C433D2;
        Thu, 25 May 2023 17:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685036017;
        bh=wEEgGo/3a4FO+gQ7yDuNpSKY17IRjGLZOy18Dr8aYsc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KjQW+AC25/0+yMDqMzBUN2csPhcMaJxxbDHUQcGp9mWU3psfmJVVOued2c1gT0mSr
         JRTlz+wSRaoVFoFlzejBsjgWZUc4TYzrxPr+chOBFg32lBeRQsvdLsH9NPkKrIyaOF
         3sSKQijZTwz0XVWOw89AUKsGgdDJfdRbYewfCcV0Zbj2uCdL3EaXmDRANATqMKhtqG
         IhZs/t/5sqqboM6Z1nT/dsGw4CKthm0Flm1+5MX2RgbV20nh5RtvR/tiw/UIHEleii
         HL5xdgwO/iKJRGKSDTCZs5WQqN1TU/4R/J5nNSyAjSxbW32xI3tye0N9lTZKeGy2gG
         FYEdRhYvtGAjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45B8BC395DF;
        Thu, 25 May 2023 17:33:37 +0000 (UTC)
Subject: Re: [GIT PULL] m68k fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230525073545.3225081-1-geert@linux-m68k.org>
References: <20230525073545.3225081-1-geert@linux-m68k.org>
X-PR-Tracked-List-Id: <linux-m68k.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230525073545.3225081-1-geert@linux-m68k.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.4-tag2
X-PR-Tracked-Commit-Id: b845b574f86dcb6a70dfa698aa87a237b0878d2a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5566051fa67352af069e0eb4b047f2b832b9a1cc
Message-Id: <168503601727.13926.4521381185593167712.pr-tracker-bot@kernel.org>
Date:   Thu, 25 May 2023 17:33:37 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 25 May 2023 09:35:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/geert/linux-m68k.git tags/m68k-for-v6.4-tag2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5566051fa67352af069e0eb4b047f2b832b9a1cc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
