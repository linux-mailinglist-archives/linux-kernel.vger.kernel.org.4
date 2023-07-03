Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0174618C
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjGCRtI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGCRtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C57EE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E81F60FD8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 17:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2090C433C8;
        Mon,  3 Jul 2023 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688406541;
        bh=kEmXmNRqiuyl+OHW9SiQzS+SCe3tejjJmfF9+4natVA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=OxLp6FJNcZEk+AEu5+D9GN4ZAsbHKYNAgnBrRqxnnhY1Xnev29YAVW1RSe5ljiwzR
         4enb5qDDk7hA9kVkuRD6r7oihQvofcmChTsW4CUj5JZTMYi9Q4kiECdx1HExloFbd1
         p7rxwkkaannhT+XIstqwwa3Xy1JpFWkCw+NyOziMRgV1nBk24qE5aDZhTJfYDQ7AJP
         v7rXE+CySY+0GIb7wCEwB6B2mkq6MffXkoBB5OZtplS/adWtTiRmqOlk35JdwtiEK9
         vAHr/2+d0RXIjK0z1BDgnRSUC1ux3bIpx5/D56jJPxer0ViibqHkNk+BpFYj/2nYez
         Sxmc831RFO2og==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF964C04E32;
        Mon,  3 Jul 2023 17:49:01 +0000 (UTC)
Subject: Re: [GIT PULL] I3C changes for 6.5
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202307022204546baff5fd@mail.local>
References: <202307022204546baff5fd@mail.local>
X-PR-Tracked-List-Id: <linux-i3c.lists.infradead.org>
X-PR-Tracked-Message-Id: <202307022204546baff5fd@mail.local>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.5
X-PR-Tracked-Commit-Id: 49b472ebc61de3d4aa7cc57539246bb39f6c5128
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a74195876b95fce5f1c5b051b8c3b01e1b18a83b
Message-Id: <168840654184.7534.16257030229241907500.pr-tracker-bot@kernel.org>
Date:   Mon, 03 Jul 2023 17:49:01 +0000
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Mon, 3 Jul 2023 00:04:54 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git tags/i3c/for-6.5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a74195876b95fce5f1c5b051b8c3b01e1b18a83b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
