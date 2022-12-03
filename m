Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15966411D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 01:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiLCAKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 19:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234694AbiLCAKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 19:10:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0588E5A95
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:10:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0048B82314
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 00:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6A012C433C1;
        Sat,  3 Dec 2022 00:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670026237;
        bh=UoY0yL+gTdz7KbbVWhh7PwyPSxsEMr3LBk1X+Lcsp9o=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=gkjK0P/KQx4EFlGtAziXzbWtTof6dTryM3kOJO3UqWpMn4FADe1Qh3Brgb3kVMe2z
         h4JVR8gFIc1IWIgMeAYhHS+SCuhP5Tu+PrSbmvVwqyfUjtm3Y9enEZFjJZXxPzopNt
         yPMuJ5qU02Oi1/CA3cMZJ4UmjNOVIFqzFapilK1pjXQ96tJiSP2mGiUwsLyL8+7qA+
         AaNAZfClQ0SXy0cz4IcPbJS5sCDUAm9Tw01k6K0GRzU7pIVDXUQng9P6lJiVNWs6Fb
         +hTCELrEK58aiY/LS3B3lnkk1eM5d00ErmPH92ysm7i/VUlatNUQd84/J1vcBSa8d2
         Ic5pMiTw6U9Qw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56D22C395F5;
        Sat,  3 Dec 2022 00:10:37 +0000 (UTC)
Subject: Re: [GIT PULL] RISC-V Fixes for 6.1-rc8
From:   pr-tracker-bot@kernel.org
In-Reply-To: <mhng-ade5e352-1239-4324-aab5-e2fb6a575c25@palmer-ri-x1c9a>
References: <mhng-ade5e352-1239-4324-aab5-e2fb6a575c25@palmer-ri-x1c9a>
X-PR-Tracked-List-Id: <linux-riscv.lists.infradead.org>
X-PR-Tracked-Message-Id: <mhng-ade5e352-1239-4324-aab5-e2fb6a575c25@palmer-ri-x1c9a>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc8
X-PR-Tracked-Commit-Id: 39cefc5f6cd25d555e0455b24810e9aff365b8d6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0e15c3c75a28b10bac7b3ad7627fd6b458623283
Message-Id: <167002623735.23477.14131709914366367868.pr-tracker-bot@kernel.org>
Date:   Sat, 03 Dec 2022 00:10:37 +0000
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 02 Dec 2022 08:53:14 -0800 (PST):

> git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.1-rc8

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0e15c3c75a28b10bac7b3ad7627fd6b458623283

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
