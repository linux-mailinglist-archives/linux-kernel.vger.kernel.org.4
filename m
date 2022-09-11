Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319CC5B50E5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiIKThF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiIKThA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:37:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0170125585
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 12:37:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 920EB6106F
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 19:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED887C433C1;
        Sun, 11 Sep 2022 19:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662925019;
        bh=k52RZdITnjHKzViFr87ILbB+UqQ+VsI0+BlmL1LofTQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=YMBk+X/6q7LU1M7GSYKUbwCmmo0K2iqnbPT78XfWV528o9LMKIe/o6ODkClWNV2Vy
         A6YmiYt/7/RDEZCpiVAWOcJfWHQWkh5R168eiBK8QbvwfGzvDnyeWzC46nPSJDC+MU
         gVb8G+XS+2jOGwbbV76/DSvmTabsnWPgD6GinZhSeCo1+0EJMHZNqtJE6/ENblzZkl
         XomUtBU6SkRvNbfNcH8PHopcByc1x1QhACXavLTgQYF/8KSxL8U94MrcvhwrlJc8ab
         72atXEt9wo2K7gphq//0xsLVwFH4nk4MUWug3w5+wfO9iMsG/2GIrE6rOxx0QPA/h9
         OgQpCK1KwMF+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4D9FC73FF1;
        Sun, 11 Sep 2022 19:36:58 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fixes for -rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20220911113725.GA2070@willie-the-truck>
References: <20220911113725.GA2070@willie-the-truck>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20220911113725.GA2070@willie-the-truck>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes
X-PR-Tracked-Commit-Id: 3fe3fd5f30720b4afd3345cc186808125e7f5848
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 087aa69a9f2b2f1aaa173f976fec94058f623a9d
Message-Id: <166292501886.24843.13810703109696574312.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Sep 2022 19:36:58 +0000
To:     Will Deacon <will@kernel.org>
Cc:     torvalds@linux-foundation.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 11 Sep 2022 12:37:27 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/087aa69a9f2b2f1aaa173f976fec94058f623a9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
