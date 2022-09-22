Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEAD5E6A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiIVSP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiIVSPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:15:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8401F43627;
        Thu, 22 Sep 2022 11:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38540B839C7;
        Thu, 22 Sep 2022 18:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00452C433C1;
        Thu, 22 Sep 2022 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663870501;
        bh=GI/QxPt+QyjHICWT2YeAeZh/4G8AdCEzeszTisas9hk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qx4oBrqod4c+pKBZL9oNufTPmKwB5RNZeLe5k61ChRnuFj4u2id4S1UoMvYn3vflX
         TEF7a0YO+KtKcuFb/+0sH/RvegsjttedDXIP6zQHB9OML7Fm1Nt4FXAnov3kFDLyN3
         6kfy+cHyLZceK7zzcJRH3s9qJwLyV+ZHQwu1uQ1QbyduZzVqJl8ZfgYuzh8SlycW1s
         tNNxTgl1WrWFRppPh02rAfBiAK4zVwyWiZxBQgidLJnOx7u7naFeTHNNcOfyeds6O0
         Pxs1zU9aRrQHeYFsD/3MTABvl9SomseIdZ73MEF1Vl7AlDuEL1+iPrl9m8BI9x+OpB
         GrVjr+fsYVOng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0F05E21ED1;
        Thu, 22 Sep 2022 18:15:00 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220922101614.118590-1-brgl@bgdev.pl>
References: <20220922101614.118590-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220922101614.118590-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0-rc7
X-PR-Tracked-Commit-Id: 69bef19d6b9700e96285f4b4e28691cda3dcd0d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e0a93e42756fa93b69fe8848cf8dda7cee5d13a
Message-Id: <166387050091.24554.4518458579542642534.pr-tracker-bot@kernel.org>
Date:   Thu, 22 Sep 2022 18:15:00 +0000
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

The pull request you sent on Thu, 22 Sep 2022 12:16:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e0a93e42756fa93b69fe8848cf8dda7cee5d13a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
