Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072A564BEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 22:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiLMV5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 16:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237017AbiLMVze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 16:55:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425E25C6E;
        Tue, 13 Dec 2022 13:54:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81AB161744;
        Tue, 13 Dec 2022 21:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E77AEC433F0;
        Tue, 13 Dec 2022 21:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670968439;
        bh=P1k/51A7KQ9Rnp1vDNzZmRTK4PMeOsDP3jt5PUORj0I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WL4EBS4A6/0Yv+QD6u6sfMeMhVeSUt6Luh5ZD9ZL1OEcEhcsraRqSR22buqIUDRZ5
         qUa2weqpckaMCDfmtNOvXQ9s/+2OvHlcJILFz+In/IcoevvbFfKVlBN6YMhkvyZ1sn
         JUUSpc1JXzR62D/IOs2vF2YOe9w+EUDOj6WNKlieopk2rSO8Fv1ahEJV89+U6a7ZmF
         TbSRRdM0gyNFREWXSHT+1y78B+VzD0SmsWocaYvaYIHM7xc3+osudUilgApBxif7uK
         xZV5GzYqsTuMAbaLBZxJk7yLEaYk5BtxfZzIozUVFTP7omMbIkdLtEnFKlnM0dnLeU
         TkNfQZAnRGupA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C92B2C41612;
        Tue, 13 Dec 2022 21:53:59 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221212131621.6AAC2C433F0@smtp.kernel.org>
References: <20221212131621.6AAC2C433F0@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221212131621.6AAC2C433F0@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2
X-PR-Tracked-Commit-Id: 3cf241c3d56ff19f5192cb42a025bc6582b6e8fa
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d0f3ad23cf4f4046e88eef92c608d43cad9e4f7e
Message-Id: <167096843982.13204.7190568082693527148.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 21:53:59 +0000
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

The pull request you sent on Mon, 12 Dec 2022 13:16:10 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d0f3ad23cf4f4046e88eef92c608d43cad9e4f7e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
