Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0455A6A8D3E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCBXuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjCBXuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:50:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C2938B46
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:50:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E94761668
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 23:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83DC6C433D2;
        Thu,  2 Mar 2023 23:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677801012;
        bh=aHhYJZbcos5zGl2kR1zfyCTztXHPxNW1QtvM2Qw43Zk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KEnc3lOPNb1Ccmup8TbAnHV4VNSW+eHvMZWP+HKjPxs+fR60FuV1bCgzzWihEK/gT
         0YBIXSHS+T/jekVoz2vfrCX/qk/S7s2R3r9YE32BeQ9x2O+oQ13uywYnfENlxbk9CW
         huGQwLTZyAZXbiAkpXsKh6yo/tD2fHzvi+srnJ/2w6wVL0V5LoyXxFtcU32z5x0fpl
         kHLxwV0OLa6xezmU72fLVzHynfSTJDCqvzaGzkjEeiTvAARVvgvU/2iaufR3TAQg6m
         +LkmT2Qgq1eD4Oop0BEU3oJiOEukKmIHe0o8PKSAQLRY7juVAtzN3hARTy0i7LXx1W
         nuSgSVLpc47eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C2DDC43161;
        Thu,  2 Mar 2023 23:50:12 +0000 (UTC)
Subject: Re: [git pull] drm-next-fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tzkY1=9Lv4sejpcHTNbMcZWNgzYY6UdPFX4TZcU5g20Rw@mail.gmail.com>
References: <CAPM=9tzkY1=9Lv4sejpcHTNbMcZWNgzYY6UdPFX4TZcU5g20Rw@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tzkY1=9Lv4sejpcHTNbMcZWNgzYY6UdPFX4TZcU5g20Rw@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-03-03-1
X-PR-Tracked-Commit-Id: 54ceb92724a8cf5294c284d5e9f770fc763cdab2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
Message-Id: <167780101243.2106.12305433771137679724.pr-tracker-bot@kernel.org>
Date:   Thu, 02 Mar 2023 23:50:12 +0000
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

The pull request you sent on Fri, 3 Mar 2023 09:07:58 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-03-03-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2eb29d59ddf02e39774abfb60b2030b0b7e27c1f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
