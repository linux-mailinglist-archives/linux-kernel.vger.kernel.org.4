Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79B732628
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 06:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242708AbjFPERC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242728AbjFPEQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 00:16:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7F2976
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 21:16:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D02361D7D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:16:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D6BEC433CB;
        Fri, 16 Jun 2023 04:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686889005;
        bh=3YKd3SS9ibMMgdSfLYTMSYXk+EuiUD2alt/LfUjDHGM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UBR/AQJMHzN5nGqEaXj9/GQWlQInqsY/Ggjo0rJHqMbWXBj4PUIqY++EIW2ZoeGpn
         eVlWweB1rHdwQDC/8N1x3izTsr2hclf85vymk8Nkd7SjexGtzznAkMXURtKDPdIax6
         2Jbx2X7QHqdk59u5P9AcPEEi6/mBCxzLISNLvljOx7KKH3Pby++LBlv7DURmlt8i9x
         f0ANQoxbz+9+wPDHqdWf/qIhHigjiY7dyW72FuSBkqjF6TiCT7qhhWr3kpCYs0Kxyq
         izVTjfq5EaRLxWmafLnY5Sk9duHO0Cdz1t9jLjNk8yHMh+mgmG0NhcLvUZZfn8Fjsp
         lDgYWefLNT1NA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 341A5C3274B;
        Fri, 16 Jun 2023 04:16:45 +0000 (UTC)
Subject: Re: [GIT PULL] Networking for v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230615225716.1507720-1-kuba@kernel.org>
References: <20230615225716.1507720-1-kuba@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230615225716.1507720-1-kuba@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc7
X-PR-Tracked-Commit-Id: 8f0e3703571fe771d06235870ccbbf4ad41e63e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40f71e7cd3c6ac04293556ab0504a372393838ff
Message-Id: <168688900521.32380.13001680271505981059.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Jun 2023 04:16:45 +0000
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     torvalds@linux-foundation.org, kuba@kernel.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 15 Jun 2023 15:57:16 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git net-6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40f71e7cd3c6ac04293556ab0504a372393838ff

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
