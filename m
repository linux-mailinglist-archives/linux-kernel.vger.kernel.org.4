Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0C6315BA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiKTSw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 13:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiKTSw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 13:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D3916588
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 10:52:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C930D60C91
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 394B2C433C1;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668970374;
        bh=WMkm9gjECuPYdxgN4OEAMDUtD4vZPocbPDjjHgdyQ8A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gXdYX5CwKKBbo6HwnieXpBy6in4X0YHY5hn9ILuhKQfNnF834K3wWXiT8kpL4Jjdw
         wDq1mUM53v2/Vm1v9H8jQHQCjIY+Wq4nISUpf1EDCLtgGos8tK4cNio1617jb8ClOC
         JxqiRY5IA6pUXQa0nrTlC/erl2u+KXxKae5dsV6BASgwmHvq+qdG6r0RTAU633f8C7
         AN9UvbObBkVF+EUfPTNRDfxpALPc0SswKS6b1OIyVyzoYyQ9e0ZaHYVcVZcO/BN3fV
         51e36HmzFpgZVW2QonYamSQiBicKrZT/1Yw6FUY2hqX+4AiDWLpyrqUnZtoB8+qJQZ
         ARjNyj2rSXZiQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23D3EC395F0;
        Sun, 20 Nov 2022 18:52:54 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for 6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3oKGZRs9Evwwz5j@zn.tnic>
References: <Y3oKGZRs9Evwwz5j@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3oKGZRs9Evwwz5j@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.1_rc6
X-PR-Tracked-Commit-Id: 23df39fc6a36183af5e6e4f47523f1ad2cdc1d30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a211a753d1c836856cf942afbf3b6bfdcf0a5f4
Message-Id: <166897037414.26274.16710229785356479900.pr-tracker-bot@kernel.org>
Date:   Sun, 20 Nov 2022 18:52:54 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 20 Nov 2022 12:06:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.1_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a211a753d1c836856cf942afbf3b6bfdcf0a5f4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
