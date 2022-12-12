Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F8D64ABB5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiLLXpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234015AbiLLXpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:45:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC7E1C43D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 15:45:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9722C612A3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B82BC43392;
        Mon, 12 Dec 2022 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670888734;
        bh=KpVbB2J3bHJFgRfgGtnZsA8lbz6yOINpCU6xQNXjCvo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QSx7OwSt9dX8yh3ujVax7FGg2i7TiY3qDctAUiRTtMeEu1r8l/8WpABKWD2xT00f/
         /9gExtZvPwBhvQQGmKLBk7nTeyzyH/Q+ykEd/04EnhreUL9SoQzJlX9JZzILDaMsjd
         6GACgnytVcvLrmcOfFLfdzBK2brIdEkLYV8DexilzB4xrhdVVyErjIpMtG2gtnVjcL
         zcaNX/VcuFqK6RmgIRKy8I5baH4LvHFutSAAjYjNF3/rUU+y8DZmVPj33ctd5Ko9GL
         QM/ubnUgak/WaUOB5P3fYTR2SbQwOyh4CqHwg4UWWpflMUl13UiK3Aa0ioQsn9nJf0
         Juh2qzEz6ALPQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE4D1C41606;
        Mon, 12 Dec 2022 23:45:33 +0000 (UTC)
Subject: Re: [GIT PULL] locking changes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5eMDYABnSszN9/s@gmail.com>
References: <Y5eMDYABnSszN9/s@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5eMDYABnSszN9/s@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-12-12
X-PR-Tracked-Commit-Id: 90d758896787048fa3d4209309d4800f3920e66f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 617fe4fa82b2fe5bcb99f97f223f408603bfa5a0
Message-Id: <167088873397.9522.7509300424949580747.pr-tracker-bot@kernel.org>
Date:   Mon, 12 Dec 2022 23:45:33 +0000
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 12 Dec 2022 21:16:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking-core-2022-12-12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/617fe4fa82b2fe5bcb99f97f223f408603bfa5a0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
