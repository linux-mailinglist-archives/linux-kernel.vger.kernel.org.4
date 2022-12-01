Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D2463F86B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiLAThY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiLAThW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:37:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF332EE;
        Thu,  1 Dec 2022 11:37:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E068D620FF;
        Thu,  1 Dec 2022 19:37:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E378C433D6;
        Thu,  1 Dec 2022 19:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669923441;
        bh=XoIH9GVzxAuWhvn6FjlBDdYpTYhw5huEBtcbbmAujig=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uxhw6x1FMXZFYAKjJTYG6/vfRIyE3cy9ooTjU7JS9NDvtmOsGx6ZKv79k0SSmAWZQ
         NQEAvLhlo4My1R5se/lo/8xKcjOzANJXkQRVGfFq6GSOYr3AjRdWcNSGFMv02A5Woe
         ovgb51pjEJxLCbCMj6TLrfvrvawBoBkruHz+QbVIpIEghYvZLa1imRz/Rmu23yaHkJ
         HZFyv9nq7a4cwXlMoCPVi19aTJuVEic0LSxx1bhdQ1jPITkiXn3rmsPoKNySMJzzLW
         FCDA7mndG7fGz4Jo6nPNqhzCRyjljgvMy5Kxx3CqUfQqrGAYS661I1iyLN8nG5oGoo
         7En5WBtu0UHWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BABFE270C8;
        Thu,  1 Dec 2022 19:37:21 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.1-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221130225720.1615026-1-sboyd@kernel.org>
References: <20221130225720.1615026-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221130225720.1615026-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: f6abcc21d94393801937aed808b8f055ffec8579
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 063c0e773ab33103407a76051821777014b756fe
Message-Id: <166992344123.6584.7162534931533061224.pr-tracker-bot@kernel.org>
Date:   Thu, 01 Dec 2022 19:37:21 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 30 Nov 2022 14:57:20 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/063c0e773ab33103407a76051821777014b756fe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
