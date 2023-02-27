Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4296A4973
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB0SSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjB0SSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:18:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EBFE05F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 10:18:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3C1960EFC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 18:18:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25DB2C433A4;
        Mon, 27 Feb 2023 18:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677521893;
        bh=X8Hu6VLQLXJaUYWe13zPsLaBRddm7j4qNbM+aK6p894=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GgATav+F/cZwPyflAzlrKlC8o07Y7BMUnm8n+Ev+BeLcOEX/9rr+qd1NSRdrD06QJ
         G6EZd39P7UHWX5yC3ffdyHcLq+2cVFpVPtrPokBNlrUuhGIcJOoS1mFkT7jQn3nqOd
         0vzZn1X8ic+15ecC0cea8cQSZC1D+oJ7qi8H1qwprrR4vkjfGaRYT6sDhjgo07Tv0e
         qXYOLuCas/XX1d871LK5GzHXS9Zi2tZqMFsPLGhr48zAyvz7J1Oej93u6t/5buGcGC
         /r/uBLbXrfS7PwPlly1ryiVcXbIMtTjl3Js5IHyKP6tUFmGVCiXbIkKB8EVL/znbKz
         dS6oRi6BUoN7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12056E68D2D;
        Mon, 27 Feb 2023 18:18:13 +0000 (UTC)
Subject: Re: [GIT PULL] memblock: small optimizations
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/xyFjdgpYP5rm3z@kernel.org>
References: <Y/xyFjdgpYP5rm3z@kernel.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <Y/xyFjdgpYP5rm3z@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.3-rc1
X-PR-Tracked-Commit-Id: 2fe03412e2e1be3d5ab37b8351a37c3aec506556
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a6d92493bb2e6e0a2fbb4a8b2c7ed97b4a5652b
Message-Id: <167752189306.27343.14227572278633810885.pr-tracker-bot@kernel.org>
Date:   Mon, 27 Feb 2023 18:18:13 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Peng Zhang <zhangpeng.00@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 27 Feb 2023 11:04:22 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a6d92493bb2e6e0a2fbb4a8b2c7ed97b4a5652b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
