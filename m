Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C96AA558
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 00:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbjCCXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 18:05:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbjCCXFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 18:05:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05EF5FEB8;
        Fri,  3 Mar 2023 15:05:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FB48619A0;
        Fri,  3 Mar 2023 23:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95A7FC433D2;
        Fri,  3 Mar 2023 23:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677884666;
        bh=FcAjh5P8Ii6oUGV8/gve+dRdN7GBcOY0Qu00xV45gNc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L110KZyKEI2PHEKEnKc1K+G1a66HLTm/+aFRJ9jGsvb0KSfmRya4h4/j0oVOg9MG9
         36rVis2Cvf5ESuL+j3Juq2P28fo5p6PzAr6eO4gz8B3SRGajl/6HxuY7eQN29cNCaK
         7VgcFzG/yzUz/WOofHdi9EOBROfX5at1hV1sISSsae5fU9NbeXAvnuCgIfUCsRf9ci
         F6tSGED8DltKUftn72phvwL8SH3Gc/x0o/m6OZqGggBxz88DsUtb9v77eLf+Ok6le3
         eNcxRA7XPXKNUzxiAMYL5ESyP0onfPT8yt73Wf6jAdsXlVwGpFlC9ggr1EI8rjDbs6
         Qqq27pdgAKO6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 82B79C41679;
        Fri,  3 Mar 2023 23:04:26 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.3-rc1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230303212105.78945-1-ojeda@kernel.org>
References: <20230303212105.78945-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230303212105.78945-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.3-rc1
X-PR-Tracked-Commit-Id: 3098cb655e7c9ea1c2919e61234f63ebaab6bb21
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 34c108a02c30627bcd4875e4f32c915acc45305f
Message-Id: <167788466652.32457.2489864860891486202.pr-tracker-bot@kernel.org>
Date:   Fri, 03 Mar 2023 23:04:26 +0000
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

The pull request you sent on Fri,  3 Mar 2023 22:21:05 +0100:

> https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/34c108a02c30627bcd4875e4f32c915acc45305f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
