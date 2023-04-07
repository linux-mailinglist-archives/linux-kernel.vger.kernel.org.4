Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEDF6DB587
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjDGU5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjDGU5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6880CCC2E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:56:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D6FC65485
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 20:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BD6F2C433D2;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680901012;
        bh=wuKOAqEmmt4gBEkPB4quhxfveir1m2uzbpEEqWr8rBo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=GZhsLZDiWIErpE34WRi3gXP0eMwusFzlmUrBuQ2/N7PL+0pZWYHuEvOXwNlyMrD6+
         xDESXiosCGQOqijp7+b87w+oFLdB0QNwP7NM45auklUI83uDZc9wAEVTOC5k0xEGhX
         SVdfpmPlGZ9H0ODP744vi//si3aINTILlN1PusfPxhildUWV/+SMRTGokkcpdg9Y5S
         8XbWHjbDzuvvwsKu2PSuVsu7tRhbFJvQOQdW1iAp9VQGsJEN81gUB3KYkkS3u11UMn
         2TIfgc609RFGG3QEJVHARhORXCTs/sAmDgpHadzN3xIRlzbF4mt5SwTbyBKZKUXMOo
         xGXyu624rcsFQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A4B22C395C5;
        Fri,  7 Apr 2023 20:56:52 +0000 (UTC)
Subject: Re: [GIT PULL] arm64 fix for 6.3-rc6
From:   pr-tracker-bot@kernel.org
In-Reply-To: <ZC/peJ5jIi12hNpN@arm.com>
References: <ZC/peJ5jIi12hNpN@arm.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <ZC/peJ5jIi12hNpN@arm.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes
X-PR-Tracked-Commit-Id: 32d85999680601d01b2a36713c9ffd7397c8688b
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d523dc7b16c4a3697700348d77a8a9bf37555e97
Message-Id: <168090101266.23908.10796341490922564341.pr-tracker-bot@kernel.org>
Date:   Fri, 07 Apr 2023 20:56:52 +0000
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pull request you sent on Fri, 7 Apr 2023 10:59:20 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d523dc7b16c4a3697700348d77a8a9bf37555e97

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
