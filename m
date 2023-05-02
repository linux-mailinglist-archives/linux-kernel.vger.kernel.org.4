Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2336F4D50
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 00:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjEBW7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjEBW7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 18:59:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D164481;
        Tue,  2 May 2023 15:58:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A16E62A20;
        Tue,  2 May 2023 22:50:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87E9BC433EF;
        Tue,  2 May 2023 22:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683067800;
        bh=991SvigG+kU0Z/u6B0wlJjM3uDLXg6cFN/gcnrmlkS4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tWaHbArUCggSJyvRJB7EzrADdUKORXa1MHhOWRstVukem3+9BDp9eInN8qmRfYumw
         aaad26Q6JSAwZj7tIfwxk/k9THvVMZVenwYjjn+hmmSNUgDae4GUREq9gff6aXo3V3
         KiIzVL/VTCZWteJAr7mp4kpN+gEBauvAeXbkYuse3kTsYaIxMcgvX3muiKoLw3LJA8
         DqprJq/ot9e1ZCMCyzNMS3vdiu8Mse5KezOhRZl8FhvSmt2REgnAl6/5jEUZbMXGU0
         4shV6mvajC7H2vO/gwNKB4bvvWE9M2pHbz6hIO9/ICp01aEZHUJCkWDpxG7KfLDBbX
         BawLahgcDIeuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74801C41677;
        Tue,  2 May 2023 22:50:00 +0000 (UTC)
Subject: Re: [GIT PULL] pin control bulk changes for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
References: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CACRpkdZ=bpsSKKgqGbGThvVAZc8fEx2vStbm9GUaZ5s1p5YGmQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.4-1
X-PR-Tracked-Commit-Id: b7badd752de05312fdb1aeb388480f706d0c087f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 348551ddaf311c76b01cdcbaf61b6fef06a49144
Message-Id: <168306780046.4082.4222056325406889872.pr-tracker-bot@kernel.org>
Date:   Tue, 02 May 2023 22:50:00 +0000
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 2 May 2023 22:29:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git tags/pinctrl-v6.4-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/348551ddaf311c76b01cdcbaf61b6fef06a49144

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
