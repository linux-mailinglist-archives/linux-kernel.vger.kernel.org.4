Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50968709F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 20:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjESScx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 14:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjESScs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 14:32:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490981A6
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 11:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA5465A6E
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:32:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4839BC433D2;
        Fri, 19 May 2023 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684521167;
        bh=K14RvfL5bNtJjP01WcOq4iiUrs8BdClIvTB9DLiZclg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oAYuSKUe9Ie24I1iLoSOypBITGudkjhVPeoCtWIM1VEd0e/8XlktKlLs1HuoH4Wwp
         Luvotd1IcjW5AmPxRuGeg7QumrBUAJLFuSGrt8zhKdnEWzLucoFurpLJnK8pMFgsNW
         WryQ6xenvy/M1nFkqSUrrEsFj9sUkO4wBeEdfQuKMvhylP72RHfTQ549J1wEF8QXpy
         5FLzXzERV/569ufUTKuy10Wzrf3IgHaMl5Dyf5ktZ2t2dOoz9n1LU49HjGYiacoRUN
         lG706/vs1mQXNJGKc87a6PUzZ3HoW+y1+NLnUpvP9R00udxrizp3F9WJMWh5OeVSPx
         kCsyQIJHbVudg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36360C73FE0;
        Fri, 19 May 2023 18:32:47 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87jzx420m1.wl-tiwai@suse.de>
References: <87jzx420m1.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87jzx420m1.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc3
X-PR-Tracked-Commit-Id: dc4f2ccaedddb489a83e7b12ebbdc347272aacc9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 46be92e58fa8868fc10854de94f270e1d58ec434
Message-Id: <168452116721.23824.3223277432558454839.pr-tracker-bot@kernel.org>
Date:   Fri, 19 May 2023 18:32:47 +0000
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

The pull request you sent on Fri, 19 May 2023 10:20:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/46be92e58fa8868fc10854de94f270e1d58ec434

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
