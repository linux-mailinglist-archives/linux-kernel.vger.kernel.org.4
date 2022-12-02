Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1A16411A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 00:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234851AbiLBXpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 18:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiLBXpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 18:45:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303DFA479
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 15:45:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1518FB82303
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 23:45:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8246C433C1;
        Fri,  2 Dec 2022 23:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670024738;
        bh=UAErkwDGe/jS1dv9QXF4vNE2WMUm6h+F/WR+dJAFzvM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LSIcRqGLm5YPV2BQXsnRUseNLHh0dzhhts90NazS6m9wvcMNqyZ3xEYMhuQzgNM7k
         sEvYEEQgQRMI+8xpA/bcR1B3wvS9c/EhS65Oh2BacglgwXCHbdzCR1KxEiSqRXdxAE
         THKtJlaMFzR3bnpjxYyR1Re1uKEemjAc1RrAYC39UXczqO1Lo8QajwaFp6cPZlqVVH
         2jwpR5LGXlunYEiboYiEIs+Ym70RKiF/ZSbjE3U2svok3tGAtlOY6NhYwBdIVM8NgA
         2rcg7boc1imHtyj2k/1FRketVYWvDu50e5pn9Um2gkPuHMX02Z7ZuO23wvL3fH92vO
         I5NRH5L7pfj6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6BA8C395EC;
        Fri,  2 Dec 2022 23:45:38 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87mt86kxa7.wl-tiwai@suse.de>
References: <87mt86kxa7.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87mt86kxa7.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc8
X-PR-Tracked-Commit-Id: b47068b4aa53a57552398e3f60d0ed1918700c2b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1e9185d20b56af04022d2e656802254f4ea47eb
Message-Id: <167002473874.10636.13334900101983934948.pr-tracker-bot@kernel.org>
Date:   Fri, 02 Dec 2022 23:45:38 +0000
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

The pull request you sent on Fri, 02 Dec 2022 09:46:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1e9185d20b56af04022d2e656802254f4ea47eb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
