Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F765E7FB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbiIWQ0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiIWQ0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:26:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655FB121652
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:25:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9AF462881
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 566B5C433D6;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663950358;
        bh=6/yGaslh/dWxXVkqzgI2Ad98VykwZ0oCykFFp4Op0dU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mwkx+tZTkiJZ751ZhEz9dTJAbsuX1oEKXQ9ePnGwk+CGKv07L7UHhJA1eTbyY1/2U
         egmkaxwaMvTyZvJeq686QPAoeXk0MlSR0axayui2VfHeRBGw55xZwSE0gx5MBMbK8N
         mTtffgToBjAuuV71nw2dHE/GKK3ZwtU0HJTP4UVvEyugk78tlcqBZUu+dWBo4JdbKV
         ztzwLCxupIszpIW071AHdcWLqc4NJTALEgHDkinmZXfU+zIemamGNAbJcMkbgqjcK6
         QFz/cRay04/8BDwZDmR5NbLEuNURjR3ek2IRTY4OVo1RIyE4659WdUeqmPqqQ+ppBI
         OqQ1wEZ2V3C9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D3B1E4D03A;
        Fri, 23 Sep 2022 16:25:58 +0000 (UTC)
Subject: Re: [GIT PULL] xen: branch for v6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220923084007.22001-1-jgross@suse.com>
References: <20220923084007.22001-1-jgross@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220923084007.22001-1-jgross@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc7-tag
X-PR-Tracked-Commit-Id: ce6b8ccdef959ba86b2711e090e84a987a000bf7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 526e8262856027cea38c45a5ff45fbe4204aed04
Message-Id: <166395035824.8411.4093321633967293739.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Sep 2022 16:25:58 +0000
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

The pull request you sent on Fri, 23 Sep 2022 10:40:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git for-linus-6.0-rc7-tag

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/526e8262856027cea38c45a5ff45fbe4204aed04

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
