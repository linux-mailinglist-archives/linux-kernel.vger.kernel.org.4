Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E95B36E2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiIIMAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbiIIL7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 07:59:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027E4402E4
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 04:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5962361FC9
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA952C43144;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662724793;
        bh=IJUOputFjXV5vAt5gxHNiaNMaKyzne6hC3CXA7k88CE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iMzhxNvfYM0PeT6xEpg6o4+zShKPxE6BmIU9GsO3VC5Mz/VzPMSFSQzE+M836ltZy
         gQV0hoG5pRtiFlY6pGxKpED3WSbS2kHmOWgLOpkU2LqMRncF4v4ZsWq5Kdaco8sevb
         c6jTOVJLv+zXA/n0iOhyeKXiRGvV2Gr2GciyorL45+1uwGBf9/0HP03++MBrVT9a3f
         IFTo0qld6BWcBpoI3SU0QqUJOqCnbieKPyj+nTPEUTmTe7mhw85fO8PFBp++9zruZ+
         EO/kXSqbw/Ckpgd+m5RJXu97SezSveA3UMbV5tm5L9RxfGsBqwgYhvY6o9hfg7IL1a
         fNGi3G+WZ1Wrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9FE4C4166E;
        Fri,  9 Sep 2022 11:59:53 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfl1c4ga.wl-tiwai@suse.de>
References: <87sfl1c4ga.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfl1c4ga.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc5
X-PR-Tracked-Commit-Id: 09e3e3159cd4d3c9f3a1f025cb8e635d93c67c9a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83dfc0e2fd008b6fd2df70f6635cc4def41da056
Message-Id: <166272479368.31182.381554369841369827.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 11:59:53 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Sep 2022 10:55:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83dfc0e2fd008b6fd2df70f6635cc4def41da056

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
