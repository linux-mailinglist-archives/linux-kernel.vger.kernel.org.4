Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1E867724B
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjAVUUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjAVUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5302F15CA5
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 12:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A0EAB80B67
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 20:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD643C4339C;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674418838;
        bh=lHOdugfzdZmNFcz0XY5+uWnIqYzTnjI3WVaxDb3v330=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r4ASRX3ZfgnXD6bVydpJ8caipxNG7mn61KcWIm2fVB5WSkR9KcdhsZQkANGyGL3W5
         b4mWfDC0+ZZUl6f1Eo78pPF0DoQ0f4BPT0Q/NY2fzBQGwXWgHOSYcQutJM18uN/eGF
         szJJP1h5o5/rThKJXCRfHL6FQwaQLSmL0O8Y9kO0JKM5CdxFT4809ARc7ON1+QXrJ2
         EGXqFj5ln7bpA1deVl29ou0fEZTw5oCT97F2+HEaAtrKgqd43A8CUAfbyI2Aw6WnBq
         IbHzfIQ+T2JttjipbQxyPwoOVeh9tZSzDuRFawZqxr9Phrsr1lody7FJDpc9041VuA
         fici0iJTqvOlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98569C04E34;
        Sun, 22 Jan 2023 20:20:38 +0000 (UTC)
Subject: Re: [GIT PULL] sched/urgent for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y80pqpsa/f2eEcYP@zn.tnic>
References: <Y80pqpsa/f2eEcYP@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y80pqpsa/f2eEcYP@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.2_rc6
X-PR-Tracked-Commit-Id: 5f5cc9ed992cbab6361f198966f0edba5fc52688
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2475bf0250dee99b477e0c56d7dc9d7ac3f04117
Message-Id: <167441883862.2461.14910574486585478128.pr-tracker-bot@kernel.org>
Date:   Sun, 22 Jan 2023 20:20:38 +0000
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

The pull request you sent on Sun, 22 Jan 2023 13:18:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v6.2_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2475bf0250dee99b477e0c56d7dc9d7ac3f04117

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
