Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4FB5FF3F6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiJNTNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 15:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiJNTNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 15:13:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F315190E78;
        Fri, 14 Oct 2022 12:13:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2CA61350;
        Fri, 14 Oct 2022 19:13:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8C554C433D6;
        Fri, 14 Oct 2022 19:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665774826;
        bh=QZ9EMOYyUwLdTvQtiz+ZBUfiLvvFj1z1eqmpQHmL0Vk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rZrsRmQ3YTnRKkfZr9iW7GkXR2ekeHXuzOe8Low4N2TxrZnfo6NrdmJD9NFY0Bg3n
         PIFo46v8P61/7aM86VS/01AG9rLyPtHrV66Pnu/7p3BWED7NqVa4q1pymJ+aPyJpig
         r06ZiEwhoKQSHOR/HtgJDCNQatfs4JW3kj3tv7pOHSyQ2bIL+u0SC57CKMzB+G6n+n
         vTJmMxAhspznFmz59i26f1KmDuvqS7OSuFBGxfKZtr3rh/iRYq1UqhBTeBkfMM0r0v
         bSuhqiVNxp4WV6/n1wCbrT4A4izJPDrpat/AQP79tbRFOJnAnV3cpw37IbyFDp1qF3
         sE2Cie1yV5glQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78600E4D00A;
        Fri, 14 Oct 2022 19:13:46 +0000 (UTC)
Subject: Re: [GIT PULL] parisc architecture fixes and enhancements for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y0mvXY9NMPyBfsNF@p100>
References: <Y0mvXY9NMPyBfsNF@p100>
X-PR-Tracked-List-Id: <linux-parisc.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y0mvXY9NMPyBfsNF@p100>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-1
X-PR-Tracked-Commit-Id: 34314cd615af5036e582fad14f2bb13e4383bfe1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f2e44139f3e0edb8be8821fe4dc93afd7b034182
Message-Id: <166577482647.24477.6095579070079517276.pr-tracker-bot@kernel.org>
Date:   Fri, 14 Oct 2022 19:13:46 +0000
To:     Helge Deller <deller@gmx.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 14 Oct 2022 20:50:05 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f2e44139f3e0edb8be8821fe4dc93afd7b034182

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
