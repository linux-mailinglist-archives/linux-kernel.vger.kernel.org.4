Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8968ACCA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 23:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjBDWDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 17:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjBDWDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 17:03:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AE93C18;
        Sat,  4 Feb 2023 14:03:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 878FD606A0;
        Sat,  4 Feb 2023 22:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0BE5C433D2;
        Sat,  4 Feb 2023 22:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675548184;
        bh=/p2PO6uFg8zCUmU2qJ39SvSj/BHlP8kaF5lp8n81mKA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ogltbFRZtE5C5Ekjp6n1tncdRhOvgEMFzMZ03IJCJn9i+UiFeOpK/24sWYhnKginn
         3JTqAnKTZ9qJyLOiqc7jX+WHSMLl0lzQL9XPN7ZFcDv235Mj/mhaA0scE0kiGtrj9E
         foX7rGHJ2Jx/0FfH0iG0achxNgxcaTuhPN9apfolymU7iO1ceT4jKpn98nrFlqYDo2
         X4q8uYXaD054a5yFvXT/XUztI4Zw74A5qDuDX0cdZMC9Y/TiY7mNBdJ2cc7PTckIW3
         B4Vq1ZAkW1n+BKNVH3TOKUsx/nvfrAk740jYpkxb54JMW5kD+9iVQgzUr4wiHjR5ss
         Az428Thhjg5OA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DFAFAC0C40E;
        Sat,  4 Feb 2023 22:03:03 +0000 (UTC)
Subject: Re: [GIT PULL] RTC fixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y97QU2E8/VO/ZIjt@mail.local>
References: <Y97QU2E8/VO/ZIjt@mail.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y97QU2E8/VO/ZIjt@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2-fixes
X-PR-Tracked-Commit-Id: 08279468a294d8c996a657ecc9e51bd5c084c75d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95078069c1e70d1b3b141132d18d0c563acedd0c
Message-Id: <167554818390.25542.1995531657307970499.pr-tracker-bot@kernel.org>
Date:   Sat, 04 Feb 2023 22:03:03 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 4 Feb 2023 22:38:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95078069c1e70d1b3b141132d18d0c563acedd0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
