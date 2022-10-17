Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6976015C5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJQRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiJQRvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:51:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7005FD1;
        Mon, 17 Oct 2022 10:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEBFE60F36;
        Mon, 17 Oct 2022 17:51:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1ACF3C433C1;
        Mon, 17 Oct 2022 17:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666029061;
        bh=Pe1Lyf2DnBt2VTfMpH5vvneN3eOJku2j1qqq5NSeedM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=C1510eQcUxmC+xrHbOgO/0lbiwic2GmSUnLv5yTuumi2Jrr6iDeAAbtbCwvI1Nkdh
         6hi+I3pI5at8SWdOA/P9KHewgOKrOOJdlI5vLsNmStvoVt7GuufRwJJ01b7bhQpuVw
         WFb/jJo2smJPpDvFEo2uqFwrZodSNWvErP89L6FQINzf7FjDxFtuRKMNLBX8ZtBWFs
         Nrua3RDz7Um5xnwgzuJkApVtlAoJ753ibqM0U+QSMSKCqKvBkgzfELo4JSae6ISEEm
         pFGWdIZoRKFjQu26xqNXNlYPVCCJIzw5u2Dj9rOScPV4T3lNFzb8bDWh7ZWC98Gg2H
         k52PXU+3kvoyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 053CDE270EC;
        Mon, 17 Oct 2022 17:51:01 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
References: <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au> <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p2
X-PR-Tracked-Commit-Id: 96cb9d0554457086664d3bd10630b11193d863f1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bbb8ceb5e2421184db9560e9d2cfaf858e1db616
Message-Id: <166602906101.15524.107899211870190151.pr-tracker-bot@kernel.org>
Date:   Mon, 17 Oct 2022 17:51:01 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 17 Oct 2022 12:38:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bbb8ceb5e2421184db9560e9d2cfaf858e1db616

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
