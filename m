Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D4E6E876A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 03:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjDTBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 21:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbjDTBZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 21:25:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52ECB4C1F;
        Wed, 19 Apr 2023 18:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E090D62985;
        Thu, 20 Apr 2023 01:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55162C433D2;
        Thu, 20 Apr 2023 01:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681953920;
        bh=WciTIZljjPC2swgKaJkGbJu5HU0uxHvb1Vd07l5Zchw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=XqnP7YsfxJDAi7LU+PtuDzQow1N1SwdzdIyAQXbwGiQnfbefM6MREiwZQ7MXbPN1f
         H34KRC6jeR7ndKC3vihzCJbYplRD2BSm9PzRdnQARg+Opg6Rxfp7p5mi9DpF0wLfVx
         Hfd+kiyPsPtPS3lfTJZqOtsyVHNk77pKhVerlLTtou41PvXlJQBk38V4eelrA8Ilba
         dcvPDdBFj3sKg0EHj+0Bl0Jlj4IE74VR5XgM6wq+ffs5BLpE2rpegLTEYM+NB+GtQn
         gxhpfIE5s/ynFLE/88LMgYjeOjD6skNqm17lCxRxNdl1kDkEAhBUgF2v7MQmwytfxE
         c/aUfF/4Rg4HQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 41996C395EA;
        Thu, 20 Apr 2023 01:25:20 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230419163823.f2a0f64f0ef67ddee54c2461@linux-foundation.org>
References: <20230419163823.f2a0f64f0ef67ddee54c2461@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20230419163823.f2a0f64f0ef67ddee54c2461@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-04-19-16-36
X-PR-Tracked-Commit-Id: ef832747a82dfbc22a3702219cc716f449b24e4a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: cb0856346a60fe3eb837ba5e73588a41f81ac05f
Message-Id: <168195392025.1989.12917488404470266327.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Apr 2023 01:25:20 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 19 Apr 2023 16:38:23 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-04-19-16-36

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/cb0856346a60fe3eb837ba5e73588a41f81ac05f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
