Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D185BB329
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 22:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiIPUBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 16:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbiIPUBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 16:01:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FD88DE9;
        Fri, 16 Sep 2022 13:01:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9F829B82930;
        Fri, 16 Sep 2022 20:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B7BC433D6;
        Fri, 16 Sep 2022 20:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663358491;
        bh=P/HCtlTVZB36SWfyy8EacvCkHE7w5qNdyZxC2uYVRF4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cJvhjx7VH9ECU4J6vh5aGvsUQaxEaKf++nlYV2K9+QrmT1vOgUv6Zw2QyRWEp1rF/
         IVEhk9IrUni6Xi5b0QMDq9fessZLGCwEkR5inEuRJCt4P3+2D6iUmfzX4+6ZDL8eoM
         TgAke+oYXqkFhNQCRncan0RGu24xh1P3Ct/RASZMOxh/UhqN4VTybqtB7MEEspA4go
         18c1R1NLHxxGk+AJf/wLh5/LPTEI98Z3un8f7bG/jxEEcKx3QlrV5BlgmtB+RWUTpG
         ULu/fzxXEWt18poPI/J/Nx8Dp0+p8Xg4P6BZD2NWBnxrSLQ4JH0y3bRRMuckV678Yu
         iU4PVhWnUmnsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E819C73FE5;
        Fri, 16 Sep 2022 20:01:31 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220916074253.781428-1-brgl@bgdev.pl>
References: <20220916074253.781428-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220916074253.781428-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.0-rc6
X-PR-Tracked-Commit-Id: 09eed5a1ed3c752892663976837eb4244c2f1984
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a335366bad1364a07f49df9da1fdfa6d411a5f39
Message-Id: <166335849131.16959.1279781602719375595.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Sep 2022 20:01:31 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Sep 2022 09:42:53 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-fixes-for-v6.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a335366bad1364a07f49df9da1fdfa6d411a5f39

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
