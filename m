Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFCD650E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 16:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbiLSPHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 10:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiLSPGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 10:06:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549022AF;
        Mon, 19 Dec 2022 07:06:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2B9FB80DF2;
        Mon, 19 Dec 2022 15:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F6DC433EF;
        Mon, 19 Dec 2022 15:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671462377;
        bh=sXf+i47N9pwwz9/soKTMFiJYgljCvWses/1lxIFwcFQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cSzqAZWKcTpi42vipK7c4KIcyZ8eE/MN9z7+kK3ds3BV6Us7FesRXrDWoKY4icEmj
         KFabtfESLdG6N2sctInieg6prGMnL9xCafrMqr0ATLhGyWR45BUhjv8luenZR8va3o
         h+UNmx7ifBcP8ioSxNdx5c8TDMU4OlmSZVFkrQD5DEK14J8jqY290npiyCK6x+KsaN
         NbGBTQZmJiJS0h855rCzsoMJXMobwcBI043XP6p3pJFfEXvypWyZ+QAmsJkUWT00SW
         gE+6ihBDynRmbQr6HaSbKgftx3I16/ZHmxEwgcNa5BaW9ZLKzu+jty0En48MDNJYPw
         Wr3cu0XSDqDFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9302CC00445;
        Mon, 19 Dec 2022 15:06:17 +0000 (UTC)
Subject: Re: [GIT PULL] RTC for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y55nnQv5htuJnuw2@mail.local>
References: <Y55nnQv5htuJnuw2@mail.local>
X-PR-Tracked-List-Id: <linux-rtc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y55nnQv5htuJnuw2@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2
X-PR-Tracked-Commit-Id: e88f319a2546fd7772c726bf3a82a23b0859ddeb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: acd04af6e4765bdc322adab3bf72e249b8b65457
Message-Id: <167146237759.24644.6292495845831300896.pr-tracker-bot@kernel.org>
Date:   Mon, 19 Dec 2022 15:06:17 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 18 Dec 2022 02:06:37 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/acd04af6e4765bdc322adab3bf72e249b8b65457

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
