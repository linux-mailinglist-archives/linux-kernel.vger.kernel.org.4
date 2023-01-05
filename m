Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FBF65F482
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 20:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjAETcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjAETbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 14:31:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA82ADE96;
        Thu,  5 Jan 2023 11:26:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DE5261BE9;
        Thu,  5 Jan 2023 19:26:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1E86C433EF;
        Thu,  5 Jan 2023 19:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672946806;
        bh=s5g0WENZb5vwVZOYV8eJY5ke6jHO1BmPYsSPvs74uc8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sGthtr9Y87pT0RGc0Es0XVEsdyaLR9+8zLFNLFQV2Lw3B4d/toBBrCWvYvC9AEcNY
         E0mzrZwkvnw+AlIELMqvCS5P9nDwnOH19ymKvk9MROY1lmPv+1Okxss3ISaGWN20DW
         BdWE1UYBFh4EdtZVlvFenYAea7WYrinMYgo+LeT1aB/xAm2WjSmFKHDIYeHfhE1h1Z
         OPJ0iVXyMTTN2i5AodQQgl+jlzon3w2XnJMQplfSj4n2lpfyxOq4Nx+l1gHclT8nVK
         d9s4I+hO5s9C9kJ4KMdh1J48LL03MmPEmvLdfJMeaPXuQ0K0ie/BycgwsdAqL0OlUz
         PF3uHL9RuGnbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FB2CE5724A;
        Thu,  5 Jan 2023 19:26:46 +0000 (UTC)
Subject: Re: [GIT PULL - v2] fbdev fixes for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7aweqyDS7EmnDj8@ls3530>
References: <Y7aweqyDS7EmnDj8@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <Y7aweqyDS7EmnDj8@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3
X-PR-Tracked-Commit-Id: 634cf6ead93988b0da9ac054521ab63a3ba189db
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5e9af4b42660b2a8db067db8ff03db8a268d6a95
Message-Id: <167294680658.18567.5299201102789509394.pr-tracker-bot@kernel.org>
Date:   Thu, 05 Jan 2023 19:26:46 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 5 Jan 2023 12:11:54 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.2-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5e9af4b42660b2a8db067db8ff03db8a268d6a95

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
