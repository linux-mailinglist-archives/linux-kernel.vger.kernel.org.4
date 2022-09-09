Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F985B3EB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiIISQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiIISQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 14:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494BE10B011
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 11:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDAF86209E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 18:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8CCF9C433D6;
        Fri,  9 Sep 2022 18:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662747401;
        bh=ynniiHjprYhsTIWCLE1X1hNSPewlqP3YhOY6nNTZ//I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ph6IIM9Xhpmnie7zafAUNgg10GyQQfFHFml9OCzRhut91bKLnAlrmxWP8ATOLhNEG
         aTZY8FmsUggx4XjYX4AoCx8EhYMDpgVVFE64lXpytpibJz2wD89AA3BYkCswdv8zqR
         vh3ADToe6gCedt3sByfNof/7aWysRvXhBSCKoeWc48bCSMjB4nbAUWaLikRwsvyuCi
         Nd8+b1d/QdaC4TrxFaIvpi9vcDFxu8NwLqxX8SjMtlCet1IRT2H2qx0jZQUa877JwP
         NIzL+28PcrDIubvKLERB7T20E2BjpjlIZRzsqWh8bDwof3xSpI1JuEmZfIts8Ra0VI
         WZ6V8TQVm+/CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7A12AC4166E;
        Fri,  9 Sep 2022 18:16:41 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.0-rc5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-8b892856-b176-48da-8f9b-869810e0cf26@palmer-ri-x1c9>
References: <mhng-8b892856-b176-48da-8f9b-869810e0cf26@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-8b892856-b176-48da-8f9b-869810e0cf26@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc5
X-PR-Tracked-Commit-Id: 20e0fbab16003ae23a9e86a64bcb93e3121587ca
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 22b2e2d6ab35fdef4439e27da2df208014d52eda
Message-Id: <166274740148.9705.5282979394712829527.pr-tracker-bot@kernel.org>
Date:   Fri, 09 Sep 2022 18:16:41 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 09 Sep 2022 07:20:17 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.0-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/22b2e2d6ab35fdef4439e27da2df208014d52eda

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
