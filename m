Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636155F6DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiJFTBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbiJFTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:00:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD9D12765
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D7F61A8D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B914C43470;
        Thu,  6 Oct 2022 19:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665082822;
        bh=/8EaopQIER4jWSL4+FFkf6kmjmOhaTUwRyo2xC771es=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=JDTVS/igd5fJ22ihliUf8k+OCIgw3oIAL7KwEgstS/ekUxq+hq9FZp6/ISatbyUeG
         h87V094X2tovK9CWqWd1MAGZiDgtiwtXeQm7AaiG8Ym426X89ekewezeOYJRpnjf6b
         cdp3Y0hz0YYouNdwOQGnx6jO9Y7KUulCAQt8wziUPOUilcBsL7P58PaGwX5oV7R0Yo
         YD0WH5DzJbX7YSpU2Gm17lTGNSeccJ6fhKRaAewV37p4TGeYYLbtEW6T8hf5PVCoKQ
         UnBef4KlI9Q3lnHQD8R1THwPA5bUK0+2XcrGEwYO+OVLD1RVq58EseKTHVkfTQqwx1
         H2HGAKaUX0xZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 22E4CE2A05F;
        Thu,  6 Oct 2022 19:00:22 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 updates for 6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221005144116.2256580-1-catalin.marinas@arm.com>
References: <20221005144116.2256580-1-catalin.marinas@arm.com>
X-PR-Tracked-List-Id: <linux-arm-kernel.lists.infradead.org>
X-PR-Tracked-Message-Id: <20221005144116.2256580-1-catalin.marinas@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream
X-PR-Tracked-Commit-Id: d2995249a2f72333a4ab4922ff3c42a76c023791
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 18fd049731e67651009f316195da9281b756f2cf
Message-Id: <166508282208.16472.12517332358220770164.pr-tracker-bot@kernel.org>
Date:   Thu, 06 Oct 2022 19:00:22 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Wed,  5 Oct 2022 15:41:16 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-upstream

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/18fd049731e67651009f316195da9281b756f2cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
