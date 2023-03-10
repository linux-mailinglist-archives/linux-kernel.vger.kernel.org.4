Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3656B4E77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbjCJR0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 12:26:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbjCJR0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 12:26:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FD1091C7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 09:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE47CB82383
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E26C433D2;
        Fri, 10 Mar 2023 17:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678469175;
        bh=7yDJIksP2pkD5A3LIju0IAc34idp1TL6F956poMuw9k=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BK1oXWYckL8LGBCJ1S00xqgZ/tciDQOUN/Idg8saL+6sf75aeAGHKrKpaeqRLlT0v
         ylzF3i5IZ+lvYv7n7sbRia58iKBU7+HDdkdpOY/DTLp+CQ8r5wqUw+hjfx83lUgyNv
         DhNopNy9/26An2QMIG6P4RbxJbPDWbiAz/h3gQm6TRtzFZT5gGlMTI6xZrKrpoMzsR
         ZuYwrvH3nep76yuJ2kdl4VIxlu5Z2MuIEMQHbfDCpi49iG74XSQBlKM2XwCU5IS6/D
         uA2yJQMqwfSPLSX2MizlfbBk/eQlsSrOH8mjq6cyYLVhlIdqssq0wTkNs/2wGnm/83
         OLwFqv49eQGcg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7859FC59A4C;
        Fri, 10 Mar 2023 17:26:15 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.3-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-6fd4abee-eb36-4748-9b07-d310908f08bb@palmer-ri-x1c9a>
References: <mhng-6fd4abee-eb36-4748-9b07-d310908f08bb@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-6fd4abee-eb36-4748-9b07-d310908f08bb@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc2
X-PR-Tracked-Commit-Id: 2a8db5ec4a28a0fce822d10224db9471a44b6925
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 55a21105ecc156495446d8ae75d7d73f66baed7b
Message-Id: <167846917548.3321.5405028351126348489.pr-tracker-bot@kernel.org>
Date:   Fri, 10 Mar 2023 17:26:15 +0000
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

The pull request you sent on Fri, 10 Mar 2023 08:46:41 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/55a21105ecc156495446d8ae75d7d73f66baed7b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
