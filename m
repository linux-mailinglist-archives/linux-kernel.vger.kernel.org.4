Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5908A612C45
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJ3Sey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJ3Set (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:34:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370DD5FBD;
        Sun, 30 Oct 2022 11:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4283B80E86;
        Sun, 30 Oct 2022 18:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6394CC433D6;
        Sun, 30 Oct 2022 18:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667154885;
        bh=Kdx/aQdgYf1+FBPYtOWMrOrqkh6NJT68OlABNPE/Wow=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GYnhGpdM0837slfoJ1UrpV7L4CAu+SVD/Oh455f21wQfB1qAaDXPW4g5eZjRIwyw7
         p6qUHoO6PrWW52PqRXVNCbBWPxmSXhymWYso1M7rV8pwfYJqcE2uQXngKRmLKcvLaC
         yfG64y3gGy5MYeQGhYq1Y49KSDVNezecl0WflPRW5bv801nN44WD9C8VWI8cjSGPfz
         WnIelbfLnATVh4n0XrKK99Bk0UJ8l6s/REb98wvFyw3rgCfw+jQXA/sBrO5VUT+JWF
         FzbDM1l8CYaklluAn25INqg/bHxrg5wXIx9xylEfK90SOdiLWFLLhu3AsPHB/Bp8Dc
         IWDTZqIxp6pHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51131C4166D;
        Sun, 30 Oct 2022 18:34:45 +0000 (UTC)
Subject: Re: [GIT PULL] fbdev fixes for v6.1-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y16vjgbo+tx6lArZ@ls3530>
References: <Y16vjgbo+tx6lArZ@ls3530>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <Y16vjgbo+tx6lArZ@ls3530>
X-PR-Tracked-Remote: http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc3
X-PR-Tracked-Commit-Id: 3c6bf6bddc84888c0ce163b09dee0ddd23b5172a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b72018ab8236c3ae427068adeb94bdd3f20454ec
Message-Id: <166715488532.31922.18039345236961645035.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Oct 2022 18:34:45 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Oct 2022 18:08:30 +0100:

> http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git tags/fbdev-for-6.1-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b72018ab8236c3ae427068adeb94bdd3f20454ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
