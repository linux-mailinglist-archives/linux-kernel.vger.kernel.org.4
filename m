Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0869D925
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbjBUDH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBUDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C6E233F8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 200D260F7D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B58AC433D2;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948844;
        bh=WxuJGlYszv1GLdnbMr/0DQoftxE01Bo6pWk8caTxtm4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lBb1pabnSTMKS+73cYEFNjCPALxX0OTvuBxnHJ8/HHESCv3L8XyooIP0pkMyM5ybd
         NqKNpCy6a++5DEIePKgKQV0JpPCUMtsq1HJXAwvVJfTuxUxN+xRaXHW/3eZ4vsQHdb
         UlX2yk+n0Ii+ODNPBmIMTXWqn/h3PCnqFaVntzAdG9DJBey3ylVNKi2UafuMSKQQ72
         mJZf6XwPJsPMM7Dcu4db8KXlhGDkWtZfuXOKnXhcfacAXgUt06CI/1uDc0DkQTrVyc
         bPjv7mMu8/A3xJPLcgFvmCEW5aCiAtQW3w4bGl8nEbJMX0a4Ewg75tA22+8XhoVLiP
         gcdcbIGKyjQKw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67690E68D20;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/Nvf+xayGNkhaOd@gmail.com>
References: <Y/Nvf+xayGNkhaOd@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Nvf+xayGNkhaOd@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-02-20
X-PR-Tracked-Commit-Id: 65c24d7b0f9142c6acc9bd6dabeba22767077681
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6be3dafc7c1d323debb5910d697c5cd2cb19825f
Message-Id: <167694884441.12895.2099754833632013649.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:02:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-asm-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6be3dafc7c1d323debb5910d697c5cd2cb19825f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
