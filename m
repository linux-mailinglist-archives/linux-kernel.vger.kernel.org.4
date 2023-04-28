Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC36F20A9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346765AbjD1WEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346755AbjD1WEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:04:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0414E46BB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:04:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 917FD645AD
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 22:04:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB78AC433D2;
        Fri, 28 Apr 2023 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682719463;
        bh=tJomylVvw2KtauO42XDG/VqEOvjb1aK9bsNO540GBu0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QdpZxTGr1CmLSdn2FH2HFMJF7vzs87zbrJcAq5eKizu5mDzMoSX68ZLAyJi+Klyta
         Dm+eY1BPRpNy2gp37Komq6ZitPnqzk8CZ+y2NO4XqhhG4ttdrYLnH6tisKximjUB+h
         JqM768sGnNroZvKWUKF+0UbCQVWF7roe+g4Gb2RNF8evGVWY80hvFWP7/Eg5jZ+ovm
         Ym1F4VsvqwuZd7tGG+Me/rWMEf1ZD0GfLwspEhEWc5CZXKCjZwwN5lJWAkjjJ6GCXo
         dAErHtwPP/cI6yP1pHt1KyovOsnUTFY+mNqjgk8UIztHUjEqf36/o1GYDKdG2g6WSq
         oUCrm92+hGdcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7427C43158;
        Fri, 28 Apr 2023 22:04:22 +0000 (UTC)
Subject: Re: Re: [GIT PULL] objtool changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZErZgObZuVWSgxYY@gmail.com>
References: <ZErZgObZuVWSgxYY@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZErZgObZuVWSgxYY@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-04-27
X-PR-Tracked-Commit-Id: 611d4c716db0141cfc436994dc5aff1d69c924ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2aff7c706c7483f4895ca250c92c1d71e45b6e82
Message-Id: <168271946287.9872.723325575971931173.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Apr 2023 22:04:22 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 27 Apr 2023 22:22:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git objtool-core-2023-04-27

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2aff7c706c7483f4895ca250c92c1d71e45b6e82

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
