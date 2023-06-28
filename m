Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C932741A34
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjF1VKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjF1VJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:09:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680821FDC
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D856146F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 21:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F255C433C8;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687986574;
        bh=z+HoXU6rjSBSv86S4/GAJtmBn308b7Z91NBgfSIPLo8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=DueTKAfaGse3n6WJgCtnyb9umNi3/dV3MFG0AP982xrgQPrK10OD5GHhxZPRGjg/r
         c/AriTxnAEyMYGcCW7vFcDsGdEunCwC4CFnPWhftK4cVYgqAQVm6kkD5g1x4zzAr55
         iTSY2Pum4MzjRP8LH68z+vLXxqJyXrfgrQ/RZLkDxRSxW30qpDN6+N36NI0nEbeYUS
         qzeHzCjg765dck/lZ6f/y91+pvMvHZpIbp+erk4Bs7NXaWK4T6WMFjne2DXde0Z6xC
         oFdk0H1JggAB6hzzk/foVc3ovTQmq9u9++62isBFa61bjnJ7qw2Vxpbspnj6j78jiZ
         12sytkepGaqHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CD90E5380A;
        Wed, 28 Jun 2023 21:09:34 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626133308.E761FC433C0@smtp.kernel.org>
References: <20230626133308.E761FC433C0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626133308.E761FC433C0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.5
X-PR-Tracked-Commit-Id: d0c99ffe212679b338d12fe283964e6e43ce1501
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4171a9aa235988fc5cb19d84d493496cb73e6988
Message-Id: <168798657437.29247.18089035491028747135.pr-tracker-bot@kernel.org>
Date:   Wed, 28 Jun 2023 21:09:34 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 14:32:56 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4171a9aa235988fc5cb19d84d493496cb73e6988

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
