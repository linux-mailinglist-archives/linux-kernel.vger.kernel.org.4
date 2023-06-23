Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA7173C441
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 00:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFWWo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 18:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjFWWoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 18:44:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9176F2709;
        Fri, 23 Jun 2023 15:44:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FB4961032;
        Fri, 23 Jun 2023 22:44:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99283C433C8;
        Fri, 23 Jun 2023 22:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687560266;
        bh=Wr7zm1d3+1/PRzBWYwHCK8wDB9DoGN6UEtzTbqmDGOk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FjKd7hZ1J/IZF8ZeywuYkEnoXM+igT8YpDo5KtwEe/2+DUW97RQyoihabwHYRXtsR
         VRKnaei/v2+23EZjNhqv99HH2WvzF9jHqieTZcirqG3Jkm8+P5z9kiBF09d3bniwjd
         fCPl5+cn1djVlI/a8zOs7XohG0HDeqtb+uAbYH1oZ4QbYsatS/7hmXSaXzZ8hdE6Rw
         GrFuFqYugBWvzUup6gbGGOxQuxm7ZBjsFHcUyBueJ45iaoqj3zlKOA3v3kDoOJ+WXo
         Aus4wHDpnGdAmUlfCZRzzqHsyl8q/khovziCaD15DycXkBMYR0YZQsiNC36sT0H9Le
         lmEW9tUAMDFrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86236C395D9;
        Fri, 23 Jun 2023 22:44:26 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230623101012.114200-1-brgl@bgdev.pl>
References: <20230623101012.114200-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230623101012.114200-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4
X-PR-Tracked-Commit-Id: ff7a1790fbf92f1bdd0966d3f0da3ea808ede876
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6edecb9986eeffbf67e89aa510bc07835067cf60
Message-Id: <168756026653.32686.10070476089865994488.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 22:44:26 +0000
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

The pull request you sent on Fri, 23 Jun 2023 12:10:12 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6edecb9986eeffbf67e89aa510bc07835067cf60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
