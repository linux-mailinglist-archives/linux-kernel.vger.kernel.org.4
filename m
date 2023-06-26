Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5F773E68D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjFZReS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjFZReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:34:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5164D1702;
        Mon, 26 Jun 2023 10:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B722F60F14;
        Mon, 26 Jun 2023 17:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DF43C433C9;
        Mon, 26 Jun 2023 17:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687800842;
        bh=PvaQpWcCeaSa01iNPCGqUlHMStH4ZZDULeQ+gGbRdYk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=d0nSFyMnDcJNlCAnsv7kWAFcCev7fJ2FhJM7YfhZY7Z1jSdallr6fDwISc1mlNXmd
         iEMbih7eLnyNIizVlB07O5KUN/AnJP4N/VWOetX+qDtuqapTLU2JhwH2ShY0oILZcF
         zvdgJogi/ZyedmhR6l1C8rshSVBkiFhs9h5xiGtW9qOe9n5lE6CYnoWcnXIgoWExfF
         /1UCgH16biO5wit/HfL0hn+v3I+ywp/gysI3jeUww4z0jkfTUFSTlK5ChDF37hgOAn
         zT97JFXxbD+r5rOKHV3hzwwdxsAXgKkBZUtkyg6hpv+yVkfKHPAbnadknTnPO34FYW
         XELtoSJSyTsBg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A09FC43170;
        Mon, 26 Jun 2023 17:34:02 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230618161558.1051269-1-ojeda@kernel.org>
References: <20230618161558.1051269-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <rust-for-linux.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230618161558.1051269-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux.git tags/rust-6.5
X-PR-Tracked-Commit-Id: d2e3115d717197cb2bc020dd1f06b06538474ac3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a1257b5e3b7f8a21faf462d0118067fe31e71ffb
Message-Id: <168780084202.11860.14342370139192013385.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 17:34:02 +0000
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

The pull request you sent on Sun, 18 Jun 2023 18:15:58 +0200:

> https://github.com/Rust-for-Linux/linux.git tags/rust-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a1257b5e3b7f8a21faf462d0118067fe31e71ffb

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
