Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBCB6F8DE8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjEFCUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjEFCUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:20:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307B96EAC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 19:20:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2A68641D5
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 02:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 238DFC433D2;
        Sat,  6 May 2023 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683339605;
        bh=iCUEk4aHnW9ogjaiR4yyuEnw2EQ9Wi1t3x0e1Y3g4/o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=q8WMTELR/+J/hGAVVh/Z7RlNbLybSxvXCwwiCiMvZ0Al7KcMeN6ZW2Q4Ixndi/fbF
         9S/RzmLjKzYF8GSRSAtxVsIqoLrEuNAVeSTbmN1gFoHiJUbjL4BtTbPb8OCO18cfCq
         pXHBCR4S3mvvDK8o1IOexRc1gcX6aoUvX7MtZ5MrdQwo8EYZt8g8DaRMgGAzXVwYEC
         mvNFX3IO/sGugbJLREk4Q/OykFPhuyaZ3j7NLxfVW0aUdseh27J2OOe4PACBisbghh
         9+JLDuxCi9kdwF4btrkBTy4vpOqtqjZIyoXcSH7rgGNN7YQjky0mDMROmYQzrzE/YL
         UgHK0Zd5m1pGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12090E5FFFA;
        Sat,  6 May 2023 02:20:05 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230505214917.1453870-1-kuba@kernel.org>
References: <20230505214917.1453870-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <netdev.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230505214917.1453870-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc1
X-PR-Tracked-Commit-Id: 644bca1d48139ad77570c24d22bafaf8e438cf03
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ed23734c23d2fc1e6a1ff80f8c2b82faeed0ed0c
Message-Id: <168333960506.28237.6227431350749436076.pr-tracker-bot@kernel.org>
Date:   Sat, 06 May 2023 02:20:05 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri,  5 May 2023 14:49:17 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ed23734c23d2fc1e6a1ff80f8c2b82faeed0ed0c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
