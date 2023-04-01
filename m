Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF206D32B9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 19:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjDARG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 13:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDARG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 13:06:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372A21A94A;
        Sat,  1 Apr 2023 10:06:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C489F60C42;
        Sat,  1 Apr 2023 17:06:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91824C4339B;
        Sat,  1 Apr 2023 17:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680368815;
        bh=53/87XneiLa2ZTJ2XQcMaw1zEOe3J/B2LfWbaC8+er4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pTFdj/Wln5k6SPt6xm0qXNlDjMMhPwWk+4yox2dds1u7KgsA4XDmQMqlft8/SxkFK
         d/qWaXQyYcqxwPXk0hPkVKHW/FP1ivw/Z3hkfmx+1tzZWwzYhpU1IJqmkL01Ed+0KZ
         Zf+1NhzGlylOjKCWcDi2f4p0a64B1+niC4yYj/hL7MTxY2A+F3q4dlEXL6Q+mLem81
         9Wv9m7bdEUkflgAl8Qbjz+fSDVlOXMmWAqgnhIgBimdpcu7TBVegwHx6NJFvzzmKqv
         aIiJj53u0MrmbuB1+546mWb8VS1q9tTwk26hh/1g9k/QOdMKumMbkKO3zpWEIEhLKT
         U18NdoIB4VqhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7E025C43157;
        Sat,  1 Apr 2023 17:06:55 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZqoUZuLr9ra9JbSEQqqOWZvdh33Lk+R2P7qw8upx3nnA@mail.gmail.com>
References: <CACRpkdZqoUZuLr9ra9JbSEQqqOWZvdh33Lk+R2P7qw8upx3nnA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZqoUZuLr9ra9JbSEQqqOWZvdh33Lk+R2P7qw8upx3nnA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-2
X-PR-Tracked-Commit-Id: e4056e38ec87b4c21eb34bb8e38b1b0ca1221744
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93e2b01740863cf2f4a58887ac1384e6324b50a2
Message-Id: <168036881550.2643.15900096815337872183.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Apr 2023 17:06:55 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Apr 2023 18:28:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93e2b01740863cf2f4a58887ac1384e6324b50a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
