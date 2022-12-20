Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600F9652352
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiLTPA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234149AbiLTPAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:00:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC701638B;
        Tue, 20 Dec 2022 07:00:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4990B614BB;
        Tue, 20 Dec 2022 15:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA3DEC433F1;
        Tue, 20 Dec 2022 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671548406;
        bh=04jEh+dz958edKH/foDaYlunScZB4dk3Lz6EiJF+QQU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=t4tnDCPiHh1G4lWm6fBZ+PsRIi/y2+ddf979bhQJrGHCBQ9dAf8QlWFYaFBG3DE70
         ff/NBisK4Hfwm+3SzQO2kmtWxllV5lUOTvqsm5fK4UymzDCBpMZp0+G/7Cy4tpODz6
         KTA3rNTZ3NJSRWsACejkf3caj1dgF8EyfaPA/COCkZbBa8WHkpwXnYNr6vCC4lH1fA
         8ULnjKZ7ogoAT/QH9WDWFr8Dj7exbIcQn/nr/lJSEDwRjUSR9LNcHpx5klvJSEERFX
         xbNIxQ7eLejoGkJY1E0NclNJAxCNF8l0XkF471vl8hhY69e5a9hLS2SSeNwSJ7HYoB
         vk32Xjw/hQHTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 903BBC43141;
        Tue, 20 Dec 2022 15:00:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPDX/LICENSES update for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y6F1oyqcjVYmQ0pu@kroah.com>
References: <Y6F1oyqcjVYmQ0pu@kroah.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y6F1oyqcjVYmQ0pu@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.2-rc1
X-PR-Tracked-Commit-Id: 6cad1ecd4e3213d892b70afa999a81849d1f0206
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 32d528c4b885108694f613406d9f39fa4873bd37
Message-Id: <167154840656.23150.11199029485116262633.pr-tracker-bot@kernel.org>
Date:   Tue, 20 Dec 2022 15:00:06 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-spdx@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 20 Dec 2022 09:43:15 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/spdx.git tags/spdx-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/32d528c4b885108694f613406d9f39fa4873bd37

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
