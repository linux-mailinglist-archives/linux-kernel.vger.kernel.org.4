Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CC364EE70
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 17:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiLPQCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 11:02:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbiLPQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 11:02:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562407614C
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 08:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3864B6211F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A293C433F0;
        Fri, 16 Dec 2022 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671206419;
        bh=IQQv4b61wWwH7FPOrFTJ+BEEpYvJhL/dStpDWPLYSeY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L92uQR6NEfcqwdjGPuvZwBspyKvxgPal00paXGfAkj1oglvWbWuvBM0a/yVnS1QBi
         zGgq6Mk6CymTYL80N+C5xwcED0kz4xj415KQkDHkFxzwfLKUffQ/7QZw2Qf7lOoOok
         xEeDmHLfzwxdpdbNCVQHDdYy5+g8VJCYgACzVLMARhATJcxSw5Q6z08G+kgUPQen1r
         7ulXuIMyXLavgQPWAmOt80iCoUq+LhgROIioavaQranMLqLA6sbGWVcgmjOPMKeEur
         EqVqDNwHiZXHbRxaGNJGwYjV3JYAOI6okcbFAdpbrFAN2sPASmRLqqAiptq48WtXGz
         6bUd08VdTmS6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EC17FC00445;
        Fri, 16 Dec 2022 16:00:18 +0000 (UTC)
Subject: Re: [GIT PULL] Staging driver changes for 6.2-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5wv3SDxQMwtuKvx@kroah.com>
References: <Y5wv3SDxQMwtuKvx@kroah.com>
X-PR-Tracked-List-Id: <linux-staging.lists.linux.dev>
X-PR-Tracked-Message-Id: <Y5wv3SDxQMwtuKvx@kroah.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc1
X-PR-Tracked-Commit-Id: 37aa6b98237082a4bf882b4d986329b94ebd447d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b83a7080d30032cf70832bc2bb04cc342e203b88
Message-Id: <167120641896.30725.12946476742763105184.pr-tracker-bot@kernel.org>
Date:   Fri, 16 Dec 2022 16:00:18 +0000
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 09:44:13 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b83a7080d30032cf70832bc2bb04cc342e203b88

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
