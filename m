Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C1B744A79
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 18:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjGAQML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 12:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjGAQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 12:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA45A270E;
        Sat,  1 Jul 2023 09:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F79600BE;
        Sat,  1 Jul 2023 16:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2F27C433C8;
        Sat,  1 Jul 2023 16:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688227923;
        bh=gJzHuTVfdzUvwJvKHCqV5CrmrPHXO9GNjtF8nhc4haE=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=SQ2hp5grrEhKBHouoGFBefQn2kEutAeFok7dKqyTKy5WYqZQRXdfwRV/lJFZabcxh
         0uhCyNF2470s9xedQwOhQB+Y1VN01DZcYLlXDYyVvhDaJbN77bl0fnpccjs14pYeJN
         RSBc/j0h8dlXY9q9PV640Hgjn6bf62u94962Lu5lK35HlqUpxxlkCe1BjvvfblSNw7
         Uhm358cdy/2MgVEveRo25AmCSFoVWp22CExSLVxMQkymrotI0sRjzA3v5W59hhGZRF
         3g2N6CHcgpt1mXbKliZt3GMVy+/64O0Hq/K0zN+upeTX1kVJB+4+kHrf5jw5XUAoot
         Mx7oG9Kuz0Bww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE920C0C40E;
        Sat,  1 Jul 2023 16:12:02 +0000 (UTC)
Subject: Re: [GIT PULL v2] flexible-array transformations for 6.5-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZJ8C4PtPrxr6LTA7@work>
References: <ZJ8C4PtPrxr6LTA7@work>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZJ8C4PtPrxr6LTA7@work>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1
X-PR-Tracked-Commit-Id: 40ca06d71d60677a8424798610c97a46e4140a21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 170ab6c51a42a8a1c1a7ce09367b578db6f2f383
Message-Id: <168822792283.621.4577729889953275464.pr-tracker-bot@kernel.org>
Date:   Sat, 01 Jul 2023 16:12:02 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 30 Jun 2023 10:29:20 -0600:

> git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-transformations-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/170ab6c51a42a8a1c1a7ce09367b578db6f2f383

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
