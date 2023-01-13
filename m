Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE39F66994E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241288AbjAMOCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbjAMOBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:01:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FC995AB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A170E61DD3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 13:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E8C9C433EF;
        Fri, 13 Jan 2023 13:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673618307;
        bh=Q9S3tBnkISRvZNIZhLt77B9L22qFOfedXzGJwYRM5Q0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GBJNcwBRs5t3Lp2AQr/MjG1q/f5D8+Ln7eqUHzsQcjZQPXNgdglmJzNiwYeCOt7Ch
         U94OY3G2LZCqDwj17t3v/igxZC+btWhcmZ7uNOfvyhEhFe5TNLM6ke9t0vQ6ZarWXw
         SCH+eNg0Gq9ghn7HSz4+mRkmA4tvBPMite/U204li8vBogaoLLEIJOCe6b7M+UuoF2
         jTcP6Shz50tX6xKVLCzHuFKpWAhLnpWk8Cptk6+I/so3dFw9c9SNZY1KLAHpA0NyKr
         hLGlSUOIQPhpeK89a9+euApB5B34LvLRUftr08JMx7/yTNFYNy04hqJifwyKE3tsuA
         v1w0fQ4Bm+svQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F0C08C395C7;
        Fri, 13 Jan 2023 13:58:26 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230113102936.GA12734@willie-the-truck>
References: <20230113102936.GA12734@willie-the-truck>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20230113102936.GA12734@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 68a63a412d18bd2e2577c8928139f92541afa7a6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d45b832d6f41b003c1dee953096cfd4c6e5233b0
Message-Id: <167361830698.16011.15206526931402211485.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 13:58:26 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 13 Jan 2023 10:29:37 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d45b832d6f41b003c1dee953096cfd4c6e5233b0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
