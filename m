Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C09DF6260CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbiKKSDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbiKKSDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:03:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CC965E44
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:03:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24AF162089
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 18:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8D48C433C1;
        Fri, 11 Nov 2022 18:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668189783;
        bh=eDxpYGXZz7q+HMfN0lo9h0m7cnwd8+zf86z4MHZD8j0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=uptBZ5axr4ri2+huVdH6vqBDO3OkfKma3Bj9wsLMNCTKGzuQyVsENY4Cy4C8QSmZX
         1YOQkmyL4cHgtVcQ7o0lLHC3fhMl3KumTTlHlBcI0gXvl54/35FCPtO32XupmiHgui
         /dZDFMJZq/PKJ0yhLNVBjx+qQcl5lR5bBCbMnRut8e56/U6VqdmajRxMjMWzXrd7Ov
         CxTDF24/96r82m3l27JMfEww9KcJ0zjc2nIASk6LG/d+hrxRCxYRWXSSAytfZzwW2y
         jc9zXnNvEn7Hbt3HsGYr05EaIpJliMeRhZSVUdycNQ/NaXp91NHgoF/Da67qnEzvcu
         tNC4fLLyAiSlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DA364C395FE;
        Fri, 11 Nov 2022 18:03:02 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tz0wieno61nXib1N+P2KKERh6HO947d6rEYiBZMccr4Lg@mail.gmail.com>
References: <CAPM=9tz0wieno61nXib1N+P2KKERh6HO947d6rEYiBZMccr4Lg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAPM=9tz0wieno61nXib1N+P2KKERh6HO947d6rEYiBZMccr4Lg@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-11
X-PR-Tracked-Commit-Id: b7ffd9d9ee13de2c5ad88046a5149de4cfb2a74b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fd979ca691715891a979ce12d1a485b108af74d3
Message-Id: <166818978288.15878.9908916054430327359.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Nov 2022 18:03:02 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 11 Nov 2022 12:18:21 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2022-11-11

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fd979ca691715891a979ce12d1a485b108af74d3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
