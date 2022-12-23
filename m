Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09A6553D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiLWTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbiLWTXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:23:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF671DDE2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 11:23:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64815B8210E
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 19:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21F8FC433F2;
        Fri, 23 Dec 2022 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671823383;
        bh=8FTgvJzVoDhHz9py4Hb0n3+luGF0J7g/ElNpN/giQzk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=a4aG/4q0x0tgI7EQnf4yZMlRPNBuKnPezWWZ1fV4vD0GbUEdQs/lhfrQNaq5ZGq5m
         AM8Qfjhho00wh7BzbzXQJze7///qmwdl0it11GwXAz63pZi+GBpXhCfbrcUA0Xlwm5
         iiYw/v2HMAtah2hqW3AsUfTHR5jkyUhMtiApryTgHB32lFnhCKKGJLbvZDPSklsGAm
         WbzR7eyeUOZI5gF+Bwe52zry41Wk3jsIJivvgSkIIP8C+t1zIibw25ZKAML+fUxtVY
         2/whBS0iGjWfNsAk6EAZgzjcHD5ysModK2p3Bf2FMZXf+/KpyK9cUnxmvtLskk/xgS
         QmtMcghRWznew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 10C4CC43159;
        Fri, 23 Dec 2022 19:23:03 +0000 (UTC)
Subject: Re: [GIT PULL] sound updates for 6.2-rc1 (#2)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87y1qy2yit.wl-tiwai@suse.de>
References: <87y1qy2yit.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87y1qy2yit.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc1-2
X-PR-Tracked-Commit-Id: 6bf5f9a8b408a6ce5aba6119f305b5b8f1238025
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a27405b2ed9c7717ac1ea5587d465234a592c3b3
Message-Id: <167182338306.13713.14356151456855590142.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Dec 2022 19:23:03 +0000
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

The pull request you sent on Fri, 23 Dec 2022 11:40:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc1-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a27405b2ed9c7717ac1ea5587d465234a592c3b3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
