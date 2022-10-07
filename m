Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB20E5F7DDE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJGTVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 15:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiJGTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 15:20:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D2EBC626
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 12:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DA82B80A08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 19:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9AE9C433D7;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665170420;
        bh=gL+cWcJ1emruwxOjquvPbx5EHhXZdJd4sCqcnZhxXg0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ubjUFwOFoCRgL6GH88gzooQg4iQZSMZNF0TZWilkuc10Bpt57XLKje2MUBGLVVTeY
         WHNFIBeZWhNLDOlwiFj3vFAikFSP2a7QN/ldZSB7QklJSahZiltrnpLGGGC5u+9Jrm
         4F3n4jOZeS5KCCNHkokqyD4wlxeVvjx8pvkasfroGL5HtqmBbPKYq50cWrDH0dAQsk
         7bInMis2kN/Y4YubKNVlXLXkhRorFD/nRR5JdcWGo3Jv6linh9Q6PnbQZPi6JTRENd
         AbMsftYYBntk93GWgrATeTjehxpkRJZ/P+ZQem0njzDKxfSDuNSMERB0XqCAjQdytb
         J4yzdfInSGH2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B39F4E21ED6;
        Fri,  7 Oct 2022 19:20:20 +0000 (UTC)
Subject: Re: [GIT PULL] hsi changes for v6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221006194201.qdf4biulcdfw3mdu@mercury.elektranox.org>
References: <20221006194201.qdf4biulcdfw3mdu@mercury.elektranox.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221006194201.qdf4biulcdfw3mdu@mercury.elektranox.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.1
X-PR-Tracked-Commit-Id: 811908159e7ee583e30565018a08284cf5ddae77
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 83da5ec6b7fccd37547477effa6a4b1162c1acf1
Message-Id: <166517042073.8063.7734726699543872820.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Oct 2022 19:20:20 +0000
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 6 Oct 2022 21:42:01 +0200:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi.git tags/hsi-for-6.1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/83da5ec6b7fccd37547477effa6a4b1162c1acf1

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
