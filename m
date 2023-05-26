Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BF4712E34
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjEZUim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjEZUik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:38:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A467134;
        Fri, 26 May 2023 13:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB94A6533F;
        Fri, 26 May 2023 20:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E139C433D2;
        Fri, 26 May 2023 20:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685133518;
        bh=iNGDMrMfg+sC3+4ezC/mmKJRwZSc7S4H3xQ6FzEQiKo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=s2eiR4VUWqVJIgrYxjOqxnkUPvyOmi+np/YknAcWz599IBlrknNkb4TEnfje4bion
         7TYvsJbX+9tcLWS/k7PtMRyWmekzl6+qUGB4SFgUX/ckjUbrXE1+UNGmac4avDYs9d
         ML2skPOhD19vaxY27dEhU9RQq5Yrt+h3WC6S17C4nDZZdLqsYKK+SnfjV2Kyl7T/fY
         VQ9opTecARIlav7fmDF8N7gzvJbfe6aPxSJ6tD+FjJY6OOLSDUdLupe0OAxZgIEsoY
         +DoYhaFSCfXzRunpXwcy5qnRrkYZLPKEBuKJAW0e/alcNqHrOiVaHSj2Lr7erroDpE
         6opc1MZvK5JwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29A66E22B06;
        Fri, 26 May 2023 20:38:38 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.4-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230526142407.67019-1-brgl@bgdev.pl>
References: <20230526142407.67019-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-gpio.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230526142407.67019-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc4
X-PR-Tracked-Commit-Id: 3002b8642f016d7fe3ff56240dacea1075f6b877
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91a304340a2272b1941c9ac81d57c68f97e6260d
Message-Id: <168513351816.25583.11417742938287876898.pr-tracker-bot@kernel.org>
Date:   Fri, 26 May 2023 20:38:38 +0000
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

The pull request you sent on Fri, 26 May 2023 16:24:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.4-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91a304340a2272b1941c9ac81d57c68f97e6260d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
