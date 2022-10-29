Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A056124B8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJ2Rko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJ2Rkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:40:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EDA491E2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:40:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DFA9B80D3A
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 17:40:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102EBC433D6;
        Sat, 29 Oct 2022 17:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667065234;
        bh=lYagOyKb5yVvupfNOTAb95+iRFTKOiPV3Lgapdw5lzU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Cqd30bUl5fJMipLLzkuueHuX6ynDsDhdlSYgcfjUyOqb68lrTrq7Qk+C1rflsa1WS
         2oFoDgHBGVnaI1b8BmTIdeAyA/Z4l3AOTtPWdY692KFs1QJ44UDFOp/2cMxZBghYb7
         /XKr1BW2TRQs1QjH2m49N8f/itnfauHMiJwPvn1Y+hET29J9hHDURB512wtm2srWM1
         kuisACz4ZUcrAGpUNOlFnnNw2daDMc5rOFU5yWaogvfgu8VpVr2Ft5G2LghwYqtXYW
         Janq/BOyJAOc73RfStUmjPYY839hCVQ3h8VrYHnryXPiVw2ewecQ9xhAJjup8dUC4i
         U/4ZJN+XIm/qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2B51C4166D;
        Sat, 29 Oct 2022 17:40:33 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.1-3 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87zgdesy5y.fsf@mpe.ellerman.id.au>
References: <87zgdesy5y.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87zgdesy5y.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-3
X-PR-Tracked-Commit-Id: 65722736c3baf29e02e964a09e85c9ef71c48e8d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 91562cf99364dd29755988f3cc33ce9a46cd5b0a
Message-Id: <166706523398.17372.12855262120121557759.pr-tracker-bot@kernel.org>
Date:   Sat, 29 Oct 2022 17:40:33 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org, npiggin@gmail.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Oct 2022 21:48:41 +1100:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.1-3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/91562cf99364dd29755988f3cc33ce9a46cd5b0a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
