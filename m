Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561D76247E0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 18:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiKJRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 12:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbiKJRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 12:03:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1330E5599
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 09:03:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9BD3B8224A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 76BF7C433C1;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668099808;
        bh=JqjcwJ5MnkAs4iuw3TTnpB8D3xFVrTblNg8QcKn1S+c=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=CjlA8ADiLIvWSZtKHtK6S4PYRVnvblXkNwLqaF1+jV4TSElAMtPYYCAxh4nN0vbYw
         s1h89+R5oa8EZ9VY98b8iCTyPnivdeda4AnvY4CxojhBY5y0my0I5wGGgTfJ0Fa2Xr
         gXq39ueitCjRvVeDanp7LF1p9hdn6oS5EThuqS86a+YffSSZKSPc95HpjKtMfCLHrf
         B4fUSsVaKRiB9iQT2EN3C2mt6/wG2u/1egRq+IgC665+So5m0xXtMqPzwthiEILM7e
         aOKXwPUXsvqg0IfbAKOBWxrcbpEDLO9NWZb+hpR84h0NYdsvknLDte73lUzkB2is0F
         H6pkUIBEPseEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 609D8C395FD;
        Thu, 10 Nov 2022 17:03:28 +0000 (UTC)
Subject: Re: [GIT PULL]: Generic phy fixes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y2zGjvUEs1402DEw@matsya>
References: <Y2zGjvUEs1402DEw@matsya>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y2zGjvUEs1402DEw@matsya>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.1
X-PR-Tracked-Commit-Id: 819b885cd886c193782891c4f51bbcab3de119a4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8395ee62b1b78a3d2789840bf6bf1a7c43deaa32
Message-Id: <166809980839.1852.13706251158020656636.pr-tracker-bot@kernel.org>
Date:   Thu, 10 Nov 2022 17:03:28 +0000
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 10 Nov 2022 15:08:22 +0530:

> git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8395ee62b1b78a3d2789840bf6bf1a7c43deaa32

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
