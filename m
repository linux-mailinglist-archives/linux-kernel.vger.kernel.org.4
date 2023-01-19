Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5969A674BAB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjATFEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjATFEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:04:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2150C41DC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2B2DB82728
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9692AC433D2;
        Thu, 19 Jan 2023 20:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674160395;
        bh=AXsUSK+DZQH6EwixwLuKZQam10AUTUSWkmQMuVUlNvs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cLu084G4pDwwY1W8fs85mI80C/BzvmRHbJEaWiCCSySkewViMMxOIaLr1F4MiTvO3
         rDzHBGkJ4eFPDUs6PIGNeHAC9APVrbb1PsoX7mIfzw3J7woCE00o8Bc4oOrlJr5Sri
         bUhcCsnSRJ6Bcsaed2qEJVJIt6PY6b/RejZyyg1dscU0RXuPL9G2hJAH5E1tRcgCn7
         iixM6nuaxFSyx2pGoXWQvf8IbQtOiof6zBwCTM6uu99vaAa1yYOlxbUMHdhlAU2BxA
         gMT3Ft4JIJL0XnNPoZZAG25jrLUngqIEx8vDqQY1k7gUl1lc07Ou0zLgmayj0ikcnl
         vc6RiE/5RSUAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83759C39564;
        Thu, 19 Jan 2023 20:33:15 +0000 (UTC)
Subject: Re: [GIT PULL] printk fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y8lnK3WdqVM3bxBX@alley>
References: <Y8lnK3WdqVM3bxBX@alley>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y8lnK3WdqVM3bxBX@alley>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2-rc5
X-PR-Tracked-Commit-Id: 21493c6e96e550509ead696ecca9f0d7196ee91c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d368967cb1039b5c4cccb62b5a4b9468c50cd143
Message-Id: <167416039553.29090.4593723838433610550.pr-tracker-bot@kernel.org>
Date:   Thu, 19 Jan 2023 20:33:15 +0000
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 19 Jan 2023 16:52:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d368967cb1039b5c4cccb62b5a4b9468c50cd143

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
