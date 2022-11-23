Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986576369D6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239588AbiKWTYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238859AbiKWTYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:24:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1AC604D;
        Wed, 23 Nov 2022 11:24:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F300B82465;
        Wed, 23 Nov 2022 19:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFA54C433D6;
        Wed, 23 Nov 2022 19:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669231460;
        bh=0Xv6hRd935ZkfNko0MKVnltSbedyCiqw414iUAfzvzE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TyjCnpF1jEctFcv9uvRqngj6SXPUwa5aSjdPivFrTkzgZQs28HfnSrbsoIgoSQBa1
         JGp/MC1UCMTIZ0/zEs5cM7Mcg19DZac9wQmRt1HdjuS12scHNFuCp0mE4tpK+wSHea
         8TJbf2FX6CfhLAZp/n2Yq0Iccjjm3NNO2UScjKBa0j96Z+MAKbm5c1wueNTYqG0vMC
         F9eLJWiMHH/qYTHcgCPNcO3SU/RZ7IBfKuWJHgdiQWIzlSK1mSLL/D4JRxUpdscxYs
         S4aefM17MmiGRestep+Ntmipbt62FH1csg950qx+juBTH28XRNN8rdEgF4use3WYj+
         pZRj4jWP8Ipjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8BF5C395ED;
        Wed, 23 Nov 2022 19:24:19 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.1-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221123160524.A4687C433C1@smtp.kernel.org>
References: <20221123160524.A4687C433C1@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221123160524.A4687C433C1@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc6
X-PR-Tracked-Commit-Id: e85e9e0d8cb759013d6474011c227f92e442d746
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4312098baf37ee17a8350725e6e0d0e8590252d4
Message-Id: <166923145988.2332.3821760036184874925.pr-tracker-bot@kernel.org>
Date:   Wed, 23 Nov 2022 19:24:19 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 23 Nov 2022 16:04:59 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.1-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4312098baf37ee17a8350725e6e0d0e8590252d4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
