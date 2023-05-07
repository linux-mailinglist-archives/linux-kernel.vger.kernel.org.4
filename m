Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74D6F9AD0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 20:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbjEGSMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjEGSMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 14:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2BE4EDB;
        Sun,  7 May 2023 11:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 824A5616C9;
        Sun,  7 May 2023 18:12:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E482CC4339B;
        Sun,  7 May 2023 18:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683483133;
        bh=tI+b856dXIQEYxVncjfesUNAFqQkV68/vG1VyASOGFw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=r8D6uscFrIi43XGlZjxYS4/cdDfjmJSh1gTK7qrfOKw1KjWsHAhYIJLsmFbltvLwJ
         QesQd3nTuLl9O5SGejVLyfI/optMQTcrJOBiRz+xDDRg5iicVP4LPdobLbDJxfFaXc
         8OE0rbBoTE+vzrETJvBNXitEtrHl5jzqzprce75MjRxHJjsPBMGGSTD38f6CgEsVs0
         lnG3eKDy9amk22YPRMq/d0qPvfiFjUkh7sFjeF4RkJGLUyW8fyqh7wtSd3yrpGFl0s
         YAsdSrTUkYO2Io78NoEVA2ryKvbbR0Pa+UYGY7Bu5w+Gput89Ckg9Fb24O9oe/B1gO
         GZR3pAycuMTVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3036E5FFCC;
        Sun,  7 May 2023 18:12:12 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230507002734.1674632-1-sboyd@kernel.org>
References: <20230507002734.1674632-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230507002734.1674632-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: 31c6ed4e89187beef8fe2f979c8881ca94839427
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d6b8a8c49ad6afce23c2c65a3cda0a0ccd3eaf61
Message-Id: <168348313285.16669.2190463091670324864.pr-tracker-bot@kernel.org>
Date:   Sun, 07 May 2023 18:12:12 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat,  6 May 2023 17:27:34 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d6b8a8c49ad6afce23c2c65a3cda0a0ccd3eaf61

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
