Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174CA69E5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjBURYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbjBURYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:24:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D927BD538
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 09:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B22FB81032
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B7AFC4339E;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677000284;
        bh=ZFv640IqXeghnkoXT/r8wku36D69TaZIGhxY44sT08s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UQBevu0pwssPPbBzDcENKVg4z3ZL/+dX5F8O4scesZQg7okvXzYsEkcNYcGmubSXI
         dQ5PKHa7aILjeLhQJEMJE35GV7l9QnVth9ex3x8NzyLWiMxD/X1/q7pM8jSDKp8Pry
         7hW8FpbZqXVlxRyamQUJYUH+sMPqu9WbB3zZxAYJCmD1zTCrhGl/FKBl3XARiRwQfg
         GrvDrWu/Ow9o6VcSKOddH14ypUTosfhKixK2PAtmx27hQtIgOqGiFseg4ZWYP327AJ
         g+2HDy8EwuS1XyxXcq2fhOT1tbSHE9n1wAQZSye6RzVOdQLkjs4RoX4efqlixEK+LC
         JvQurP79lY/ew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A839C43151;
        Tue, 21 Feb 2023 17:24:44 +0000 (UTC)
Subject: Re: [GIT PULL] x86/cache for v6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/OafaXrqkAhaurS@zn.tnic>
References: <Y/OafaXrqkAhaurS@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/OafaXrqkAhaurS@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.3_rc1
X-PR-Tracked-Commit-Id: 793207bad71c5339c614d12ac21d627da7bf771d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa8c3db40adf1204e47dac9c410eea82567fe82d
Message-Id: <167700028416.32027.14148407731470671630.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 17:24:44 +0000
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

The pull request you sent on Mon, 20 Feb 2023 17:06:21 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.3_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa8c3db40adf1204e47dac9c410eea82567fe82d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
