Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE66A7285
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 19:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjCASCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 13:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjCASCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 13:02:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202936FC0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 10:02:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52272B810CB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B1C6C4339E;
        Wed,  1 Mar 2023 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677693732;
        bh=6w36bUrMChLdaaMgoaOegrSqVnYO+72FGCjWIVC+j8o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GE7itJGz6Wkjx0BEcTqlh2V+7YDcazvuKQEmPkY0TvNHGsP3iWDSwU6wSWC/fwsKS
         BVNlCTxDiZHQMM12Zsm4l5BgSJEe2opmbOjYnnRH0MERZYq2UsT55ziv8y3HXTGxtg
         jzAYhh+X+/VJ4eUpFLciQzqIBL3Sy9YhRngU0+Pj86uLdBeDfg1RgM8jC+d/OZ5j6Y
         hERFdGrcmUYgAGYsOSv9q9fNOCuoHrBwCGz4zN/nTHwrtKDxbJRAMi8nE0f/N5seks
         x6uJ0/1++EO+y76/yOtfAgET1Vb/W7CcaweFoaeL6k8ZBW4zs4DV/zbKHKCeFAjPzz
         jdXfUWBHBOcug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 07C2FC395EC;
        Wed,  1 Mar 2023 18:02:12 +0000 (UTC)
Subject: Re: [GIT PULL] 9p patches for 6.3 merge window (part 1)
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
References: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y/+A/K4/2A8iRj2m@thundercleese.milagro.dyndns.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-for-linus-part1
X-PR-Tracked-Commit-Id: 89c58cb395ec0fb58df5475dced1093eaf5896ad
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3808330b20ee0b23e1e3c192610c3a2ee65605e9
Message-Id: <167769373202.10213.4551491206983692812.pr-tracker-bot@kernel.org>
Date:   Wed, 01 Mar 2023 18:02:12 +0000
To:     Eric Van Hensbergen <ericvh@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 1 Mar 2023 16:44:44 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.3-for-linus-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3808330b20ee0b23e1e3c192610c3a2ee65605e9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
