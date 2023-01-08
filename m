Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAA6614A1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 11:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjAHK5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 05:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjAHK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 05:57:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99842140FB
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 02:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A95C60C3D
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 10:57:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79C2BC433EF;
        Sun,  8 Jan 2023 10:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673175437;
        bh=h+/cXd0i519HgJXSXvoOauAnozRWf3PBRcAumyEtjK4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=g1tz1PzAAp4u9OKt9X2UrBHmN/Xh1CcTYuEhzNMX0o17Cxye192vuaWoLGFxTqB0V
         g0kPU1VMj6uq6EjAHyE3jwvt7a1Itv8JdGSopF40bKTaH30T1yoIMTV4svY+AtZ0ez
         Q4lrSRB/SM8LkfOkgpr1zZSW9vTMCmBGZsAFvjV8b+OhEZB95NVmGrsXAqusKCmoEy
         8O9ZtrbESD0fydaaJD3LDf1ezEfMs4KwGSXmsITHra/DpmXU/LEBDrqgOWCTDAKUHi
         tS0K44oTQld0/erlutRFylG6rQZjF1kMwHimvX1rdSS2XYU4Ksp0n3UTVE44fj2afZ
         i18GHr1zpP0mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 668B7E5724A;
        Sun,  8 Jan 2023 10:57:17 +0000 (UTC)
Subject: Re: [GIT PULL] memblock fixes for v6.2-rc3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7pyUprzAC/9VyNw@kernel.org>
References: <Y7pyUprzAC/9VyNw@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7pyUprzAC/9VyNw@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-01-08
X-PR-Tracked-Commit-Id: fa81ab49bbe4e1ce756581c970486de0ddb14309
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e9ffbf16caa6cb596df7fd641bc6063a922c52e6
Message-Id: <167317543741.15194.8533382934048250321.pr-tracker-bot@kernel.org>
Date:   Sun, 08 Jan 2023 10:57:17 +0000
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Thompson <dev@aaront.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 8 Jan 2023 09:35:46 +0200:

> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-01-08

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e9ffbf16caa6cb596df7fd641bc6063a922c52e6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
