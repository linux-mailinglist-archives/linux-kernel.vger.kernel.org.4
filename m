Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A90F5F4DE0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 04:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiJECoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 22:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJECoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 22:44:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7DE72840
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 19:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2CC961582
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:41:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44EBDC433D7;
        Wed,  5 Oct 2022 02:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664937709;
        bh=9Aw+9pcL3K46Mv6lYyJ6FRV3rDCYunO4q6qpSD6c0Rk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tkr1I/YOpyCtM2c35EXLC0XNHVft8av8+B5jyIDv0fgG1RenhvHW2gGA/PRp/3iT6
         DS6BLqhdQri6E5i9cMP09ToJGDPZbhMlcnomPqAY/TNHCLvOJU+4WbgLB/QpLCdeUJ
         JYXv4PpIj1O7YozqbbyKmqDOPk9M5l6psrQ8zUSEo1ZhdMZj8GXHQDpXLNd88/ZOBi
         h+U8Pr4PTl9kn80K5dEiPuNXjcbkwyXrQfUowGvy3N+Z9FbgR5TRG1rGeXXKvvXtd0
         i/1lo7k2HDSM1tybv2pGOgQN1iIZnt+vByEt/9jhs/K024v5RvR/MAwsOROLaq7qsi
         NszhApH+j6wMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A3E7E21EC2;
        Wed,  5 Oct 2022 02:41:49 +0000 (UTC)
Subject: Re: [GIT PULL] regmap updates for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221003124639.E723CC433D6@smtp.kernel.org>
References: <20221003124639.E723CC433D6@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221003124639.E723CC433D6@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.1
X-PR-Tracked-Commit-Id: 01ed230761e51f0403b3f3845c11cb67014487e2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 521d04e3c8a7dda4ed1ee1630e92d370688f6b33
Message-Id: <166493770916.5416.13046004198697036694.pr-tracker-bot@kernel.org>
Date:   Wed, 05 Oct 2022 02:41:49 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 03 Oct 2022 13:46:22 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git tags/regmap-v6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/521d04e3c8a7dda4ed1ee1630e92d370688f6b33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
