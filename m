Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B401474B9CA
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 01:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjGGXEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjGGXEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 19:04:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4191FEC
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 16:04:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 844B561AC2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 23:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5654C433C8;
        Fri,  7 Jul 2023 23:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688771045;
        bh=2knLJrNbiPyTlNkQidx30FDXBKRVHi0ZqrZdHbJxm0U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mYbP8JDZf+QNt748w9geA74sEUHc2B9b0squsp02+wkTWHtoFeQu8a9qsZr6Li+PQ
         9uGdb8Vw98wCFreyDyTPM2Txkpy1szqZ0GTUhfXYa3nDNj15KRo5EE2es2qWLeBYsc
         QrbZIyb5fUfqhzxKFVJnUwdOlzzpYlobJ11ebgcxez5HD0gSZZvf8QIfBjiH+r/oK4
         9nxu0oCut4XDVGGLCY84HHSlxTVT5SwPz0xG3xsZ/xyaVA6ODpsv9e69z0t+hP9aLI
         DzWGGJRw2SbjR/vvNaqyWhCyqiceFu+u3GxW/JwnGCWlCjfDmUWrF59OP519nYJ9DW
         +/9fR7kJQdrWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2389E537FC;
        Fri,  7 Jul 2023 23:04:05 +0000 (UTC)
Subject: Re: [GIT PULL] sound fixes for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87o7kokv8u.wl-tiwai@suse.de>
References: <87o7kokv8u.wl-tiwai@suse.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87o7kokv8u.wl-tiwai@suse.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.5-rc1
X-PR-Tracked-Commit-Id: 5251605f4d297a0eb5d3b7f39f9dcee9e4d0115a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c8ab068bea2ed7b5b192cd66d436620a0b4f05e
Message-Id: <168877104585.13958.9263778637007100142.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Jul 2023 23:04:05 +0000
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Jul 2023 09:59:13 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git tags/sound-fix-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c8ab068bea2ed7b5b192cd66d436620a0b4f05e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
