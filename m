Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BFD68A229
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjBCSpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjBCSpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:45:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2539A829
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:45:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F40FDB82B6D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 93B11C433D2;
        Fri,  3 Feb 2023 18:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449914;
        bh=FUdAYc/wLQqgbIh1DygyDvBybdfWGuo79gGEZS/KRes=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gZcuZ+YmxUOrSehH0kBnWLpmTMrUgFK5owSUXYkx8yR8zrxpHTkpPEM46pnOt4uPb
         g4Ye8NLRlSfrWigQwUimUfGXw1LZrZ1bC0mb2zGjDhz5xd3n2SS1KJPTfVLY09qsMF
         8Y+vu6A9qE5pHYKTMNMU7HX1uGzAxOYtTmC0bI0xpQNc9UCl5Mm3eThVaj9TuKXdvn
         kpv+onWP+a6GkxBr3XH867BtqXjCgT38tKgzH4ASvgoRcBmzulnuG3O84loJeKJ2P3
         JKn9nGjwoFOQmOJc4qe7pkFwRibo4E8b8sA02Z7mK7rtN5+fhb2Dl672DfifV75vPC
         dYMyuHSLza2Qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82BFFE21ED0;
        Fri,  3 Feb 2023 18:45:14 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyO4mgZr-r-sSJnNUOzVV53RSeC0BGSULwD=ebJ4WTYZg@mail.gmail.com>
References: <CAPM=9tyO4mgZr-r-sSJnNUOzVV53RSeC0BGSULwD=ebJ4WTYZg@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyO4mgZr-r-sSJnNUOzVV53RSeC0BGSULwD=ebJ4WTYZg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-03
X-PR-Tracked-Commit-Id: f1a9e82a1203802df3c917dd7ab1b5a5ded55793
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bffede38f82c27cf5e203a2c659fcc9b581dd7b8
Message-Id: <167544991452.32203.14831659985883182703.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 18:45:14 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 3 Feb 2023 13:59:18 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-03

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bffede38f82c27cf5e203a2c659fcc9b581dd7b8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
