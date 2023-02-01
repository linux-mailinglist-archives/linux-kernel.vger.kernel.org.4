Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7567F0B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 22:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjA0V6g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 16:58:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjA0V6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 16:58:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FEE22030;
        Fri, 27 Jan 2023 13:58:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0119C61DAD;
        Fri, 27 Jan 2023 21:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6562BC433EF;
        Fri, 27 Jan 2023 21:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674856712;
        bh=wCtt8xMlYLqli9/cG/yUmwX2zDvTREfXCwdLYcm8404=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Hlsi5iPNYoZO7/vtqZaRq5aQnrgTvSsSpPBuSCr0yUw2YcSIvhhuZWQJ+28OE5hGO
         K1O09wwBCmnOZYd9CtPctVqAj8ZAJPNN8LVQwfC42Q3jr4lJYxOgpagu8ZcuccUgGr
         7H+nSuDgHFQIV7ShcPw2rnBY/CGgCNJZlpT3E1ni8ZoqimwDj4LDU/dks1J49tk/dV
         rdBMbB+RpPhMVceTh4NhM+SXa7osXFCr9FDx0ms0MKVmpFUk97XNoQrcAbkAH+504A
         AtHKKYX5tt3o4jwX61+LbUTvqti7nKVjEejtD2o4XPmTsF2WejOFnTDKyamYUv9SpE
         QRQgvde+KEQRQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51AC4C39564;
        Fri, 27 Jan 2023 21:58:32 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.2-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230127194707.311571-1-brgl@bgdev.pl>
References: <20230127194707.311571-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230127194707.311571-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc6
X-PR-Tracked-Commit-Id: 677d85e1a1ee69fa05ccea83847309484be3781c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 37d0be6a7d7d6fede952c439f8d8b9d1df5c756f
Message-Id: <167485671232.1722.1287802220609620377.pr-tracker-bot@kernel.org>
Date:   Fri, 27 Jan 2023 21:58:32 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 27 Jan 2023 20:47:07 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/37d0be6a7d7d6fede952c439f8d8b9d1df5c756f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
