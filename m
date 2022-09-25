Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31DF35E9095
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 02:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiIYAxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 20:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbiIYAww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 20:52:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1354E4198D;
        Sat, 24 Sep 2022 17:52:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFE1EB80E04;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D295C433B5;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664067170;
        bh=j9am2kZAdO+nRId7qVnK9cQT/UzppQODSnmNopj4yVQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u4FzjlgVU5yFeaEcz1peGDftekCoKgrg/vzzdksDMV49+TlXGVco2pwJ1GYuvkdGT
         3dSQAeTeeoxOndTy9wsh61et9iU9HG4ThSlPI+j9RCrcq7X30l5/v1zE//JcY0Cdl0
         tVFaf1QBwoTp2W8WpJor6Ndrmhl0XCN7f5VkSmdte43by0TrSsORmnwzo6jtFN4u5H
         2K6nuHIxNIkJoH4za/OC+tU4aPxOIbRT0PCF+iit4olumOpgvVHyeQgNk/JIeAU7cV
         vap1M7/Q6a5lLDA/iN7NkPVIDXiwIIy7dRuwm/aQnYEoJb1mG0D2pYcacTwXhysQRn
         uJtqomrqhKbjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E22CE4D03B;
        Sun, 25 Sep 2022 00:52:50 +0000 (UTC)
Subject: Re: [GIT PULL] Kbuild fixes for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAK7LNATDVBT1NKZtUkjk3GpqxEtOc8JLjY3XMjREHrp94t13-w@mail.gmail.com>
References: <CAK7LNATDVBT1NKZtUkjk3GpqxEtOc8JLjY3XMjREHrp94t13-w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAK7LNATDVBT1NKZtUkjk3GpqxEtOc8JLjY3XMjREHrp94t13-w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0-3
X-PR-Tracked-Commit-Id: 32ef9e5054ec0321b9336058c58ec749e9c6b0fe
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 105a36f3694edc680f3e9318cdd3c03722e42554
Message-Id: <166406717031.14733.7857303199549809776.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Sep 2022 00:52:50 +0000
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Sep 2022 03:34:44 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git tags/kbuild-fixes-v6.0-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/105a36f3694edc680f3e9318cdd3c03722e42554

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
