Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5ED72A050
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFIQkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjFIQkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:40:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A9035A9;
        Fri,  9 Jun 2023 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71A31659F7;
        Fri,  9 Jun 2023 16:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CF7DFC433A0;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328808;
        bh=2yHtu/RRODLKLC7OUFw31aAR2keEMZcwuX6xDdga1s0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mCTe35YoipZqps7kv89e5FwdIQEZtU5MemxZbaB0PX88ado/DmDKGi+tbIErxjWRv
         Zk7UC7YGpVCGs5LkSwTKugtyQ2mHKxcAeyga7jsfiWDgj8VIu0cDLP5Pg4YPQWJDlF
         QjZ6RElIG8ReTj9q93Xz6tB0v+qeYT2MapShxC91HNHEePk6pc8RFfJOUgOe7uRQrP
         EM068gd4VLAryF5YAte3wLNtmA1O1bFU+d+105pnQ8AyNGSRbRnl7gJFWqJPBC8Z/q
         CVeORKR62m5k+a7Xx9daixBomwtulShOouHkaZEDThGsanheD5px8Wv6UpN4eqJHco
         TwOm1LEBFrbWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE92DE1CF31;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230609144613.210272-1-brgl@bgdev.pl>
References: <20230609144613.210272-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230609144613.210272-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc6
X-PR-Tracked-Commit-Id: d1f11f41eb746a33816695f1b6b6719826cc532c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 92d22212c090b4afbb7d7e8f91d72988c7586aa6
Message-Id: <168632880870.22626.9756096475061656426.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:08 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  9 Jun 2023 16:46:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/92d22212c090b4afbb7d7e8f91d72988c7586aa6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
