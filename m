Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6461770AFAE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 20:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjEUS6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 14:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjEUS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 14:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA926B6
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 11:58:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4825E60EDF
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2F85C433D2;
        Sun, 21 May 2023 18:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684695521;
        bh=/s+nj4hdgdCkFS6k/Y91Lo9lSdTRhEiF1cAVjbNKp98=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Q4IKUq+LjbsrBELU3zbg5iESlWI4RcGbbatLRSx8kMTDLWpu9e10OGGplWfpsSoVx
         JTLkN7Ewwq1FrndFW94aGdM4V0MPkgaYa6PopwKqZKmE4gXaj8YjJcQ/le8QUDR50q
         bs0M+jWkvaHknJZWl+6W8o5mspEx/KMXFTMUT288YMgpYdkd3RfpeW2aLhghgt2rel
         SF8IhUCSEUogud77gytU5+TwQ4SpVJoEkhNo3RT5TdINnNblu2UQx/fy0lB9UyiqsQ
         +jz3sQVDCiv3z54gcyvzE0y7BqpndWyrJBlDVDAQQd5fL8uAZw1ZpRFNFvECZ/FsF7
         DMgUpGD3xHbJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90033C41672;
        Sun, 21 May 2023 18:58:41 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.4-2 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lehizbq1.fsf@mail.lhotse>
References: <87lehizbq1.fsf@mail.lhotse>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <87lehizbq1.fsf@mail.lhotse>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-2
X-PR-Tracked-Commit-Id: 1f7aacc5eb9ed2cc17be7a90da5cd559effb9d59
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4927cb98f0eeaa5dbeac882e8372f4b16dc62624
Message-Id: <168469552158.22409.5910069869296532022.pr-tracker-bot@kernel.org>
Date:   Sun, 21 May 2023 18:58:41 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        gbatra@linux.vnet.ibm.com, hbathini@linux.ibm.com, jgg@nvidia.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathan@kernel.org, rdunlap@infradead.org, robh@kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 21 May 2023 11:59:02 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.4-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4927cb98f0eeaa5dbeac882e8372f4b16dc62624

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
