Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A99165AB2E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:30:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjAATai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:30:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjAATa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0D2AE6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 11:30:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE3E760DFC
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FAACC433F2;
        Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672601426;
        bh=fljVMHnnRAVGvSQRXwVObv/ZPCdfR1iQfmngC6OijSI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Pad3ckXLqWILL6eTvOZoHYqzhYLe1NsqLNT4oK4OhTCLA4Dy4DEU3npejQflwVriW
         qJhFcK5b/Gyhxh84Y1Vldv7rvnsc6FDDreo2dLs0+aP4ijo5lzv5HEIYm3YdIxByMT
         22HpOGIyPu/SM/rTHuXoweAPxlnpcJZDHO1+QwEU4dpOqLx6itvFNtAnoaorU7lWYi
         ubG41bORN7NXI9U/UvXtsF15RXks3b/3fo09irTfjc5iLReZJEHxFX00Ziyt3cXjyD
         L9kibck/uDZtZ9Fi2f1TFCHm/3ZgC5LxlRTazjGUO7DQq2D9jYA+OHynjShd2pxirh
         lFTiC//okY3Gg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC905C197B4;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7GjauqO+sohqfZl@zn.tnic>
References: <Y7GjauqO+sohqfZl@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7GjauqO+sohqfZl@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc2
X-PR-Tracked-Commit-Id: 0a041ebca4956292cadfb14a63ace3a9c1dcb0a3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 150aae354b817f540848476bace2b2ba9931b197
Message-Id: <167260142596.13445.17076379338648993491.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Jan 2023 19:30:25 +0000
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

The pull request you sent on Sun, 1 Jan 2023 16:14:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.2_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/150aae354b817f540848476bace2b2ba9931b197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
