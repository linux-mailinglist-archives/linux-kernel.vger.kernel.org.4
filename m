Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B2B7446B5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 07:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjGAFF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 01:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjGAFFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 01:05:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237204204;
        Fri, 30 Jun 2023 22:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A514960B8C;
        Sat,  1 Jul 2023 05:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1745AC433C9;
        Sat,  1 Jul 2023 05:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688187899;
        bh=r3E4bu0q39/YHv32/QL3M2UIC7f/9/i18mQccXMm638=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aVK+SX6X/PL5k0COEhG9Ob7F57ekj6J5/j2y8b2fJM1aSl9ZozG2d8LlBkh04xSRG
         7/ta76uSujkUlrGW6pNFf2rbrWtiO9zfSt2iHRdJ17dJtsvngt423H9/ZNXG2Wnvk6
         /ogDT9QS+3BdPXaXBGT3DJWzLfqfPCJEW3ZaLWufTR5J2WJQXrXcCH1HxVDfSYJwID
         z1A9jgzNwQ9tXj4ysTbNXo/4a1qlYrmYbZwANsdhbMhUh0bG2jsaDg+GiDqXVn5g6n
         KVQbqD5fDnyxeU4un+uQ60XcYWYSD05SOL2lmi0TxFn6amM1lnRYEnkWRyNSGcegji
         xOspFmE7rraYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06199C0C40E;
        Sat,  1 Jul 2023 05:04:59 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Update for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
References: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au>
 <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au>
 <ZEYLC6QsKnqlEQzW@gondor.apana.org.au> <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJ0RSuWLwzikFr9r@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.5-p1
X-PR-Tracked-Commit-Id: 486bfb05913ac9969a3a71a4dc48f17f31cb162d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5d95ff84e62be914b4a4dabfa814e4096b05b1b0
Message-Id: <168818789902.30776.2952225788951073208.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 05:04:59 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 29 Jun 2023 13:06:18 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.5-p1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5d95ff84e62be914b4a4dabfa814e4096b05b1b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
