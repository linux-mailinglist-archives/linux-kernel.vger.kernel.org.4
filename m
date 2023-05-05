Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4E26F894C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbjEETMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjEETMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:12:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835DD11A
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:12:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17BEE63E80
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:12:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B732C433EF;
        Fri,  5 May 2023 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683313923;
        bh=/r9+H+5SNZPduayjN6ZBjQuCEtkKiLccWkjSpcnnB3s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=I9e0ilCRNV4Qj70hjkOxesOAhu3TZRjdhdn+j0oAEITAzyZfvGduJVxFndDi3LZhy
         56cmDEzObazIF4qr6/g8adF2XxFjv9EGipOXYxqjPMiWT9EDxvZrXkMNxwv/zWhu4y
         A7T+pstrBx6DH47bnZtUgr8ef/KgznkdeC5hoGJtDGzeW+q6IXG1m31f2A01PMJvS0
         LZ56UO36YhIMgJPSRqrdYcI6LSZbLTlnF01urWreNiL4V4NwPvY5cSXa0vHtohrgP3
         0fTd/UMtFbxaTcb0+rT4Qk3BiRRWdYMK03WAu+q1INzAvEdbCn+7zPg46his5+SLcT
         JMjHXxAIYRTgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A4FFC395FD;
        Fri,  5 May 2023 19:12:03 +0000 (UTC)
Subject: Re: [git pull] drm fixes part 2 for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tx4RUsYmOH4vLcXQ4dyTxkBDO5WeEXabWX4hdDbUp3ghA@mail.gmail.com>
References: <CAPM=9tx4RUsYmOH4vLcXQ4dyTxkBDO5WeEXabWX4hdDbUp3ghA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tx4RUsYmOH4vLcXQ4dyTxkBDO5WeEXabWX4hdDbUp3ghA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-05-05
X-PR-Tracked-Commit-Id: 1bef84af084e981550d9ecc3359baa22533d7b99
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 084f51d473cd566eab310d5da56fe7b68d0b10be
Message-Id: <168331392342.10509.11940586646872605215.pr-tracker-bot@kernel.org>
Date:   Fri, 05 May 2023 19:12:03 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 5 May 2023 13:10:28 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-next-2023-05-05

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/084f51d473cd566eab310d5da56fe7b68d0b10be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
