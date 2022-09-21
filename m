Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA605C0442
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbiIUQeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbiIUQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:33:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715DAA1D22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A637A62798
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 133C9C433D6;
        Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663776931;
        bh=5N3LFgdcX6tvyDu/0uWB/F9XKtuHVZRs750q3Ttv5EU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=iuSmQGmwY1+wcvnwr0ugj33BZjqNVKIgw5Qa2ksxIIAUBc1PyG9EspZWGHy0BO/Mq
         EiTNfubUypIGEzscqFleQEjQCu2ma7NAhLIgDvQ3ID0+gHFkW6Tl42JQNogJwMZRjA
         viaPokyUaDEQ8ozysAw3wgVk4OrH2dwK68ZLWLNuHysvs7oVrLUbGbC28ZVV774iY0
         QoseTCMqYFKr2hAL7hkdW5UwzfMp04Q6AqXtg8K2pxCSiB+R5ws0nYFV1/UgL6VOcI
         2rhinwSi80+oKgIGO0mtITG8upDBdgGAMUGg/WB8UboKnEU9UaTq8jLvUWVc71jw0U
         3pyMaIABBipAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E854CE4D03C;
        Wed, 21 Sep 2022 16:15:30 +0000 (UTC)
Subject: Re: [GIT PULL] exfat fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAKYAXd-ns2vr_JHJ9ZBvS43Mng2s-xDoV_4rMz2kvJf65zs16w@mail.gmail.com>
References: <CAKYAXd-ns2vr_JHJ9ZBvS43Mng2s-xDoV_4rMz2kvJf65zs16w@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAKYAXd-ns2vr_JHJ9ZBvS43Mng2s-xDoV_4rMz2kvJf65zs16w@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.0-rc7
X-PR-Tracked-Commit-Id: 2e9ceb6728f1dc2fa4b5d08f37d88cbc49a20a62
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 48062bb2647711a5ed7605f485dfcb8fc9938d9c
Message-Id: <166377693094.7162.15286590957692708426.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Sep 2022 16:15:30 +0000
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Sep 2022 16:50:19 +0900:

> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git tags/exfat-for-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/48062bb2647711a5ed7605f485dfcb8fc9938d9c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
