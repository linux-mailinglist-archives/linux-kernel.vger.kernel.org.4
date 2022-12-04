Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309C6641FD7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 22:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiLDVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiLDVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 16:25:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E3E13CC9
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 13:25:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E174B80B96
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 21:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6CB0C433C1;
        Sun,  4 Dec 2022 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670189136;
        bh=ht9iWJeEyJTdrJieTaPOrLuJsJ4w2hAcMDkLDv2Xkvw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=BvtcxhOO677O2LtGREBjbXRe6KtHuGgG0tNZIqR06l/ugdW4Ap7D6dNczTjGanbmG
         HU6wDjVKwDiq0Vc97HkN67ghSPQ1oSJkDRNmOkFMvQPfl9VM0gLsVrT6CmC/1WO06s
         Ki7RuIJmqfh+1bjzmCS6IsGi1/yvk693pGy6TXS9NOb5aOYt9kaFTMFji02I+p0/yS
         QxOnCDSv+ZDxyntTHYST8enV093GlN26uB6HhxGphUSV4CVVgfi2EztObV/ZcPZV1t
         Mehmx5SrtdKMOOtUoehq2GxwILQPbj10CKNdn7CosSuDOYRtP651CMbFru5OcbPG1N
         2aSXKCM3jNtGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B01BFC41622;
        Sun,  4 Dec 2022 21:25:36 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-6 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87sfhvs3v2.fsf@mpe.ellerman.id.au>
References: <87sfhvs3v2.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87sfhvs3v2.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-6
X-PR-Tracked-Commit-Id: 2e7ec190a0e38aaa8a6d87fd5f804ec07947febc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae6bb71711713e7b6b2d9ed2af7318dc8ae5cfb2
Message-Id: <167018913671.1549.6783660245670189886.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Dec 2022 21:25:36 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 05 Dec 2022 00:19:45 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae6bb71711713e7b6b2d9ed2af7318dc8ae5cfb2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
