Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82AEB6BA552
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjCOCle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCOCl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:41:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EDA3526D;
        Tue, 14 Mar 2023 19:41:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF4F4B81C61;
        Wed, 15 Mar 2023 02:41:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9D7BAC4339B;
        Wed, 15 Mar 2023 02:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678848083;
        bh=cvwvvi834SOtHAuwLy0Zo0aR1OIbazmHZSMZaKfwczI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BmEhCZU610hENjDKTPIru5SZl/g85ocOLYqEejmrfgZ4faNkeuXv7WU+aS7xGbxoi
         mWNv4VhykovcnocNxZOx1BYfE1e3Rftw1gn12l8zFfIAHW/Mwu31R5tUQmmTEUD4BT
         Bs1yCDmDgZDDPQOTg9FrFrIZCf04+tQ5ZEoXc0gLVPvHhkBsvtqAY6FHtZ4iKqL8oK
         XVUFex+cclO6qsePLGvRa8tEE2HqSfmtsblb6jDuq5n3r7G5UykDXU5Pcj6dpWnc7Q
         3pCFxx6k5ssUL38eUXWvGH977w7Rx5kvoONhFdrdmBbgTWO1s8M9SFo8XPBYifPknT
         vytzJphQGiT0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C2D5E4D005;
        Wed, 15 Mar 2023 02:41:23 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230313231919.66868-1-sboyd@kernel.org>
References: <20230313231919.66868-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230313231919.66868-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 5cf9d015be160e2d90d29ae74ef1364390e8fce8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0856b7c14b690ef9917cdb1d94e96169212e43b
Message-Id: <167884808357.332.78190221801282534.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Mar 2023 02:41:23 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 13 Mar 2023 16:19:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0856b7c14b690ef9917cdb1d94e96169212e43b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
