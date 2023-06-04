Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902F72171E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjFDM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFDM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:58:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799B491
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 05:58:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1648E60A09
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 12:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D71DC433D2;
        Sun,  4 Jun 2023 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883528;
        bh=wZP56eCt8tUe4WOQ92fVMWrOVCz0JXlpUlcK7Utb43I=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OGCdCMDJL2pcZfe2WaWCpA6j0em0fs0eALBy+FqsKSMbh1RXpBdpDdyAaAy/RlTEC
         Ui36z+arOqiBFhnyWsdxTZBRSo7FUOgVGR5+4M+FMPhObeEdS1fw49AvRNHMqmUL1Z
         LSNrDNbhnnGZDxjj4pWvJx0Vg/32+S/7X3+/8NCR2tktsLmxdbvkD5tBjPyBj0vIli
         NId/Pf61RwKea/5agD8ECHIhFD4pzptU2948Lu3Vkis385SxWCPrrsqI6422fNP00h
         5pIc2Y8qJTno090zYU8Hz6m7NWuVpuX1E9XH29bIpBk7ofdKGrR31MTr+H4EjFQo1R
         nV54iTC0aN57g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59B91E29F3F;
        Sun,  4 Jun 2023 12:58:48 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87cz2cgj7b.fsf@mail.lhotse>
References: <87cz2cgj7b.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87cz2cgj7b.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-4
X-PR-Tracked-Commit-Id: 719dfd5925e186e09a2a6f23016936ac436f3d78
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9455b4b6db1e9b11d242595cc968332ecdd3cc91
Message-Id: <168588352834.18655.15577335638635726575.pr-tracker-bot@kernel.org>
Date:   Sun, 04 Jun 2023 12:58:48 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        gbatra@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maninder1.s@samsung.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 04 Jun 2023 10:33:12 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9455b4b6db1e9b11d242595cc968332ecdd3cc91

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
