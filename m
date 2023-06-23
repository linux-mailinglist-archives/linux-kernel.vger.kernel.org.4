Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DFD73C4F5
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjFWXxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 19:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFWXxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 19:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4066C2706
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 16:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3E7D61159
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C671C433C8;
        Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687564400;
        bh=Prl0w0EvatYR2CD50Dj8a99X75vysBYpl8V1RITdtfo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WPLC6QAq4WasxldNpMG/nc86CDf5DsIDdmdgbvNnQyYWrt4r3/LsU+u9cFm4Dqs9Z
         98MWPK4loitQYKMSMJ3MlicydA5QSUlJfndq9GpEfl9pnrL1ItO2neWAQEPtOfX7DV
         SU7jS5C5gquFI3sF60uGQU0jcrUgvvHAj02vg+sVwxGETfiC6mVcS9TzD19jJNDoSX
         lrBsei78r69gAfs7kt5i8jQwLiNbiu0yFK6oloWgqqBzvy3I7TRJOWcQ4IDt0GLC/O
         kO7AZlrS+SXf2cE5vK65+Vp1kDUab/MbghNmGUM9LUvPdx0psFwLmSYXs3rdtkOqGx
         EEeFaLOttBR/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 274B0C43143;
        Fri, 23 Jun 2023 23:53:20 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.4-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJWd6uejO9mO65IX@8bytes.org>
References: <ZJWd6uejO9mO65IX@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJWd6uejO9mO65IX@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.4-rc7
X-PR-Tracked-Commit-Id: 5b00369fcf6d1ff9050b94800dc596925ff3623f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 917b3c7c0bcf82f62afc1d046352933bd68db931
Message-Id: <168756440015.22934.16962642794111444007.pr-tracker-bot@kernel.org>
Date:   Fri, 23 Jun 2023 23:53:20 +0000
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

The pull request you sent on Fri, 23 Jun 2023 15:28:10 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fix-v6.4-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/917b3c7c0bcf82f62afc1d046352933bd68db931

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
