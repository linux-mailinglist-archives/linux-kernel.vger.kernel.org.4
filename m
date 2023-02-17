Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC42D69B5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBQWrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBQWri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:47:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B63A2CFD1;
        Fri, 17 Feb 2023 14:47:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAD6062085;
        Fri, 17 Feb 2023 22:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D5F7C433EF;
        Fri, 17 Feb 2023 22:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676674057;
        bh=+694XX3j2FIFP5mwW9FUmzvrU2AW56ZKIMMz/bldlFs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ubwXq8074IctBrH7NtM1yOLvZFvhE5ddngPBkIz5JfspHCtmVWJGawBGttwvcqq1T
         hU8WEfODrRvJy7MHUGHAzlkGej7jRAYz/Vos+hC7MPiHcH7cl3uAc7lfTwHnDj+rPv
         nzBGgzb1huWip8BJm36pKSuovTrz+spWszbOcYw62RVk8lhPeRhPPIWyj7fedOTXnO
         J0uutdhMiiuqzWJuDwWxaw0ofKcarEZToB/JQFLW99gy14wFUldQs8FGIcBmDY+D9x
         trx5HPY/Y75d9OYlshTaxFug5R0dhPQq6N8f18rT7btIZgiivoniGXhcjuweZP7ZHF
         UTkKLHsapUY2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08E9BC1614B;
        Fri, 17 Feb 2023 22:47:37 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.2 - part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230217123642.115329-1-brgl@bgdev.pl>
References: <20230217123642.115329-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230217123642.115329-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2-part2
X-PR-Tracked-Commit-Id: 79eeab1d85e0fee4c0bc36f3b6ddf3920f39f74b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b89ca5a780f59f8762e22d2fbcfa64b95c8891d
Message-Id: <167667405702.13496.14475881316047702804.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Feb 2023 22:47:37 +0000
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

The pull request you sent on Fri, 17 Feb 2023 13:36:42 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.2-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b89ca5a780f59f8762e22d2fbcfa64b95c8891d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
