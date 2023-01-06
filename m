Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98D6608BE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbjAFVT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236427AbjAFVTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:19:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2595181D48
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 13:19:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B79BDB81ECF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 21:19:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6718BC433D2;
        Fri,  6 Jan 2023 21:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673039943;
        bh=zPRGi3Zj6aD1vdymlifi1P8F5+sOZLbS/zm+omULfNY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=aY9EVn4WmobDnuEsdUW8h1Gxi3WL81SMXrJMjnz4RtILNawYGf+FcUroAdvuMxvEO
         DdYVmLGBoY7Bl5msQROGIomFQZkM/fJXpRZ/ILSibj/bUBDIeOgDRQl5BoDTe4BlqP
         6sLWlDBu0NlEHD6Qj9EMZOuGytIvaVgaaKxMhIPgLMVh2WklvhqmvYPaityLmcW7yu
         dAM/djY0yjwNZTaUlxUz4FH4JYilRg+qgvYQSyFL7OA1KRym61BT7cOIqIUv7kQP8D
         A1C7VHWKmnvo+3Lra7HpDwH6SsCM99mkDzzmql8cF1vLiOjNQbjHOI46ypjx859L9B
         89R5zDMdvnryg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55972E57254;
        Fri,  6 Jan 2023 21:19:03 +0000 (UTC)
Subject: Re: [GIT PULL] ARM TIF_NOTIFY_SIGNAL fixup
From:   pr-tracker-bot@kernel.org
In-Reply-To: <7839c5ff-13d2-9542-546b-d9cd3e527187@kernel.dk>
References: <7839c5ff-13d2-9542-546b-d9cd3e527187@kernel.dk>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <7839c5ff-13d2-9542-546b-d9cd3e527187@kernel.dk>
X-PR-Tracked-Remote: git://git.kernel.dk/linux.git tags/tif-notify-signal-2023-01-06
X-PR-Tracked-Commit-Id: 191f8453fc99a537ea78b727acea739782378b0d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 93387d499e49429eef2c343ab6f9f5d92ec780a2
Message-Id: <167303994334.10294.3014237142625782070.pr-tracker-bot@kernel.org>
Date:   Fri, 06 Jan 2023 21:19:03 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 6 Jan 2023 09:22:20 -0700:

> git://git.kernel.dk/linux.git tags/tif-notify-signal-2023-01-06

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/93387d499e49429eef2c343ab6f9f5d92ec780a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
