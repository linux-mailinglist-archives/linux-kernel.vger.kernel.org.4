Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44669FC92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbjBVT5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBVT4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:56:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3DF30D6;
        Wed, 22 Feb 2023 11:56:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52F3161556;
        Wed, 22 Feb 2023 19:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C84B9C433D2;
        Wed, 22 Feb 2023 19:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677095630;
        bh=+iIgJs6Xx46jI6pjgSiGv8VXM9HyrRtWv21ywwvW/wA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GLEXpiSaTe6KfqkxuIQEJRMLoe/WM1wktvpmrxNtqk7FXQP1VPWILBbf8d4Vh80Ab
         hvK2GFBH8Y+bfjsYSnldpk9w27JHDw0bkZmKPmjpHUcYNJtCEuRgJkSZAdYvrb2jnY
         MHSSpq+A2E/cM1p1P5bIwjeVDTRpsrVYTtR/JOp8tspS1AV8yWPiVRxp4/V/MPY3pM
         xGDjrWuppj0Ix3CCvmILLlgEUVxMiDUNtAuShc5mEzofUp0ImUS6bbstf80b+dCh48
         5CHv7yA3+9mk9EiP6TTGNktQcWpgiYyNPTHrqffDDJGlpA4rSepwmV8bmk5i/hBoK6
         SaLymM0l6jTLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE071C43151;
        Wed, 22 Feb 2023 19:53:50 +0000 (UTC)
Subject: Re: [GIT PULL] SPI updates for v6.2-rc8-abi
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230216131125.4A6FAC433D2@smtp.kernel.org>
References: <20230216131125.4A6FAC433D2@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230216131125.4A6FAC433D2@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi
X-PR-Tracked-Commit-Id: 80323599e33f9c19287a1a3707481fb157b27052
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2cca486cad4bf51da57cdad150697476a702ab69
Message-Id: <167709563070.30115.13456763822987476104.pr-tracker-bot@kernel.org>
Date:   Wed, 22 Feb 2023 19:53:50 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 16 Feb 2023 13:11:08 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-v6.2-rc8-abi

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2cca486cad4bf51da57cdad150697476a702ab69

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
