Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E64474629E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbjGCSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjGCSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2FCE71
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68CB36100B
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2417C433CC;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688409552;
        bh=O9W+XDoz/kkSVeNtCFBglCTpC+J7LCNn0I60bcg9b2E=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=rsSRYOSeza40h7mAA2aLFtVQDTZSlw+xKj4NuPCGI49eltTtpPJevlfs1KpASBsXh
         p9QObrXjezPqnjamMhrvDGxiO/QUAWO4iMYGiRB0UXz0BOFo+gQZS8smjjMqMYpp5v
         Dq2pUa0JeVsrfLaJxUvXEBIUDHkQ/b66ylfPf4siJtYBYvqkpZzepiHYsNeIbd2K/s
         lJmWzycE9qyMfz6Tm1CdUvMvgXm7Vnewv9ojq6WSQqSiWeZapKV9+NtWdnRPyaMel/
         PG/Tf9HcIrCR7RBpHkNNLO7cbIqJfFQUHKqR9iRiv9jN3ZK5vJMOJ2IUMiiL78JiIH
         yRGon2rpFy5zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFAF5C04E32;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
Subject: Re: [GIT PULL] Backlight for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703101159.GC10359@google.com>
References: <20230703101159.GC10359@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703101159.GC10359@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.5
X-PR-Tracked-Commit-Id: a33677b9211b6c328ad359b072043af94f7c9592
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0a8d6c9c7128a93689fba384cdd7f72b0ce19abd
Message-Id: <168840955278.6002.14324176226987373463.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 18:39:12 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 11:11:59 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git tags/backlight-next-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0a8d6c9c7128a93689fba384cdd7f72b0ce19abd

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
