Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A43B6534F7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbiLURUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiLURTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:19:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F4264B7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 09:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5CE72CE1862
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB419C433EF;
        Wed, 21 Dec 2022 17:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671643114;
        bh=a3k/ay7R/8uj1/TlK+dl1JAY+ti+BB5o7W+nu3sAzLA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bCeYiyyz6F4+8DoIQeUsVeSpo1lwsuGP31juQgIrSO9r2bWBc6hi+OzbtAK6XdE6n
         hLP59HppVxXFBUb1umigaJEeL6D31eHTtLuxEegSOAU0fNma1vduCL9JqnK99zMlJV
         hU6ya2VVbY2+hOG5ihtBVpcsDmUhLgDnX/p+jFwdOIfdptETf8IWefiYu1AzIudg7d
         ll96mc79mdxkwuiSN43A+6H94uOGZjXLBT8yZqSBlLpwemUFXyGk49VEU/nstnwAEF
         t2ZqmXH6fIqJGoLLnbsGDWtAm1vNi2v4+nEPnF/xI/Snmeq5Hu7bF/iRLlkQ5HsPuy
         GlgJ664Hg9rtg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99DE8C43141;
        Wed, 21 Dec 2022 17:18:34 +0000 (UTC)
Subject: Re: [GIT PULL] random number generator fixes for 6.2-rc1, part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221220022458.11682-1-Jason@zx2c4.com>
References: <20221220022458.11682-1-Jason@zx2c4.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221220022458.11682-1-Jason@zx2c4.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus
X-PR-Tracked-Commit-Id: 3c202d14a9d73fb63c3dccb18feac5618c21e1c4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 222882c2ab1221b6df2d189138638a6435cd8e88
Message-Id: <167164311462.3046.5847869816362356774.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Dec 2022 17:18:34 +0000
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 03:24:58 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git tags/random-6.2-rc1-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/222882c2ab1221b6df2d189138638a6435cd8e88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
