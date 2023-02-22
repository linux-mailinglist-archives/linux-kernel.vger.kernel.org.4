Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C87269FC95
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjBVT5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjBVT44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260374EDC;
        Wed, 22 Feb 2023 11:56:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A40DC6159D;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 829D8C433EF;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095632;
        bh=A/wZKVpC5CwAfPQmXehj6KPs2edbpCjdlL0j6mkiFBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Qy/TM7mmeONfcctwh9D6kf+vW7ttyajrJNaZW5LNu+bWHuD/cDoiTui4K34m6wbCN
         y8z27BU7i/n/9ioIMM60ryhfWgnAPm2TAlfZRGH7VJ6y8qEkWZP8IzMaYdWTweaYsn
         y4I2EZiL3TjNUPS4yVRUaFgmvt+Y5aCiRJh3L7+vRb1S9vlYcbWUo7B8Eb2IMKKd+w
         bfucPVBt02LguXmYITgQqd6sbn6NmyKFrsb56+Y1km2KVqsTeGSybZIeuvTICcUl18
         AVwdXQnvSs+2sHRR7u6IKodJ5mSrNmab03mXSe2XyUc3nuJyT10cJYfLj0RURiqXNr
         dRj/3GmYw6oIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70AD3C43157;
        Wed, 22 Feb 2023 19:53:52 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: updates for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230222092958.18493-1-brgl@bgdev.pl>
References: <20230222092958.18493-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230222092958.18493-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.3
X-PR-Tracked-Commit-Id: 4827aae061337251bb91801b316157a78b845ec7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17bbc46fc9d5128756dc9f36063836eaede06b0b
Message-Id: <167709563245.30115.4856246962497339536.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:52 +0000
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

The pull request you sent on Wed, 22 Feb 2023 10:29:58 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-updates-for-v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17bbc46fc9d5128756dc9f36063836eaede06b0b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
