Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7EF742BE8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 20:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbjF2Sa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 14:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjF2SaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 14:30:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595173A94
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 11:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20034615F7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2596C433CA;
        Thu, 29 Jun 2023 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688063413;
        bh=bscEg9WR4uBEG6hYoQJeBnn31LwClrK+zPNHqsipK4k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LKwscQONhwvqe9b199R2TmPjadQ3QWoQ/PXzFrdq/8kwYQTvjlp/9K49qxlcXZfpz
         rEtSv9HHYCAeOrg24nlWgqzPw7BeDgPLtgkhynXj9lyrChQTvBkKE4yq9LB18KYO3k
         uY7y53g40IXvxX+kX9X7NuAfGq8OLyiZg1176l+HzaVd8o9nl/mtvApBbqLXEdGhYd
         b6Mz8M+3t05unDBaPTuvmkqgzV5eC9rNBgFy9CmX1rD/QeXFNxRqCjfyPt0C6BYgnH
         RC6MWGsvOU+h/WcN04U7k6m18/3nPEp/pSoNrzXJbBWZOlwD9PpbQCF9coVaF1BIxl
         Qo7iRFI53ObBA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C46B7C41671;
        Thu, 29 Jun 2023 18:30:13 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87tturevnv.wl-tiwai@suse.de>
References: <87tturevnv.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87tturevnv.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc1
X-PR-Tracked-Commit-Id: d6048fdc870240e5020343f8af0c825829c232bd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f8824e151fbfa0ac0a258015d606ea6f4a10251b
Message-Id: <168806341377.20934.5588910192303590564.pr-tracker-bot@kernel.org>
Date:   Thu, 29 Jun 2023 18:30:13 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Jun 2023 12:19:32 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f8824e151fbfa0ac0a258015d606ea6f4a10251b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
