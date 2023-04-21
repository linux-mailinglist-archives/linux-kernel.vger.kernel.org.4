Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 138406EB040
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 19:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjDURJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbjDURIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928D43585;
        Fri, 21 Apr 2023 10:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6832A65260;
        Fri, 21 Apr 2023 17:08:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9F8DC4339C;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682096883;
        bh=UuQ/l31q1VJS2/Wq2uCslV+pGBszHHnSaHhkUvS9MPs=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q0k4EJGG4jqJslJ7ABA7O+nYXxxNjGt18CeRRx8VL1Cw2Y3LoSO6u3zwLbhtL+PBp
         Ti/i/QqTecXATehqEiV833mggOSfUdKTyLvDrJmFcQnczGy2awQ3iFqbJ5Ixf7/AWG
         9Mvnx48lUUa3x7W4OvT6epm+5PmzhbhMwaLQqsGTRHS4g2g5BgVwobvcIJbLNVJg3z
         0YRUviwbHnK2wjn+k8UDGfpJN6peUoN4/aXX94kbxY6SmejtOJyEUfuJpEhvM4Q/uc
         1SvV0TI20yaTH2o2ZOu74bdpCQglTJHcz46R4/vdMJ1hidgtSHBk/kaSdsiTfdlSsA
         Z+Bng6CfNLFeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0557E501E3;
        Fri, 21 Apr 2023 17:08:03 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421100713.39702-1-brgl@bgdev.pl>
References: <20230421100713.39702-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421100713.39702-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3
X-PR-Tracked-Commit-Id: 2ce987d7eeb168b749494694ae3666de87fc356e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bdc83e00f0a195b85e7879b65a4ca7a6520fe135
Message-Id: <168209688371.21086.13965699469933058203.pr-tracker-bot@kernel.org>
Date:   Fri, 21 Apr 2023 17:08:03 +0000
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

The pull request you sent on Fri, 21 Apr 2023 12:07:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bdc83e00f0a195b85e7879b65a4ca7a6520fe135

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
