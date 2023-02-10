Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2257691667
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 02:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBJB4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 20:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjBJB4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 20:56:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C009E366BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 17:56:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 841D1B823B6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:56:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4EB12C433EF;
        Fri, 10 Feb 2023 01:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675994191;
        bh=bcPjDfvMzZA5oOJEPAtNUf5zODbvzRsKlND8PjAokts=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HYTN0Eanl+9O43bhKlTx0pD0AILjvlfN6DAKxyredarvbBtFnuNrUvZAhNlhiJ5fS
         w8bACoVO5kVN2cvcR7m8seSv/taHXzZjNr0p8T5QJB/WKzwKABFEyUcr8uZfWPw5Il
         m2vHAh4pqp2bKRjSsZlRKb+ED6NW3f8hJNTwnP3R2W6Yzii3g+rlQNAxz/mVXR1yYF
         Jzd2CQPLtumkNQVvkUU+I8J6O5EIPd8hcTgYQwmou2JwWegJFzAYNOUUv6FW8AWDRr
         5SgzTRCZHuL2bY9S1u5vSk0/aA+TNdnHxoKjGwkj1xmalOWrJA4lbt5olMqJmRoDFy
         YJJ38vMNgAPfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E784E21ECB;
        Fri, 10 Feb 2023 01:56:31 +0000 (UTC)
Subject: Re: [git pull] drm fixes for 6.2-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAPM=9tyEJyxto-DDoerhGFxZWG8-M3xOsAfDhKfgAy8yARhvOA@mail.gmail.com>
References: <CAPM=9tyEJyxto-DDoerhGFxZWG8-M3xOsAfDhKfgAy8yARhvOA@mail.gmail.com>
X-PR-Tracked-List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
X-PR-Tracked-Message-Id: <CAPM=9tyEJyxto-DDoerhGFxZWG8-M3xOsAfDhKfgAy8yARhvOA@mail.gmail.com>
X-PR-Tracked-Remote: git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-10
X-PR-Tracked-Commit-Id: 777c1e01cb7e1947765fb0c3b9b71dab18e53e46
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 38c1e0c65865426676123cc9a127526fa02bcac6
Message-Id: <167599419124.18539.12388719795658212182.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Feb 2023 01:56:31 +0000
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 10 Feb 2023 11:19:51 +1000:

> git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2023-02-10

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/38c1e0c65865426676123cc9a127526fa02bcac6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
