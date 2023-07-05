Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA269748E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbjGET5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjGET5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:57:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC2121;
        Wed,  5 Jul 2023 12:57:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EBD98616DE;
        Wed,  5 Jul 2023 19:57:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5DE5CC433C8;
        Wed,  5 Jul 2023 19:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688587052;
        bh=HeqnQ21oGR4OaPoBPjBZZM1sQhmNoQPEE/HJhGgBPeM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=hCwEd/zGXfM8J43f6yTwEvo39vwTN6DbKYA+wyyDi/oNLOYplJwQs9URnTKEJDX+S
         Yv50tSCMVYpdXGWlRxoiU5vjiBI4lOfvbY7NwoOeJFSVhprLrQKpRsfs0uQqidfwxS
         pBsKJtHcUkAg6GqzYSOoLPvXNC8ldjmjsssf6hIohID/7B981jXWTxRLrb68wdVi+g
         zTMfNZxyCJOVKA7U1JAbzakQuRW29osiUtJkXK1LLMcbL5rpZfSEvKPN8hHewf7jMS
         p6oUU3H0e1jhR7BauhZxakB3GUYh0I14bcO7tkYghciSRTn3B2dVfsAUoqOfINmW5j
         x7voGDu+oy3YA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A75EC0C40E;
        Wed,  5 Jul 2023 19:57:32 +0000 (UTC)
Subject: Re: [GIT PULL] pwm: Changes for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230705145632.2510377-1-thierry.reding@gmail.com>
References: <20230705145632.2510377-1-thierry.reding@gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230705145632.2510377-1-thierry.reding@gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.5-rc1
X-PR-Tracked-Commit-Id: 92554cdd428fce212d2a71a06939e7cab90f7c77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ace1ba1c9038b30f29c5759bc4726bbed7748f15
Message-Id: <168858705229.23936.12243479994391390576.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Jul 2023 19:57:32 +0000
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Jul 2023 16:56:31 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ace1ba1c9038b30f29c5759bc4726bbed7748f15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
