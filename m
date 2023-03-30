Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728196D1093
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 23:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3VLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 17:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjC3VLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 17:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EEFEC4D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 14:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6268BB82A37
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 21:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B212C4339E;
        Thu, 30 Mar 2023 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680210663;
        bh=yLUm+SD15hQAp8b/G6sbW5kSY7OOZIAufqQ88dBu5kU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=U4OMe2XGSbVI+qvYqHFyyt6WSTHEKFc+QQ/QTgd82X1/Whu4imSKPQa4ImIM4VHK/
         RJduBlwf67rYJvUZCIFSQ+fYJkaEYkUo7rTZte6FqWzAVIiqyJlmw9azMkHNPIIuKg
         bKPfwsoJBaqLYoAFY8E6evkZH8JtuQiVTWRmDu9LQlMRmH7hj+I0q809AZrLu9tURU
         6TD1sgvm3oR9eT5m/8+fHAcGQNHtgJojH6jb0vPHupgccgO/vJf9oNmuT3M6Kxwzjt
         2y4/9NoCoYjU5SEjtJEZx4jWRY+yLzzmVprRF7njgTo0bQJQtEGBsJPhH4YdlW2L6M
         nYEaK3HjMyMvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18BCAE49FA7;
        Thu, 30 Mar 2023 21:11:03 +0000 (UTC)
Subject: Re: [PULL] drm-fixes for 6.3-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZCXnVLzzdzt4xX7E@phenom.ffwll.local>
References: <ZCXnVLzzdzt4xX7E@phenom.ffwll.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZCXnVLzzdzt4xX7E@phenom.ffwll.local>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-30
X-PR-Tracked-Commit-Id: 7af63e079a7d6d45a3796a7ba625e2ec131f62be
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0d3ff8087b2c12ee012c547f3bde46a3f60d6f6f
Message-Id: <168021066309.12065.2646138721732559028.pr-tracker-bot@kernel.org>
Date:   Thu, 30 Mar 2023 21:11:03 +0000
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 30 Mar 2023 21:47:32 +0200:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-03-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0d3ff8087b2c12ee012c547f3bde46a3f60d6f6f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
