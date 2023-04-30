Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2C0F6F2742
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 02:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbjD3Aw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 20:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjD3AwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 20:52:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A492619A6;
        Sat, 29 Apr 2023 17:52:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D83261268;
        Sun, 30 Apr 2023 00:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B354C433D2;
        Sun, 30 Apr 2023 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682815942;
        bh=+eSzCKdPDaIGkxtVyeNSKhp/O6nGOhDGwjf0jRWYwg0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kRzi9HS+zUqBzk5LaH4r2AQffJ+hPC8jImTT2eXec8+5nY07eS9BOFF4IaOndBRz8
         U5qy3r3feQmbMOFHTZye3Ym2Z2eT8Gh5CLNpTvaISEjn02gg8iKJdLTk3WqilReIAo
         3Lj+Qsu+owyll/ATaput44Ja56V4VT5rmiSBUvV8Mo3GyL9UCdncJxYMVkBOy+891J
         Y3ZXJNF6IXJRnamtkii9e6KU0vJfxzVyrYs0V3I0rwRLtHkp03gVesfTIXDS6bidQc
         gGpmd5cM6+9OeUmjSnwbieL5U6QpVgTFxEVD3cmdxRILjoQKEOi7m5cDsZMGJUgjTo
         cOFuSr7JcVllA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 64B37C43158;
        Sun, 30 Apr 2023 00:52:22 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230429012555.2883350-1-sboyd@kernel.org>
References: <20230429012555.2883350-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230429012555.2883350-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: a9863979fbc25838bbe7c5badf538cedfc802f60
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e81507acdc19d91df4121f409871f3e4e055f6c2
Message-Id: <168281594240.341.8144890961518670604.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 00:52:22 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Apr 2023 18:25:55 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e81507acdc19d91df4121f409871f3e4e055f6c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
