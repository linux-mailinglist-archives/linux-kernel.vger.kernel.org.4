Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C17364E0D1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiLOSaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiLOS3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:29:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBD249B5E;
        Thu, 15 Dec 2022 10:28:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA419B81C29;
        Thu, 15 Dec 2022 18:28:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E91AC433D2;
        Thu, 15 Dec 2022 18:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671128928;
        bh=o6UZMQMOH5g+W9oA5KA/75KnLzt9XW76dKtkSzBtNwU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m/1EoY/6XlNFlULHDn5l1oewBIG7mqyPnxCeWi8wC+pDblpRlq10NwEHCI1QrmTra
         TSv8koPIVgF05/km/T1UvA/AcHcieQebVDx+4hj0cK7Pb4ReeCG3r6t3fpo4z0gNow
         AtKR4IV7rm4nk4Xw3jOTwRjk1HyL9YAgcRLWpc4gLLBrzNTMfu326Rnr/c4l0yPfmD
         kzNSVRbqogWhqwrATpo+K0NuAvpk5cYuygiXsCpr+8k1z9mSGKW2KivnlA2dgUZRXt
         zanDiNlQOUQeY2Rw5oqN3ZbUQhzT1uuCTDbYCMDPpWDpJo216Pa28LA0edbQGzsmMW
         iXYzai6VkfJ5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EB73E4D00F;
        Thu, 15 Dec 2022 18:28:48 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221215113050.34875-1-brgl@bgdev.pl>
References: <20221215113050.34875-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221215113050.34875-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.2
X-PR-Tracked-Commit-Id: 11e47bbd700f31bd1ee9f8863381bc9e741c0e97
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0f234ff90a211272138be1611ba53f3155ebd78
Message-Id: <167112892858.20649.17398306585589933013.pr-tracker-bot@kernel.org>
Date:   Thu, 15 Dec 2022 18:28:48 +0000
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

The pull request you sent on Thu, 15 Dec 2022 12:30:50 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0f234ff90a211272138be1611ba53f3155ebd78

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
