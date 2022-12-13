Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6017C64AD3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiLMBks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiLMBkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:40:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC26443;
        Mon, 12 Dec 2022 17:39:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70627612FC;
        Tue, 13 Dec 2022 01:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CD365C433D2;
        Tue, 13 Dec 2022 01:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670895593;
        bh=cMcfA4guqRhduwVB5sBsCzcLjoO5gZUVcJLTif6DjGc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=G1WP3IvlH7LlUmGpE4bAiPLqyXxAjWwmzIVr8o1exEGXqE8PBx5X2vlPXmcj1BKr9
         ABMAEBrC5C6U7inSYBomEWVDSMzdiklstrRVSKuHX8BHZKnvOyMp0/ZRjzrLk+9/a9
         viK9LeUG3tQJpewVmx6pERq0T7yQp9aH9QKQcIo61zocTRk1eAVmybGxk0x5zI2LzY
         k2Y+KR1MtsGvMJTQ4AE7qFcf/q4hXXUxnqd81FNtdWbmMUd/MjAznp+ZeFYsvmKUt2
         UKHeX3iZaP0zESp39+AFdJ6PPRyKtYvW/qzf/LCj25irbrqcLodfWcQzTuaf4tiszM
         bdmoHkPNoVj3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBA11C00445;
        Tue, 13 Dec 2022 01:39:53 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20221211005609.270457-1-ojeda@kernel.org>
References: <20221211005609.270457-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20221211005609.270457-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-6.2
X-PR-Tracked-Commit-Id: b9ecf9b9ac5969d7b7ea786ce5c76e24246df2c5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 96f42635684739cb563aa48d92d0d16b8dc9bda8
Message-Id: <167089559376.7166.10788068885071372996.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 01:39:53 +0000
To:     ojeda@kernel.org
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

The pull request you sent on Sun, 11 Dec 2022 01:56:09 +0100:

> https://github.com/Rust-for-Linux/linux tags/rust-6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/96f42635684739cb563aa48d92d0d16b8dc9bda8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
