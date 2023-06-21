Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E696F738D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjFURjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjFURjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:39:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065861BC;
        Wed, 21 Jun 2023 10:39:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EBEF61654;
        Wed, 21 Jun 2023 17:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E745EC433CB;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687369146;
        bh=DVNeAJO6Dgu8FDtvT21kR6U2wQb981RxOa6r9gYEPjA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=P84uHmlE8LtkMjgQH842tZb60Y7vCKvLbU13rb8n+/aFIovxwF6Fxza0aIl02I89b
         m6G8uIuk7F/nFHKH5DchLTnB1IMpEGrBpfPs4Q/O49e3VrEt3wRp6J4yoAOqHS7zSp
         gSQsfDnK91wTXdPMhWgRQHkz6tKsMaaVomNcHMNwDB+Yk1QYlM7eF7pTh8f1SPsiut
         AZrG7Yvl8EQ1XKeaujylEi1YpX5WBt/CAcccVabCagqX12a8SUqfPgfWpZ5JRtm60M
         riphZEVD0rAEB530sdKsl8Udh+EDjsuqK8VR1ML4vSWwzzIUhRpeINTknyNbq9ku6v
         AXuX1DQ35uYYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C6BFAE45226;
        Wed, 21 Jun 2023 17:39:06 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230621132404.E6CB1C433C9@smtp.kernel.org>
References: <20230621132404.E6CB1C433C9@smtp.kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230621132404.E6CB1C433C9@smtp.kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc7
X-PR-Tracked-Commit-Id: 9d7054fb3ac2e8d252aae1268f20623f244e644f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2214170caabbff673935eb046a7edf4621213931
Message-Id: <168736914680.5231.5830283319897263285.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Jun 2023 17:39:06 +0000
To:     Mark Brown <broonie@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Jun 2023 14:23:50 +0100:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2214170caabbff673935eb046a7edf4621213931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
