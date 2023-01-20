Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC62675CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjATSrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjATSq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:46:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD70564BD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 10:46:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07818B82793
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B19C7C433D2;
        Fri, 20 Jan 2023 18:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674240413;
        bh=+3yI2nk3cf1PMiPEAwNlJ8wvoNP2evOlEbDiXir0H6s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KlBA6i2gkcVtCwxu8twdTQnL07JLNFjSfgLAm1F2yCmIPZXO8eYFR50zpZPIwQOlJ
         49OzoAnYbtYVMY5gKdPfzgr8uM9wzigXGWcd0c78ROJ6qcQg3PXpr992cQF81H6CJ5
         XjE6XZvcO/cvxolrUqOetvR5ea7uZQY0iS1AkZlOCi6US1hR9csAxEGeCo2ms2Go7Y
         N8iqj5yGZmNQwTHe/pfCiuQk0o6kBhmOiCj2q3eV6uMOtdaRLgJ81Iote9FXBjhNcR
         zBm6CH2uNhT9J6kmENxCCAI3rsE7QjbQJtR10GJkeQX3AR/n6dWrLovzQ7SbQXMKu7
         4u3/nWNO8UBWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A00C9E54D2B;
        Fri, 20 Jan 2023 18:46:53 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyh=fnWEUfE_Y5mMVwxgHEUCpev6pXyOQsxG+NpeEVQgA@mail.gmail.com>
References: <CAPM=9tyh=fnWEUfE_Y5mMVwxgHEUCpev6pXyOQsxG+NpeEVQgA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyh=fnWEUfE_Y5mMVwxgHEUCpev6pXyOQsxG+NpeEVQgA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-20
X-PR-Tracked-Commit-Id: 3f30a6e67ce49c0068f8058893326db46b6db11f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ff83fec8179e392be2f472f0a9ec3da8f6d529c6
Message-Id: <167424041365.21297.9755516045782199117.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 18:46:53 +0000
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

The pull request you sent on Fri, 20 Jan 2023 12:52:59 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-01-20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ff83fec8179e392be2f472f0a9ec3da8f6d529c6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
