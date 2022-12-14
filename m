Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E4664D372
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 00:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiLNX3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 18:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiLNX3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 18:29:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27FF4B989
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 15:27:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F6D061C55
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:27:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E3862C433EF;
        Wed, 14 Dec 2022 23:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671060427;
        bh=Bk/6T0xJfpqUaFErXxHCWGAyejbt5gi8N/dlodCrvmE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=O0npsNKRTBv7xdfSHEFonm1cec2iBIlthaHErQt+/sxSkxebLKQW2YCXAUgXATyTP
         BnR7mByArsCn7lje2HdIaycVcP3OHVtSv0JpB9YK/amdDU4oc1SyME8QqRnUaH82s9
         Vk5hwFOD3gIkYqxnP7AdPsOwLbxsmFoS2bFTkP9gT+8aik2iTvLRVH/amrLvLQxXoC
         u8Sbsp5oKoEjRa8vnuQm5X/qHyzkTkVU+/KTI7YD8GaXiU4MiXTa79u2VMCtYVFIn/
         dPMJbtjCmYkuWK+vIxWidIQjYaTuQj3fTrK4GHH9TXSizQV+vmhEHqNJjuU7YvngVR
         QCmoQQt5jz/jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1E1AC395EA;
        Wed, 14 Dec 2022 23:27:07 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.2 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-f76eb33c-7cc1-426f-8f29-37f6bb78baec@palmer-ri-x1c9>
References: <mhng-f76eb33c-7cc1-426f-8f29-37f6bb78baec@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-f76eb33c-7cc1-426f-8f29-37f6bb78baec@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-mw1
X-PR-Tracked-Commit-Id: 6e66e96e31b81fb08075d18a3e2c201f1e2171da
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eb67d239f3aa1711afb0a42eab50459d9f3d672e
Message-Id: <167106042785.23862.14625886517446517728.pr-tracker-bot@kernel.org>
Date:   Wed, 14 Dec 2022 23:27:07 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 14 Dec 2022 10:40:05 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.2-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eb67d239f3aa1711afb0a42eab50459d9f3d672e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
