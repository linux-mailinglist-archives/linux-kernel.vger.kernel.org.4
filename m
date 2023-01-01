Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16E65AB2D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjAATaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 14:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjAATa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 14:30:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BD2BDF
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 11:30:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC1D60DF8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 19:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAF8BC433EF;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672601426;
        bh=8rueFuwtewjE8JEeLO02X/Ue4qnWsql2DW9s9EW+rJU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ep97MFySxTLuT2xSWSYnbfzWpg6H7WO0hObzG/ILenz+iHKXaAipyGq/SQwNfzZ9N
         kOmLgqruLrElMI4IL7kItJSGyImW9qETzfUTc6cBmMdQJd8EBaRJpvizAb/CGounXr
         Qw820sQFWIRs5bj/+Rov8MJRsACPBHTTO3l/Sg8UbuGeGbmHHGyWPTX0kOrB+mp3rk
         YxX8mMpN5EnAWck0JWCIdiEwMP1eX8Feo8DQ5Bk/asD4tstez7Rt6Os58+KPsoDJcR
         GawkySf9VgrZG/ia4lgscLUV/NDCu8SFT3yAnoq824zl3cMtqnA0nt0cjHfcPE/rkR
         QQLE7jKjROS3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D9509C395E0;
        Sun,  1 Jan 2023 19:30:25 +0000 (UTC)
Subject: Re: [GIT PULL] locking/urgent for v6.2-rc2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y7Gf65Z5S++WefTw@zn.tnic>
References: <Y7Gf65Z5S++WefTw@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y7Gf65Z5S++WefTw@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.2_rc2
X-PR-Tracked-Commit-Id: 94cd8fa09f5f1ebdd4e90964b08b7f2cc4b36c43
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95d248d16f9cb42de717367832cffa0f83e97fde
Message-Id: <167260142588.13445.11792462672695326544.pr-tracker-bot@kernel.org>
Date:   Sun, 01 Jan 2023 19:30:25 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 1 Jan 2023 15:59:55 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.2_rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95d248d16f9cb42de717367832cffa0f83e97fde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
