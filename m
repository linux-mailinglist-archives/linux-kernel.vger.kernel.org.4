Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFAB55FA2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiJJRWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJJRWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07AF24BED
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B07460FCB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 17:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 977CCC433D6;
        Mon, 10 Oct 2022 17:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665422526;
        bh=2FPTYSJuWciqIXZ4ysCmkBCLw7IrRBOlyadVOwUhpAk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m8ZJPsjhLva/rY1F7qoY91m870G3N2dY92btB7ua/F0yIuqVhn3r3xcDQzKyZeCbO
         Ma9JEAYKZsoHnmr6kro4AKrXGQD9kumy/0JSzcsEZ0KjsNlGKxkBs2mVJ42+nYSdrH
         zeFmlgJpMk0tff7jODN8xpR/erBTX8iWdDa9lMCZ5q+m1I6f5iItHir1rt1CuuA35H
         urNzswZxopSuUOqoXL+t0JVrezmPd1Hz2Hhpvgk6Ut3wpWp/kkK4DE9DMVntUS0FyP
         6PuG+fM4Mw0uikDKXwewCAjszBIv6mcm3zvP1J+pDj5WMrEKEfTRxQRWvwf9cYVc6+
         uN3VN9sEkhZhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DA04E4D022;
        Mon, 10 Oct 2022 17:22:06 +0000 (UTC)
Subject: Re: [GIT pull] sched/rt for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de>
References: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <166497241171.125841.9535880258521894817.tglx@xen13.tec.linutronix.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2022-10-05
X-PR-Tracked-Commit-Id: 44b0c2957adc62b86fcd51adeaf8e993171bc319
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7f6dcffb44ad246e3211c6aeaba8a625e2766836
Message-Id: <166542252650.13651.5982493291727323145.pr-tracker-bot@kernel.org>
Date:   Mon, 10 Oct 2022 17:22:06 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Oct 2022 14:21:22 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-rt-2022-10-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7f6dcffb44ad246e3211c6aeaba8a625e2766836

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
