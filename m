Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA767A8AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 03:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjAYCXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 21:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjAYCXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 21:23:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F0C460A1;
        Tue, 24 Jan 2023 18:23:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 244DB61425;
        Wed, 25 Jan 2023 02:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83D95C433D2;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674613383;
        bh=RmBWaMyaa0laTJX7aWLHIfTg4wj/shTg5ZFg8+FJ9RM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=NXrcGXdS+881kce/xUMs2Fn3Mhlr43Vv7ffoeC4bp6zxpmqt6edjo5aAvuDa2x5Fe
         +DhqPG7rDXK300AWLmy8PcnUcvAWT9wk4bc+BZvdIny2q92StWNedGRL+8AYnPIBlF
         0AuBwa2Xr/zna94ioGuJp1weDAcJH6gaK2Qr+EiZGj47DKMeRhMyxHe3zETwXrE9Hq
         8vjbIyZG15J15AVwuYtu/knjl7bONRzi5Y9CKxhh/o3+Vzwct/25EdHK1KOZccwwUY
         3UOUARGglk8D9vA6Q5jiQINjgL0MK7nXq4G9tw3WL33ZZKF7KJVXbdwred/hItFIu0
         IuLDVj0kgQbOA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 69E80E21EE1;
        Wed, 25 Jan 2023 02:23:03 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230124193334.161057-1-ojeda@kernel.org>
References: <20230124193334.161057-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230124193334.161057-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.2
X-PR-Tracked-Commit-Id: 6618d69aa129a8fc613e64775d5019524c6f231b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 246dc53fb2461dbcd66d4d1d914246a581edad29
Message-Id: <167461338342.26446.17308850166282928589.pr-tracker-bot@kernel.org>
Date:   Wed, 25 Jan 2023 02:23:03 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 24 Jan 2023 20:33:34 +0100:

> https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/246dc53fb2461dbcd66d4d1d914246a581edad29

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
