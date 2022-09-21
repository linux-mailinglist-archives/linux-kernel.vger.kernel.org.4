Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059B5C0441
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 18:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiIUQeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 12:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiIUQdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 12:33:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716D5A1D26
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 09:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3B9D627C1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2499BC433B5;
        Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663776931;
        bh=JW+hViMKt1r6lWulLNKU+E16DgdeDjWXe+Jw1HYGLA0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mV+kd7T+f8L4bVzufECzLQEspc2/ZlGG6QwrN97Mf2hhw3BNFzv7x4YOSIMxfv3Ny
         P6MwA08HM47fARtsoQn4Cz8PzVERl8NI2dM8bGlfIvyP6Fc5wKfTybUlAqh55Hk7WJ
         tu4N3HEh5khtF6TCK8W2kwbrDO1irznoRHIkLlSs3ct7YRNiECqjaVq20Tw+pVVjJu
         oGecD1w/WKu+vfaEJoOW82tbm5Oi5wkGUlmy9TTpyxTpjvITwJ0IeaJngXzxCY8CVd
         ntWaneUTAUyPPfaoKyM7Fn72A2485OGUXadg3FzO0sq2pc/lew31ha5k7PfyUF507H
         HaiEVXWnvYu3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05291E4D03E;
        Wed, 21 Sep 2022 16:15:31 +0000 (UTC)
Subject: Re: [git pull] IOMMU Fixes for Linux v6.0-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YysBOff9ZGM/EfQh@8bytes.org>
References: <YysBOff9ZGM/EfQh@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YysBOff9ZGM/EfQh@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc6
X-PR-Tracked-Commit-Id: 154897807050c1161cb2660e502fc0470d46b986
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 06f7db9499937c6496d697a765ac05cdcd37f381
Message-Id: <166377693101.7162.6643161946869174835.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Sep 2022 16:15:31 +0000
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

The pull request you sent on Wed, 21 Sep 2022 14:19:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git tags/iommu-fixes-v6.0-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/06f7db9499937c6496d697a765ac05cdcd37f381

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
