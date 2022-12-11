Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083806491A2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 02:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLKBQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Dec 2022 20:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLKBQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Dec 2022 20:16:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B913D2F;
        Sat, 10 Dec 2022 17:16:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E44C560CF8;
        Sun, 11 Dec 2022 01:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3902C433D2;
        Sun, 11 Dec 2022 01:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670721409;
        bh=qTGP2kIwOws5ihL3lyrc24HaI1fZpI1qwQqQOirFeTI=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GpYitqo/EUNFGLWi6ICxTJmx/4BWo8c9AnKfCyTNgJC+msaDobd63L2RbO/M/uDA/
         cTfcYI4T7EjGGlLOvp3fpmHBRW1MtNjxkU9crKcKSfgpZ/PzqGnHiMtrH2pm//xSqz
         OqJ0nbaagAQD2Sr6Y4LUXSs6Ht4vaQK+czp2cxWb1rwZsswe0HimJnedqsP6jGcFOY
         6P4nOOnuJJ35snCHMFAlyYlJ+AQqQKyvYp2+d6zsymyioDAnWGdEl5W/onc9xADHfw
         6pK1ybDY9dwa0mSLBITssLZoct2KXVKoPBWn8bO5c4adL0g+YE4+0POFkz2YN3MJZ1
         z50CTQS1umzWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CA2C433D7;
        Sun, 11 Dec 2022 01:16:49 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.1 final
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
References: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
X-PR-Tracked-List-Id: <linux-mm.kvack.org>
X-PR-Tracked-Message-Id: <20221210170317.130e7dbfc0e78de6067c4012@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-10-1
X-PR-Tracked-Commit-Id: 4a7ba45b1a435e7097ca0f79a847d0949d0eb088
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 4cee37b3a4e68c42b867c87a6218e11bc571ba66
Message-Id: <167072140965.29481.9621645628185394506.pr-tracker-bot@kernel.org>
Date:   Sun, 11 Dec 2022 01:16:49 +0000
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 10 Dec 2022 17:03:17 -0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2022-12-10-1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/4cee37b3a4e68c42b867c87a6218e11bc571ba66

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
