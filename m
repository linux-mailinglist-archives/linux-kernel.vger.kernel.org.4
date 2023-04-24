Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF77C6ED4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 20:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjDXSuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbjDXSt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 14:49:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C72CAF25
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 11:49:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F63C628B2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 18:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A666BC4339B;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682362055;
        bh=5ZWbLbcxGFBx2Ye9REDGVsMNYUoLtggGE+WahN4iav4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cVZcStVjJW29D48jfeqG4jWRDkMp323ZxbHzZC60E8BtahBVz4BjgJOu6S03CCY+B
         qlEsEYOwzbSWpxn4x/kXVpXdy/fOv7G8bPgTNlwH/9oqbilM6sBb2QSOkzWbY1rI/W
         Uh0J/ho+Icyr3VIFnuIBGg9KkTS65c+6o+2HBMCw5dQ4CmKE9X/fl3wGCXem4G3Psw
         WXxFgkepbLhAcc07pffVVabY4H+feCr/9J+zgFt2Ja/qZlpyOQXftXEPLvPByYZpCA
         v/kUmoBHHnkSysccphAyN0598KzV7+5qVjh9kTA/57QXKFutJrKLYjSiHokiaXT9s6
         f4lygJTJqtB8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 94542E5FFC7;
        Mon, 24 Apr 2023 18:47:35 +0000 (UTC)
Subject: Re: [GIT PULL] tomoyo update for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <4cdeaf08-be26-f379-5512-6a6137bfcf25@I-love.SAKURA.ne.jp>
References: <4cdeaf08-be26-f379-5512-6a6137bfcf25@I-love.SAKURA.ne.jp>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4cdeaf08-be26-f379-5512-6a6137bfcf25@I-love.SAKURA.ne.jp>
X-PR-Tracked-Remote: git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230424
X-PR-Tracked-Commit-Id: c120c98486c2855d2ae266c2af63d26f61dfcc4e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5af4b523ba9be70372eafab02ebfb9babf77ec7d
Message-Id: <168236205560.5635.3982295041627917135.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 18:47:35 +0000
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 18:58:25 +0900:

> git://git.osdn.net/gitroot/tomoyo/tomoyo-test1.git tags/tomoyo-pr-20230424

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5af4b523ba9be70372eafab02ebfb9babf77ec7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
