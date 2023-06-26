Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2241A73EED9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 00:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjFZWyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 18:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjFZWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 18:54:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A631A1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 15:54:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FBC260FAC
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:54:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D64A4C433BA;
        Mon, 26 Jun 2023 22:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687820049;
        bh=p02kpoV7LAqufaf/AzgLuI1tJMB8TkJgDtlNNcoAp9g=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=KBFCsExhU/a72/4Yi/Zo2r0DUn3PmRkRiBa5ZbgtcG7gStm9Vrh/WhA+e6WcLg1QV
         8uGlSrVTPv3BuayQz+o62Om3PQdI4Ji5OCUiFCBUzT7pD7n+BCiekl6BTNPeIZ5PuV
         RPgCFRInQti/xuTAvL6+0il35561utRchVaYQ/AD03RhJ82T0y7+GX4cVp79FWfDZx
         8K9ncTvlr6W9fnupRVeYBIIlBQ+IvVBOnCZjxOC0vhJJTqb2iwuS+DRS30P9bXRVOU
         PRvIaVxAM7rQQVTi85wVDt6YUZq0/gF8BYr2N/Q50q8T+2i4vODgBoNKXzlBvZeFl7
         Kvm16QOruJWzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1CBFE537FE;
        Mon, 26 Jun 2023 22:54:09 +0000 (UTC)
Subject: Re: [GIT PULL] x86/alternatives for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230626130124.GCZJmMJKLdnwrwkbzF@fat_crate.local>
References: <20230626130124.GCZJmMJKLdnwrwkbzF@fat_crate.local>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230626130124.GCZJmMJKLdnwrwkbzF@fat_crate.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.5
X-PR-Tracked-Commit-Id: 2bd4aa9325821551648cf9738d6aa3a49317d7e5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8c69e7afe9588f9259a6422c6619d7643c76d12c
Message-Id: <168782004978.10634.10820613021037065376.pr-tracker-bot@kernel.org>
Date:   Mon, 26 Jun 2023 22:54:09 +0000
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 26 Jun 2023 15:01:24 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_alternatives_for_v6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8c69e7afe9588f9259a6422c6619d7643c76d12c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
