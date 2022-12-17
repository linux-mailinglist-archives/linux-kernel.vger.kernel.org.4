Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD11C64F95A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 15:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiLQO2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 09:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiLQO2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 09:28:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BD515831
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 06:28:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 968CCB80025
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 14:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63645C433F0;
        Sat, 17 Dec 2022 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671287303;
        bh=F3teeNkmhU0PCgjijZ0BqF7BnBPzlc+3V6j2oeWLb1A=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=WuPNvzREe6ko5qi87Pva4CYlfjwOXI9Kvz79LALKHHV9q1P9UzxlfWtw2R6/+xWEo
         mr6gHC9Hjnva3GDTI1rKhZJGzkCU27v2xe7+BAiChfxdDma7Gs+ABr6OgicNTxcIpz
         lG7ae0Dxikyjy1xe+5CXX79Ac2iXsqc6cVXstpAqL18JgZJYCLJRFFCflmJ7sIyt3U
         k4KyG2ufXvF4u7yjOFsSmdZzO+Gf2ZvVgMbHSUH5qYr7sQeNKXeZGABFk4cjRv+YfK
         PajbR1pjJr1YPQPm52OaqyMe50t7CaRp5RD8HQNyawUBOOvLFKxvDszpD3vcjuqRFf
         6w1mfvcigVNvA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51013E21EFC;
        Sat, 17 Dec 2022 14:28:23 +0000 (UTC)
Subject: Re: [GIT PULL] gfs2 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221216143317.668868-1-agruenba@redhat.com>
References: <20221216143317.668868-1-agruenba@redhat.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221216143317.668868-1-agruenba@redhat.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.1-rc7-fixes
X-PR-Tracked-Commit-Id: 6b46a06100dd0e0ebe400573e94ccd09163bfd5b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6830d50325ee27fbf0150f77cbec1ed304a5b8f6
Message-Id: <167128730332.18739.14355794267651380961.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Dec 2022 14:28:23 +0000
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel@redhat.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 16 Dec 2022 15:33:17 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tags/gfs2-v6.1-rc7-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6830d50325ee27fbf0150f77cbec1ed304a5b8f6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
