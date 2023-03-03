Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C875B6A9F7C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjCCSqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjCCSqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:46:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0495062DBA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:46:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C18261997
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:44:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B219BC433D2;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677869070;
        bh=QZevfkBmy4cNqiG2nfJQcvQiWgn6Oe3/Sv5wusq1rWo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=UPTds9wDuX74b997P7pERlSqgRiNSAY+BM7SXLlkM8UdUHyL1twoYxM4633n1o65O
         uQ64VC/t4eoWxzk3/wHEwEOiSv+fxUqH46e0zKHydf98vMyeI/vmkAGOWAt676hUIe
         QMCK0+OXRf8NLqaIC5K/gfNOig01IrpWGhhcAYuiMwk1vxCRhULqAKbPBPVJ2kGB9b
         nNgZEvlMQNMAoZ40WBHMYQJgjlRBvxYyMh6R/6mMEw5RycWQQsEy2yuA+9nZAthLd/
         tJ0SF9acrSN/maO5PIDH8ghQkdWWwS+8mb6HX1x22kh1w1JSD+XALclbzPoxvlszbZ
         xjMJkEZ2GxpwA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 99561E68D5C;
        Fri,  3 Mar 2023 18:44:30 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.3 Merge Window, Part 2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-030bb7f3-2a9b-4061-8f41-e3e20c9b1671@palmer-ri-x1c9>
References: <mhng-030bb7f3-2a9b-4061-8f41-e3e20c9b1671@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-030bb7f3-2a9b-4061-8f41-e3e20c9b1671@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-mw2
X-PR-Tracked-Commit-Id: 61fc1ee8be26bc192d691932b0a67eabee45d12f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: bf1a1bad82407ad81130c065f6495ec0f939ae60
Message-Id: <167786907062.30023.15883158873202816895.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 18:44:30 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 03 Mar 2023 01:22:11 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.3-mw2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/bf1a1bad82407ad81130c065f6495ec0f939ae60

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
