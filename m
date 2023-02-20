Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEC169D4E1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjBTUWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjBTUWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:22:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B640921A12;
        Mon, 20 Feb 2023 12:21:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A96B60F2F;
        Mon, 20 Feb 2023 20:20:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C422CC433D2;
        Mon, 20 Feb 2023 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676924404;
        bh=99h1FX1DYIZ8FxUg0cKoapThaYPydsBdF/rO8Y7+58s=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=u7loxAInSMPATdjFegvUQlEKrcO8jSZ6o5gyakp8MEdfB3Gnj3bU31av/sdrrKQz2
         dWWS/m3kJJFAlezBBQaHU21CCWvIdjXOwrbl5sProKcTvTUf4KzmstjcVygYxhzFOn
         e8jqd4zddwLtROZMaE5xybrVnMKh2MytpCCqUaflcNBa765NHSq+IPf19Iwcs+zbBA
         3u6fBcdaOpxeVAgpb/RQxnIbHaRI2GlOFVV3T3aPSniCzI000tC3CuLjFwH9Jw69Ng
         x8ZlDn93pPdm1FnrcjIYhe88+bh2wGS4t/EO+YBNJ50dwB0OGELmwhFdHcYbpi3pTS
         aa6yF4S7CwF6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE259E68D20;
        Mon, 20 Feb 2023 20:20:04 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230212183249.162376-1-ojeda@kernel.org>
References: <20230212183249.162376-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230212183249.162376-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-6.3
X-PR-Tracked-Commit-Id: 7ea01d3169a28d090fc8f22e7fcb4e4f1090c2d2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 69adb0bcb833963050d82e645b6a1a0747662490
Message-Id: <167692440469.19824.12170630179739195973.pr-tracker-bot@kernel.org>
Date:   Mon, 20 Feb 2023 20:20:04 +0000
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

The pull request you sent on Sun, 12 Feb 2023 19:32:49 +0100:

> https://github.com/Rust-for-Linux/linux tags/rust-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/69adb0bcb833963050d82e645b6a1a0747662490

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
