Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FE46A139F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjBWXQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBWXQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:16:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E69230192
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4F7A6B81B5E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1842CC433A0;
        Thu, 23 Feb 2023 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194203;
        bh=6E5cexUdcgZ/jNhBxOEU0KaxrXO4Qk03YPFp41sktFg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Uh2efSLmb77l8oWDwokGgep2MbrdkUE2mPt0xQqOJAgl3AicpwCFTt4/R3BUw7+r9
         c3GcvPWC7PzXbUymPkxpYfIF0h+qLtMm9bc/vRUghRUJVNZkB9dhzLJ8YX9UQpY3QF
         PhIJCQqWcmviX7a0bkejmacJcDtSIGe/nnXBawqt1FGlww2jkM7vVU3fdU+DaNOvjt
         eT1hnSrISUlVRCA+sxtuHtFKrpfpDL9xwvkQPOTTDNoqUYb/5WbvPFCzZoV4z4bbKC
         qob9rgRYVozZ0DFTAieYYCeaLf88UkFGGNW+hRAlzZEyZq1LUsZdgbAskB8skkweX2
         +r3r2lffL1bwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07D73C43157;
        Thu, 23 Feb 2023 23:16:43 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/csGl2m6+e763Of@google.com>
References: <Y/csGl2m6+e763Of@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/csGl2m6+e763Of@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.3
X-PR-Tracked-Commit-Id: 056f65c3938bfa40141669b974d441348af3ee54
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e4bc15889506723d7b93c053ad4a75cd58248d74
Message-Id: <167719420302.30381.3753088953266345001.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 23:16:43 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 09:04:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git tags/leds-next-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e4bc15889506723d7b93c053ad4a75cd58248d74

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
