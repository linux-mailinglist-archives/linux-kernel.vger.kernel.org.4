Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A9074DC31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjGJRUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjGJRUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:20:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2763E12B;
        Mon, 10 Jul 2023 10:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA67261159;
        Mon, 10 Jul 2023 17:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 29A3AC433CC;
        Mon, 10 Jul 2023 17:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689009637;
        bh=zReLWvx1QKJN2i56dAtjCpxC3FuoBmPsfE49KgXKMuk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=oTX7QKI6Aiz//gQovPRVoOK7+tCZJJImGPsRCu3LIklh2AZ9FFo/5HJSSBlyHzD0Z
         FaoEkUNMZ5jnyWoPYBrqd0CRWOOpirltUViyuh2O0w15u/lndX4FbP93E0TReZpBo4
         jOautr4VPUcsRQOgDT3Wqod4Q0b+p/XRRC5/M0IcviYbMGC0XlGvej3seYxLC50LiG
         AyYntCvHISncg1Az5g3KgIxlCuGBTBFGxt4svz1SQPx2h0UM3nNzCyzjmh5kLpR75m
         JWIYSPwTCY1cByb+QzkfvbgJDpfWQzolyjX+SIFUUf6+LCswhzxUD5VFH8i9PnTm4H
         fUb8cXw78sQJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13A33C0C40E;
        Mon, 10 Jul 2023 17:20:37 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
References: <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au>
 <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
 <ZHQe9A8CC93iCFMG@gondor.apana.org.au> <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZKtH5zrS4pR22PGT@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 v6.5-p2
X-PR-Tracked-Commit-Id: 0b7ec177b589842c0abf9e91459c83ba28d32452
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 419caed6cc77f19148faefe13515f8685ede219b
Message-Id: <168900963707.24521.5138657771951384766.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Jul 2023 17:20:37 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 10 Jul 2023 09:51:03 +1000:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6 v6.5-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/419caed6cc77f19148faefe13515f8685ede219b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
