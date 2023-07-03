Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A147974629F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjGCSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbjGCSjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA08E6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 11:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3689661011
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 18:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BA9AC433C8;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688409552;
        bh=xsMBW7H8F8GjWEQzPBojVxvT274kYcgVxjyb3/X4F9U=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=L/zxg/J59d2iAtgd8YPDbZpr9R6MTyvx5hSPy/UhEjdppFrJ+sPKYevXRxMudsnrk
         FKA9imDyKvLmBAIBCLR9k4lzvI/0LRD+EO3tdBbF9jG8FJ0YP29YWBsPlb614SXDl6
         AHOY0wIE5WzTuXn53nBqM2qLJyDpNx9oOeRuSl95uB7QWYe86h90QtAmMPqi1AR4kc
         l3duYabmhmJr9g/Zkh4pdNJi4RjMyLYgXppc5ElSUr5lVPFXvCeYajvGCoBcg4k0Rk
         Qen/wgm6bCcl8ELSRVSC/tD3tH7i+c59aKm+4hdvrsjBenwtJarVLKY25mHsJvPTlb
         +v7cdFyk5ytKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8425CC04E32;
        Mon,  3 Jul 2023 18:39:12 +0000 (UTC)
Subject: Re: [GIT PULL] LEDs for v6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <20230703100831.GB10359@google.com>
References: <20230703100831.GB10359@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20230703100831.GB10359@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.5
X-PR-Tracked-Commit-Id: 877e91191ccf0782ae18c5dfa7522fb1e5bfba8c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c156d4af4354091c38a1cbef62c0b1574e8c4394
Message-Id: <168840955253.6002.6521827755789672569.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 18:39:12 +0000
To:     Lee Jones <lee@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 11:08:31 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c156d4af4354091c38a1cbef62c0b1574e8c4394

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
