Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1017406C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjF0XKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjF0XKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:10:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A64F297C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 670586123D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 23:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38753C433CC;
        Tue, 27 Jun 2023 23:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687907415;
        bh=yng0FmqgKRoBmPf/eooWitt8N2NyVf7Z939LZHz7L4M=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=jk2JGaIBYH30CQ8nYzHdI8GQNE4FsBYyS7QRDWce5o2xbnJbFJcj23X+c7ZIi3RS/
         ncABrrLEpfjFG0bzz4lcbefVQSLQuMv+yQ0oek6+vL++P/AOAuHZILmRRYuqSZ2Ogr
         fgkL362nzZy/2S68s+OExOpbOyXDPawH/tFma4rWyANykcbYqlK32Sk6aBphQJ8vxM
         V8wi7nX6lKsX1W5M7cnIlh2N+UBrdfpAOmRKdogZd/quUfQGgCM53mv8ihoXp6rzSG
         CNK+w6zOqUihHd2HbHlnMGKyoJwYaiPgrQHlUuvQraKDzS5AZuDSbkteqrIYeB3C9J
         lTZWDfwOkhSJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D412E5380A;
        Tue, 27 Jun 2023 23:10:15 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627060906.14981-1-jgross@suse.com>
References: <20230627060906.14981-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230627060906.14981-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc1-tag
X-PR-Tracked-Commit-Id: fb9b7b4b2b82d72031bff6d615215c1c74064bb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18eb3b6dff007f2e4ef4f0d8567dfb5cdb6086fc
Message-Id: <168790741504.21322.17901076437712757797.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 23:10:15 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 08:09:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.5-rc1-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18eb3b6dff007f2e4ef4f0d8567dfb5cdb6086fc

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
