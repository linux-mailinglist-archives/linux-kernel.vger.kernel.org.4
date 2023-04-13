Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E846E187A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjDMXpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjDMXpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:45:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084DB35B1;
        Thu, 13 Apr 2023 16:45:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 908C66428A;
        Thu, 13 Apr 2023 23:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2FD6C433EF;
        Thu, 13 Apr 2023 23:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429513;
        bh=SjndJN9h7+r/dIQeKYTVRWL3UjFPyhDljk21Mjk1fJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H06UHAt2aiJxr3CrSYJkI4P0N9TdQXMeWBeKS9BRpzbE0IPcj2gzb/dU1HDI7vDMZ
         Fot8aMVKLYxKDPx10F3hWl5V+XGSHiTGI34iBMjRLiyNN2YqdeXCRmq/rYZr0ebL//
         3Jte9z0UD4Ve7SWzu6l9HVsdASdoLzubkpvzHwdvWyJsWGOYJ4d+0wnIa9Tc2d06x6
         ySdze3mFYn5SihSafF1H0INP+jP8TYbt7qbXnSZAEaY3iWo2y4nEImcz6n8jUaMTFN
         iZzBDwxNQBkCY7Hd+gRkEzrkRm8rhYxrJg+yqrQ5ONTdRv2pof3hkLFFrpyxhMUZzk
         RXbHmZqYcYElQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E937E5244F;
        Thu, 13 Apr 2023 23:45:13 +0000 (UTC)
Subject: Re: [GIT PULL] clk fixes for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230413224047.4086269-1-sboyd@kernel.org>
References: <20230413224047.4086269-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230413224047.4086269-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus
X-PR-Tracked-Commit-Id: 632e04739c8f45c2d9ca4d4c5bd18d80c2ac9296
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e44f45fee8d5520c6a72e308054fc627e8e38619
Message-Id: <168142951364.2357.1414765178289555260.pr-tracker-bot@kernel.org>
Date:   Thu, 13 Apr 2023 23:45:13 +0000
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

The pull request you sent on Thu, 13 Apr 2023 15:40:47 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e44f45fee8d5520c6a72e308054fc627e8e38619

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
