Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79AFF69D92B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbjBUDHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 22:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233422AbjBUDH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:07:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD963233F9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:07:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55F61B80E84
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 03:07:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CF18C433A4;
        Tue, 21 Feb 2023 03:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676948845;
        bh=6Sz2vGMawkEKTsEbONBHw2NhVmXTquHVx98sCjfCfC8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d9MyS8Lm/FGDoXD3aV88sJKqEOrL+6SYdsNfxJ/I5agllZEWITpBaaQiiOZbVApBE
         cy0XrHQnR43DzY2oOFHZjg3Z3UHJGLmqSYIn8Emt9IkRvQyYyKGFKFBlWnRSlVXUOn
         ExQtXOYSjilk4UzWIfA6F09uRBGToK9PWtHwtLzE84KId7982t7BeXUET2g5F4YrZD
         AxZqahRYrp96cL9tFEUrv4j4xEl/TBYzYaMpPUndnauqgkhxUeLaPIIwyxqrifDgEq
         JNtDFiRaORhLE6v+S81XUQ0DRL36JAIvgw52Xu4p2AvWWuPGmBQGB3YWwVnMVd2A5F
         KXC1W713zne7g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EBA95C59A4C;
        Tue, 21 Feb 2023 03:07:24 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/Nzi6aRDKNcvv1a@gmail.com>
References: <Y/Nzi6aRDKNcvv1a@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/Nzi6aRDKNcvv1a@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-02-20
X-PR-Tracked-Commit-Id: ce3ba2af9695e4bd64d797e0026321e5dca29dd3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8a68bd3e9ff6f480fc03369023a1d981cb803079
Message-Id: <167694884496.12895.3747761873594795012.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 03:07:24 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 14:20:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8a68bd3e9ff6f480fc03369023a1d981cb803079

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
