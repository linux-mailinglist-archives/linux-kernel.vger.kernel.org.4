Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF7C6BA54E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCOClZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCOClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:41:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A7334020;
        Tue, 14 Mar 2023 19:41:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B8FFB81BBD;
        Wed, 15 Mar 2023 02:41:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D0C1C433EF;
        Wed, 15 Mar 2023 02:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678848079;
        bh=h3J4HEJI4W2lctfe9G8Y3rHE+SQmJmji2y22Oimd2JU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=sdJ7GzwNEfBUvfMEyjsnWAykD1GrkewaVCnF4UaSVPOwkK2izKwQW+Mt666ecQcoq
         ycuIogfDZO3iCMUyVMrI0Nb5zS9bq+TFtDEGn85MKIk7QEUrnhmWYiSyKxWDMml+x0
         9ISe5apdxYpTU0qy0oEVp+npjhckg/o5pL15HbwWhkszEpeCy6gEjVKoAwffBuybWT
         5wj07ZJWowI2vOlERj3NxyBZ5vvSO36lwX6paUUpG9pvZgYEvjJq05/upItpjaPaRj
         NXQxXgTW/IOvXH3fby/4M3C1ByhulgWC0+nb+R5pA5g3jaN7FgMH7A+ORF73A7j0YF
         /SbDdyMOI44oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BC50E66CBA;
        Wed, 15 Mar 2023 02:41:19 +0000 (UTC)
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230314165437.a2d992731a970582fe36aaba@linux-foundation.org>
References: <20230314165437.a2d992731a970582fe36aaba@linux-foundation.org>
X-PR-Tracked-List-Id: <mm-commits.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230314165437.a2d992731a970582fe36aaba@linux-foundation.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-14-16-51
X-PR-Tracked-Commit-Id: dd52a61da0dd8bab8b90e808f0e5ad507b61ad6d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26e2878b3e18530c6198354a561be202235bd325
Message-Id: <167884807923.332.13367805991971100767.pr-tracker-bot@kernel.org>
Date:   Wed, 15 Mar 2023 02:41:19 +0000
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

The pull request you sent on Tue, 14 Mar 2023 16:54:37 -0700:

> git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2023-03-14-16-51

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26e2878b3e18530c6198354a561be202235bd325

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
