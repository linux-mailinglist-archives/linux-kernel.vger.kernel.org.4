Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64176A3403
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjBZUkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 15:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjBZUkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 15:40:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3D8BDDC;
        Sun, 26 Feb 2023 12:40:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 43976B80B4A;
        Sun, 26 Feb 2023 20:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B05C433D2;
        Sun, 26 Feb 2023 20:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677444013;
        bh=yBJttvv33ZQb5C0Xe6rjk6BKXNL3j5AM7R6vuvNLIyg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DTOpKPYW4Nx2YsdIqJqf1wcx0WwnFdFIWcNDGZf20mzkJgYR2cjZnGMhswslyvJKK
         zcxL3nFGGCtsUIJ47zK3DS3zGDvkoiv39mXyxcykqdeu8543ETZy6X5q9E3ndnGG8j
         AQUsNba4QJ9+hgK0rzxvtWOAAGNy07GjYjKv2NYJkrSXfI4UTXUgP8H8h0GAimI53o
         z83fWlLiKdmAzAm66lvi1IlNuTlIkInxoYdu5kkwt3spR5/qhZJfZhH1gNABsCBVWR
         pJl9m5ay9Vt04V23gTXSqMev7XNeCWVcyH8TenYtaFBiHA6wd0h2B5ASrLNG4tOB3E
         T2wrMKHRAnkOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1F74C41676;
        Sun, 26 Feb 2023 20:40:12 +0000 (UTC)
Subject: Re: [GIT PULL for v6.3-rc1] media updates
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230226114551.68480d44@coco.lan>
References: <20230226114551.68480d44@coco.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230226114551.68480d44@coco.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.3-1
X-PR-Tracked-Commit-Id: 3e62aba8284de0994a669d07983299242e68fe72
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4b8c673b761e74add4fd185d806ac16c9b40158f
Message-Id: <167744401282.16333.2884325415530923772.pr-tracker-bot@kernel.org>
Date:   Sun, 26 Feb 2023 20:40:12 +0000
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 26 Feb 2023 11:45:51 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media tags/media/v6.3-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4b8c673b761e74add4fd185d806ac16c9b40158f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
