Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01C573F106
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 04:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjF0C4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjF0C4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 22:56:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD0419A4;
        Mon, 26 Jun 2023 19:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8850A60FF6;
        Tue, 27 Jun 2023 02:56:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9B08C433CA;
        Tue, 27 Jun 2023 02:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687834576;
        bh=hsfUWJ0xkaQxSQXw1IsagHZ+KW0sSoMJ7zs1WEM1ciQ=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TxK0IQMM/PdvEeRm6tsaA5zZSmXDW3A+M2WuD4tm15+DoxzqJu1k1DxM+aGk2VrtL
         Cd3D9i7EepZQ7cq0kxIdOjYCNdJvWpI8hE/89DB+0cphXB9mt+B0p/5XPX7tsypfsP
         2wvkhJ7vqIWRu1rwAMfxRWu66Mdl4zMo7F/kq2TBScCe8HdEdnrQdAktWeH9kOGXpz
         BDH3cm/vVifNYpyBvQ1DBivYE95BEaqKMp9Noqseu29RNx6gJFaeSXWps9w84Jirlc
         DPTYLW1qi1Jk0QUUygzj4iwOkYqQQAvc+ZrzbGnofvC0GGqJa3ZpclIzXMNBaHxP9L
         I8ZLxORct4v4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C95F1E5380A;
        Tue, 27 Jun 2023 02:56:16 +0000 (UTC)
Subject: Re: [GIT PULL] Power management updates for v6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAJZ5v0iQk8ytZ0953_HCWU6Vr62J9UeC8Z9pirOHAfjpbvcOfg@mail.gmail.com>
References: <CAJZ5v0iQk8ytZ0953_HCWU6Vr62J9UeC8Z9pirOHAfjpbvcOfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAJZ5v0iQk8ytZ0953_HCWU6Vr62J9UeC8Z9pirOHAfjpbvcOfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc1
X-PR-Tracked-Commit-Id: c89a27f4f8fbf4dcbaf1738b42b8c68e160d7cda
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 40e8e98f512fc76891ae2328a63e2e4ffdbe3010
Message-Id: <168783457682.6991.3642465326113444679.pr-tracker-bot@kernel.org>
Date:   Tue, 27 Jun 2023 02:56:16 +0000
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 19:21:06 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/40e8e98f512fc76891ae2328a63e2e4ffdbe3010

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
