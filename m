Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC776A2B7B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjBYTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBYTUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 14:20:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D943714997;
        Sat, 25 Feb 2023 11:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6601060B7A;
        Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38187C433D2;
        Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677352807;
        bh=tlR7u2eLf1X/KYtTz27gBp5RFZ8hvNlh84wj+7CPelk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=m/hP/Ge8G0iizl0xvRyTy2kAm4fI/U6xq9mqaA9O3fFq2l80XB2BS4WZEvb/sOH9V
         X5/cLa+bdf+QXYhIxnMz0+bOPQLAvJOgREQGWQ8exifQMnMgxUtNwZt6xyw+4F4ktx
         pHaSGGzwLKzoFY4TIiFiHWwR7ge584b+S+Y6kNzFaQe8hSglRUcY3WN6k+pNTbzXIK
         NC/X/qj3W7chwYlJzlsV5oXGbD+ZeI/xr0kebRSn19T+MF6d4pnRsh/DST2hEwFYiR
         dqOirXsuXb9v94q+Q2DJsUWbdUZJOVQpe3ArxZZNw/aw+rbLfMvc+jz4A186XOUS58
         ugOuFyZNXBizg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 25D91E68D34;
        Sat, 25 Feb 2023 19:20:07 +0000 (UTC)
Subject: Re: [GIT PULL] MIPS changes for v6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230223161025.GA11164@alpha.franken.de>
References: <20230223161025.GA11164@alpha.franken.de>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230223161025.GA11164@alpha.franken.de>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3
X-PR-Tracked-Commit-Id: 91dc288f4edf0d768e46c2c6d33e0ab703403459
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5596c6adb04d00cad445641a35f1f1745de57119
Message-Id: <167735280715.23615.1992103130769797465.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Feb 2023 19:20:07 +0000
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     torvalds@linux-foundation.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 23 Feb 2023 17:10:25 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5596c6adb04d00cad445641a35f1f1745de57119

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
