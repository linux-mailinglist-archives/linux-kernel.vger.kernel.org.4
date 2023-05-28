Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D90B713955
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjE1Lq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjE1Lqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:46:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36A9AF;
        Sun, 28 May 2023 04:46:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C799661607;
        Sun, 28 May 2023 11:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8847C433A8;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685274402;
        bh=SaC7jWFGGul0rNqM4MBRgCfz0Y+RUqsiTwRWm/y7BIg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=EqhTdr3+ksZMPq1Azc+tr+VeJQyNzADt1UjCo6iqOFaFSHgt9Vzvk02Whxqmd+Amu
         kS/TXMD3gD2fzgX25uLXJbkBLPaWcfbJSit9Lf1LLPOVcZB/OftF4LtnyjIYK1smu0
         k+VHWCelNPPb5nWLEovRzbgWjxPVWkUGR8RFwAOIjggbdF0qbuu6PaP+9z4jYwFGp2
         +nFI6MY+ry66MYQy0MtqfnNtSOyXKjv7ScjindB3dchZQ3zxQPRzYhQKIZj1lXCMeR
         YNG4Ic9TfkM09WOxU0U3cUS++8eankbrB72hdqEZ3VP0+FEZh1mWW6b1esxKW3jWuu
         VjN368raa09eg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0DF6C395DF;
        Sun, 28 May 2023 11:46:42 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS fixes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230528083633.GA3069@alpha.franken.de>
References: <20230528083633.GA3069@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230528083633.GA3069@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.4_1
X-PR-Tracked-Commit-Id: 4897a898a216058dec55e5e5902534e6e224fcdf
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 045049cb3819341fb83f807967a70c22fdddbd96
Message-Id: <168527440285.32373.4005713261964830308.pr-tracker-bot@kernel.org>
Date:   Sun, 28 May 2023 11:46:42 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 28 May 2023 10:36:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.4_1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/045049cb3819341fb83f807967a70c22fdddbd96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
