Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137806A2C8E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 00:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBYXWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 18:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjBYXWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 18:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5DBD14229;
        Sat, 25 Feb 2023 15:22:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E145B80B46;
        Sat, 25 Feb 2023 23:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B2F2C433D2;
        Sat, 25 Feb 2023 23:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677367329;
        bh=laxUjxKUL1KdFBI5/DZLgXrZDWAz4MZtnAzUt4/SxLM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jYpgHvyMEpi0iMzSn6aUzcEi74EEbjbjD0IsZa7aNmLcU3T81w5uCpF1n4bh122Tp
         B3+9sPO0CG3MY1vhPYegre10PnwXiA4st4NPJDGSv7w19xylQ6btRR7Tfg3h58rTH/
         EMe88QR9GBK6GWYUR22gj4ZvyLbGZGAwo4hs0LOgSGLy7KNbT4SoKCcxxEvCHNgXfO
         uss9Y2DV9NAzQ9njpWS9eqBBcXBiYdjQWwJWyycBa/AEg6bsEBxibtiKx7RpR8LpFx
         IhfaTn0lpiO7tCKKpIpXNggDfejnUm9Fg7DeADF7k6m46uBNDJcmkmFIIT4lDGgsTQ
         6GcLm66wYiVTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A0EBE68D26;
        Sat, 25 Feb 2023 23:22:09 +0000 (UTC)
Subject: Re: [GIT PULL] clk changes for the merge window
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230225044543.502452-1-sboyd@kernel.org>
References: <20230225044543.502452-1-sboyd@kernel.org>
X-PR-Tracked-List-Id: <linux-clk.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230225044543.502452-1-sboyd@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus
X-PR-Tracked-Commit-Id: b64baafa24d2c430513329daf5ebb821620d0c03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1ec35eadc3b448c91a6b763371a7073444e95f9d
Message-Id: <167736732916.9412.3213886750778915610.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 23:22:09 +0000
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 24 Feb 2023 20:45:42 -0800:

> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-for-linus

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1ec35eadc3b448c91a6b763371a7073444e95f9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
