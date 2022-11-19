Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2204B630FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 18:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiKSRPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 12:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbiKSROv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 12:14:51 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C1613F7D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 09:14:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B17BECE0ACC
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 17:14:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA222C433D7;
        Sat, 19 Nov 2022 17:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668878087;
        bh=ViUt861U9NZUfU0dUux6MCnqEVPqanlr7xe9etONFhw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QOSsu1MLeVUPuWsZN8PeiQ/p1y/q4ohqYJ5r8eWTWWhr5buwSw3Ks2wmQIUv6vO1v
         OklLyBWeJ3RxCSLcJ24EZlRRfVFpjJ1V7Q/NFy26gzmGIcvx578+ZPj0mMH80bTB88
         19vSZYjDwXa9lr0MDS1prvVHNCO5KjMt7IyhBOdYdoTRYxVfG7Y9DUpqpb7ITWZDnv
         p9+usT3oys50uaO6sY4Q2jajMv+zZAQlOwyQRkHfsmbZFvpw9vNy5tnO3yDhtpGGeI
         eVte0co5T2sYM8RDpLyiXw1znYMB/JvJacuiyiOyvYib5Q9BBYcfJE95b35rMeI0tX
         HT0AH1Sb+YHfg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C32E9E29F44;
        Sat, 19 Nov 2022 17:14:47 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.1-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y3kAl1vpndkuviqt@8bytes.org>
References: <Y3kAl1vpndkuviqt@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y3kAl1vpndkuviqt@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc5
X-PR-Tracked-Commit-Id: 7fc961cf7ffcb130c4e93ee9a5628134f9de700a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25
Message-Id: <166887808779.22538.16903428600473858764.pr-tracker-bot@kernel.org>
Date:   Sat, 19 Nov 2022 17:14:47 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 19 Nov 2022 17:13:11 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.1-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b6e7fdfd6f6a8bf88fcdb4a45da52c42ba238c25

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
