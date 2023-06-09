Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EEC72A052
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjFIQka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFIQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9309D30DB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25FE2659F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 16:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F554C433EF;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328808;
        bh=3+2gFyqFAiNEMKDFYmHNhsxNyNi3iZZ6XNlU46/Iswc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=e9FIvbyudf0M2FHv8UEmCGSog9dJRM8HB+TtV5iW/UWydSh0392Zh9AWRxzUiM99Q
         zuIi+VmnB2rs5o28B9qlQBEo7dyNgn73p5Geyr3ZMHMaXbgjSahlzFY3gwY5gXf3B1
         l+gDsfcZRo8A72/W306ByXvCwMrcJ40e3H1uMmqqKE/KgHZcqVPeOjY5oXR87U5nYD
         q1OZ642E8736JmWRxz51zod9ur8Vw/fR1xt0ls8HRekG9igUJOuT1sIsUDiDMLXyLh
         VCO2km5FClmkNnQxHj2GKPiSOOkKk02sE/slWcEIJHB9zk6VDRumPUR01YZqJqSYj5
         WqOKeRZ+6fiJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C2FDC395F3;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87bkhpcdt2.wl-tiwai@suse.de>
References: <87bkhpcdt2.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87bkhpcdt2.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc6
X-PR-Tracked-Commit-Id: b752a385b584d385683c65cb76a1298f1379a88c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 697fa9b586ef3032b5e09b33cbfba9035d1466f1
Message-Id: <168632880843.22626.7394232778405766209.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:08 +0000
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

The pull request you sent on Fri, 09 Jun 2023 09:09:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/697fa9b586ef3032b5e09b33cbfba9035d1466f1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
