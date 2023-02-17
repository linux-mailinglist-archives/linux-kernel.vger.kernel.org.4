Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AA569B5AF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBQWr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:47:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjBQWrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:47:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA4E2712
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:47:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C3ADB82D08
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 22:47:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D09A4C4339C;
        Fri, 17 Feb 2023 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674066;
        bh=4UqKOeV4m/lPRGsMnYqcDGIruGrvNhgPJhvgWXGQixI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=quljNiEWnfwWoRrSybaIIsUPI4cDgsP4a1imrkjoA51b0EmTeKz/aSvQctX83srhQ
         +bjDz/S2B6tHDxDJFZyGYvmVoSdX1RsL9LSruBK/K0fs27lwtBNjcj8s7NMgUKefMC
         X8xbbW6wvsmtgWHIZozH/ipoj/jbrlbI/rSePKvy3fL2CgotgjY56i89N0yWnUIgzh
         jH8bDG67TE9CMmfkKEHB1FF5CaFliV/Gf57ltRybJGVA6Y8JUZCjmx2HLzWzrcC/sr
         50xcb4KofKrL3BCMNhkIqeMj0YBxK/xx+jO3AcODGXISXXqRfV6BorZGuspo7qHNZK
         cBXBMcufmyTIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE070C1614B;
        Fri, 17 Feb 2023 22:47:46 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lekwh15s.wl-tiwai@suse.de>
References: <87lekwh15s.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lekwh15s.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.2
X-PR-Tracked-Commit-Id: e97fc9cffbb9f372b53b42c36cd7b20aab44a554
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 03dad2f0c781443558a510316a5c22fdd2aa312b
Message-Id: <167667406677.13496.1884279935666728374.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 22:47:46 +0000
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

The pull request you sent on Fri, 17 Feb 2023 14:27:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/03dad2f0c781443558a510316a5c22fdd2aa312b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
