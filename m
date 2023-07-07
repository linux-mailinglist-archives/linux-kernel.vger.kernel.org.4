Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E37274AAC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 07:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbjGGFvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 01:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjGGFvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 01:51:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF36F1BC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 22:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D59161727
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 05:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1B76C433C8;
        Fri,  7 Jul 2023 05:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688709067;
        bh=lCMBzR7YYZo623mv3/jS4RCYKmpO8KxU3UrnoLOcpms=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T90Uyc94vAHlGiszs5SgqZpqWtlsen/3FR7Q9h46HEzJGEs//j/p634yMYc784anr
         2rTT0enGomNE+cq0HYUNdoJ0Ys0K+6lP+jYri7SSN6woo1KnzJcggXxvuv1hS3XWZk
         YcUSYFy3IH7WXdrpZgSxoh+XXmcE/RsrEfo3e08p/P2WEpfvn0Ret7RaDL4OQN50np
         I1mRgO0oJbfXrOBlXpPejZFqqMGP5jIKZz7xzDJbubFOroPhCGajfCvtTPyl8G97rg
         Yi8LypA410x5HaqSwSUEoa/xCrAdElNvy/iieCotJ5gHb6XCFRUz0oqGxQgS01mvBc
         0eg6/yy7WFw0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A180FE53801;
        Fri,  7 Jul 2023 05:51:07 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9twAjnoMTUAmm42=hmAtbPuqmMzDgOFDA4zGK2BuD0g2DQ@mail.gmail.com>
References: <CAPM=9twAjnoMTUAmm42=hmAtbPuqmMzDgOFDA4zGK2BuD0g2DQ@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9twAjnoMTUAmm42=hmAtbPuqmMzDgOFDA4zGK2BuD0g2DQ@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-07-07
X-PR-Tracked-Commit-Id: 6725f33228077902ddac2a05e0ab361dee36e4ba
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5133c9e51de41bfa902153888e11add3342ede18
Message-Id: <168870906765.5711.11420919438513080286.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 05:51:07 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Jul 2023 11:14:46 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-07-07

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5133c9e51de41bfa902153888e11add3342ede18

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
