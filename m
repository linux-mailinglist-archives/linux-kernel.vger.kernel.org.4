Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7C15F4895
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 19:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJDRfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 13:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiJDReJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9907B66A68
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 10:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3436B81B61
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 17:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B89BC43148;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664904845;
        bh=bFShf0JYMGtY27jzNpdU56j0JGCSEH6wtceaOJ4tUT0=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=k0boDZQyF2XtPO7q0luCd230ExyzXH4TcWC8Qz36Ksv14ik0+Jfy1bKyT44Z8tQ+J
         mn0ELsKVgE5wS6FcGVWoCd8aJXR061/ZxNrS6xAhMlA8fwK0QfkvouAiW06snulwDl
         /MzTCsYNeMgtdjspe9dPBnA9j4GvsnuVT6Xpd7CZaaQ+YJrQnDkUJEOkfzyrTSk54b
         PfyGFYp8xWIPWujUniw4ymROpeNZHnsR2LK5pL4Svkmj9oBnJa3eO/NBv5zQIMC6gR
         Au7Y+Im71ckhM6S9bke3BUM1qKueAIJRHwOM7/34N3TGpdWUXZ18t3bEP+aETAYIYb
         ACTpE52luJXHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 599E2E49F62;
        Tue,  4 Oct 2022 17:34:05 +0000 (UTC)
Subject: Re: [GIT PULL] x86/core for 6.1
From:   pr-tracker-bot@kernel.org
In-Reply-To: <YzwDkPQtUXDQU5km@zn.tnic>
References: <YzwDkPQtUXDQU5km@zn.tnic>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <YzwDkPQtUXDQU5km@zn.tnic>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.1_rc1
X-PR-Tracked-Commit-Id: 8c03af3e090e9d57d90f482d344563dd4bae1e66
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8cded8fb1299eb20fc2f7a89dc9328cdf1baf9e5
Message-Id: <166490484536.22164.16576159877787784806.pr-tracker-bot@kernel.org>
Date:   Tue, 04 Oct 2022 17:34:05 +0000
To:     Borislav Petkov <bp@suse.de>
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

The pull request you sent on Tue, 4 Oct 2022 11:57:36 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_core_for_v6.1_rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8cded8fb1299eb20fc2f7a89dc9328cdf1baf9e5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
