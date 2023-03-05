Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E6F6AB1E5
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjCEThW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjCEThU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:37:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF79FF25;
        Sun,  5 Mar 2023 11:37:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DECBB60B54;
        Sun,  5 Mar 2023 19:37:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4CBA4C433EF;
        Sun,  5 Mar 2023 19:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678045038;
        bh=R11WY1CFSMMzf+fziJywudIzTwyCMsUuneDOj5AF0jY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=J3tYoZMD8DPwh4uIzrEjenGbrQZ68/B7bvNFPGpWQc5HxnckMkHU/9lQOXlZck+/+
         2WGtBj6fbIbrAfzxrPXmQ8d3bd2c992HtwoQzTnDK3uQr05PSYqS0s9+SQrIv7NBkp
         TaIuJ5CL/qxgCg8Gw+UnG0RKWYmGmZLje0iHyfI+eoHrN/oGCzF56om8mKF2Z/6ryG
         gaDsy6I+1LZIE7dMWRE3v1/KMPBFOO8UrQDS6pyOmxYC2HHDu//hrecK6cAqlwFbhL
         2MFvsj0EouwM6NijKU6kfH+sKFODBIlO1Yie5zTYJHrKz5kwa5ukwOuVNVhZH9K4Fq
         l3F5t7WgW36gA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B81EE68D22;
        Sun,  5 Mar 2023 19:37:18 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZARrt99wJb7IhoY4@gondor.apana.org.au>
References: <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au>
 <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
 <Y7fmtJHWT1Zx+A1j@gondor.apana.org.au> <ZARrt99wJb7IhoY4@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZARrt99wJb7IhoY4@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p2
X-PR-Tracked-Commit-Id: 660ca9470f9c613fa2c71a123a9469c80a697ee4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f915322fe014c5c515119381e886faf07b3c9d31
Message-Id: <167804503823.1860.745945862604336880.pr-tracker-bot@kernel.org>
Date:   Sun, 05 Mar 2023 19:37:18 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 5 Mar 2023 18:15:19 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git v6.3-p2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f915322fe014c5c515119381e886faf07b3c9d31

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
