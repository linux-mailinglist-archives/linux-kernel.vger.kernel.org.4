Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3BB675E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 21:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjATUGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 15:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjATUGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 15:06:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4651564B2;
        Fri, 20 Jan 2023 12:06:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 786A5B829C5;
        Fri, 20 Jan 2023 20:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B0DAC4339E;
        Fri, 20 Jan 2023 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674245198;
        bh=9FpkTMZ4vPmTaiZSV8NQesNFe1X+ADoJNqRjtkmtaV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FT3ODCNiB+dRSCtxSH2N7Ws1dEVEnMs7+ot6EwxBTwloIDDg1vc/traP+E4CFiFYn
         BEx0diB7eGpu56empc4ZAisdU5oROCGdcKliVUfxeuZj093oEDgKAhf/TNwHWGDKc3
         iusDH8cc7gNnnSUmmWvjyrKF2KXkHcA4gHTHwVyPmubsy+IylqhVup8e4c4/WCl6pX
         HpdyAvr9fRwnPEnvgvaCmx1CxdhO4vroQs7lzLuUbP3/GBW49rPcVFAE8qIhHv0gUL
         dxJ1QIUv5v6d6pacBcFd4C+swUNpFjewM7rC7T0FYSTtG5ZIlAgSbwOQXPQd/OxlsE
         zW3KJd1ebn4eQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A421E54D2B;
        Fri, 20 Jan 2023 20:06:38 +0000 (UTC)
Subject: Re: [GIT PULL] MMC fixes for v6.2-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230120102654.113502-1-ulf.hansson@linaro.org>
References: <20230120102654.113502-1-ulf.hansson@linaro.org>
X-PR-Tracked-List-Id: <linux-mmc.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230120102654.113502-1-ulf.hansson@linaro.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc2
X-PR-Tracked-Commit-Id: 8509419758f2cc28dd05370385af0d91573b76b4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 1670d7e69b044e900bb6a3d57a03c9202ea387ae
Message-Id: <167424519810.30775.5642125600185940057.pr-tracker-bot@kernel.org>
Date:   Fri, 20 Jan 2023 20:06:38 +0000
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 20 Jan 2023 11:26:54 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.2-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/1670d7e69b044e900bb6a3d57a03c9202ea387ae

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
