Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8506E9CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjDTTxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 15:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjDTTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 15:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9EC84EC7;
        Thu, 20 Apr 2023 12:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46B0864B7D;
        Thu, 20 Apr 2023 19:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2A53C433D2;
        Thu, 20 Apr 2023 19:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682020385;
        bh=7IYRCUwdn37bqlWiSgRsMKB0/9U+AFbuoxdH/jpYyG8=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=T9b/jpaBUDTmxUpbsUViEzVNBOBvh6bBO7m391wZbwUHUYPaOXD/jLwoMU/TrhRcE
         JeJ5PNNqyBhyRr3LHzDjh9ntPdrQkKkWso1f0W2i5y00mcTyI5So19BBAenzVcFdSp
         tnVUdvYdLrVWe639UOE1ECThXQ6AohZiDUQ8FUAxmXxrXfHJ9+dwT7mgwW5DXSPEdy
         bSqA+eA5BU2+eIZd0bxoZ1sMiCT5QLBeEfYDxxRjCCBzFCmc7/ZUq5+fqTM7jWDjeK
         yP5zwPLgwOxamHDGjoDKao9VdF1YTOt4HV+4uqk6ba/JefKDSXaTEEb16vpM6bSIns
         nmcvI5gy46rug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 90223C395C8;
        Thu, 20 Apr 2023 19:53:05 +0000 (UTC)
Subject: Re: [GIT PULL] Rust fixes for 6.3
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230420134458.942139-1-ojeda@kernel.org>
References: <20230420134458.942139-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230420134458.942139-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.3
X-PR-Tracked-Commit-Id: d966c3cab924fb750fefef11e77a6fa07dd5420e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6a66fdd29ea1695d615fcc93dccfb6dbe2f53b1d
Message-Id: <168202038558.11187.3968634757505964546.pr-tracker-bot@kernel.org>
Date:   Thu, 20 Apr 2023 19:53:05 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Thu, 20 Apr 2023 15:44:58 +0200:

> https://github.com/Rust-for-Linux/linux tags/rust-fixes-6.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6a66fdd29ea1695d615fcc93dccfb6dbe2f53b1d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
