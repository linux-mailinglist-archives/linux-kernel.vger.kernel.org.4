Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D678C74412D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjF3RZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbjF3RYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:24:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD8619BA
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86DA2618F5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 17:23:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E80D4C433C9;
        Fri, 30 Jun 2023 17:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688145835;
        bh=2KR4I/Ss9VfGmV70PDMEpHvWyGrJiuTM1ywp8HOpPVI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=A6lxMDwH1UFKsx05ipSY/faG36hnga3If0owidP4M55sTcsRfkO1paTlp/XO4sxj5
         t81no3w6IjTUzFmXUTdKTiyfCeFM819oeLVE+e2QQN+JnMOvgIQd6xt/AJFs2haP0D
         R2Igx7Bbz8hnmkFiJSlOHhaqshzm83/lVULUnbpaMxEpJpiCT9V6DXxHhCJGOvHwLJ
         BUCV73A3NBLVB1GaDzEhOrMaxTnrnTRae37SvuLOWFnfh2lJYF7aEKaaXO4dZ5R+sX
         G2YQaURuu9yEdr3lcR2ehgN+ofz25vOyu9B4HsBNtkkZUUdFXCi2WYzs2NOgS6/+q9
         NiQE96nZUbMzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5441C43158;
        Fri, 30 Jun 2023 17:23:55 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Patches for the 6.5 Merge Window, Part 1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
References: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-ebcc1b82-5dd0-4f2d-824e-8d9250374abf@palmer-ri-x1c9>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw1
X-PR-Tracked-Commit-Id: 488833ccdcac118da16701f4ee0673b20ba47fe3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 533925cb760431cb496a8c965cfd765a1a21d37e
Message-Id: <168814583586.9404.258443610866190315.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Jun 2023 17:23:55 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 08:40:50 -0700 (PDT):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.5-mw1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/533925cb760431cb496a8c965cfd765a1a21d37e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
