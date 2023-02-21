Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEBA69D834
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 02:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjBUBxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 20:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233110AbjBUBw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 20:52:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090F2331E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 17:52:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1DE160F6A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 269A0C433EF;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676944366;
        bh=/QPp5xggbTwc/uVZmnue3IAarnQrYXWVpOnoTFnlo40=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=dsOe5OWbXGCXFNyVcn2ZBNR7haF5ajTS440y3Zjf2WOm1ROpMIrzy25Uo8yvUqr+b
         2YBy/5EgKYClX8+qdRr2q6/RKfOIzhb59YndqTInzaoZbfBSgXK3n1eGC3tXSEPRT2
         BRcoLtuwBhp/hLCLEPpuRRc6kQ8+8MB1F0hyX0BEpQDjfy+G3nzw/c6vfsSnrmgJAd
         Ipne69rt7WQmRL0eGpU4QxZFMa8dXvWN3y8sV8e/+SOHx2sNYupE8EUZxME6FZbNFC
         f1+298nmetIneOZjvE2VZHPcaX7onEEupW8whz69/gNSIzuz3/zdqE/rs6Aye0onhd
         S03rEFxzkWOEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15701E68D22;
        Tue, 21 Feb 2023 01:52:46 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/NmzouehvMWTPVZ@gmail.com>
References: <Y/NmzouehvMWTPVZ@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/NmzouehvMWTPVZ@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-02-20
X-PR-Tracked-Commit-Id: 3b4863fa5b7dd50dab1b10abbed938efd203752f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6e649d08568220ee88deef0a1ad8b3a935420cf2
Message-Id: <167694436607.8087.12659521480083298022.pr-tracker-bot@kernel.org>
Date:   Tue, 21 Feb 2023 01:52:46 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 20 Feb 2023 13:25:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2023-02-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6e649d08568220ee88deef0a1ad8b3a935420cf2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
