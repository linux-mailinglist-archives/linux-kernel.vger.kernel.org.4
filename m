Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725746F2A97
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbjD3UI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjD3UIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45B31707
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3A16105A
        for <linux-kernel@vger.kernel.org>; Sun, 30 Apr 2023 20:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2E4FC433EF;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682885290;
        bh=1r1D2D0Bq6g0xjD9HH4VPtVZQyARYm8kIxHx2+58W5A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OThqrb2lPnh8oiFucr+ZQjkNGWZadxPuTTIZYNKk0GBgGkkP6FwBgJs2ULGGZA4gA
         iTZdxqLNsEpP/OuXq40oekGJ8qlWmS7jQ2BnJ2o43kodde721M8soLltf79FvApksW
         h5JAg2ukXDCKgMNq0BnQ0DbM6eKL7AsLiMmlmTdDMB8EC01yqFgmU4QzrJpMO4lLCT
         RHee9HcDGc9e+h5BKYbwbOytX5yJ7okwEEkFojmYpdC8WdevQ278hTMxUWwzcpt7jx
         bWpCfacAA9YEOXNWyALcbhw/1M0yKiWFEYWy4OSUfSsURxVJ70gJmAIWenyh4STWNi
         V5e9yevT9yJhw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A367BE5FFC9;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Subject: Re: [git pull] IOMMU Updates for Linux v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
References: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZE5NR5Ml8I2/Ze0f@8bytes.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git pull-test
X-PR-Tracked-Commit-Id: e51b4198396cd715b140c0e8b259680429ff0cfb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
Message-Id: <168288529065.32747.7019505821134712516.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 20:08:10 +0000
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 30 Apr 2023 13:13:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git pull-test

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/58390c8ce1bddb6c623f62e7ed36383e7fa5c02f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
