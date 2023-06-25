Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D9073D2AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 19:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjFYRXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 13:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFYRXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 13:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212D197
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 10:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94CC860C05
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 17:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF44BC433C9;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687713810;
        bh=7AFTxOakYHkjSdLko16JMgdE9pZ2zO+XnC5bID5eyyg=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OOZVQksCPc/JnU42nCsWc8hVYQ2JVURxg5a3FqApe+almPPwcrciJD3XlVGkB9WYl
         9bvf7RGx+0iZ2YHIZD1xPBc60js8A/qZ7AAFWGpe4diTgQsPLNjeCbeCsB9fyBQlQS
         1HfTnnIOqB7XQtm2IIJMC71GIBay9hSX/tFE36L3qqFrt9cxNCNB6lBOWC6FOV0fND
         K3xo6cCInP5iAXQEp7GiNJI+kWO6k7EjV+d9aHlFl1jc5/2KI5bmE4/YzHW3wcaJy6
         V3b2Ta0NsOHTYJHrqQjTHPMqKFd5ljanXqMEvnkI6mc2Zg5nUOr0Gitk6Rcyh9EUdz
         dKZP7IoK+Wmpg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D767FC43157;
        Sun, 25 Jun 2023 17:23:29 +0000 (UTC)
Subject: Re: [GIT PULL] perf/urgent for v6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230625094033.GCZJgLkSWnRJfxNXCQ@fat_crate.local>
References: <20230625094033.GCZJgLkSWnRJfxNXCQ@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230625094033.GCZJgLkSWnRJfxNXCQ@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4
X-PR-Tracked-Commit-Id: a6742cb90b567f952a95efa27dee345748d09fc7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 547cc9be86f4c51c51fd429ace6c2e1ef9050d15
Message-Id: <168771380987.13789.7103120769984778149.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jun 2023 17:23:29 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sun, 25 Jun 2023 11:40:33 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/perf_urgent_for_v6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/547cc9be86f4c51c51fd429ace6c2e1ef9050d15

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
