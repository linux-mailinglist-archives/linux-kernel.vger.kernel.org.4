Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035072A054
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 18:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjFIQkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 12:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjFIQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 12:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78E93594;
        Fri,  9 Jun 2023 09:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45366659F4;
        Fri,  9 Jun 2023 16:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6213C4339C;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686328808;
        bh=FcwH5p/720sl8Q385VprrM+CjyJCy1V5sS32UG0H868=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=qtxZP4THlNPjs9c1J5/ZecSetyfmJaEhXQZCLu0cpCosfkovi6Cul+Iiq43q1qQpr
         UB9dyGRtP6SvLf86xyNrQTwEi26roslhnYo7gHhchZYRKeQWXCYefLvyDANCVLFN06
         VyqsQVzHOrvt51ZwYDdEWf4di8NmYkGmCxt4J6KZ03zMxiXgO8UyD/bxsivt4gaaJm
         0XJ7+b2y/M/E2WUoSdjYJp/fzQ8/k2uUOabDSQWMHMtBomDJEwj/L5gcPnWF1dPsrC
         YbnrJ0zNL+AWjQ/bTtF678oumGoYbqZcI1xykKSOp5nWxANfkV3UI7uIVxLIefJGQg
         NcX67bOYKz3vw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8EB78C395F8;
        Fri,  9 Jun 2023 16:40:08 +0000 (UTC)
Subject: Re: [GIT PULL] pin control fix for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdbUZ=V+C+kyu40hCtgtzDRVfKwdwaZ4uJhDPSuhwRrgEA@mail.gmail.com>
References: <CACRpkdbUZ=V+C+kyu40hCtgtzDRVfKwdwaZ4uJhDPSuhwRrgEA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdbUZ=V+C+kyu40hCtgtzDRVfKwdwaZ4uJhDPSuhwRrgEA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.4-2
X-PR-Tracked-Commit-Id: 5b10ff013e8a57f8845615ac2cc37edf7f6eef05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 333a396d71ce4083da31ccbf30772bf2da1509b4
Message-Id: <168632880857.22626.8746708968982379710.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Jun 2023 16:40:08 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 9 Jun 2023 10:54:23 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/333a396d71ce4083da31ccbf30772bf2da1509b4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
