Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636755F1023
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 18:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiI3QiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 12:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiI3QiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:38:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DF11739DB;
        Fri, 30 Sep 2022 09:38:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 397D3B82961;
        Fri, 30 Sep 2022 16:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E278DC433D6;
        Fri, 30 Sep 2022 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664555896;
        bh=6ZMEUrPQX6cckaFQAD7taUYv3Tr/6ElYEI8r9/Zk7IY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kOm2McKlpoMWzt+duVjii36iDLsBkdFaFNfzjCEvrY0TTCQYb8azvX7MI7hxobBkY
         Lr8K8XSsTlQ645/d+4Nd4BKk7xgQ83Jf+bXiJ/sTU3nxOwWikro03mlGymOaSh+Fjs
         4Bey1cnt53s9QKF6OlP5fApz9UXNGVC7CSgi8YkIksHx+13zuwQFRD2VufIjbvp+a8
         8aniwzlxMQSFxcJ28+bVSjp0mlZ3jZvBwjZ/IuofmMWqBJPn9tDCGCm7CzsDgx0wZG
         1Chplaq06az/bi0IZaCu0fHXrc+S5501xneIOlPnjBOQCuNMAB8ZADP0YgcmLUiX2o
         kwo1RvyqMuOpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CD1A4C04E59;
        Fri, 30 Sep 2022 16:38:16 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220930094040.39361-1-brgl@bgdev.pl>
References: <20220930094040.39361-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220930094040.39361-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0
X-PR-Tracked-Commit-Id: 4335417da2b8d6d9b2d4411b5f9e248e5bb2d380
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 89e10b860cbf8015dd77aaa90839fb0ef65e0619
Message-Id: <166455589683.13600.15697207210603432091.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 16:38:16 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 11:40:40 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/89e10b860cbf8015dd77aaa90839fb0ef65e0619

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
