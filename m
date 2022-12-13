Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D764BEF3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237478AbiLMV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237654AbiLMVzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B8626483;
        Tue, 13 Dec 2022 13:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D5836174C;
        Tue, 13 Dec 2022 21:54:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4822C433D2;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968442;
        bh=hgpBuVcvMrdGBqFui4q6AYWVyY2QiHfvL8dSsxHImI4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NNlijZ0iCOw2WXEnzChBBFPP6mZWTf6clLB1RTATzNb/Fm0ilLpMaZF3TeK3v1YAQ
         1u5NvEFaQJC73aP32p+qbcbzpEdHVLtiNuXQbk4iSHgM5UsjqhyXPgLFoPE4TTsoxs
         +DF/NB/jy2MjP7D58PXnwcbGDoiqzUHauJ81VnurExlZTzzIo6EGdYhy2w2SYF7qrC
         Nd41VQPm2f9GS42D60abKlsEys1I/AYH4T9EEXKNfzPxzeKViW0P+LhX7UBOXACzGQ
         /C3khILN8QJ0Vb5DQdhJmA+4/3NeVX/C1hEvyw+CbuaXTJd//erANuZgco4ZoqFP+P
         0c7j3raksEO8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5A6FC00445;
        Tue, 13 Dec 2022 21:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221213211749.4067995-1-sboyd@kernel.org>
References: <20221213211749.4067995-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221213211749.4067995-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 0e2c9884cbbae00f956d881848669790d73be43d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0015edd6f66172f93aa720192020138ca13ba0a6
Message-Id: <167096844287.13204.6931822813419220324.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:54:02 +0000
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

The pull request you sent on Tue, 13 Dec 2022 13:17:49 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0015edd6f66172f93aa720192020138ca13ba0a6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
