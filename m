Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4016924DC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbjBJRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbjBJRw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:52:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE37F73967
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 09:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6699C61E61
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 17:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0E04C433EF;
        Fri, 10 Feb 2023 17:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676051575;
        bh=jXyBXDz+XfHe3r6qD/rX2h/9NwaGgrJ+Fxqd8NagV9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cxBt9Kd1jn5DN6WQpkBibYKYqVDo++22cOd1HwpU/urZw+hgCFOQMpSuF62EyzXiT
         0ShNApWfb6ugQ+9E34b8jL5bVDTwNrpZYNjaOCEOxWSwAoECnY7NhDOtdIm/FqWf4b
         Amv6yku0z6Q15C9ZTU4oGLfb+TRVQ4t/7rCsZu/j0B5IPtLvwSBIeP5ZN/YbSIVebY
         ePf2Nvzhzx8wD+kLBG5bqTxO3jrB2pmcYE/xAO0L4YZY22YMJd0RxNCrpzbmxxLcVY
         ixL2Ba9zLUOqGcpLelIl841wShiB509UPsiHi5QSKD6bvio/lj3Dgcz+Q2CtQjd0oa
         gltKQMoklTTTw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ADF92E55EFD;
        Fri, 10 Feb 2023 17:52:55 +0000 (UTC)
Subject: Re: Re: [GIT PULL] sound fixes for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sffdj33b.wl-tiwai@suse.de>
References: <87sffdj33b.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sffdj33b.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc8
X-PR-Tracked-Commit-Id: 88d18b8896bd98e636b632f805b7e84e61458255
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4fe37223975ce04c4a4ad0a136cd4e64b39bc3ca
Message-Id: <167605157570.13061.12933849465988651320.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 17:52:55 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>,
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

The pull request you sent on Fri, 10 Feb 2023 10:12:56 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-6.2-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4fe37223975ce04c4a4ad0a136cd4e64b39bc3ca

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
