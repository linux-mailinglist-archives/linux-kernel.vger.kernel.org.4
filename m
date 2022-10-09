Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3095F8EED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJIVSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 17:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiJIVRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 17:17:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4FC65E7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 14:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66B87B80DC7
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 21:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 34CA0C433D6;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665350237;
        bh=Es/2BThmp7XL9RuYfTeRmgf9ulTqA+6Rk8+OCWEZxX4=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=K3IqbaA8YbbqC/5SWxODXo+2R6Efyz+DEfIkOGkQid4LDvMc+DP1c5nHy/ELHqx7P
         PtsS69NpVRTakM/w4/bs9aqtJ5BC7Opxx+Q1q1IkYa27tAqDtDcQaoD35teGN/on1S
         gpw31bwKWJjicILYGxas8HtxF2F2rMFukBfT6ag++0gjQhGSiS9e0lDNLtBlNs0L9T
         l4LJLGi4jJ09UYy5+qaccUi5fTyM8ah86YoOEWAoz3n2y4Eq0FtFQf+2IAE8gb/vgB
         c6p11ldQJ2NtYJrjU658Yutxa0Spt7ub3D4HBNrkyCrPWDjNDnrBFr72xq+2r2hVgr
         bEbN+7b/TEvBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 261F9C73FE7;
        Sun,  9 Oct 2022 21:17:17 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.1 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-6190fb79-f9f6-41bd-90f3-d4d6009d41a5@palmer-ri-x1c9>
References: <mhng-6190fb79-f9f6-41bd-90f3-d4d6009d41a5@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <mhng-6190fb79-f9f6-41bd-90f3-d4d6009d41a5@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw1
X-PR-Tracked-Commit-Id: 87f81e66e2e84c7e6056413703d732a99c20c09b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2e64066dab157ffcd0e9ec2ff631862e6e222876
Message-Id: <166535023715.11566.287602438367733555.pr-tracker-bot@kernel.org>
Date:   Sun, 09 Oct 2022 21:17:17 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 07 Oct 2022 10:47:57 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2e64066dab157ffcd0e9ec2ff631862e6e222876

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
