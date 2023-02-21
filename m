Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F7669D835
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjBUBxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:53:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233245AbjBUBw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:52:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5121A1B4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:52:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 61747CE1264
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89982C433A4;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676944366;
        bh=B87uAV932X0uHKXfwHgJ7HkFDhUJsP7oqiJLA6wdJT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=PVbnKceD3mcGUbzwqXMYh75/AhrOIQWbuTsuOeowrRX0rtPVC//j2+4PZvP66fUnv
         IX2hx5ya2R2StZhAKuTW+wwFWnEzEPYI45UOa9x2Lqcq2lCJkZrAbFN9ciB3K35BB1
         wQg5x5X6onWBBGPUIV6NWzeq1yQPZU8FeeijQMbQVRNmigtgDWisQHh1Hqu80bjUbg
         k7dKXRQ1TmdsWDNQudMPagi2mBWFRkeYDKYSiD9uz/sM0PM/pVtO72XnAVPo98Zlwx
         b5hcSj3aOkgs8T2Z02TVnAHUJEtVL52zLgtuv7q/xidBwKWg2P6otmJiTlq907k2k2
         SHVtO9pn/fKew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75C31E68D20;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] scheduler changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NttaqRZ+zaHIjo@gmail.com>
References: <Y/NttaqRZ+zaHIjo@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NttaqRZ+zaHIjo@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-02-20
X-PR-Tracked-Commit-Id: 7c4a5b89a0b5a57a64b601775b296abf77a9fe97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1f2d9ffc7a5f916935749ffc6e93fb33bfe94d2f
Message-Id: <167694436647.8087.14443442533378022588.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 01:52:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:55:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1f2d9ffc7a5f916935749ffc6e93fb33bfe94d2f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
