Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B459C5F1DE9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiJAQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiJAQw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:52:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7DA2981D;
        Sat,  1 Oct 2022 09:52:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD90260C63;
        Sat,  1 Oct 2022 16:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE067C433C1;
        Sat,  1 Oct 2022 16:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664643141;
        bh=lJc4t456VjYF77RGsqjsCI+nG94Gn8L6fwV4EMAwl7Y=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=F5gXyLE5igVIvrl2A2nkriLQOzwmm6Li/oNiZzIJr7R2DRvG1U0yDPJh00odFcz/I
         C9ZvB0LrB1vU7/Eh/meNRtx8mLZuBHrI/qMKe60THhBHJXTvPdOOmhK5iztZtpgl2O
         LRfyoSOsIj55myEhWioGxEB3S+D12LJFG9pRMXlnJz+Q+vWWmJxnAwaH9xk9b0zxON
         AkfvdcgWc89CukZ8NuqVvoMAQuJHnKfgJ+lMnrqDf+UwDxovyiqdobBvS84RPoXlAj
         NmhHsHaxsUsG27m0J+Rc0T0KI/beqGZBRWPepL66IvJu+gDNXnGCprxaedKCdXAt86
         nOe2ShpBzKKug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C026E21EC6;
        Sat,  1 Oct 2022 16:52:21 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220930185257.d02c928a322dfa727bed4cb3@linux-foundation.org>
References: <20220930185257.d02c928a322dfa727bed4cb3@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20220930185257.d02c928a322dfa727bed4cb3@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-30
X-PR-Tracked-Commit-Id: 1c8e2349f2d033f634d046063b704b2ca6c46972
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2a4b6e13e170a5c0c201a1858a8f5a61f98eb11e
Message-Id: <166464314162.22904.11483810474518228998.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Oct 2022 16:52:21 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Sep 2022 18:52:57 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-09-30

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2a4b6e13e170a5c0c201a1858a8f5a61f98eb11e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
