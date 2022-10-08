Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA545F863E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 19:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbiJHRgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiJHRgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 13:36:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D26A3ECE8;
        Sat,  8 Oct 2022 10:35:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA7C560A09;
        Sat,  8 Oct 2022 17:35:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49ECEC433D7;
        Sat,  8 Oct 2022 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665250557;
        bh=DlYBVKpIV+ZwCfvmnP3tKtm9iUUPm9gFMj+24zqkijk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=LWoHyIF5P1j1idqVjvZjDZm4vLTF995Mab8qPrSsEu23pPA/b06QN4Sqmu3l/20sA
         1U/jtXESicvWtJctqs/ZiDTt/OVm3vLEX1+F4f/I05n+iA4lT+H3dfx3s6zCgssJuS
         TN9+GWslmrX6MXS7VmD6Ikiz8UlrrIYevgWEjBRWyii3BmujFdKul74ZGzLJaJf5Mi
         VvBJa+qoXtSRxB6ET39sdn6DsqVM0ioqRHutKpKojMIcp6Z48QGqdxi4XoA3pE6PI9
         l9WnBUPRB4LL8lYDi4IGf/jFJliqNP+7FMNqjpIauO/eVThZUhnukZ/IGP0bj3hL+1
         Zo2GIY5jTRRlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 39FC2E2A05C;
        Sat,  8 Oct 2022 17:35:57 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221007195906.350225-1-brgl@bgdev.pl>
References: <20221007195906.350225-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221007195906.350225-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-updates-for-v6.1-rc1
X-PR-Tracked-Commit-Id: 3c92506d86785967fd7e7933e04491b9276c2f00
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f01603979a4afaad7504a728918b678d572cda9e
Message-Id: <166525055723.22843.9581406575358742657.pr-tracker-bot@kernel.org>
Date:   Sat, 08 Oct 2022 17:35:57 +0000
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

The pull request you sent on Fri,  7 Oct 2022 21:59:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio-updates-for-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f01603979a4afaad7504a728918b678d572cda9e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
