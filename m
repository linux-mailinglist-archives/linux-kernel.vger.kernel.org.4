Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A8C5B50E6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIKThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIKThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:37:02 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B20124BC8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 12:37:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 98505CE0D9B
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8176C433D7;
        Sun, 11 Sep 2022 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662925018;
        bh=eTos0eDJdtt2fJTQCA5fj9y11CKl1aqrN65B9927ehM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FFlSbb+gqV6yIy6yKM20Rw/wTB6kvtSSbXFp/VvLiZJpiO37yr4GZMmRiff1fs71r
         sibGpknM3MrYjzK/aov7BD7q2HLgnUrYCGl3PSd2pUN2+InwRkxPN0nPq4sii0UunY
         3ZqMKwGXcGeHrKCfsdn8Zozt8k3pbpjZE/+JYYSvDxQ8Gi5aWsW02AgoMcahNFtrAa
         cwqHhPWNZJTKf+KoSEFFfM/int3txTwqNRtt2Q0JzMA21pNqXgexfnbGAAWpM/40BV
         PpeN0pTFe8HrejAqgqm3+TifXKClSqijwXJB7HKM2ChlwrtFEjVetXx0nJ1dJQpUS8
         XM5NJYXukb1GQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BF677C73FF0;
        Sun, 11 Sep 2022 19:36:58 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.0-rc4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Yx2Otdo+oqAeDG6s@8bytes.org>
References: <Yx2Otdo+oqAeDG6s@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Yx2Otdo+oqAeDG6s@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc4
X-PR-Tracked-Commit-Id: 2380f1e8195ef612deea1dc7a3d611c5d2b9b56a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2ccd4502f512e04b6cc01995da730e8754529cf9
Message-Id: <166292501878.24843.5844761897401885517.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Sep 2022 19:36:58 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Sep 2022 09:31:01 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2ccd4502f512e04b6cc01995da730e8754529cf9

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
