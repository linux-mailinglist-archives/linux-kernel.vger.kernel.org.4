Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE55F16A6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 01:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiI3X3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 19:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiI3X3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 19:29:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434206D55C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 16:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB1B4B82ABC
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 23:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADFFEC433B5;
        Fri, 30 Sep 2022 23:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664580557;
        bh=VRYbn7R55mSytqdcZwzs+tKwdeBpsQ1usbfu2/4Ni78=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WIjNG6vrzLG6Ldo8Gigoeqs7NH0FcMt7E7gNR6t3m1nTm390aGWCYswRP+lsw0T+2
         hL6ioDuBNvWKxHwZ0WfkoJie140LJHoLg+obIXtYnt7LhBuDGDyzNBkc47PWsYJnR8
         eZZiAm6H2mZhy1oa8GWWYLDm4HvOe/JPD0wv4BVh3XFi2LZfgakyjmy6rjiNmk5Cv6
         CXH4AnLLS9jUmecbutYgcIcmUMTh0GdOzGcO8xX74XdHFNvCZQICCOWwNLcVyA0817
         TLh3ScfbO107k0JQQ6eY8ZDovVBvg0tXcxI4h5Oyd1MAgUBYsa43xZ08j9UKms14i1
         wKOxmqqa+OKqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90553E49FA7;
        Fri, 30 Sep 2022 23:29:17 +0000 (UTC)
Subject: Re: [PULL] drm-fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzdrcM2YAK4qyePP@phenom.ffwll.local>
References: <YzdrcM2YAK4qyePP@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzdrcM2YAK4qyePP@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-01
X-PR-Tracked-Commit-Id: 414208e48963fdb136240d7f59c15e627832d288
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ffb4d94b4314655cea60ab7962756e6bab72fc7e
Message-Id: <166458055758.7949.5587471339706789894.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Sep 2022 23:29:17 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 00:19:28 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-10-01

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ffb4d94b4314655cea60ab7962756e6bab72fc7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
