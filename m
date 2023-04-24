Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6F96ED6E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 23:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbjDXVqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 17:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjDXVpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 17:45:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6508A4A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 14:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61D3961975
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 21:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7441C4339B;
        Mon, 24 Apr 2023 21:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682372742;
        bh=VyTBpf/snyNQhrjlNL4oZ13thg4h3ip2t2we9wU6ynM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=ja+I4UcuT0mQjsn9qLexhNVQBhd9Ms34NKynlVaH8VHGNrEofn7fHq8SbUFGgBJVE
         iNTsbAgkV1h6ulG7vPQFLBpb5UxjbbipCTvfEA1dQdDglXcqXji9W2yQ2kQCT0LohE
         wvCOAvDofCesOgigIP5Al72kGuAWcv8U1EMqMz5mmCSFawYTMwckM08sXh7L3kFcWI
         p71cfMyv+qpUc1Oz8znNwLg8v/e9Ar2MCicHM6HhDGmsrjGUmkMXTtqNq7m5V29B47
         m3KwruxXTWze0+Nls6t1beDCyGgO+o6U18KHOx1uOD3BKN8fxQ3vcLWPlluBwAwtOj
         ftC7Wsz6LVkfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B2231E5FFC9;
        Mon, 24 Apr 2023 21:45:42 +0000 (UTC)
Subject: Re: [GIT PULL] clone3 selftest fix
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230421-semester-nothilfen-990da22419a2@brauner>
References: <20230421-semester-nothilfen-990da22419a2@brauner>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230421-semester-nothilfen-990da22419a2@brauner>
X-PR-Tracked-Remote: git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/kernel.clone3.tests
X-PR-Tracked-Commit-Id: d95debbdc528d50042807754d6085c15abc21768
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a632b76b427d886911221331f4bfcd44a3e58197
Message-Id: <168237274272.2393.8153426216146210950.pr-tracker-bot@kernel.org>
Date:   Mon, 24 Apr 2023 21:45:42 +0000
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 21 Apr 2023 15:29:18 +0200:

> git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/v6.4/kernel.clone3.tests

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a632b76b427d886911221331f4bfcd44a3e58197

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
