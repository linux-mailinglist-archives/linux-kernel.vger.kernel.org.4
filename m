Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98C75F8148
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 01:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbiJGXiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 19:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJGXhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 19:37:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1088C9DDA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:37:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDF1CB82477
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 23:37:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88B01C43470;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665185870;
        bh=UT0fBj3Q/sSTm4mfK3K3G+RoC0C3koDkuE0Ecw+3nEI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=myee/WwgnPcvg3AJ4n8Nmka2aNIk5kpbj9UJ77hZt5hZPkQRjPXBNAVab7wwl51au
         t6L0qH/PBfOGVSti0VzlFtqoq0Qv4HQm8BC0PWXdEVydpwlyJNYz7ufdJ75tu2FW4h
         GOt6pCLHq93Mioq1r9QItZ1503c9Zd/wrIsbHElQkY5gV5Wlr7W4BaLYZHkc5dVho0
         VkuHGks65PHMbu24wY14yqjz6+P1fD07y9ENGM710Bnr331TFgTwAshQ+8hgPDgsgl
         TJWH3jEVt6mOiRZYqzwfQysbhYQMc/qith5DKUlxh8jcJ1l9qb0iehXQfft2JPKPzo
         SkxIClhwVa6Og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EE72E2A05C;
        Fri,  7 Oct 2022 23:37:50 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0Ak14T6qDHEq8bi@matsya>
References: <Y0Ak14T6qDHEq8bi@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0Ak14T6qDHEq8bi@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.1
X-PR-Tracked-Commit-Id: 9aa0dade8f6b4cdcbb114e1a06037939ee3238bc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 33e591dee915832c618cf68bb1058c8e7d296128
Message-Id: <166518587045.18327.1307511524367186977.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 23:37:50 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Oct 2022 18:38:39 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/33e591dee915832c618cf68bb1058c8e7d296128

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
