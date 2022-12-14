Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F4D64D258
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLNWZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 17:25:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLNWZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 17:25:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB691248FB;
        Wed, 14 Dec 2022 14:25:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65DCBB81A1A;
        Wed, 14 Dec 2022 22:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1FF06C433EF;
        Wed, 14 Dec 2022 22:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671056712;
        bh=2kg920/gBGTt/bw9KziIxPJX8dOcX6PLVZjDKCaNy0k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GV7oo3tqu4nzIHDarnj08XLvEQ5ax3htAYK82aAqfNi8cnskYcp8spn6bfVbkaZCU
         NAJWO+MicQgnPcBWaKDEzhebNlQlGmCW1x9Hd8k1j9YcGH0S5LWNOxV60h3ewiYvr7
         oZA4EErfg6U8xFk4W7iLwvz3J8KCPKcdpbs3nmbB8ziN/KASMp42H9HNmrWcz1OIQP
         y5GLvMJEoDZoqzfYdQQiX55vt1Ixly6rTQ32BA2iezlzXpY8Ev1nBEStV/bsBXoey6
         1qQK5urNcLw++JOkcLSqq7ykrtEOAaECH1O8+saeAZb6xp5qDQZcYE6vTRhzdV1+Ft
         9gXc3MbG09Dlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D1F1C41612;
        Wed, 14 Dec 2022 22:25:12 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
References: <20210929023843.GA28594@gondor.apana.org.au>
 <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au> <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.2-p1
X-PR-Tracked-Commit-Id: 453de3eb08c4b7e31b3019a4b0cc3ebce51a6219
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 64e7003c6b85626a533a67c1ba938b75a3db24e6
Message-Id: <167105671204.22509.7163108624117806005.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 22:25:12 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 16:15:22 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.2-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/64e7003c6b85626a533a67c1ba938b75a3db24e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
