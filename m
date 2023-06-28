Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84FF740BC5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbjF1Im3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjF1IjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:39:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9253AA5
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC1ED6126E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2242EC433CA;
        Wed, 28 Jun 2023 04:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687927812;
        bh=NrI3YyFjQ7blO7nK6F3TMldEJrgTNfJnroF8IisetBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K9uddh2QQXbNVA6gOmt0x0BbgMUtTNvP6ryddXjHo4zJHd4CM9WXt6vpZBpbcO6Df
         cl9ijQNfK0RKtQ/4a0/04ewCdB4fUkff35TPNzz8mLuQ0iy1UDbt7esEow5K2zeQwW
         rKIiLLH1FeR8bGbA9oAGdn9dgbZd4GdxjTngAiVK4iVBwie3qzP5eWhX4DbtuXrZeK
         3HR8y9VIn4ZRbMQ94uLxLvf7IRoYTCDoBBtboIPDzwXR0idzHiQmYX+48ifmN9WGwx
         egkC4ujnI9/FKfwpWq2T4EBtUECJOzqmQykryuTSDeRFldg3ltU/RKNUzwdnlXG6Ok
         CkKFb3Tv6WqfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 045B2E537FE;
        Wed, 28 Jun 2023 04:50:12 +0000 (UTC)
Subject: Re: [GIT PULL] pstore updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202306271655.F397BDF@keescook>
References: <202306271655.F397BDF@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202306271655.F397BDF@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.5-rc1
X-PR-Tracked-Commit-Id: d97038d5ec2062733c1e016caf9baaf68cf64ea1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8ad78685ffa6e3836b5b32197bffb03ee3389bec
Message-Id: <168792781201.32196.14729678069635792413.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 04:50:12 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Kees Cook <keescook@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 16:55:18 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8ad78685ffa6e3836b5b32197bffb03ee3389bec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
