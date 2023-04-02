Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFE86D39AB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDBSCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDBSCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:02:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D98D520
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 432A5B80F4B
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 18:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C52CC4339C;
        Sun,  2 Apr 2023 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680458526;
        bh=OlZXiUfmDAaznyUbKDn1oUOJ1mFDgynyKFyPsT0bDK8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=mt2VCAPMjKWu+mU205Lzup7XhhFW/omfwTuElDc0hA9CuZ8e6Pc6WU/oLr24SI7aW
         vMpff6Y/QMAqszv0KXuiQGVkq7IonktANQaCer2CYbV5iHaQGtA01kf0Rbf+QZ+Prv
         rCUQJCYIhKyRWL2A1bJkNpw9g00u2ptJRhuL+nTJ9M2AZ6Zr7KgcP/JUufpuxTg9mA
         Arq8T8YAApIGpfxux0asVMLXRx3ez0m5WwJW6WcKiBMCpPfFQQDWEnwVJPYN0uE9uA
         Hm0rUeKdSS+csNl5KfGEI5ZEzJ6XN+BOV53MsAXfa8D7B+jQR1UMbbX2HPRpwapvZT
         hFh105o97Op6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EE6C6C73FE0;
        Sun,  2 Apr 2023 18:02:05 +0000 (UTC)
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-6.3-4 tag
From:   pr-tracker-bot@kernel.org
In-Reply-To: <87lejabnq1.fsf@mpe.ellerman.id.au>
References: <87lejabnq1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
X-PR-Tracked-Message-Id: <87lejabnq1.fsf@mpe.ellerman.id.au>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-4
X-PR-Tracked-Commit-Id: eca9f6e6f83b6725b84e1c76fdde19b003cff0eb
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 95d0b9d89d78e0983d4feb012b0f12d13d1ae19a
Message-Id: <168045852597.9845.4713978101198277146.pr-tracker-bot@kernel.org>
Date:   Sun, 02 Apr 2023 18:02:05 +0000
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, axboe@kernel.dk,
        linuxppc-dev@lists.ozlabs.org, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org, bgray@linux.ibm.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 02 Apr 2023 20:08:38 +1000:

> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.3-4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/95d0b9d89d78e0983d4feb012b0f12d13d1ae19a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
