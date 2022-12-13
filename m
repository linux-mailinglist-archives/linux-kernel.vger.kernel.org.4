Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A9864C0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 00:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbiLMXcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 18:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237263AbiLMXb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 18:31:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F312DC0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 15:31:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 907D8B81604
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 23:31:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 323E6C43396;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670974315;
        bh=1226CP1kZMK43HzqYRkq6P74991e/wXACOnh9MEVaXk=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=bCT1rdaGM1tTPUPps2Ryww+PoQEqJBAfalsfBciqyP61/5UjD4lu/6aXai6epUjCi
         BYLo/FcG/mOeQfr/8SUoe+V5ylGpTqvDU45DhVPXKkqUJw+WSrHuyXmXG/2JJaCV+g
         rvwNA0ddeQe5E2Fzrvy38KM8jBNXpXmBQM63m3xKosry23EuFXy4/scJKRWF8nSWS5
         7wARttkgWJn9Bfx5GblXqlQ1oWkc0wa93TV19peLUwbVFXKea8BYzBqRWiiVevdgyW
         N/QBDfsK8e0yikk8+ldVQQtf23VPknxzWiRUTo5Ep9KGBucP71JWz7ASpDSL+Fwotw
         bEAketuLNFMkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20A7AC41612;
        Tue, 13 Dec 2022 23:31:55 +0000 (UTC)
Subject: Re: [GIT PULL] x86/microcode for v6.2
From:   pr-tracker-bot@kernel.org
In-Reply-To: <Y5iPT6W7GkNx5qai@zn.tnic>
References: <Y5iPT6W7GkNx5qai@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Y5iPT6W7GkNx5qai@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.2
X-PR-Tracked-Commit-Id: be1b670f61443aa5d0d01782e9b8ea0ee825d018
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a70210f41566131f88d31583f96e36cb7f5d2ad0
Message-Id: <167097431513.3216.18184837117263434676.pr-tracker-bot@kernel.org>
Date:   Tue, 13 Dec 2022 23:31:55 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Tue, 13 Dec 2022 15:42:23 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a70210f41566131f88d31583f96e36cb7f5d2ad0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
