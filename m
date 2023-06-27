Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854BD740549
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjF0Uwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjF0Uwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:52:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024F10D2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 13:52:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C0E461239
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 20:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D17FEC433CB;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687899150;
        bh=ie5p4N13R+grYbU2YNTXrsN3iNRmaojajICJnDUdjDw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=tSAB3aXlqwJmGMRYzK4uGrL9ouOYNKBnK4Zp8i9hVCUurHx19gQwdeGHhddVaKcX9
         Hk6azRGZQcZ32Uo2CP0BKlIuqzgEmkaH4FPBWFDbLKVX5NyeMxuZDcVpCcq3o31Xer
         Ri7N/00PQipo9mZGX+a7CDQ4G2YlkR9eUdBJMiyvChRfcF8CPSsj5UOyKZZfsdCMso
         cVugXxBInMpwBB/ScU1zu6HqfH/qA7rws0T4BfEmjthDPZNqJEqpijtVR4semwQuP3
         36pNAqtAPI604E4RiaSARKSw1c384UfZTe8HZwzj9ebL6brHlAM052ed7xBljrhmqH
         sz7c+vM+AlK+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BDEA0E53807;
        Tue, 27 Jun 2023 20:52:30 +0000 (UTC)
Subject: Re: [GIT PULL] x86/mtrr for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230627115311.GEZJrNp+K+a3qqNKGO@fat_crate.local>
References: <20230627115311.GEZJrNp+K+a3qqNKGO@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230627115311.GEZJrNp+K+a3qqNKGO@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.5
X-PR-Tracked-Commit-Id: 30d65d1b19850c9bc8c17dba8ebe9be5e0c17054
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dc43fc753bb5946e91ccdce9f393074675379a00
Message-Id: <168789915077.12194.6090709055831726515.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 20:52:30 +0000
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

The pull request you sent on Tue, 27 Jun 2023 13:53:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_mtrr_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dc43fc753bb5946e91ccdce9f393074675379a00

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
