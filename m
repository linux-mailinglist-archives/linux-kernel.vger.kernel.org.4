Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55EC46118B3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJ1REV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJ1RD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:03:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A927694A;
        Fri, 28 Oct 2022 10:02:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4A30B82BC9;
        Fri, 28 Oct 2022 17:02:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E05C4347C;
        Fri, 28 Oct 2022 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976545;
        bh=E55JAz0X5sihZqw+uWt3qJNVTkaweKmZYpRSZ+MOVhw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mUl20Z1wIdIQtafrsC9TKewLrx1EeaQKqdcBSX2cx49Skepm+mt+KBQpGsE7rK59N
         j+pRmvEysJtbubJGdTpkaS0Ko6JpzLYzH4Nel0EMFJO49dOO825kgzYHots+70Qnf3
         WL7tmPmkau8PuFhOR2OjnrOpJ8QMEVlWIES4vO1k97JfOfNF50cFNlClJrPaqRDyoF
         PNxsv7ng2P1pZM9sMJIH8nlKD3A87M/14Sn76bKJgz9Nypfg8oSlHfO3dAjinBzP6r
         oXDEM/TgiU5mK2Re5q3haZNaqIENN8/ADttCKY9OaNmukqOMbflhu4ZYvebt8pkrLF
         hnYzZtUzyZdEw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 721CBC41671;
        Fri, 28 Oct 2022 17:02:25 +0000 (UTC)
Subject: Re: [GIT PULL] Crypto Fixes for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
References: <20211029041408.GA3192@gondor.apana.org.au>
 <20211112104815.GA14105@gondor.apana.org.au>
 <YcKz4wHYTe3qlW7L@gondor.apana.org.au>
 <YgMn+1qQPQId50hO@gondor.apana.org.au>
 <YjE5yThYIzih2kM6@gondor.apana.org.au>
 <YkUdKiJflWqxBmx5@gondor.apana.org.au>
 <YpC1/rWeVgMoA5X1@gondor.apana.org.au>
 <Yqw7bf7ln6vtU/VH@gondor.apana.org.au>
 <Yr1XPJsAH2l1cx3A@gondor.apana.org.au>
 <Y0zcWCmNmdXnX8RP@gondor.apana.org.au> <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
X-PR-Tracked-List-Id: <linux-crypto.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y1thZ/+Gh/ONyf7x@gondor.apana.org.au>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p3
X-PR-Tracked-Commit-Id: 9f6035af06b526e678808d492fc0830aef6cfbd8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 05c31d25cc9678cc173cf12e259d638e8a641f66
Message-Id: <166697654545.8271.855921267569729941.pr-tracker-bot@kernel.org>
Date:   Fri, 28 Oct 2022 17:02:25 +0000
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 28 Oct 2022 12:58:15 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git tags/v6.1-p3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/05c31d25cc9678cc173cf12e259d638e8a641f66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
