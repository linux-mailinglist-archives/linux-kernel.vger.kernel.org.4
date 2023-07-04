Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B972374667B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 02:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjGDAQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 20:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGDAQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 20:16:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55E0B2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828A261088
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC6F7C433C8;
        Tue,  4 Jul 2023 00:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688429808;
        bh=M2GCZpGmpO45YE/KCOYZOCvV9qVDVpMy3yBLtA6xVV8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=VsppCcH97PvXHBHwD43M/fczAO0tVTAuu1uY1PRxsoe+I3ux5AE4zgST2+2g+EFd0
         lbHJunXuEWMefaK0eVwi/dt+Kja0MkaqkH1smbFh7GD5CB9XFieldJsvEgVJoUY7qw
         /nj30OgP3NFTYAhIxlQ+Z3r1jLtVxFl/Pi9c5l9tapblc+C33K7z2dVfxTLBRIG+2y
         1JUxklSeuULO4Eq6Z4NR6j+VkVhdkjVhk9/Mk9zVhXvWLCGw1ZrrSp4mbPtWbec6Sv
         qvdA/F9fTT+kTFbNeTjPjoUw8d1DMh9sWYVIX299BJ0IG8XjXi9QqUcTYH2bQ3QNIt
         iFR8PhdKIIGgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAECBC04E32;
        Tue,  4 Jul 2023 00:16:47 +0000 (UTC)
Subject: Re: [GIT PULL] kgdb changes for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703083918.GA5601@aspen.lan>
References: <20230703083918.GA5601@aspen.lan>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703083918.GA5601@aspen.lan>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.5-rc1
X-PR-Tracked-Commit-Id: b6464883f45ae6412de33e53587974fd86ba811e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: eded37770c9f80ecd5ba842359c4f1058d9812c3
Message-Id: <168842980788.28751.6171022365212976058.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Jul 2023 00:16:47 +0000
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 09:39:18 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-6.5-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/eded37770c9f80ecd5ba842359c4f1058d9812c3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
