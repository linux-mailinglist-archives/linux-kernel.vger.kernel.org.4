Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A563699D9A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 21:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjBPUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 15:23:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjBPUXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 15:23:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F44193CC;
        Thu, 16 Feb 2023 12:23:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4FB960B8B;
        Thu, 16 Feb 2023 20:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 26A17C433D2;
        Thu, 16 Feb 2023 20:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676579026;
        bh=CEDS1x2eLVVZX9XEHEIsVdW6j6BrAFpDPYSdG3rigYI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bfeF4LcJJsJnUoqSnFfo13UkIe+t2u0ujsDIztyWIiuFOxXuIfRAfifA2wjoIySKV
         1V1vDqfbpbX4JaVZB1q5dVWREt4LRi/6S0f/s+eccrBM9wyihwekS+1UZZEcDNj7/s
         ghD+yL4IKHi+9xK9SMOaAL5UhDyyie+vCClmyE6b6inUuHGpyPgRATUrjNwbxEIi1d
         zy8NfmygMckCGU8Ghc29gjsp+lrsEUKfxRPWTW6B9Tiw8jlSKtyivlM47GneMEEzqj
         zuK4/BJCY78SCSXyu6vwTeFjHc5iZaarVAHTCeAd8dEra4bfmMlOnVwxL0DSWSu8aA
         ilEGBH6qsGAgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 137B8E21ED0;
        Thu, 16 Feb 2023 20:23:46 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230216145536.121063-1-brgl@bgdev.pl>
References: <20230216145536.121063-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230216145536.121063-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2
X-PR-Tracked-Commit-Id: b8b3b0bfb742f0cbb006c66b10216b724ce42e25
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18902059e05bd22edaf70ab5819291d0618c93dc
Message-Id: <167657902606.10840.12806254757701504817.pr-tracker-bot@kernel.org>
Date:   Thu, 16 Feb 2023 20:23:46 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 15:55:36 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18902059e05bd22edaf70ab5819291d0618c93dc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
