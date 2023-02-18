Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA57069B7D8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 04:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjBRDEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 22:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBRDEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 22:04:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A01C6B330;
        Fri, 17 Feb 2023 19:04:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AF609B82F28;
        Sat, 18 Feb 2023 03:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F10AC433EF;
        Sat, 18 Feb 2023 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676689468;
        bh=2bj7d/9sTjnIwubfO4gptXyPlYmiHPnLCYj0UUaVN9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=p1vYmbSHgaliHausQYkKzz3fwqv2507XdIyFjadw6qZ3QyN6ex2ZKnNie+X1YAVeD
         oB5FwGGRW9POhURypVSotmRCPObu6ZvPti6L3RLozbEF0malAjKy+t5sf74QI4Yra/
         cZwCathvX/ChCQwxtA9II/3HcgCWd2du6L37PqBXCQjx1/A/DvelKtjClHgp1Wp16a
         70vGOFEAoqGSNggC74tGdP2LKNVQsOv2A1Hau5pW6MZR6H1qVM16TVpNt0K/5k9JC1
         jSNZQIAWsC8U3OM52TgD+1GeEzMSbBITFO4D21tNReM+tNh0JDSryt44jhjuUA1WCm
         JQ961kPIXvT0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B825E68D2F;
        Sat, 18 Feb 2023 03:04:28 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217151820.e1fa2d36179e44069a77040c@linux-foundation.org>
References: <20230217151820.e1fa2d36179e44069a77040c@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230217151820.e1fa2d36179e44069a77040c@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-17-15-16-2
X-PR-Tracked-Commit-Id: 99b9402a36f0799f25feee4465bfa4b8dfa74b4d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38f8ccde04a3fa317b51b05e63c3cb57e1641931
Message-Id: <167668946830.29732.7595341653557543287.pr-tracker-bot@kernel.org>
Date:   Sat, 18 Feb 2023 03:04:28 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Feb 2023 15:18:20 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-02-17-15-16-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38f8ccde04a3fa317b51b05e63c3cb57e1641931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
