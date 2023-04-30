Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB46D6F2A95
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 22:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjD3UI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Apr 2023 16:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjD3UIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Apr 2023 16:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A2810D7;
        Sun, 30 Apr 2023 13:08:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D57A61038;
        Sun, 30 Apr 2023 20:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCF44C433D2;
        Sun, 30 Apr 2023 20:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682885289;
        bh=t2xJTluT8JPh7EIo5tKzDvYugPPh/MSnmHWUEwOKqbM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Ei7+eWZSJXM9vlUcMaFpn9qVwSVQ7OWzEdseS5OssZiindn+dvnOttvIxwgbmM1Vd
         Z7etv0i6Gg8vn8uV+w7gHZLNQK7K5dQk7TvJuIPkLmSB92nv+Fp5g47hQaVGPFok63
         FFjB9dsB4bmHxUM98tewiTC+s9mwCWjXAsP5eHf5PJXB0l9S/lONH+4l3dVNMn1+hf
         4wg/Rh6solCNCxolBYMKjyAJx0sDCOfj5H+mngXaVuDWs3b0NaT4im0aXqXSdwuqrH
         QSQe+Tui/nqRtZrohv5v4zVZ7OmbmUwEwGhdhdYtYP9w1cIpGhMM13IKNcsiObVIpp
         B6wbnU2Pq4q9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7FF9E5FFC9;
        Sun, 30 Apr 2023 20:08:09 +0000 (UTC)
Subject: Re: [GIT PULL] Rust for 6.4
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230429012119.421536-1-ojeda@kernel.org>
References: <20230429012119.421536-1-ojeda@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230429012119.421536-1-ojeda@kernel.org>
X-PR-Tracked-Remote: https://github.com/Rust-for-Linux/linux tags/rust-6.4
X-PR-Tracked-Commit-Id: ea76e08f4d901a450619831a255e9e0a4c0ed162
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 310897659cf056016e2c772a028f9b8abc934928
Message-Id: <168288528974.32747.13019561296474196328.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Apr 2023 20:08:09 +0000
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Sat, 29 Apr 2023 03:21:19 +0200:

> https://github.com/Rust-for-Linux/linux tags/rust-6.4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/310897659cf056016e2c772a028f9b8abc934928

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
