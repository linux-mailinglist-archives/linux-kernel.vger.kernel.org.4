Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59585F3AB5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 02:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiJDAhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 20:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJDAgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 20:36:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B94286F5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 17:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1110C61232
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7516DC43142;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664843808;
        bh=doCjKynMUApN8SmOyhV+BDFzJhNIRVezNou3DHCtWbc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TKDzi1avxa8XTGzNV/ECUh5W/WJ1MUQkHgcxdWksIMPFgx08fZPy+Jn27vzhMzV/a
         zWYyQP9r+H3Nnlr6YQJvU4bBbX6A7i7XeBLktQJqqrFm/MBQ4yTVwtIgHyatYBykub
         M3Q6BGioz6OuiZE9jbL5XCL656dLbEPE2E6XAQWW1M4jELdZkP4Qdsh02pxpIf9Rto
         FVMCYsL6S0AiL/d2iIm6J3WhMCxx3e9Kc1LhueojPQTszI9NWN5Lg+piHuvwSgZG1A
         lVyoNaQVVrmiZFzNxVhCs7MX99UuYph9Hz51ezQxbqw9cy/QGaaACdfJWaGiNPxFx9
         79qpOPVXIYmnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5B0B8E49FA3;
        Tue,  4 Oct 2022 00:36:48 +0000 (UTC)
Subject: Re: [GIT PULL] execve updates for v6.1-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202210010938.3922D4DCE@keescook>
References: <202210010938.3922D4DCE@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202210010938.3922D4DCE@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc1
X-PR-Tracked-Commit-Id: 9f4beead610c83065cc0410bfe97ff51d8e9578d
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 12ed00ba01abf39e0869c02ccdde5e24a357466b
Message-Id: <166484380836.25503.4009817414907557987.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 00:36:48 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 1 Oct 2022 09:40:11 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/execve-v6.1-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/12ed00ba01abf39e0869c02ccdde5e24a357466b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
