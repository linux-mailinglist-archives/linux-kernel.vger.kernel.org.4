Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8F964C0A9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbiLMXcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbiLMXb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEB6E7A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0820D6177E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5680AC433D2;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974314;
        bh=XjCf45oteKdEauyFJLAvI037WWjioU2QVYdz33U3J1U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cLsLmYwwuccrpVBeXvLOp8DK+pRGHf8zOrgCbrtp1uQAM00hnkz/dNTP18Q+S7PhL
         Yvr2kzFjBKctu8x4LXkBw0q2fu14BejiHcAz5nIWLwZCYeGJuVA7wE9Pikszcl4oGZ
         C0fWNFOQA/mWCJyPFxbWC0PjwyVavhxINjhiKA++sbB1dyylYl+lAcJZ8r6OT1ifCJ
         SQF7XFh3yTRVZdU8RlnsAbhqzk7bqQHbSmHIuanCt+6Drv7QZiFo8e6FCkpU+wf128
         6cqjO+GFmpevveJQuWSROyLX8vnDJp8yx8EtJp2gHVURLNJ1MJxrqX8pxXu4HFBff+
         Y7YHHC54xFupQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42A00C00445;
        Tue, 13 Dec 2022 23:31:54 +0000 (UTC)
Subject: Re: [GIT PULL] x86/asm for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5hhoqZ7kWJ5KHMx@zn.tnic>
References: <Y5hhoqZ7kWJ5KHMx@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5hhoqZ7kWJ5KHMx@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v6.2
X-PR-Tracked-Commit-Id: bce5a1e8a34006a5e80213ede5e5c465d53f1dce
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b9ed79c2d587bec5f603d66801478a5af9af842
Message-Id: <167097431426.3216.2249414895104788910.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:54 +0000
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

The pull request you sent on Tue, 13 Dec 2022 12:27:30 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_asm_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b9ed79c2d587bec5f603d66801478a5af9af842

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
