Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669555C0533
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 19:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiIURTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 13:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiIURTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 13:19:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0921FC4E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 10:19:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E3D616C3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 17:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02451C433D6;
        Wed, 21 Sep 2022 17:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663780769;
        bh=gbYOGCStePzlpXymksozfvPxgfWdFuT0ETfvmxbBGCw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=cavDqbP7DrxmdIT8l2hMTL4ZZY0Y0WvsaKhUI3xzESDZNPeyiydMztjt3pUUN0oy0
         IyD2cW4yBwl5kJEX4jnAZLLsHxE4lbw/PL5If5oUDLo5kSCcerRw9p9hn8inSOauHx
         dV3uXHBPRGZomGegaZd3v8T3zt0rS0+0tvlZdJRy9x+BRRySuTnoQThHBr00NUM5nr
         UtM5cFS6y/wr1rPjXBxKbaf7qPiuD3dBA1gL9fxM28oTx7QPtae2U6MMPsuZbFwuwf
         XqPjf2jjHfEoy+0CQFxnKrILurBp92KK7TNBZh2CmhMssfwY0xaAnHQlmsliKfKt5s
         y4C+j/KN9o9+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E1C8AE21ECF;
        Wed, 21 Sep 2022 17:19:28 +0000 (UTC)
Subject: Re: [GIT PULL] UML fixes for 6.0-rc7
From:   pr-tracker-bot@kernel.org
In-Reply-To: <1498364411.248529.1663778196892.JavaMail.zimbra@nod.at>
References: <1498364411.248529.1663778196892.JavaMail.zimbra@nod.at>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <1498364411.248529.1663778196892.JavaMail.zimbra@nod.at>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.0-rc7
X-PR-Tracked-Commit-Id: bd71558d585ac61cfd799db7f25e78dca404dd7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc164f4fb00a0abebdfff132f8bc7291a28f5401
Message-Id: <166378076891.11705.11776026051332194901.pr-tracker-bot@kernel.org>
Date:   Wed, 21 Sep 2022 17:19:28 +0000
To:     Richard Weinberger <richard@nod.at>
Cc:     torvalds <torvalds@linux-foundation.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed, 21 Sep 2022 18:36:36 +0200 (CEST):

> git://git.kernel.org/pub/scm/linux/kernel/git/uml/linux.git tags/for-linus-6.0-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc164f4fb00a0abebdfff132f8bc7291a28f5401

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
