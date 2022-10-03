Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417E65F3943
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJCWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiJCWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C4F580AF;
        Mon,  3 Oct 2022 15:44:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670436120F;
        Mon,  3 Oct 2022 22:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB0BCC433D6;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664837045;
        bh=/HVKYKSoYtxToiHZ/glXPpg1HuuUWLVH0a0TSC85gG4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=lnYl4ZOoHs19sQJjbwmwFwuuZ8QAxC7yCn8xXUS5651cqGpkeHOrxz2eRLvnRpMzY
         miQvSx7nS1DdW1uk+bbJvm0WVsL98yfxz5UWJq3bDJkOO/BMDhb8OaWTY9/NFHF58O
         roUzEY3ImGLiA3rCqekDTA4eSTftW16ouU1lYn14PKVDERfikQapM5WsiHw6TljYfz
         OA6Bn+kIjW/389HcQSGeb7Y2sZjRcw/XYVb2kkmY0k7/ZMWekT5HsE1MTm3UY1aJlT
         bjyzE2BsYUV/K7mfgJHYp2589ApwkyWaZoacGJEpHhjfCOTVNmsMypOe9WVzinbust
         cfZrxF/h/5itg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFA26E49FA3;
        Mon,  3 Oct 2022 22:44:05 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0ip_C6y1KopyN2pEs7dyqPw6NzKG1WtJSeqyKJeMOYwfA@mail.gmail.com>
References: <CAJZ5v0ip_C6y1KopyN2pEs7dyqPw6NzKG1WtJSeqyKJeMOYwfA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-pm.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0ip_C6y1KopyN2pEs7dyqPw6NzKG1WtJSeqyKJeMOYwfA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc1
X-PR-Tracked-Commit-Id: ac73ce394a129a88cb01ce190844bcd172ce14fb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c79e6fa98ca8628556a01fe277022bda64829fdf
Message-Id: <166483704571.27150.15639837287137970590.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Oct 2022 22:44:05 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Oct 2022 21:56:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c79e6fa98ca8628556a01fe277022bda64829fdf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
