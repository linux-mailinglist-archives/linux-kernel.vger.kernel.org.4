Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EAF36BEFE0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbjCQRjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCQRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:39:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6355065
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:38:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9665960F85
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 17:38:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06754C433EF;
        Fri, 17 Mar 2023 17:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679074729;
        bh=/GK69WOmeFghWy5LWrJHJwnxaWh9cZwuMfkbrUepWxw=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=kFNDvXlU5VtbHAfyLcWMmu+jmc8mJdnKFszhLncZZIXSyxHvXaTmFKP3DU3J/HSkb
         LeMfyy9PJ0WUE5Mt3OlVYjZCR03Ggo1pBqL9nmqtTftIwo9tlAlQtkkRkxMkatYvZG
         jghOY3hGjRKf2pDLh8/ZUUKOiqefMWi3bouhNZJbsbYx/fFfO8iv2LO7WbzvZO2PZt
         Gt1pBTOtAsivYBaXXldWmlz3JvHGps2Glbm7DCJAQ2D0MZT0V+shLjvkAHpE2YTXjQ
         nhoQ6VQ3HgulMKWFjLWDqs3Cw4ZBLM8y5XJd0G9oqqvFqmud9gb1xjpIuDPiJPZp8u
         jgaOsZJOS60gw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA26BE66CBF;
        Fri, 17 Mar 2023 17:38:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87cz58m54s.fsf@mpe.ellerman.id.au>
References: <87cz58m54s.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87cz58m54s.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-3
X-PR-Tracked-Commit-Id: f2c7e3562b4c4f1699acc1538ebf3e75f5cced35
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17adaeaed05b879964b1a72e4db87ebf3b2a38ba
Message-Id: <167907472895.9394.3576308926534908749.pr-tracker-bot@kernel.org>
Date:   Fri, 17 Mar 2023 17:38:48 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        rdunlap@infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ruscur@russell.cc
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 17 Mar 2023 14:24:51 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17adaeaed05b879964b1a72e4db87ebf3b2a38ba

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
