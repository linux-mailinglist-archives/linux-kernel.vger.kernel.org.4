Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CAC6DB589
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjDGU52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjDGU5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:57:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABA2A24C;
        Fri,  7 Apr 2023 13:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87E5A65487;
        Fri,  7 Apr 2023 20:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBC00C4339E;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901013;
        bh=+JqAifahXe7aXE0II9YKApovywYHoT3Yp0/zB3cmf+o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Sh1dj3XZxNDgQPv0MwfX5Twi4ZPuan6SKROetjlzrPVETUJ4vThngENU5rnqyur3j
         S0X/qVd42vSLO7IlvI5lMhu9Dm0Bxj1cRRfQQQQL/95nQp7g9kJ0CRlCj3qyHNnTGi
         s+VwmV5l2ozXhc/4qHC2XqtjcmZZqEQvAEx/g1tNSfw9UKRWRDgZwT69vHzM7GzvSX
         pajqwNS7+D8n1NKmKBCSdi9YKDpTO0bKq7nq93cR/MZBjAnlAIxiuS+hL1wLy5w0Nc
         Ws7fQx+75DbP/XR0AXG10HgDhWOJAMGU5+5FT48+hQ8FJbYOgDb0etewDyZT9MtQBz
         BrAwO+3PkTT4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D72E7C4167B;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
Subject: Re: [GIT PULL] gpio: fixes for v6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230407114530.75942-1-brgl@bgdev.pl>
References: <20230407114530.75942-1-brgl@bgdev.pl>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230407114530.75942-1-brgl@bgdev.pl>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3-rc6
X-PR-Tracked-Commit-Id: 7b75c4703609a3ebaf67271813521bc0281e1ec1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa318c48808c0aa73216bd94c54c4553d3663add
Message-Id: <168090101287.23908.9699179400700750265.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Apr 2023 20:56:52 +0000
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  7 Apr 2023 13:45:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa318c48808c0aa73216bd94c54c4553d3663add

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
