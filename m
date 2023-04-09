Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE12B6DC0D6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 19:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDIRRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 13:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDIRRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 13:17:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D469C30F8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 10:17:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7076E60C0A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 17:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB81CC433EF;
        Sun,  9 Apr 2023 17:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681060627;
        bh=NiydsmcKG/vUrCL45f/r5+EKfS9KCN9Xc16eFK+Gd8s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VC6RGgpLh91bZ8+kdgDiy9+LtRV940x3yqBgxcVLB5EvG4OyVsYiNQZZpIUPYmJpZ
         miM7fwtLIrLQfzfT4OvlcFmtsWHmWFbLstCK/qKnPITZKNBvCkEH8p/rwaqGywkfzG
         JYrpAW9s97IK/cXeKTNqdLDCDCMKmaqX8i3wak9ycIWB6S/dEv+BPhBXzGSBWKLHXY
         /MYuZbPPZPGFqX7y0x1iJE+AuaAslEKtZktKmxZtLQDn2L2DbJi6kOpCXGepTF2Oqw
         q9q/peeLsQikxdFmbA9IouNorC8+9iDqa2BeqhEGDptOu9wyphP3CUoej42SxCJ6DF
         5NJeLMd4GBi9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA8C0C4167B;
        Sun,  9 Apr 2023 17:17:07 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230409105446.GAZDKZdk7yLXG227S5@fat_crate.local>
References: <20230409105446.GAZDKZdk7yLXG227S5@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230409105446.GAZDKZdk7yLXG227S5@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc6
X-PR-Tracked-Commit-Id: 81515ecf155a38f3532bf5ddef88d651898df6be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4ba115e2694dc9a10abfe94766d70b64ae9479c7
Message-Id: <168106062775.14171.10379027260072476998.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Apr 2023 17:17:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 9 Apr 2023 12:54:46 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.3_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4ba115e2694dc9a10abfe94766d70b64ae9479c7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
