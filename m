Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D968A22D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 19:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBCSp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 13:45:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjBCSpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 13:45:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF659A829
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 10:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E25DB82B6D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 18:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEE29C4339B;
        Fri,  3 Feb 2023 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675449916;
        bh=jQULm9r3FpT+fvxAr7YeNejU5uJaiysClB3lHLL2Bfo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=eahyT1X3MLzg5md53sBcpdnHW+C6y4w9B2JYMxMGyVWdq9z1MfGqGH9pTAdUms4E3
         J2smldsUq81jgtCs3VIi7Kxrv9fOIp471EuFsYA4im3/n2kdy92oTtdRw7hyAd989C
         r9Xn2De+KzfSgFhENgB/dJal+oheSCCph9fPg07UE/PH6JD8/vcuHtt2KrFE35BOB+
         +HStTXPNV7o3dGtKeGf18K1tLoLSmZdNwXeI5ErSCi5lSYvde1r7yRPu4dzB4tTeGF
         gKlxTf3so/4Ocvj+LAZIBy2213mysux89JjSanJPnUPFbfQt5hx5cnLISMNCpSb696
         mILymr1Z8OZSw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BA127E21ED0;
        Fri,  3 Feb 2023 18:45:16 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.2-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-6f088575-34c6-4eb6-a52b-5d23500cff6e@palmer-ri-x1c9>
References: <mhng-6f088575-34c6-4eb6-a52b-5d23500cff6e@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-6f088575-34c6-4eb6-a52b-5d23500cff6e@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc7
X-PR-Tracked-Commit-Id: 2f394c0e7d1129a35156e492bc8f445fb20f43ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a30df1ea94ad35c7b42d44199fe1376b4d648862
Message-Id: <167544991675.32203.10293247722020816439.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Feb 2023 18:45:16 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Feb 2023 07:26:53 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a30df1ea94ad35c7b42d44199fe1376b4d648862

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
