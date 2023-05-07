Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BAB6F9AD1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjEGSM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjEGSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D2D59FB
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 11:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3402D619EE
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96BA4C433EF;
        Sun,  7 May 2023 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683483132;
        bh=GouHbZHRbV34+A9lLeeRcO9ANmdK4Z3WIgcdlv2LSBI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eTR3m17tXLpAZSduHKKG/NkS/Qfvfeiobs/sErMUMPorsIIdv4JEeESnziE5G/SUu
         78Aly8Kl0N4j+RcX8hNuXWsQtB9FiUMJEx9TeZLMzO2h6osNnNAJJrh7WFCDycSUdD
         6CBx6lYO2UsPe5noh9DC9wyXl4zpH+7n2+xT8+w4dC+FRVBUqUoCo7iUg+iRNIfB44
         8N7fl6fiplcZwrGX4lEDorQO8QTF+4MImEHKM4f0kgwFxa7apJLkvMZemvh7wnmS9o
         xC5+YvXdAj43vkC6VnhFSkTh0UcHcZfIaNrfrXQu1JQpcAVX7NHnjLfEg3QqgzkodY
         qgPYyfVXT9afQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7FE68E5FFCC;
        Sun,  7 May 2023 18:12:12 +0000 (UTC)
Subject: Re: [GIT pull] core/debugobjects for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168340025919.2105360.9722828595496474732.tglx@xen13>
References: <168340025919.2105360.9722828595496474732.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168340025919.2105360.9722828595496474732.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-05-06
X-PR-Tracked-Commit-Id: 0af462f19e635ad522f28981238334620881badc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17784de648be93b4eef0ef8fe28a16ff04feecc7
Message-Id: <168348313252.16669.7152806487745359561.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 18:12:12 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  6 May 2023 21:11:13 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2023-05-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17784de648be93b4eef0ef8fe28a16ff04feecc7

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
