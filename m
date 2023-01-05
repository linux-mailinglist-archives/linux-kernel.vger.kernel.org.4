Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55E465F665
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjAEWHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235775AbjAEWHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:07:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C0467BE4;
        Thu,  5 Jan 2023 14:07:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3822461C0D;
        Thu,  5 Jan 2023 22:07:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A03E6C433F0;
        Thu,  5 Jan 2023 22:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672956428;
        bh=v+b0FqM51NlFAt5JJA5BbkHpmbQvOxsWyRg08M8UM/s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=N2eO4MJdRjtxoGbbh5fn1/xFGpiWVJh7JXdmi8Nts7WXh4PjFY76Km9AVSpqQxbT1
         GCLBkB+rElYuEUNlHV4pSW9PkpntVXq+AR/Jew+5yD41Te0O+ximxZmbt6Yq3Of3ws
         3w7hQByGSkuUTZceGkRvOWVvMNXSiuT0vA3syi21S2wR8GShKSd/eZ3edJnevsb1uD
         UH+EswcZDGixXZn4iCm5Wn4LoKUy+YNVRhl4/CsZW6mTUAAg6ZN82eWPd3nmK2ZwyR
         mF8YCO08PMXGCXxpPxdg8RjxL2YcUbM9ubAbHBrQjMs6nVbme4od3Cs+mFvRkJynFQ
         L9+TBbS/Jan+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FAEEE5724E;
        Thu,  5 Jan 2023 22:07:08 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230105194415.552286-1-brgl@bgdev.pl>
References: <20230105194415.552286-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230105194415.552286-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc3
X-PR-Tracked-Commit-Id: 694175cd8a1643cde3acb45c9294bca44a8e08e9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa01a183924fdf2ab05eb6e44c256aaf8a786d3c
Message-Id: <167295642858.2778.823779820967000587.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Jan 2023 22:07:08 +0000
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

The pull request you sent on Thu,  5 Jan 2023 20:44:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa01a183924fdf2ab05eb6e44c256aaf8a786d3c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
