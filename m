Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7161E6F9AC9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjEGSMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231685AbjEGSMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28EB340C1;
        Sun,  7 May 2023 11:12:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B227761234;
        Sun,  7 May 2023 18:12:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E4BAC433D2;
        Sun,  7 May 2023 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683483125;
        bh=hV5wKgT1Grye95s2Xy/mi+6KaUCW4PA6/wlQyfFwJQA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U0d3Dll7eyj9jIy48UTUokVr9BqAq7JnEJ9K0AJkU/Ip4GziEnW8CaeIneEqd+UDp
         /7JDbymCN8Xjsz5/SGs/wetx+tG2L1g6mt7CPhqXkXsgDwkbDH7KzjCe6pgGijGx+V
         Wq/hY3aQXmXXF8o7zgor4xs3XAZwRqQ243jcVXuBMTko1hhfGGG3/AkWL37v1PrnQ4
         EH07RxUheV4iJOBQDpRNn7IR2h2RwegADze01OC9a0SFK27PBTU2i1TA3IFMT1Bzd+
         KKZc5XZ9G+U98Gk5xHAd4QVqVZLRZ3mETyzvA9h1tT6bi5bPmEpQAuitaSJW8HggSX
         RNv9fSw1Iw1DQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ADC0C395FD;
        Sun,  7 May 2023 18:12:05 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
References: <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au>
 <ZARrt99wJb7IhoY4@gondor.apana.org.au> <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFeldCJcieIlXKJ8@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p2
X-PR-Tracked-Commit-Id: b8969a1b69672b163d057e7745ebc915df689211
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6f69c981811c8b019d7882839e31c34ea8330860
Message-Id: <168348312503.16669.16856484399666238691.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 18:12:05 +0000
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

The pull request you sent on Sun, 7 May 2023 21:19:48 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.4-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6f69c981811c8b019d7882839e31c34ea8330860

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
