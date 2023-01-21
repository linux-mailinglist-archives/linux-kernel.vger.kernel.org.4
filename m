Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013CB6762B2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 02:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAUBZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 20:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjAUBZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 20:25:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D62871BE7;
        Fri, 20 Jan 2023 17:25:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C012BCE2A78;
        Sat, 21 Jan 2023 01:25:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA3BCC433EF;
        Sat, 21 Jan 2023 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674264328;
        bh=clcYPdsUdP6UY/KQ53aZmE9amzJVnjF5RBX7TlKS7OA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N5hORPfEYE++sRC2B9g78P5yqQWuIBFZnjJls5HM2W2QbVz+RqrNLEJQFfq4rcXMQ
         F6yOurHUQnf4d5cfh2/lqRQZYNqo9FNgQ8qwWsKCsgJFRkvTukoXpTsvPACRSHmvN8
         8YaI2dLFvSnG5Z8kysgbi7albswBEeAZHvM9C2FiICsulNd8Jl45zLnE7SP5BnVP/6
         usI1jekzU2II/IvSS7iSEeMc9RngjkVJTejzj8ggFAprzyL6eriZpUAqi9j9Nlrke5
         d5Uog+D0EoKgYj9aKk+rn8Rchwv6R6Srx/9cLYj7HmHwSLcf58pRqQNFSZZXc0uwZg
         DqMcjaT8v0eOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4713E54D2B;
        Sat, 21 Jan 2023 01:25:27 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230120223441.114683-1-brgl@bgdev.pl>
References: <20230120223441.114683-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230120223441.114683-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc5
X-PR-Tracked-Commit-Id: 4cb786180dfb5258ff3111181b5e4ecb1d4a297b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f883675bf6522b52cd75dc3de791680375961769
Message-Id: <167426432786.9448.15702424431145630776.pr-tracker-bot@kernel.org>
Date:   Sat, 21 Jan 2023 01:25:27 +0000
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

The pull request you sent on Fri, 20 Jan 2023 23:34:41 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f883675bf6522b52cd75dc3de791680375961769

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
