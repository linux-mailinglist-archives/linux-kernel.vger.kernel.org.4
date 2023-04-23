Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4267D6EC0E5
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 17:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjDWPuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 11:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjDWPuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 11:50:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508B01703
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 08:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91D361B2F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34801C4339C;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682265007;
        bh=RAK2Y5E7joyoSdc9wKdiICWB7SIT4ZB9sVQFcKA+an8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=HC2YM8uXEy6pH9+4m3rzQ2SezESLdy0V1Ai6AWIn9op2wjrrbpzNr2sWzkR3N87ea
         K46YRG5uXOyIOQX8CP6IHzGQ8tVxR8shz+c2Iz0iMQex1VQ3bUDt7CZG1u/5UcpnQz
         GQDnIti19HLnBhrNLlyxVfztbOdF/GiPQAFfrVJX88FUmDHWgIpR0u6DyYa2bYeCxw
         1ZUDKgpZrELjdJu0GmrNa1RptAEy5h/x/QcsgLAnmWimZKQ0CJJPpw1wq4KT3hhrKG
         SaZr8VThSIEIijkOVzno+nuRxDZdid7Eq6fiQuSI6XCPXyfQW1FykgXYLMxnXh2NBQ
         sK2xrPoDhzXqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 18619C395EA;
        Sun, 23 Apr 2023 15:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] irq/urgent for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230423102104.GBZEUGkAvxx4Yx/Ehc@fat_crate.local>
References: <20230423102104.GBZEUGkAvxx4Yx/Ehc@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230423102104.GBZEUGkAvxx4Yx/Ehc@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.3
X-PR-Tracked-Commit-Id: e3c026be4d3ca046799fde55ccbae9d0f059fb93
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5ad250f1fe92f21de09dabcd329e681d15aed9a4
Message-Id: <168226500709.30883.10992290951476916020.pr-tracker-bot@kernel.org>
Date:   Sun, 23 Apr 2023 15:50:07 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 23 Apr 2023 12:21:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5ad250f1fe92f21de09dabcd329e681d15aed9a4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
