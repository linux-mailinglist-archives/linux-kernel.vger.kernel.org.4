Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3486EE7D6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234954AbjDYSzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235094AbjDYSzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:55:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A101F17DC3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 787FF6312D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 18:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDDFDC4339C;
        Tue, 25 Apr 2023 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682448707;
        bh=GAJa3IObHZAI99dKeAZnyHcfE47+HfOYkRYg+1D/Aeo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QpVXP4Jc1rDaRbxb6acDOoPjuIBL57uWwt2BYmuhkIOeUk5WD0w433nqzevYH/boX
         P7yIk3pDCEeWVXl2jsCDxQwyEcNk+W/iXhYNeS5oGaipMB4ctzwH8j9P5UppQx0Chx
         +D3jUGtcDhuGZE7uj2nfXG/Be8uTe2XUBw+pkDUTsyJFTui5ABDFe+gLWU0zLgEi2C
         54UEm/Cm1Cn44v0BAfUDgJ/UoaZ7WvgO6PIWwlCEKLftKW+Y5w9+UhsModZEj/0wc6
         s0FyNCHQt7YJVSb4br5+dFC1yCVy9f+JvlpXjb1Shk/ZTO69qmUcJ/KW/HL/rZcIni
         xQ0K1+TagKMHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C50EBE5FFC5;
        Tue, 25 Apr 2023 18:51:47 +0000 (UTC)
Subject: Re: [GIT pull] irq/core for 6.4-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <168235969096.840202.4914424488387974308.tglx@xen13>
References: <168235968801.840202.17752066425816055574.tglx@xen13> <168235969096.840202.4914424488387974308.tglx@xen13>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <168235969096.840202.4914424488387974308.tglx@xen13>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-04-24
X-PR-Tracked-Commit-Id: f37202aa6e5d6d39a48f744d962fd2bf3a8a452b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3f614ab563c44fa443cbb6a7f355bdd04a5a4450
Message-Id: <168244870780.5918.11599613644956690550.pr-tracker-bot@kernel.org>
Date:   Tue, 25 Apr 2023 18:51:47 +0000
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 24 Apr 2023 20:13:26 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-core-2023-04-24

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3f614ab563c44fa443cbb6a7f355bdd04a5a4450

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
