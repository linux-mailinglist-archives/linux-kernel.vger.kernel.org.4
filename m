Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09AF655563
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 23:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232495AbiLWWsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 17:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiLWWsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 17:48:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F81B78D;
        Fri, 23 Dec 2022 14:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 469F561EF3;
        Fri, 23 Dec 2022 22:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB2C3C433F1;
        Fri, 23 Dec 2022 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671835714;
        bh=NO8bkef4ak5JGjght8J+Tl6bSS1+8AQ4F5L92zwQvRo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EXOVd4g2uR0/gJ4+4xF+I/trAlVKFdjvg9VK4/LjaaLY2TjQD1pdU8AG5LVTThVYE
         UoLSZImiTF3xvPDV5kQpMU8B3poGuT80FU6pZL+cOGvY+VjDCC9/yiAiQUrI6+7IjW
         d/a7dd3asT9rJmqWya0bsDlxCkRz29ZMgUuwwBUSlX5ViQGD4Wphvy8JmJGxg8RqTh
         KV6oil46RvJPKylFEApP09G5riHwilyhNjgrqcKUm2cTTwctMYNuVO6agh7LEJ8hn5
         Bp6TTCCTLYuhs33dUB0p9PZKHdbZCfb3jfbVZ3IL4PCLSX9BpvaUvqYQgouA/5uI4c
         9nwtlL1N3iWBQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 939F8C395E0;
        Fri, 23 Dec 2022 22:48:34 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221223214143.30A71C433EF@smtp.kernel.org>
References: <20221223214143.30A71C433EF@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221223214143.30A71C433EF@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc1
X-PR-Tracked-Commit-Id: 3b553e0041a65e499fa4e25ee146f01f4ec4e617
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72a85e2b0a1e1e6fb4ee51ae902730212b2de25c
Message-Id: <167183571459.7718.11715338346144032541.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 22:48:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 23 Dec 2022 21:41:31 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72a85e2b0a1e1e6fb4ee51ae902730212b2de25c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
