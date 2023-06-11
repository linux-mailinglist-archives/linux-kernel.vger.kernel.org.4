Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E8B72B34F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjFKRnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 13:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjFKRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 13:43:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3636D187
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 10:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6CBD61151
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 17:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 35EA2C433EF;
        Sun, 11 Jun 2023 17:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686505415;
        bh=RvF1lgTnMagzOs4D4wmxhNfSpDB7jkq5ocbLx6rztHg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VucRnOT4Zu2tT7HiOAOkmAePcy/Tuli8LIloboe/MKkOJgXSmVfVHLSDdWnJmgN8w
         Xu7LJL60iDY3GyeMWHeZwHanMjYUsg1z3Cwk3uC7uPTSIDnjj0Z2DneDxT5IJqKnj2
         0AJnSsmNzUguaUWAmHFHxchMOcmV+cQgWj8MzlcMP6zFiZ+BiMC27HySn35aqHz08p
         YJ5hMw/Lje8c3oyES2Diws32ULKxNXjbTmWn3DVrxXtfSv2ft7C9+0MXr+ZYb72jSg
         Sti5jGDTYXA2eowFQPiBNkKJ3Gb11Y8xKhHov4zvgJ6lyIdrZewUHXkQP/2m2UkRC9
         dhk9yzLkcPQ9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23021C43143;
        Sun, 11 Jun 2023 17:43:35 +0000 (UTC)
Subject: Re: [GIT PULL] x86/urgent for v6.4-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230611110551.GEZIWqj1EgUPmZbPne@fat_crate.local>
References: <20230611110551.GEZIWqj1EgUPmZbPne@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230611110551.GEZIWqj1EgUPmZbPne@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc6
X-PR-Tracked-Commit-Id: a37f2699c36a7f6606ba3300f243227856c5ad6b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c605260bc60347d3d5601900704cb22b0b2efec
Message-Id: <168650541513.29074.8299364032829933940.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Jun 2023 17:43:35 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Jun 2023 13:05:51 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.4_rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c605260bc60347d3d5601900704cb22b0b2efec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
