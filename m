Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65D69ED19
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjBVCwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjBVCwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:52:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47667AAA;
        Tue, 21 Feb 2023 18:52:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F1761582;
        Wed, 22 Feb 2023 02:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F0A5C4339C;
        Wed, 22 Feb 2023 02:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677034206;
        bh=nK4SAWCVc7vxYAkTE50oDgdZG8lwOJ7kaFvRBHki0r0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Riey0Fu5QOP8DNg5xbMrPn6qANS0mKjE1hqzE4MJIe4UbkJ4BuF9sezAPJutzXq5s
         6za/BeG1ucc3Akcn6IXo4aSxbtm9GalQ+h1MSNowSAo9gBBorHaDfHS3c6ec+oi9Ke
         DTV1QoPnWbV9nItx1PmTP0/zfanwj/s97eSLUcz/HkiHB7va35qxKPo2HPv5EIRRpJ
         o9frG5G+EsvaDCrqq1/Q/UqGVTl+/G/+nF33v9OGp15E5rmAqi1wHYCpGm2tHLwFK0
         nNX/VVJ2Y9dvoNtgsAVjOKeUbO4bcjUA6R37KuWcNj82//mRmNoP0qNnm9QhyOxEfC
         xqwQOiJ5zwNiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F112DC43159;
        Wed, 22 Feb 2023 02:50:05 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
References: <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au> <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p1
X-PR-Tracked-Commit-Id: 8b84475318641c2b89320859332544cf187e1cbd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 36289a03bcd3aabdf66de75cb6d1b4ee15726438
Message-Id: <167703420598.17986.884909835086952555.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 02:50:05 +0000
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

The pull request you sent on Mon, 20 Feb 2023 13:22:32 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/36289a03bcd3aabdf66de75cb6d1b4ee15726438

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
