Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF27C6A139D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBWXQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjBWXQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:16:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E455075
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E297B617C8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 23:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D81B3C4339B;
        Thu, 23 Feb 2023 23:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677194202;
        bh=4KRSDng2RtH4LeeHrkcYo/FyZT3xr7f022s6JYoNrVE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gpRcEbloIxLTuJeWFQL8SE7qDkStiFdN429yVr42UZub6aJ8dU6pvTio0OUhOb0h2
         HDEOA87tk4Mnz4hqB+CV6hh1O/HxEuLZ8gqF6HCbgdYb8oOWuDDEIHN+dgVS3uK5nI
         yxjGEdY8KVd7mOQqqcLvW7Ulfk08dyXwRbEK73Bfyqp9iYxJw17MgaajcywaqawJi7
         9jxZN9lGUMeV7WdyS2zs6JioTcLTLAcetU5s+wmiqFW9eTSy7Kq7/XjBaWOjdlj9TN
         k1GFud0yKKlNpG6ylmZUh8t+sFJSZ/ZJsF/TeXAZqUAXHWs2csLsGo3EuTyiQEolSF
         v7xUG58eAW5sw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA6DDE68D31;
        Thu, 23 Feb 2023 23:16:42 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/crX1pmBC0wBefi@google.com>
References: <Y/crX1pmBC0wBefi@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/crX1pmBC0wBefi@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.3
X-PR-Tracked-Commit-Id: ad614f81d2e8b9704478921935c75ccd4024b854
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 025cf4dc5d76d89952eb29405f964c93cb13d7b9
Message-Id: <167719420276.30381.1223068334016242913.pr-tracker-bot@kernel.org>
Date:   Thu, 23 Feb 2023 23:16:42 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 09:01:19 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/025cf4dc5d76d89952eb29405f964c93cb13d7b9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
