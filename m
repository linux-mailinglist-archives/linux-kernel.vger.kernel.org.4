Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280A574054B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjF0Uwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbjF0Uwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C1110D7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8C3D6123D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFF6C433D9;
        Tue, 27 Jun 2023 20:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899151;
        bh=1gD5onK9cvAMFwv2L6pj9RtElLs75yOCJBpMDKmUf4E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=pTGf+R8Roy4Xo+7N1fp9rm0ZYOdOgNs8Bp1UxEWvOMTirujSsHhd1nXfsil8XnLvB
         zNO+zXdssreZrhzS2xNxbgidrdlPOfVq+kaGJUozaMpNbbjvGmnZLHU/irOYtm8djd
         ZjqyQkT1+UruivVjV7sWHCyBUCo6GwUdfIvaTZ4l4XLeIl5yZvVylmou0NdAXeWa3J
         DXA99g3hu8Ug8TDULKuiVGghjMFU6M5PCX9zXZytAGgSf5+qf4ZGEKC/AgaaQxvz+O
         UiRnAH0yPMjwt1fo4HizoVQC1BRDzdRI/6Rl6MDmAFUnM+J2y6bPJKSjaW4hjd/lfu
         csmrjHAKCfiBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2CBE2E53807;
        Tue, 27 Jun 2023 20:52:31 +0000 (UTC)
Subject: Re: [GIT PULL] x86/sgx for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627144554.GJZJr2Iltg+EaduWjo@fat_crate.local>
References: <20230627144554.GJZJr2Iltg+EaduWjo@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627144554.GJZJr2Iltg+EaduWjo@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.5
X-PR-Tracked-Commit-Id: 1e327963cfab0e02eeeb0331178d6c353c959cd6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e8f75c0270d930ef675fee22d74d1a3250e96962
Message-Id: <168789915117.12194.8361749155879705912.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 20:52:31 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 27 Jun 2023 16:45:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sgx_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e8f75c0270d930ef675fee22d74d1a3250e96962

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
