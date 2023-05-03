Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9BCE6F5DFF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 20:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjECSeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjECSdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 14:33:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B717DA9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 11:33:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 254876303F
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 18:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 854CEC4339C;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683138742;
        bh=b2r1Q2SNLjK6g8pCFt7CiZLCt9x/d2YtY62JfoeEQtY=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A0wBjpBcb4Vp19Q1wfDNJA0Mp0Bt/HozofjDsgCjfUA7+gWatx1Q2tbkvt8GPVQbu
         AuXw2CiqPeH1T2WWsNKR6ULI8D1qqZBCI7wl8udb4O+IYdkEBigJjYSOJan63aDym5
         2FCcK8B6zVQJhJPH0uuuofiZ7DeuT787qbyQXHNhPQgngDiJRoS96Z2glCsg/Z35xz
         KyS2SdhAU3UNb2lMLjfo8/x0AIZbyNFQOvwfFM1mjyc3MlnISAPPIQFKLJCWG65kL5
         +nK0ikUhhYCra2PhgiqV0ByA7rzA3kuN7K+b6MhJ52bxHP59N9o3pUsC9ZK8rRmVnk
         ICeIflSJkMuYg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 687A7C395FD;
        Wed,  3 May 2023 18:32:22 +0000 (UTC)
Subject: Re: [GIT PULL]; soundwire updates for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZFI8eBCZ1Nx6IpUk@matsya>
References: <ZFI8eBCZ1Nx6IpUk@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZFI8eBCZ1Nx6IpUk@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.4-rc1
X-PR-Tracked-Commit-Id: 67572c8dc64412880b81d4bbc2f354dd5eddaa7d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4c9818d8652b9824c73e456dd0d73ffba1d0e64d
Message-Id: <168313874242.23026.10093385272785929058.pr-tracker-bot@kernel.org>
Date:   Wed, 03 May 2023 18:32:22 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 3 May 2023 16:20:32 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-6.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4c9818d8652b9824c73e456dd0d73ffba1d0e64d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
