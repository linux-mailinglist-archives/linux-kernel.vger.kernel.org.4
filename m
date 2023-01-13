Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC866688AC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 01:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjAMAsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 19:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240369AbjAMAsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 19:48:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7486C6133B
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:48:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F3B5621E8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74801C433F0;
        Fri, 13 Jan 2023 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673570899;
        bh=FU5yKit5p//SKeorja80X9Jb/gpyvO/lOFikrwDWQv4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FY5CGGvJ4n5TmKgXhzDzTXmr5RzlbCLO6snnSa02rVHLm1bmG0ruq6HbDlpch9vo0
         Hz+km26bAq6gzSeAx2QrOvrYp9UnaLUX62WUBoUWmTFmXXidQcjHH5rIYT2sAwDCBR
         xEP2m4WiGtmcaY9VoH2/GH+74OUI6nC0GBY3YT3SexRfeA0H1wxrcXVvzY0wPwYUA7
         Hl/w+6OPPrnRalGiSUitC9owv4Pdq2qdXzXAyGPgC8LJ1C58OVAnAmeBkXxNQgXvTJ
         /GtMByWvbUZ05liYY4Z2srBJZfD3/BIf80E37LHgvX4aG7XQyveOUOBWbIdwuJaYGh
         DA8E/DMq6FnHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62452C395D4;
        Fri, 13 Jan 2023 00:48:19 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.2-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230111122501.21815-1-jgross@suse.com>
References: <20230111122501.21815-1-jgross@suse.com>
X-PR-Tracked-List-Id: Xen developer discussion <xen-devel.lists.xenproject.org>
X-PR-Tracked-Message-Id: <20230111122501.21815-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc4-tag
X-PR-Tracked-Commit-Id: f57034cedeb6e00256313a2a6ee67f974d709b0b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bad8c4a850eaf386df681d951e3afc06bf1c7cf8
Message-Id: <167357089939.28490.16784668804617629143.pr-tracker-bot@kernel.org>
Date:   Fri, 13 Jan 2023 00:48:19 +0000
To:     Juergen Gross <jgross@suse.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, sstabellini@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 11 Jan 2023 13:25:01 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.2-rc4-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bad8c4a850eaf386df681d951e3afc06bf1c7cf8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
