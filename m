Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB65EE4DA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 21:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbiI1TNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 15:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiI1TNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 15:13:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8537A9C3E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 12:13:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 83EA1B821B5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:13:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BDB9C433B5;
        Wed, 28 Sep 2022 19:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664392418;
        bh=qIuRbHyraTHACeljvPcH2FyP25E7JvLjmPX/ko8ALB8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iMPqfS/PEAO4IO+8emXuD2qpfXBCCyYQelP6NJ0z6XKxvthgVIGjH/S7z1H2RJoAb
         EXw0AfEtYcbjj1/GHvvP14hVLSZY4zcrPYNpiFWRXZrlx6svJfq6VraRZXP374sg36
         hjx2tR3AyV6J3h8BaDyIYh7PkoKu7IlgjQrTnmWZBJveD9vF4WJ2YlLDr22wvHphG1
         C4YpbajPhXcbCVDvgEZfeMoiAQ/xUlgwsfsgqZ3RfU26nE2RJE5do2YZxkUzmz6JkZ
         tBiSKlKmX/WDDuw7QWuUJp7/60I3jd5GpqW5sfvJ0xn33KFRgA3L9Q1U9BYwWx6OLF
         DNJRn8mPyxruQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A0A4E21EC5;
        Wed, 28 Sep 2022 19:13:38 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.0
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzQMdl0bf305slSv@zn.tnic>
References: <YzQMdl0bf305slSv@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzQMdl0bf305slSv@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.0
X-PR-Tracked-Commit-Id: c0cca6a66458a0daa627774de7ca2b678a6bb3d8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c3e0e1e23c70455916ff3472072437b3605c6cfe
Message-Id: <166439241816.10768.16757883183011378792.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Sep 2022 19:13:38 +0000
To:     Borislav Petkov <bp@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 28 Sep 2022 10:57:26 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.0

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c3e0e1e23c70455916ff3472072437b3605c6cfe

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
