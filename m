Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB466EEBBC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239108AbjDZAu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbjDZAuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:50:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247219A4F;
        Tue, 25 Apr 2023 17:49:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A39A628EB;
        Wed, 26 Apr 2023 00:49:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F59BC433EF;
        Wed, 26 Apr 2023 00:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682470173;
        bh=emV0MF/7axFZU69Tly/ql3yykfFouLwcle28j5/K+MI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=vL9Rrop7cjjITGNGCMRMO83tgASaVklsKBS5woucggdbxCdq5a1agbFubE8Tabhfy
         NtKu+WkHmH1jpZ5NfiRLzGgc57zFunWPhbJu8PeZFAy8r7/lz7ppYbw+Y83NbdhByf
         cAUFlGGLjs/Gs7x5BlczDjaOprHG1Gg+J37RsG2Uqx6QjEQVCzcUvpB5z2KR0GWv5v
         4YUh/impiKcbcta+Pwkc/5EU0PCYuh4Sui+ivmi4gMXZ5me4fgNGh1n/K9kDVeRKtg
         dgKGHeb295apmytGRY6cfI+BLah02FRTLy/wdXey0zVE++oM+OxoFFmLDSdFAOQAKZ
         Vi7toL2SV7wGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EE4AE5FFC5;
        Wed, 26 Apr 2023 00:49:33 +0000 (UTC)
Subject: Re: [GIT PULL] MMC and MEMSTICK updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230424140203.4565-1-ulf.hansson@linaro.org>
References: <20230424140203.4565-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230424140203.4565-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4
X-PR-Tracked-Commit-Id: 22a4455e75be443fb80784175bb70f40ba6d0c52
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c5c06e278019892391ef4d47933796cacfec29cb
Message-Id: <168247017338.10866.15539200392938982382.pr-tracker-bot@kernel.org>
Date:   Wed, 26 Apr 2023 00:49:33 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 16:02:03 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c5c06e278019892391ef4d47933796cacfec29cb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
