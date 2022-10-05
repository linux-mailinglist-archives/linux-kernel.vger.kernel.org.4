Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237035F5A93
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 21:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiJETYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 15:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiJETX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 15:23:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0A077E9F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 12:23:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDA9861796
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 19:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D4CBC433D6;
        Wed,  5 Oct 2022 19:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664997822;
        bh=wfcKZ5X2VzC/y4GXVewZxw3NaNGY73nXaS7gIclSwuI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FJ93jeTPDBBo4D8mowIvRMX2RIj699YDoc6bOQpixZTdlIdlTGuMcdTjnaWodnhwR
         B/dY7oS5UH4XWrSSNdRykfAI7OiwxM6wRUWPvydgOgElOfARTsw2dhotK4DaT8IbVQ
         qCfMPcOoW5BB1DwTofRozLf9Spj2JRMLk3uDMtioLV6mLJeqf9MWKwNwA420AdsOXT
         ACO1Ad6F8jUZmahw+JmD8FUvITxOHN12Cjsdh5Sh3Lq8RXQ5OvGN0MDJV2ehdVTp8m
         N5w+IOLicNkIBk16WGREdRLI/EVFGHDRUL43Y8QtLUSBi3yvw+WByykJBTlgD0dfVu
         haffyxS8A+90Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3C099E21EC2;
        Wed,  5 Oct 2022 19:23:42 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <878rluv48m.wl-tiwai@suse.de>
References: <878rluv48m.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <878rluv48m.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc1
X-PR-Tracked-Commit-Id: 86a4d29e75540e20f991e72f17aa51d0e775a397
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 833477fce7a14d43ae4c07f8ddc32fa5119471a2
Message-Id: <166499782223.4557.15284998948718247855.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 19:23:42 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 05 Oct 2022 14:34:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/833477fce7a14d43ae4c07f8ddc32fa5119471a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
