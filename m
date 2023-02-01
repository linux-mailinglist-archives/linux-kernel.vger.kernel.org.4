Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A37686F83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 21:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbjBAUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 15:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjBAUC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 15:02:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392B38030
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 12:02:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ED8CB822A6
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 20:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA4BC433D2;
        Wed,  1 Feb 2023 20:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675281770;
        bh=Wc6rIArvMexezzMYogFFm0lNeXJ75xux8zXicvWY/kc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=E8L2qVWw+6IHvrhoVZvunZNRNQtHMDWdkocyE4zfM1E/EFQWwDSDvVLfJX/9spPwD
         B+k2MslBH9+YiTKFBrKpGyvIoNGCqO4fb0yWYIaD/Dna2LUC8V6vQRX4Nd26ZtvLIh
         DQBNvHwXyduLRiyg0Py8EJY5HJw/4gZH7b+s6Q3SwFapy7loFVZCTAXVO44+BaEryz
         VCsE9MLcHzPaXN2ef33uOZqYgEZRJFE/O/k6p9nhqK6lE9l9d8UCcbcjLclk7Vic6n
         85izsMGv2hA8kwy5ieqH7fMe6hSd+FmusAOV7YUANPNleiyW8MxxaBapuKn9VbmW1f
         nTsiEZ+SAMCfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7540E21ED2;
        Wed,  1 Feb 2023 20:02:50 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87edr9y5mc.wl-tiwai@suse.de>
References: <87edr9y5mc.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87edr9y5mc.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc7
X-PR-Tracked-Commit-Id: c7a806d9ce6757ff56078674916e53bd859f242d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce18d3aa6a232ec80ece60ad5d6eb17bcac1744e
Message-Id: <167528177081.26493.18394461049539345436.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Feb 2023 20:02:50 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 01 Feb 2023 12:42:03 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce18d3aa6a232ec80ece60ad5d6eb17bcac1744e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
