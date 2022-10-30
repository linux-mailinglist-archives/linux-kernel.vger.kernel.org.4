Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 880EC612C47
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJ3SfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJ3Seu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A402E5FD6;
        Sun, 30 Oct 2022 11:34:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F234B80EBC;
        Sun, 30 Oct 2022 18:34:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F21B1C433B5;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154887;
        bh=DgoaecO5HnGaofV3HhDik10qk1qmUfVrA1nZg+ltT7c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Zj2ark+Cgj8qXdq09fK1c4ZoSEAJWl5Qq8+UHlbuE9E34j6+ai9V1chGfCvqgmNov
         vrMd1eMvhHdm5Pz9zGJGU8Z+YKX1f57QkphRCW5e5R9x3L9bqCkkRdO2ifE4RSeiyj
         EJEqSBiNMGvsjwYp1banf4jdTPBVZ5GL/i/ExXcLel34phbf7bLjj0JWYeKUQvL8a+
         gVczRooebSQ4JmlPczyEK+1Z0S2yNPmkA0y66sJAAeGTY4FvwofAcuT5f8q3jPr24P
         7xadQPl8wgZ+HRWqT8vBHpWyJQJXtqwZPLOQ8gxH/uSR7df9cyQi9Q1CtUqBIgsPv3
         C5/qJBPY7/16w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDCBAC41676;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221030080519.5467-1-brgl@bgdev.pl>
References: <20221030080519.5467-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221030080519.5467-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1-rc3
X-PR-Tracked-Commit-Id: 9ed88fcfb1b08c41bde0381dece84d152d53774c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef3c0949b9bbf54be7b04a6be5ba457cc15185f2
Message-Id: <166715488690.31922.4892901757803633923.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:46 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 09:05:19 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef3c0949b9bbf54be7b04a6be5ba457cc15185f2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
